From: Bastian Binder <bastian.binder1@gmail.com>
Subject: git pull --rebase overwrites/deletes empty commits
Date: Thu, 7 Jan 2016 13:56:20 +0100
Message-ID: <CAL8XmJ2tp3A1NY_5BoNNLr=g+D4KUa7-iZy7_3E8kCUhSjNGAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 07 13:56:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHA78-0000ef-99
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jan 2016 13:56:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752458AbcAGM4W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2016 07:56:22 -0500
Received: from mail-lf0-f43.google.com ([209.85.215.43]:35368 "EHLO
	mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751458AbcAGM4W (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2016 07:56:22 -0500
Received: by mail-lf0-f43.google.com with SMTP id c192so155369787lfe.2
        for <git@vger.kernel.org>; Thu, 07 Jan 2016 04:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=PSieP4IoyybCDx7p77xyIdEuuF7tcmFm588MYQc8dHQ=;
        b=P5CM5LplaeDwqN/fn81LuciMudPGWkH971m7EgtKYSEUNSDffz+s+w8Zueylx4aV1T
         Vh8q64qfLaTq8CAY0OnEOxNr2Ax7mWNl25BotAMFONEggQBXpnNHrJ7cIUklqMYXCjKw
         gAPkU67ldfSD3thkJXoU9Y5au0jhss30ZUK9UOul03wz91SExiingeyHfqsHn8Wnqat7
         5zrboDExqDnZ2FA+1XqfXk7EF6oE7lfAWc0cTZvE8Vjxs2kRfVIC2wWGYHfY54ZM9CN0
         5E9JOHjwHJGrz1/8VJpRDqOhYIdV0LycSTJ8iGhlg4QJZ2hxH0DA73iq8KAaJ6+4vDW6
         5JJg==
X-Received: by 10.25.148.142 with SMTP id w136mr22394001lfd.31.1452171380699;
 Thu, 07 Jan 2016 04:56:20 -0800 (PST)
Received: by 10.25.211.85 with HTTP; Thu, 7 Jan 2016 04:56:20 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283480>

Hello,

I have recently encountered a probable bug in git. We have messages we
want to appear in the log and do an empty commit:

git commit --allow-empty -m "message we want to publish"

After this commit, we do a fetch-rebase in order to pull the
intermediate commits into the local branch before pushing:

git pull --rebase branch origin branch

Problem is: the pull --rebase will delete the empty commit. I see git
rebase has a --keep-empty option. I cannot find such option for the
pull --rebase operation.

Thanks in advance,

Bastian
