From: Peter Lauri <peterlauri@gmail.com>
Subject: Re: .gitignore behavior on Mac
Date: Sat, 18 May 2013 20:43:57 +0200
Message-ID: <CAEe6bfB30aD0LcgR4fzLy=xJGwzASJpgfvvtoTmFmJ1_2HZ4Jg@mail.gmail.com>
References: <CAEe6bfD_1GjMBByaEFQ4RMTMaz8XZvd00mxyfaAHtXVpbUjj6A@mail.gmail.com>
	<20130518184136.GH27005@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sat May 18 20:44:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Udm6t-0007l2-9N
	for gcvg-git-2@plane.gmane.org; Sat, 18 May 2013 20:44:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752763Ab3ERSn7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 May 2013 14:43:59 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:34036 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752651Ab3ERSn7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 May 2013 14:43:59 -0400
Received: by mail-la0-f46.google.com with SMTP id er20so1104907lab.33
        for <git@vger.kernel.org>; Sat, 18 May 2013 11:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=ISttc0f8ovDsIq0OJeaUyEZm5m8ZOLLvfymYg5ImoVs=;
        b=aPRsKytHnn6jyuHX6MSr+6V+wbUV5geCm6BaFV4dprxBomvJwZGaXNDZWJLZablHIE
         vjBszBdfWoVCOgCzKkJL8GsuncalLpbg2XU7D2jmpf0SdIKXlp8oZintOLC/6drpDpYz
         d1xvcvilqHRTjqiPDb67Af5I2LCMMym4qMgeQyjEw/B1AU6LjjcO9q6r9GibXYNMLjYU
         Dh/7LBh7tKrE+1eyHWF+pN+NLIloe0wyPCXZWzGMAg6gNdsEZhSOLpaPPT4KHVVbIPHL
         X82JumAK0KtK+pGduzcsUpkevcCuI8ZerVg/zmWmZj8MSTdYc5khTtX8qBz3lEzM/8C3
         2mJQ==
X-Received: by 10.152.120.104 with SMTP id lb8mr11986647lab.11.1368902637555;
 Sat, 18 May 2013 11:43:57 -0700 (PDT)
Received: by 10.112.20.197 with HTTP; Sat, 18 May 2013 11:43:57 -0700 (PDT)
In-Reply-To: <20130518184136.GH27005@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224804>

But I just don't want to see that darn file. It is a config file that
I have changed, and I don't want to need to stash it for each "git
svn" action I want to perform... Any solution for that?

On Sat, May 18, 2013 at 8:41 PM, John Keeping <john@keeping.me.uk> wrote:
> On Sat, May 18, 2013 at 08:36:42PM +0200, Peter Lauri wrote:
>> Shouldn't this be valid? I would expect to NOT see the
>> core/inc/config.inc.php in the "git status" output...
>>
>> Peters-MacBook-Air:dt-git plauri$ cat .gitignore
>> .buildpath
>> .project
>> .settings/
>> web/pjotr.php
>> core/inc/config.inc.php
>> dt_error.log
>> process_wrapper.sh
>>
>> Peters-MacBook-Air:dt-git plauri$ git status
>> # On branch local/DT-7_gantt
>> # Changes not staged for commit:
>> #   (use "git add <file>..." to update what will be committed)
>> #   (use "git checkout -- <file>..." to discard changes in working directory)
>> #
>> # modified:   .gitignore
>> # modified:   core/inc/config.inc.php
>
> core/inc/config.inc.php is already in the repository.  Git won't ignore
> files that are already tracked.
>
> If you remove the file from the index:
>
>     git rm --cached core/inc/config.inc.php
>
> then you'll see it as deleted in "git status" but it won't appear in the
> untracked files section even though it's still there in the working
> tree.
>
>> # Untracked files:
>> #   (use "git add <file>..." to include in what will be committed)
>> #
>> # out.ionel
>> # tree.py
>> no changes added to commit (use "git add" and/or "git commit -a")
>> Peters-MacBook-Air:dt-git plauri$
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
