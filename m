From: John Bartholomew <jpa.bartholomew@gmail.com>
Subject: Enhanced git branch list (proposal)
Date: Mon, 23 Jul 2012 19:17:47 +0100
Message-ID: <500D954B.4090007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 23 20:18:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StNCf-0006zn-NA
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 20:17:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754496Ab2GWSRw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 14:17:52 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:63391 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754186Ab2GWSRv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 14:17:51 -0400
Received: by bkwj10 with SMTP id j10so5586434bkw.19
        for <git@vger.kernel.org>; Mon, 23 Jul 2012 11:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=Y3NQ3WyU8fzusFK+Ac1HO1GmtQ+SW0rUQ9Ds239W/j0=;
        b=RSj/R3DpQCQq0tKH6hLvma0BT/nO9GLbFzIGhPa94Fqpy6NR0tSCHp1MJoB717c14l
         qO8UN0h3MdCuPfJW1QHibyMfPfUyULyImYhp0khtNkw8vBKMsMHXCytBBARPmJfIWzFw
         Nt0NdIZekIfxSzNYyTsodvRKZ2NsN6dijr2OeQ1PQYV7HmSi5/pKOztkzsj9EgZ91fgr
         QE5NDB14JJ6c13jM5tThpPiEUiluf2PTzbjrr4P5GkfitPBw2wORXqQEb1LkARspWpBw
         1Gc4YtrLsLMIujmJyj4MrtYeCrF8yS4ULHVjQSLSuD3qEh8CT6+ZaAhifAfgTgx8UyY3
         wq5w==
Received: by 10.205.123.133 with SMTP id gk5mr8350523bkc.140.1343067469790;
        Mon, 23 Jul 2012 11:17:49 -0700 (PDT)
Received: from [192.168.1.64] (78-105-125-165.zone3.bethere.co.uk. [78.105.125.165])
        by mx.google.com with ESMTPS id fu8sm8608455bkc.5.2012.07.23.11.17.48
        (version=SSLv3 cipher=OTHER);
        Mon, 23 Jul 2012 11:17:49 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120717 Thunderbird/14.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201946>

I find the output of `git branch' to be quite bare, and would like to
see more information; most importantly, what the state of the branch
is in relation to its upstream. For some time I have been using my
own script to do this. It produces output like this:

$ git lsb
  commodity-market-lua [behind 'brianetta/commodity-market-lua' by 2
commits]
  filesystem [up-to-date with 'jpab/filesystem']
  fix-ring-blending [ahead of 'jpab/fix-ring-blending' by 1 commit]
  galaxy-refactor
  galaxy-refactor-2 [diverged from 'jpab/galaxy-refactor', by 6
commits/626 commits (us/them)]
  hud-pitch-ladder [up-to-date with 'jpab/hud-pitch-ladder']
= issue-1388
  issue-695
  lmr-mtllib-improvements
  marcel-stations
* master [up-to-date with 'jpab/master']
  refcounted-body [up-to-date with 'jpab/refcounted-body']
  string-formatter [up-to-date with 'jpab/string-formatter']

The first column indicates the relation to HEAD: '*' marks the current
head, '=' marks a branch which is identical with the current HEAD.

Branches which have a configured upstream (branch.remote and
branch.merge are set) show the relation to the corresponding remote
branch.

Some key text ('up-to-date', 'ahead', 'behind' or 'diverged', and the
name of the current HEAD) is displayed with colour if colour is
enabled.

Arguments can be passed to show remote branches (for all remotes, or
for a specified remote), or all branches, and to show each branch
in relation to a specified target branch instead of the configured
remote tracking branch.

I would like to know whether there is any interest in incorporating
this functionality into the main git distribution, either as a
separate command, or within `git branch'. For my purposes I have it
aliased under the name `git lsb' for `list branches'.

You can examine the script I'm using for this at:

https://github.com/johnbartholomew/gitvoodoo/blob/master/bin/git-xbranch

Regards,

John B
