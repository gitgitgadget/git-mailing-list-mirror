From: Tarmigan <tarmigan+git@gmail.com>
Subject: Re: [PATCH] Respect crlf attribute even if core.autocrlf has not been set
Date: Sun, 3 Aug 2008 11:54:34 -0700
Message-ID: <905315640808031154j28778cd6pee75e6b008304941@mail.gmail.com>
References: <alpine.DEB.1.00.0807250159420.4140@eeepc-johanness>
	 <20080725140142.GB2925@dpotapov.dyndns.org>
	 <42C252B2-85B9-4D05-B3A2-2A0250D7F5D6@orakel.ntnu.no>
	 <20080729134619.GB7008@dpotapov.dyndns.org>
	 <A8BF9951-AB9D-4391-A6CB-E9778064F4A8@orakel.ntnu.no>
	 <80518F08-A9A9-4190-9AC4-D24DD6A1188B@zib.de>
	 <32541b130807301133w4bfc8288oa2d15911b2317dca@mail.gmail.com>
	 <56C07978-D6C9-4219-8B92-6217BD33F6D4@zib.de>
	 <905315640808030954j7487a010p136c73406298ee29@mail.gmail.com>
	 <20080803173339.GQ7008@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Steffen Prohaska" <prohaska@zib.de>,
	"Avery Pennarun" <apenwarr@gmail.com>,
	"Eyvind Bernhardsen" <eyvind-git@orakel.ntnu.no>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Joshua Jensen" <jjensen@workspacewhiz.com>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Dmitry Potapov" <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 03 20:55:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPijx-0004BW-77
	for gcvg-git-2@gmane.org; Sun, 03 Aug 2008 20:55:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752719AbYHCSyg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 14:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752861AbYHCSyg
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 14:54:36 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:21299 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752851AbYHCSyf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 14:54:35 -0400
Received: by nf-out-0910.google.com with SMTP id d3so622583nfc.21
        for <git@vger.kernel.org>; Sun, 03 Aug 2008 11:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=q/019+ZJbMwn1ACMB0Uj7/1TKNCxqSI0Av3k0lXkSvA=;
        b=abi3dmRyGKG73DQvL0gA42LH6ZVl7QQltdrsxjZrqa9S7ThbjSTuUKRKJZPQdy+wuq
         pu/a0PO0DGl1ESzR7mqvRvdh/fdjvoEGrlmYWRkK5RHKKPMbFgc6e5KG+V6TiAOrXPR4
         wl3Nt7m1+bWzlh168jvb2hk9iIemj8suXTzLI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=GkH+qP2gjm44i47Fzx0OXjm8DJ+VdSyTCsYkFjmxCvxLUA52yboPLvqyi1CBt5XMw2
         qMeMVyUWK4IlyaJfpFsjYBVwGOorwh4spr3eaK7K5y0mXf5Zac9aZp28iIeflKNUVYGr
         m0pgMpEp+IEzKt9j8cwoF1H+KydcExH3Xe/Yo=
Received: by 10.210.143.11 with SMTP id q11mr15989390ebd.61.1217789674142;
        Sun, 03 Aug 2008 11:54:34 -0700 (PDT)
Received: by 10.210.109.18 with HTTP; Sun, 3 Aug 2008 11:54:34 -0700 (PDT)
In-Reply-To: <20080803173339.GQ7008@dpotapov.dyndns.org>
Content-Disposition: inline
X-Google-Sender-Auth: a1bcf9a7d747eedb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91260>

On Sun, Aug 3, 2008 at 10:33 AM, Dmitry Potapov <dpotapov@gmail.com> wrote:
> On Sun, Aug 03, 2008 at 09:54:42AM -0700, Tarmigan wrote:
>>
>> For all I care, git can consider the files as binary, but by *default*
>> I should get back the same as I put in.
>
> Sorry, but Git is a source control system,

I think this is the heart of the disagreement.  What I love about git
is that git trusts me, the user, and it trusts my files.  It doesn't
change the encoding of my filenames by default.  It doesn't do keyword
expansion by default.  It doesn't change the case of filenames by
default.

If git is not willing to change the encoding/case of file*names* by
default, how is it acceptable to change the *content* of the files
themselves?

Yes, some systems that define themselves as "source control
management" systems make these changes for you.  But that sometimes
leads to frustrating and hard to understand (to the user) behavior.
Git has a very simple and transparent mental model, which is one of
it's greatest strengths.  In my humble opinion, autocrlf breaks this
simple "content tracker" model.

Breaking this mental model bothers me much more than the practical
issues involved with autocrlf, so I'm just going to drop that line of
argument.

Thanks,
Tarmigan
