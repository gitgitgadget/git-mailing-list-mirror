From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH] remote: unify main and subcommand usage strings
Date: Sun, 3 Nov 2013 15:17:10 +0800
Message-ID: <CANYiYbGD=VJ64pESwxkMYy8HxESyW_2N0Q5M92rCJF2E1FD-bw@mail.gmail.com>
References: <52746664.1050806@gmail.com>
	<c2d51c4014545f037bb9399dba7b378d6d79d18b.1383407880.git.tr@thomasrast.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Sun Nov 03 08:17:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VcrwB-0003RL-2J
	for gcvg-git-2@plane.gmane.org; Sun, 03 Nov 2013 08:17:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752060Ab3KCHRN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Nov 2013 02:17:13 -0500
Received: from mail-we0-f170.google.com ([74.125.82.170]:39696 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751761Ab3KCHRM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Nov 2013 02:17:12 -0500
Received: by mail-we0-f170.google.com with SMTP id u57so982041wes.1
        for <git@vger.kernel.org>; Sun, 03 Nov 2013 00:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=X7nHfyN57VzAYfTkHyql+ycrYhQHZpLrCVMppQ5ugMk=;
        b=hBZlVKjSb2BTVz1SUC7QBb92xHZGGGzs0LCAmYhsFVNCtl1pGUZsOlvDgI02bdm0d7
         WSQXUyqDem62p+lHB/dFtmx6F7uVSK1TrweTaK1pRaqPKCkovNo3ICRGtZc3/35G7yMb
         mUDnLo5vJr6NNYt2y5E/Qa9QaIdLM9XiTN7x5qTZRseBiulfAhCJ0s0fUlRI/2L217UR
         d3VN+A5yxgXORy8jNLlVT4HCjA2vrchreR0KwMN99VZ/6It+IObCbjWcDpSiV3VZoQVi
         9ANvjoyyxdEyIMbI9np74JNQ2AmoNZ3ShLLbpmdpRbGJpHyvHItBRbvOdMPBq1laOcjd
         uC5A==
X-Received: by 10.180.12.45 with SMTP id v13mr7828761wib.57.1383463030699;
 Sun, 03 Nov 2013 00:17:10 -0700 (PDT)
Received: by 10.216.122.202 with HTTP; Sun, 3 Nov 2013 00:17:10 -0700 (PDT)
In-Reply-To: <c2d51c4014545f037bb9399dba7b378d6d79d18b.1383407880.git.tr@thomasrast.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237254>

2013/11/3 Thomas Rast <tr@thomasrast.ch>:
> We had separate usages for each subcommand, and for the main command,
> even though the latter is essentially a concatenation of all of the
> former.  This leads to a lot of duplication and unnecessary
> differences, e.g., in the 'set-head' case the two strings differ only
> in a space.
>
> Unify the strings in the usages by putting each of them in a variable,
> and assembling the usage arrays from them.
>
> Note that this patch changes the usage strings for the following
> subcommands:
>
> - prune and show: the individual usage only said [<options>].  Kept
>   the snippet from the main usage, which is more specific.
>
> - set-branches: kept the main usage, which is more concise in saying
>   that --add is optional
>

Differences of git-remote usages after applied your patch.

diff -u before/git-remote-add-usage after/git-remote-add-usage
--- before/git-remote-add-usage 2013-11-03 15:10:06.000000000 +0800
+++ after/git-remote-add-usage 2013-11-03 15:11:32.000000000 +0800
@@ -1,4 +1,4 @@
-usage: git remote add [<options>] <name> <url>
+usage: git remote add [-t <branch>] [-m <master>] [-f]
[--tags|--no-tags] [--mirror=<fetch|push>] <name> <url>

     -f, --fetch           fetch the remote branches
     --tags                import all tags and associated objects when fetching

diff -u before/git-remote-prune-usage after/git-remote-prune-usage
--- before/git-remote-prune-usage 2013-11-03 15:10:06.000000000 +0800
+++ after/git-remote-prune-usage 2013-11-03 15:11:32.000000000 +0800
@@ -1,4 +1,4 @@
-usage: git remote prune [<options>] <name>
+usage: git remote prune [-n | --dry-run] <name>

     -n, --dry-run         dry run

diff -u before/git-remote-set-branches-usage after/git-remote-set-branches-usage
--- before/git-remote-set-branches-usage 2013-11-03 15:10:06.000000000 +0800
+++ after/git-remote-set-branches-usage 2013-11-03 15:11:32.000000000 +0800
@@ -1,5 +1,4 @@
-usage: git remote set-branches <name> <branch>...
-   or: git remote set-branches --add <name> <branch>...
+usage: git remote set-branches [--add] <name> <branch>...

     --add                 add branch

diff -u before/git-remote-show-usage after/git-remote-show-usage
--- before/git-remote-show-usage 2013-11-03 15:10:06.000000000 +0800
+++ after/git-remote-show-usage 2013-11-03 15:11:32.000000000 +0800
@@ -1,4 +1,4 @@
-usage: git remote show [<options>] <name>
+usage: git remote [-v | --verbose] show [-n] <name>

     -n                    do not query remotes

diff -u before/git-remote-update-usage after/git-remote-update-usage
--- before/git-remote-update-usage 2013-11-03 15:10:06.000000000 +0800
+++ after/git-remote-update-usage 2013-11-03 15:11:32.000000000 +0800
@@ -1,4 +1,4 @@
-usage: git remote update [<options>] [<group> | <remote>]...
+usage: git remote [-v | --verbose] update [-p | --prune] [(<group> |
<remote>)...]

     -p, --prune           prune remotes after fetching




-- 
Jiang Xin
