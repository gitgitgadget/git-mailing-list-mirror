From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Finally implement "git log --follow"
Date: Wed, 20 Jun 2007 08:27:49 +0200
Message-ID: <e5bfff550706192327l187b30eblb5bd5e4e76b3eab6@mail.gmail.com>
References: <alpine.LFD.0.98.0706191358180.3593@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jun 20 08:27:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0tfU-0001dR-UY
	for gcvg-git@gmane.org; Wed, 20 Jun 2007 08:27:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758714AbXFTG1v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Jun 2007 02:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758028AbXFTG1v
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jun 2007 02:27:51 -0400
Received: from nz-out-0506.google.com ([64.233.162.234]:3849 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757888AbXFTG1v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2007 02:27:51 -0400
Received: by nz-out-0506.google.com with SMTP id n1so105023nzf
        for <git@vger.kernel.org>; Tue, 19 Jun 2007 23:27:50 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KA3x0nRqoFP7FdAHHb6DBRt9DFlf1Seg/4NUhX/gcJKSAneGNGSLgNBOHS4opEgwl+DkGRkQdFqXBsX/cZYwP8m6B65JOESRP6aE59zQI+UV/iXX/A94eQHCMcnjhlx0hyCOEeXTLp8gMwWN5Xv0TZ50rIYQ5p1RBVtiws70T8s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GO7VW/ndDkrkRyDotXfVtgbr2mFHoU5rlJfxZPDXPdfZOj+nY05S1PyYBeZTQfIY1qE8geSft1BV9T4TdKv+5+bdup0z9kSrgmGlm2SDSuxts1akrl4pbC25cDFO4glZTJYa6ga2Nj+yrYieRr9Ofdcq84opCOSRwdKVOjwwxVI=
Received: by 10.143.158.16 with SMTP id k16mr27077wfo.1182320869820;
        Tue, 19 Jun 2007 23:27:49 -0700 (PDT)
Received: by 10.114.56.6 with HTTP; Tue, 19 Jun 2007 23:27:49 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.98.0706191358180.3593@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50538>

On 6/19/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
> Ok, I've really held off doing this too damn long, because I'm lazy, and I
> was always hoping that somebody else would do it.
>
> But no, people keep asking for it, but nobody actually did anything, so I
> decided I might as well bite the bullet, and instead of telling people
> they could add a "--follow" flag to "git log" to do what they want to do,
> I decided that it looks like I just have to do it for them..
>

Thanks,

  now I have one more reason to switch from using git-rev-list to
git-log in qgit, file history annotation, that is currently based on
git-rev-list, will automatically gain a powerful feature.

Marco

P.S: The only thing that is still missing in git-log against
git-rev-list is a --stdin option. This is needed because with 40 chars
SHA the command line could became very long in case of repos with many
tags/branches or when loading StGIT unapplied patches (one sha per
patch) and one git-rev-list call to loading them all.

Without --stdin we break easily on _some_ OS and in the worst cases (a
lot of unapplied patches) *even* under Linux.
