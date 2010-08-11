From: Adam Mercer <ramercer@gmail.com>
Subject: Re: Using filter-branch to move repo contents in subdirectory
Date: Wed, 11 Aug 2010 14:59:03 -0500
Message-ID: <AANLkTi=G=oWaQ4PvjbkfEs2FUXgbKr3s+hWy8azSZsAH@mail.gmail.com>
References: <AANLkTik2dL5jrEjZe0LB6Y4_PEwRt-7t_5CG7gup3pnV@mail.gmail.com> 
	<AANLkTi=TeJvF+swpMWddDtA7jh4XWedQ+FjigEdRYkx_@mail.gmail.com> 
	<AANLkTimu+V8zJeBV65nhqw0zaQHVHzZZahw2q-20SaWO@mail.gmail.com> 
	<20100811193214.GB8106@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 11 21:59:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjHSZ-0000Sr-LL
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 21:59:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758491Ab0HKT7Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Aug 2010 15:59:25 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:57506 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756655Ab0HKT7Y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Aug 2010 15:59:24 -0400
Received: by fxm13 with SMTP id 13so390759fxm.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 12:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=oGrfNmR9KJioyq9dEemV4SltTU4F1Bf+9oCb7HKIdz8=;
        b=hsD+XzbGhH1LZ/JfGz+fy5rfSwQ9sUcqG1Zod5/Lh4fSOC65/8yiciuW/RlM5vJdCx
         GGV5QUpvxqFZmX/CfjddVvaxwFV6lkJateokhhv1dXci9fta2itMYfct+ThfNAozWqhu
         d4Qu2mXJGirb4mslhfo90uY5KMbu3kF9laQwU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=xnxIlNm+++IskmYIgjjtpPc/XsREIL5oUWXmtVRFG/51C3+QVR3weV+7GcUpUTjeR1
         sMJ/m2m1DGVzuaZdYGjdGBkJqeaSdAIzdfqYonrqpA/tKuGErpe4bx2/spS2qXsphrWm
         ppLaHydK1EJ8OCbVbMkYxkU2mBtR6PIF+CbCY=
Received: by 10.239.155.74 with SMTP id h10mr1080829hbc.30.1281556763223; Wed, 
	11 Aug 2010 12:59:23 -0700 (PDT)
Received: by 10.239.183.74 with HTTP; Wed, 11 Aug 2010 12:59:03 -0700 (PDT)
In-Reply-To: <20100811193214.GB8106@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153297>

On Wed, Aug 11, 2010 at 14:32, Jeff King <peff@peff.net> wrote:

> It looks like git-update-index will not create $GIT_INDEX_FILE at all if
> you have no actual input lines to --index-info. So perhaps you have some
> commit in your repo that has no actual content in it. Either that or
> for some reason your "ls-files -s | gsed" invocation is producing no
> output.

Yep, that was the problem. I'd been modifying the history with several
git filter-branch calls and the initial commit in the repo was empty.
Getting rid of this initial empty commit allowed the command to run.

Cheers

Adam
