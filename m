From: Aaron Mell <amell@alkamitech.com>
Subject: Commit empty during rebase 2.8.1 windows
Date: Thu, 14 Apr 2016 10:39:17 -0500
Message-ID: <CAO0Hcd+Ygd_3n_xvQRB9dtuezhRKpxwuvAgqeGgQ9QZ-_b8uhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 17:39:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqjMb-0000Ed-J0
	for gcvg-git-2@plane.gmane.org; Thu, 14 Apr 2016 17:39:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756034AbcDNPjU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2016 11:39:20 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:38199 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755690AbcDNPjT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2016 11:39:19 -0400
Received: by mail-wm0-f45.google.com with SMTP id u206so131743612wme.1
        for <git@vger.kernel.org>; Thu, 14 Apr 2016 08:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=alkamitech.com; s=google;
        h=mime-version:date:message-id:subject:from:to;
        bh=5CSTsOHuqiGpOKoOTVERHYkwiqaYIUa+eR8LTUQskMA=;
        b=PfJ75M37BJ4/SVmczPqBUFf+n6AnRdPgx+AjTfFgX2gX4Ux4MWyxE75AlHa6FNlOQx
         t/OA3PlTmsCrDuvV+iC7beGoyY1MtTF2wPVH4YeP9eB5OWSuy2LK7kkKvvAG+NzLGV4f
         ISBL+PWXFUCOp8WvES5+Vy67dSAQMuqlDoFWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=5CSTsOHuqiGpOKoOTVERHYkwiqaYIUa+eR8LTUQskMA=;
        b=nIgn/qwx8/gNJemfOXOJWi+LYQ/BDwG4GdAd3C02j29Cm/1SJ5QusOybDvtq6PTefD
         plUF/9PpD4ZjiidJaFh6DLbWMAHCYpfF5CuanSpWv4ULf5j+eOkimeZW5Q/hhqhX+/G2
         Zsns0kKfdUVBkZvFAPTzWY3GS1Hh7QgGppKanG7pva2bo5P+jnba7sRN5vKH+Ruti0Bi
         NDQAfo1PbFXexyv2LaKCatJL39Lgxa2OaXTAwqHZcBqyuhDv3B3DoaXZNkEllfzpqUN4
         O3F3l8mX2BRvPd4ntaRHS5TctOEmXT4kS8Bq231tussSbMOSNjs/U2Q8cy77jDM/AHur
         puBA==
X-Gm-Message-State: AOPr4FW7RiFTYOa2CZNpiiI6CcTB/lotwDT15jshRc8zhtQeEmWfitMDN3m7Rnb7jNneYVZ33Y/YSk3CiHYOsxAX
X-Received: by 10.194.2.130 with SMTP id 2mr16480031wju.77.1460648358038; Thu,
 14 Apr 2016 08:39:18 -0700 (PDT)
Received: by 10.28.182.138 with HTTP; Thu, 14 Apr 2016 08:39:17 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291526>

So twice now during this particular rebase I have had this happen. All of
the work in this commit after being applied is gone. The only caveat is
that I had sourcetree running at the time, and I wonder if that is
somehow causing the
issue.


aaron@aaron MINGW64 /c/src/FORB (mybranch|REBASE 12/42)
$ git rebase --continue
Applying: Commit1
Applying: Commit2
Using index info to reconstruct a base tree...

my changed files were here

.git/rebase-apply/patch:59: trailing whitespace.
Insert Into
.git/rebase-apply/patch:60: trailing whitespace.
core.Provider
.git/rebase-apply/patch:61: trailing whitespace.
(ProviderTypeId, Name, Description, AssemblyInfo, CreateDate)
.git/rebase-apply/patch:66: trailing whitespace.

.git/rebase-apply/patch:72: trailing whitespace.

warning: squelched 41 whitespace errors
warning: 46 lines add whitespace errors.
Falling back to patching base and 3-way merge...
error: The following untracked working tree files would be overwritten by
merge:
file1
file2
Please move or remove them before you can merge.
Aborting
error: Failed to merge in the changes.
Patch failed at commit2
The copy of the patch that failed is found in: .git/rebase-apply/patch

When you have resolved this problem, run "git rebase --continue".
If you prefer to skip this patch, run "git rebase --skip" instead.
To check out the original branch and stop rebasing, run "git rebase
--abort".


aaron@aaron MINGW64 /c/src/FORB (mybranch|REBASE 12/42)
$ git status
rebase in progress; onto 210fcac
You are currently rebasing branch 'mybranch' on '210fcac'.
(all conflicts fixed: run "git rebase --continue")

nothing to commit, working directory clean
