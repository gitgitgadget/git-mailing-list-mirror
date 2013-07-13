From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 0/2] add git-check-mailmap command
Date: Fri, 12 Jul 2013 20:53:09 -0400
Message-ID: <1373676791-42758-1-git-send-email-sunshine@sunshineco.com>
Cc: Duy Nguyen <pclouds@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 13 02:53:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uxo5z-00040M-Gg
	for gcvg-git-2@plane.gmane.org; Sat, 13 Jul 2013 02:53:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757969Ab3GMAxv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 20:53:51 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:36538 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757957Ab3GMAxu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 20:53:50 -0400
Received: by mail-ie0-f176.google.com with SMTP id ar20so21616743iec.21
        for <git@vger.kernel.org>; Fri, 12 Jul 2013 17:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=4c2YWebYIhU4IiheWghVbp8SUzjyZ/opSygQaeJIfD8=;
        b=ENFOy6ifSC7UfrB+dHiIaCfj/qbH3+AtlZ3JYxgtSj2q7ozj/TlUS4XUmP0C5vz+3K
         evcUhozL8VENuvIS1pkEc1l5kk4MpL8HQ1TXQ9vXTABpJ8LYOmcqyw4iaac+rpkyTdUZ
         nqa4hnr3FBbqK40HYp5wpH8ILSe+DFP+epdkC7pwu+xEuFgJ0sljvR+0ROuPmtgQDIzY
         rc5tanF4FkHXTa4NpS18zIRFuyL2PzKgRiaAmo6TPWU/hHzr/j+QnWnglSQy8CGVFtlS
         E5WBW4WiMOSyHNteSQuCYbK/jFC11F5DA0g924RLYtJsrqoV2na0G6uQtQXPqz+gMUpA
         e6aA==
X-Received: by 10.42.158.9 with SMTP id f9mr13090319icx.111.1373676830205;
        Fri, 12 Jul 2013 17:53:50 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id nm17sm2562384igb.5.2013.07.12.17.53.48
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 12 Jul 2013 17:53:49 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2.804.g0da7a53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230270>

This is a re-roll of v2 [1] which introduces git-check-mailmap. The
primary motivation for this command is to expose git's stable,
well-tested C-implementation of .mailmap functionality to scripts and
porcelains, thus relieving them of the need to re-implement support
themselves. The git-contacts [2] script (currently at es/contacts in
'pu') would be one such client.

v3 addresses comments from reviewers [1].

Changes since v2:

* Drop -z/--null option.

* Simplify grammar of DESCRIPTION and OUTPUT sections of
  Documentation/git-check-mailmap.txt.

* Normalize wrapped code indentation to match standard Git style.

* Drop v2 patches [3/4] and [4/4] which convert t4203-mailmap.sh to test
  low-level mailmap functionality directly via git-check-mailmap rather
  than indirectly via git-shortlog.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/230105/
[2]: http://thread.gmane.org/gmane.comp.version-control.git/229533/

Eric Sunshine (2):
  builtin: add git-check-mailmap command
  t4203: test check-mailmap command invocation

 .gitignore                             |  1 +
 Documentation/git-check-mailmap.txt    | 47 ++++++++++++++++++++++++
 Makefile                               |  1 +
 builtin.h                              |  1 +
 builtin/check-mailmap.c                | 66 ++++++++++++++++++++++++++++++++++
 command-list.txt                       |  1 +
 contrib/completion/git-completion.bash |  1 +
 git.c                                  |  1 +
 t/t4203-mailmap.sh                     | 43 ++++++++++++++++++++++
 9 files changed, 162 insertions(+)
 create mode 100644 Documentation/git-check-mailmap.txt
 create mode 100644 builtin/check-mailmap.c

-- 
1.8.3.2.804.g0da7a53
