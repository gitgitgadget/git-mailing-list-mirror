From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Find the starting point of a local branch
Date: Mon, 24 Dec 2012 12:28:45 +0700
Message-ID: <CACsJy8CNd3W_WUMbZ1QZ4ReZ5ziX90QejK9mh1TMs0ig33kGMw@mail.gmail.com>
References: <20121224035825.GA17203@zuhnb712> <201212240409.qBO49wkV020768@no.baka.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Woody Wu <narkewoody@gmail.com>, git <git@vger.kernel.org>
To: Seth Robertson <in-gitvger@baka.org>
X-From: git-owner@vger.kernel.org Mon Dec 24 06:29:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tn0bW-0000pu-KV
	for gcvg-git-2@plane.gmane.org; Mon, 24 Dec 2012 06:29:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751492Ab2LXF3R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Dec 2012 00:29:17 -0500
Received: from mail-ob0-f173.google.com ([209.85.214.173]:53640 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102Ab2LXF3P (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Dec 2012 00:29:15 -0500
Received: by mail-ob0-f173.google.com with SMTP id xn12so6414857obc.18
        for <git@vger.kernel.org>; Sun, 23 Dec 2012 21:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Xhl5eHPaCeRUEdM0XrCQlSd13BCl16SwcYiwYRTqjD0=;
        b=kUosy/YZO8ryh5HaFkVu6eQECG/L++bf6Qa+YGRjU64Rboe1strC0iPalV7yYBKF5M
         7CW9EDLkEbLUITV0z0FnVJufX9BW7XJOTZjgpPD4STSgn4mR2Fa6WgU/ZYp+Ny/8M09v
         pteUroyBnNDDuv95lwPJfleREIzHVGe1LTK6zJgiIKbYu/DYhW8g0CM3arxlbh+sLQug
         7kwv8Wc5TY+kS+rpvzxL1MXPdJ8ZRQB3QqkY3Lzypa6KXAQBnIA1HKFCZzNqSHYtN9nN
         7PY1OMLSGv1viJ7dbPdLZXMBNuk7JTLLzAktWMK+iJj3GuAKLC0UOM9M616VMDy8felR
         5JXQ==
Received: by 10.60.32.234 with SMTP id m10mr5388561oei.7.1356326955235; Sun,
 23 Dec 2012 21:29:15 -0800 (PST)
Received: by 10.182.27.168 with HTTP; Sun, 23 Dec 2012 21:28:45 -0800 (PST)
In-Reply-To: <201212240409.qBO49wkV020768@no.baka.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212097>

On Mon, Dec 24, 2012 at 11:09 AM, Seth Robertson <in-gitvger@baka.org> wrote:
>
> In message <20121224035825.GA17203@zuhnb712>, Woody Wu writes:
>
>     How can I find out what's the staring reference point (a commit number
>     or tag name) of a locally created branch? I can use gitk to find out it
>     but this method is slow, I think there might be a command line to do it
>     quickly.
>
> The answer is more complex than you probably suspected.
>
> Technically, `git log --oneline mybranch | tail -n 1` will tell you
> the starting point of any branch.  But...I'm sure that isn't what you
> want to know.
>
> You want to know "what commit was I at when I typed `git branch
> mybranch`"?  The problem is git doesn't record this information and
> doesn't have the slightest clue.

Maybe we should store this information. reflog is a perfect place for
this, I think. If this information is reliably available, git rebase
can be told to "rebase my whole branch" instead of my choosing the
base commit for it.
-- 
Duy
