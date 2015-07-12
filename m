From: Karthik Nayak <karthik.188@gmail.com>
Subject: [GSOC] Update 5: Unification of tag -l, branch -l and for-each-ref
Date: Mon, 13 Jul 2015 02:18:17 +0530
Message-ID: <CAOLa=ZTg7j2S-E+wm3Jm9XqLraTZczP1goVZkiH9diFauho-6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <christian.couder@gmail.com>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 12 22:50:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZEOCQ-0000yW-3H
	for gcvg-git-2@plane.gmane.org; Sun, 12 Jul 2015 22:50:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbbGLUss (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Jul 2015 16:48:48 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:35331 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750926AbbGLUsr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jul 2015 16:48:47 -0400
Received: by obbop1 with SMTP id op1so218551952obb.2
        for <git@vger.kernel.org>; Sun, 12 Jul 2015 13:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=W89UCI8oEh9zVydPevKs7OyftDTBOzw3kSAJJV0vO7o=;
        b=sgi+ezU6HJI0FgLntLs/mBJfCSxSZusdn4X9r0rAl4cQAvC8CI4G0i0F33TBBNtojV
         4WdzGwwdJHJ4QwNmPGutVVfAgnBaanru9Wv4VzTKQbeEPSuPYiFRd14smR7cYf7EFZX7
         vJa2rOjrMWu62c60x1d2/NKke7zrMwFW1wokpJI2q1L2maiiGjRSqwE19ts0C0bl3keu
         8s3f0ye44CSzSd6HYCAcdibfwbOB8edxz2jceSimL/cPeDPrEv70+kI9VtLTVPHeTx3o
         +8rO4BV0RgQ87guzRlBlmr2w10y+4dOJVK4jAr7Yxkc5Tsjtj5knTHJJcYOybhOStUio
         HZyA==
X-Received: by 10.60.41.138 with SMTP id f10mr27376754oel.84.1436734126719;
 Sun, 12 Jul 2015 13:48:46 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Sun, 12 Jul 2015 13:48:17 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273904>

Hello All,

As part of GSoC I'm working on the Unification of 'for-each-ref', 'tag -l'
and 'branch -l'. Sorry for the lack of update since Jun 14, was a
little busy with an exam I had. Now thats over, I will be working more
on the project.

Current Progress:

1. Building ref-filter.{c,h} from for-each-ref.
This is the process of creating an initial library for the unification
by moving most of the code from for-each-ref to ref-filter.{c,h}.
Merged into next

2. Add options to ref-filter.
This includes the porting of --points-at, --contains, --merged,
--no-merged options from builtin/branch.c and builtin/tag.c, Also the
implementation of these options into for-each-ref.
Currently in pu
(https://github.com/git/git/commit/6d4c958d88e6456405b8d65a8bf469382c47f4c5)

3. Port builtin/tag.c to use ref-filter.
Here we port tag.c to use ref-filter and also port the --format,
--sort and --merged and --no-merged options to builtin/tag.c.
Version 2 can be found here
http://thread.gmane.org/gmane.comp.version-control.git/273731
A lot of input on this, Junio and Duy gave some suggestions on
how we can align items in the format option, there has been good progress
in this regard. More at
http://thread.gmane.org/gmane.comp.version-control.git/273732. A
working prototype of these suggestions have been pushed to Github,
where suggestions can be made until I send my next iteration of the
patch series.
Also a lot of changes suggested by my mentors Matthieu and Christian. Most of
which have been implemented and pushed to Github.

Next:
Have been working on branch.c and there is good progress for the same.
Code pushed to Github.

Github: https://github.com/KarthikNayak/git

Thanks to everyone who has helped :)

-- 
Regards,
Karthik Nayak
