From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] Add a new option 'core.askpass'.
Date: Mon, 30 Aug 2010 08:56:58 -0500
Message-ID: <20100830135658.GC2315@burratino>
References: <201008271251.19754.k.franke@science-computing.de>
 <7vaao8hsmx.fsf@alter.siamese.dyndns.org>
 <201008301344.22983.k.franke@science-computing.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Frank Li <lznuaa@gmail.com>
To: Knut Franke <k.franke@science-computing.de>
X-From: git-owner@vger.kernel.org Mon Aug 30 15:58:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oq4sy-0005bp-CY
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 15:58:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755276Ab0H3N6s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Aug 2010 09:58:48 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:37492 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753718Ab0H3N6r (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Aug 2010 09:58:47 -0400
Received: by pvg2 with SMTP id 2so2085430pvg.19
        for <git@vger.kernel.org>; Mon, 30 Aug 2010 06:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=acft9gKLprlv+8rKevtzKhHrIA/oWAkYXtot2Xa13Y4=;
        b=HaakVp4WBLBXVEQm4JSnDQca+4WfR9C4fK8ZyIHsHHfqoRODkn2Sig78tzdbmAs8Rm
         46ODeuwgcDVFcaiNZSYsVfVnFPuKmZS8tURtH1TTQqv3yTRifQwv9pmXrwSgSnFESpRy
         yFQSqetdtByO3NgioYSl8ztyRBSz0fYiXiqyM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=DJXQrNieU3ZSKSBUGhyP6k848RXB+PTFess3N/KcHN+6W2CqyvPODLhfzL3Vqk6WfU
         G4oBpe5rX0XCLKP0fd9BoC3tqQeKvZ2GdzpAOxAnrZv2Fo65MOSeqKnBe9MPHARX4iEi
         Vy+RZQxPOA6dTQwLPAEIir2J+3xz6MibOl6uY=
Received: by 10.114.136.19 with SMTP id j19mr108740wad.54.1283176726299;
        Mon, 30 Aug 2010 06:58:46 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id g31sm7555853ibh.4.2010.08.30.06.58.45
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 30 Aug 2010 06:58:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201008301344.22983.k.franke@science-computing.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154803>

Knut Franke wrote:
> On Friday 27 August 2010 19:28:38 Junio C Hamano wrote:

>> Also this
>> does not feel like a "core." thing, but it may be just me.
>
> Where else could it go? It's not entirely http specific:
>
> $ grep git_getpass *.c
> connect.c:char *git_getpass(const char *prompt)
> http.c:                 user_pass = xstrdup(git_getpass("Password: "));
> http.c: ssl_cert_password = git_getpass("Certificate Password: ");
> http.c:                          * git_getpass is needed here because its very likely stdin/stdout are
> http.c:                          * but that is non-portable.  Using git_getpass() can at least be stubbed
> http.c:                         user_name = xstrdup(git_getpass("Username: "));
> imap-send.c:                    arg = git_getpass(prompt);
>
> Nor does it relate to a single command.

Perhaps "push.askpass" and "imap.askpass", maybe with the latter
defaulting to the former or something?  This would help preserve
the illusion that the git commands are sort of independent tools.

Haven't thought deeply about it at all, though.
