From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: gitignore excludes not working?
Date: Fri, 6 Dec 2013 12:26:59 -0500
Message-ID: <CACPiFCJ0Jj1M8KCrwus=DeRSBE2O3HKhvEo-UJhHoZDhHTzsSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 06 18:27:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VozBV-0000zV-QF
	for gcvg-git-2@plane.gmane.org; Fri, 06 Dec 2013 18:27:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754641Ab3LFR1V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Dec 2013 12:27:21 -0500
Received: from mail-vc0-f171.google.com ([209.85.220.171]:45018 "EHLO
	mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753223Ab3LFR1V (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Dec 2013 12:27:21 -0500
Received: by mail-vc0-f171.google.com with SMTP id ik5so1034256vcb.30
        for <git@vger.kernel.org>; Fri, 06 Dec 2013 09:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=b1nnW/po3IcLvyK7dah1TcMWjzkGzOaFVWGYY67XGBY=;
        b=ugy7scO5nuxK8tVSOWF5hbVeVzmv2oCz5LeJHwf60t/iFExKslLWMpdRSGvJ9e5gkK
         QH3hv4TTBeVgaxTknW+FroBhPRSZjtElddjWnlBzlRDurvFIDc3NL+IVAAZFJxj9pSfN
         QcqNP5E+ngnR9P2Pz1r/Mz5unYnUJte1enWPM1NfMzAncbUhGX40WkNHIZ7LORGJU9V7
         47FJTr7OqN7Q2LeG+u7JYhL1yelSP4grx+SAwjSlhvqsnaxpRjAqC8REhNtLuPIo5Z16
         UdRlaV/Pj/ql1sch8k8B6ZwNrTiV8ySeEAYFHkn9MOdJ0ggqRjzw5hN/4PGvGOEcKW7A
         qjIQ==
X-Received: by 10.58.217.169 with SMTP id oz9mr2612152vec.42.1386350840105;
 Fri, 06 Dec 2013 09:27:20 -0800 (PST)
Received: by 10.220.74.133 with HTTP; Fri, 6 Dec 2013 09:26:59 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238936>

Tested with git 1.7.12.4 (Apple Git-37) and git 1.8.3.1 on F20.

$ mkdir foo
$ cd foo
$ git init
Initialized empty Git repository in /tmp/foo/.git/
$ mkdir -p modules/boring
$ mkdir -p modules/interesting
$ touch modules/boring/lib.c
$ touch modules/interesting/other.c
$ touch modules/interesting/lib.c
$ git add modules/interesting/lib.c
$ git status
# On branch master
#
# Initial commit
#
# Changes to be committed:
#   (use "git rm --cached <file>..." to unstage)
#
# new file:   modules/interesting/lib.c
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
# modules/boring/
# modules/interesting/other.c

$ echo '/modules/' > .gitignore
$ echo '!/modules/interesting/' >> .gitignore

On this git status, I would expect to see modules/interesting/other.c
listed as untracked, however:

$ git status
# On branch master
#
# Initial commit
#
# Changes to be committed:
#   (use "git rm --cached <file>..." to unstage)
#
# new file:   modules/interesting/lib.c
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
# .gitignore


thoughts?



m
-- 
 martin.langhoff@gmail.com
 -  ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 ~ http://docs.moodle.org/en/User:Martin_Langhoff
