From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH] Move all dashed form git commands to libexecdir
Date: Sun, 2 Dec 2007 12:50:05 +0700
Message-ID: <fcaeb9bf0712012150p5430b1fel1addf675adf0aaf0@mail.gmail.com>
References: <20071129231444.GA9616@coredump.intra.peff.net>
	 <20071130005852.GA12224@coredump.intra.peff.net>
	 <alpine.LFD.0.9999.0711291821220.8458@woody.linux-foundation.org>
	 <5E2A9E2B-8B9A-46B0-99D0-DB3798F10119@zib.de>
	 <20071130151223.GB22095@coredump.intra.peff.net>
	 <8aa486160711300728x70f591f1hf8884a78f2b15806@mail.gmail.com>
	 <20071130152942.GA22489@coredump.intra.peff.net>
	 <alpine.LFD.0.9999.0711300745330.8458@woody.linux-foundation.org>
	 <fcaeb9bf0711302234l32460a1fqbf9825fc8055f99d@mail.gmail.com>
	 <7vve7i43ec.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Jeff King" <peff@peff.net>, "Santi B?jar" <sbejar@gmail.com>,
	"Steffen Prohaska" <prohaska@zib.de>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Jan Hudec" <bulb@ucw.cz>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 02 06:50:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iyhiy-0003JP-Ua
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 06:50:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbXLBFuK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 00:50:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750996AbXLBFuK
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 00:50:10 -0500
Received: from mu-out-0910.google.com ([209.85.134.184]:40823 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851AbXLBFuI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 00:50:08 -0500
Received: by mu-out-0910.google.com with SMTP id i10so661897mue
        for <git@vger.kernel.org>; Sat, 01 Dec 2007 21:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=g90Zks6FA4PFE1I1vS3l5G2962U+IIOu4WKDUoaSb88=;
        b=KbyKEZYGNFIdQ7/ZZVUg1wFg5HDWgU/jGnUQK3txsi0XL3VSXVya9mSlT67FG/6wBbCMQtsC/Yvmkhir1L82WjF11ljnGRUPZjgVNHTMZDeYd7fT24xGQXXchLDlh3BxHXdU6v28kZyzPOP7FfuTQFTlQwpIGQ3gA83JlgDEbtU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=L+VvJHV5Utfmhf1hQcv9kKuYD15QGEvbhp3dZBCVV0ItSilNMxy67bhI99aQMMwR995SNxDt6uUEKAJ5GKISWIZqFAr5UjcHDR5TK0jYmZwjBuCJJJPOAF1jowMKWV2IHJ3BnG8WHrAxt5MkBrPp/5CaMrii6tKpGknhrEDvpCs=
Received: by 10.86.60.7 with SMTP id i7mr9145383fga.1196574605519;
        Sat, 01 Dec 2007 21:50:05 -0800 (PST)
Received: by 10.86.83.6 with HTTP; Sat, 1 Dec 2007 21:50:05 -0800 (PST)
In-Reply-To: <7vve7i43ec.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66760>

On Dec 2, 2007 2:32 AM, Junio C Hamano <gitster@pobox.com> wrote:
> "Nguyen Thai Ngoc Duy" <pclouds@gmail.com> writes:
>
> > On Nov 30, 2007 10:50 PM, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> >
> >> Well, different people will want different viewers *anyway* (ie some will
> >> prefer qgit etc), so how about making "git view" be something that
> >> literally acts as a built-in alias that just defaults to running gitk (if
> >> for no other reason than the fact that gitk is the one that ships with
> >> git, and simply has most users).
> >
> > We already have "git show", now we gonna get "git view", git trainers
> > may have hard time explaining this one shows you a particular object
> > while the other one shows you history. How about "git lshistory" (from
> > clearcase land) or git show --history?
>
> Heh, we have "bisect visualize".  How about "git visualize"?
>

"git visualize"++


-- 
Duy
