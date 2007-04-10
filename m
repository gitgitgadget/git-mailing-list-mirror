From: Tomash Brechko <tomash.brechko@gmail.com>
Subject: Re: [PATCH (resend)] Pass -C1 to git-apply in StGIT's apply_diff() and apply_patch().
Date: Tue, 10 Apr 2007 23:32:14 +0400
Message-ID: <20070410193214.GF4946@moonlight.home>
References: <20070409112422.GE11593@moonlight.home> <b0943d9e0704100948k2b505916w5485b99e72d36c10@mail.gmail.com> <20070410192130.GE4946@moonlight.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 01:11:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbM4m-0001DX-LE
	for gcvg-git@gmane.org; Tue, 10 Apr 2007 21:32:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753312AbXDJTcV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 15:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753329AbXDJTcV
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 15:32:21 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:62761 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753312AbXDJTcV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 15:32:21 -0400
Received: by ug-out-1314.google.com with SMTP id 44so137781uga
        for <git@vger.kernel.org>; Tue, 10 Apr 2007 12:32:19 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:date:from:to:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=RlsCm8Ol4SYC+wWYB7yjhBgpPj3OMiWHyypG/Cr+Pb53JxFBC6AeHV4pyzgtzUN4expAFIue81klBc5j5feFVjLs5DUfmWmSdWaEcKjxiV+Zu5TbYJP8+MYBkCIhQs69oQp/7bxu3tbs8K46mfJ7aeCcI/uodzKRl4m4wuJHfDk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=qynmozDDkNxZSu8yp/4BOaE07rE+iUNqPvLBWd82IdIspO+/TmmsemOBsmNaeb1uTaQOr17HIvnOgssBPnFh5Dun2CXV9LcZXy89vh8/pWEejmCL+eyZ6tphBm+PUu1WpesFwmH+4JlFYo4lBrZbSnshFaYL59+Q63dtrW35DSw=
Received: by 10.67.103.7 with SMTP id f7mr516921ugm.1176233539484;
        Tue, 10 Apr 2007 12:32:19 -0700 (PDT)
Received: from moonlight.home ( [80.246.71.156])
        by mx.google.com with ESMTP id e34sm1102689ugd.2007.04.10.12.32.18;
        Tue, 10 Apr 2007 12:32:19 -0700 (PDT)
Received: from moonlight.home (localhost.localdomain [127.0.0.1])
	by moonlight.home (Postfix) with ESMTP id 139273A7C2;
	Tue, 10 Apr 2007 23:32:15 +0400 (MSD)
Received: (from tomash@localhost)
	by moonlight.home (8.13.1/8.13.1/Submit) id l3AJWE1k001115;
	Tue, 10 Apr 2007 23:32:14 +0400
Mail-Followup-To: git@vger.kernel.org,
	Catalin Marinas <catalin.marinas@gmail.com>
Content-Disposition: inline
In-Reply-To: <20070410192130.GE4946@moonlight.home>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44147>

On Tue, Apr 10, 2007 at 23:21:30 +0400, Tomash Brechko wrote:
> But I see your point, and back then I didn't realize how it will
> affect the 'push' command.
> 
> So, I think the best would be to have 'pull'-like commands (pull,
> rebase, import, fold, sync) to be liberal by default (accept pathes
> with -C1), while 'push'-like commands (push, any other?) to be
> conservative (require full context match).  And both classes should
> provide the way to explicitly control acceptance level.

Please disregard this part.  It's late here, and I mistook StGIT's
push for GIT's push.  Once we are talking about StGIT's push (push of
the patch back to the stack), why would we want to start tree-way
merge when the context has changed?  My point was exactly that since I
want to keep my patches up-to-date with the main branch, I do rebase
from time to time, and I'm not interested in doing the merge every
time just because something has changed upstream in surrounding code.

The same goes for patches that were already applied upstream.
Whatever the current context around the code of my applied patch is, I
have to accept it, because the patch was applied.  I'm going to throw
it away locally, but currently I have to do the merge first.

I think I didn't get you point.


-- 
   Tomash Brechko
