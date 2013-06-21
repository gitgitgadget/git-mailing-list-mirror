From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 00/16] Cleanup {branches,remotes}-file cruft
Date: Fri, 21 Jun 2013 16:42:24 +0530
Message-ID: <1371813160-4200-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 21 13:16:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpzJz-00030x-IS
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 13:16:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935464Ab3FULP6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 07:15:58 -0400
Received: from mail-pb0-f47.google.com ([209.85.160.47]:56809 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933076Ab3FULP6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 07:15:58 -0400
Received: by mail-pb0-f47.google.com with SMTP id rr13so7631026pbb.34
        for <git@vger.kernel.org>; Fri, 21 Jun 2013 04:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=cbhyjDgIdzzOSai+JeroflGr/1SKgREB8LQxvdLGHpc=;
        b=j2ALSncHZiSihCxbWW4tfFxtneHu1W8+89NFlJbAzTSwT1SkCEYTiIXMqoMMPQyER/
         vgGWq+zDUFNuytLivGGrOApKby9EBIep41i7Tb6hmVufjycN0/FPagqQQYnRepPcqDG8
         T1tKNJOEbEqW3ufbvUn9xBfIeer/jCTTXjqSMY0U0M/DhQ9JGffqVP0uiZquBVkaaMub
         laIw5eYLyMgH1fQHSSxZSCkneC2HcwoD7LtZGXnHQhzVofrRs8E9P11CEd/lHffSnmYp
         sfUfOzk3pZ7zuEYisyff+p85RZU6JZB9d0OT0m6OlRTIATHFi+S0fwl3z32GLMrzVOye
         Aupw==
X-Received: by 10.66.159.168 with SMTP id xd8mr15589128pab.146.1371813357557;
        Fri, 21 Jun 2013 04:15:57 -0700 (PDT)
Received: from localhost.localdomain ([122.164.10.8])
        by mx.google.com with ESMTPSA id ig4sm4486341pbc.18.2013.06.21.04.15.55
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 21 Jun 2013 04:15:56 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.499.g7ad3486.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228594>

Hi,

This is a cleanup operation to get rid of the historical
$GIT_DIR/{branches,remotes} cruft.  Mostly no-brainers that don't
deserve a second look.  The ordering of the series might be somewhat
weird, but that's because it's the order in which I wrote those
patches: rebasing results in stupid conflicts that's not worth
anyone's time.

Thanks.

Ramkumar Ramachandra (16):
  t/t5505-remote: modernize subshell-style of one test
  t/t5505-remote: test push-refspec in branches-file
  t/t5505-remote: use test_path_is_missing
  t/t5505-remote: remove dependency on $origin_url
  remote: remove dead code in read_branches_file()
  t/t5505-remote: test url-with-# in branches-file
  t/t5516-fetch-push: don't use branches-file
  t/t5516-fetch-push: use test_config()
  ls-remote doc: fix example invocation on git.git
  ls-remote doc: rewrite <repository> paragraph
  ls-remote doc: don't encourage use of branches-file
  t/t5505-remote: modernize subshell-style of one test
  t/t5505-remote: test multiple push/pull in remotes-file
  t/t5510-fetch: don't use remotes-file
  t/t5515-fetch-merge-logic: don't use {branches,remotes}-file
  remote: deprecate read_{branches,remotes}_file

 Documentation/git-ls-remote.txt | 13 ++++---
 remote.c                        | 34 ++++++-------------
 t/t5505-remote.sh               | 75 +++++++++++++++++++++++++++++------------
 t/t5510-fetch.sh                |  9 ++---
 t/t5515-fetch-merge-logic.sh    | 28 +++++++--------
 t/t5516-fetch-push.sh           | 62 +++++++++++++++++++---------------
 6 files changed, 121 insertions(+), 100 deletions(-)

-- 
1.8.3.1.499.g7ad3486.dirty
