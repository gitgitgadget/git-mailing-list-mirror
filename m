From: Christian Couder <christian.couder@gmail.com>
Subject: Re: flatten-merge history
Date: Sun, 26 Oct 2014 06:46:41 +0100
Message-ID: <CAP8UFD3jyZ+7bk-xrE=TghzFj9UL=+Mtz-CvFWK9azNrRcOU5Q@mail.gmail.com>
References: <544B9839.7000302@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Henning Moll <newsScott@gmx.de>
X-From: git-owner@vger.kernel.org Sun Oct 26 06:49:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XiGhJ-0001AF-8O
	for gcvg-git-2@plane.gmane.org; Sun, 26 Oct 2014 06:49:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750909AbaJZFqn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Oct 2014 01:46:43 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:61911 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750787AbaJZFqm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Oct 2014 01:46:42 -0400
Received: by mail-ig0-f177.google.com with SMTP id h18so715991igc.4
        for <git@vger.kernel.org>; Sat, 25 Oct 2014 22:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=0T0+4bEKfQriH1KhD8DZ2IFE1bUUsx+YW0YhgjSGyqg=;
        b=rD7ygR11yEEaSNBC3L5SONZBD1lOxyL2tHTtky7LMbCXHzAtbYFy9+OVuqW5pN++pG
         4uEqH9tgqmyKX+pquKPbesmb2ZoiHO6P4l9Mixgafar/ngxi7MtT+fQBoDacGZN27WLu
         hCxwDWzR0JhMM3ZM62QIb78Q3w6vOfTlxLT8g+/sEgZ4E2KXH1Tsjs3UtAYKMj9xNJ9R
         nVBjmfs9Z/sxVk4OS61J2ZuXBhF+/Vt/XnqbzzYUe7mhB4sp3PqLPMYLZ9litz64RITG
         UoHcfxY8e+2QFhInXTs7Gt6dw/DfnFFB5/fkbEdoB3pxK+eJEAUeBMBMRwYPis4F3L2V
         W/pA==
X-Received: by 10.42.236.13 with SMTP id ki13mr1528360icb.15.1414302401889;
 Sat, 25 Oct 2014 22:46:41 -0700 (PDT)
Received: by 10.50.250.179 with HTTP; Sat, 25 Oct 2014 22:46:41 -0700 (PDT)
In-Reply-To: <544B9839.7000302@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sat, Oct 25, 2014 at 2:31 PM, Henning Moll <newsScott@gmx.de> wrote:
> Hi,
>
> suppose the following history
>
>     P - - - Q - - - - - R       <-extern
>
> A -- - B - - - C - D - - - E   <-master
>           \           \
>           M ...       \         <-b1
>                           \
>                           W ...   <-b2
>
>
> Note that master and extern do not have a common parent. Both histories are
> 'distinct', they do not share common files, so there can't be any merge
> conflicts. What i want to achieve is this history:
>
>     P - - - Q - - - - - R       <-extern
>
> A -P'- B'- Q'- C'- D'- R'- E'  <-master
>             \           \
>             M'...       \         <-b1
>                             \
>                             W'...   <-b2
>
> The two histories should be merged in chronological order.
> So while master reflects P-Q-R, b2 should only reflect P-Q and b1 should
> only reflect P.
>
> All my current attempts (surgery with git replace or interactive rebase
> combined with merging) were not successfull.

Could you tell us why interactive rebase did not work?
If there can't be any merge conflict between both histories, it should
have worked without asking you to resolve any conflict.

Best,
Christian.
