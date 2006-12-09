X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: kernel.org mirroring (Re: [GIT PULL] MMC update)
Date: Sat, 9 Dec 2006 14:28:25 +1300
Message-ID: <46a038f90612081728s65d65ccewe64fa1a496de76fa@mail.gmail.com>
References: <Pine.LNX.4.64.0612020835110.3476@woody.osdl.org>
	 <4578722E.9030402@zytor.com> <4579611F.5010303@dawes.za.net>
	 <200612081438.25493.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 9 Dec 2006 01:28:35 +0000 (UTC)
Cc: "Rogan Dawes" <discard@dawes.za.net>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Linus Torvalds" <torvalds@osdl.org>,
	"Kernel Org Admin" <ftpadmin@kernel.org>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Petr Baudis" <pasky@ucw.cz>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JT2Pa/yTE8xr/MYQ4VVCSzcd7ydmHLn8oc3Begr9ag2D38eDzs8w5jtZJxFirAM0HrAI3eLAE9tMHEuHS1R2TVF4jONOf8d2hp2kFkAP/AMSW66wKdTdmI0MDizlOW86qGZcBHw8ptPXCOKgIbRBWupFDycsQRs5ln0tKTApCpw=
In-Reply-To: <200612081438.25493.jnareb@gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33785>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gsr0x-0000G0-Ej for gcvg-git@gmane.org; Sat, 09 Dec
 2006 02:28:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1947619AbWLIB22 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 20:28:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947624AbWLIB22
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 20:28:28 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:53286 "EHLO
 nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1947619AbWLIB21 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec
 2006 20:28:27 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1287557nfa for
 <git@vger.kernel.org>; Fri, 08 Dec 2006 17:28:26 -0800 (PST)
Received: by 10.49.80.12 with SMTP id h12mr1142326nfl.1165627705902; Fri, 08
 Dec 2006 17:28:25 -0800 (PST)
Received: by 10.49.51.10 with HTTP; Fri, 8 Dec 2006 17:28:25 -0800 (PST)
To: "Jakub Narebski" <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

On 12/9/06, Jakub Narebski <jnareb@gmail.com> wrote:
> Perhaps gitweb should generate it's own ETag instead of messing with
> 'expires' header?

That'll be the winning solution. A combination of

 - cache SHA1-based requests forever
 - cache ref-based requests a longish time,  setting an ETag that
contains headname+SHA1
 - on 'revalidate', check the ETag vs the ref and only recompute if
things have changed

In the meantime, the code on kernel.org needs to be updated to the
latest gitweb. On our server, I'd say the newer gitweb is 3~4 times
faster serving the "expensive" summary pages. And much smarter in
terms of caching headers.

cheers


