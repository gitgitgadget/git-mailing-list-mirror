From: Alexander Shopov <ash@kambanaria.org>
Subject: [PATCH] Fixning WTF porcelain messages
Date: Sun, 10 Aug 2014 18:13:26 +0300
Message-ID: <1407683607-4143-1-git-send-email-ash@kambanaria.org>
Cc: avarab@gmail.com, jn.avila@free.fr, worldhello.net@gmail.com,
	marcopaolone@gmail.com, marcomsousa@gmail.com,
	peter@softwolves.pp.se, ralf.thielow@gmail.com, gitster@pobox.com,
	Alexander Shopov <ash@kambanaria.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 10 17:13:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XGUoe-0007EV-MG
	for gcvg-git-2@plane.gmane.org; Sun, 10 Aug 2014 17:13:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbaHJPNo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2014 11:13:44 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:56044 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750986AbaHJPNn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2014 11:13:43 -0400
Received: by mail-wi0-f171.google.com with SMTP id hi2so3109673wib.4
        for <git@vger.kernel.org>; Sun, 10 Aug 2014 08:13:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=beZowUUmj1EXj5uywJiJZjY6Jk+TpxPF9uxjwDSuoyg=;
        b=kVbYNwNUDOvD1mO3OHr5BKEH0fJh+sLceyRkr1WNTA/ku8TMxpCWNKeqJnpf9deKx1
         IiAiN7p3OZDxYFzEMl8t8U2CZSYfiDUyXYj+CByuYJiLZ5WmE2QdKJ4ELArtrcLQVVao
         K95NH6Qqnpf14Kq1XW3MBSF8zOAX17kOgP4kSCUWK0PRerIlABnSCWErz15W4GzfEQI8
         6wbjGhG2zFu3NKL9EDKRUOAfYNhpbKuKzSrdzmRXPF3VxlRtdzudXCPEB1FMpkAZCcYc
         2KD6TW6Oms9PxLnWf8fNyDltZ5oKv0UFbc4Oq2/PqHvhYzkKFd58iJbkpN7wHJh9cZrC
         q/TQ==
X-Gm-Message-State: ALoCoQlGuUa+pD0k1dLpJfjDhag6AchDFiqDa1bQbRKbX9eJjsVSAClO2/4D2iJSXSWisXs/5vi5
X-Received: by 10.180.39.34 with SMTP id m2mr17903404wik.80.1407683621166;
        Sun, 10 Aug 2014 08:13:41 -0700 (PDT)
Received: from dalgonosko.localdomain (78-83-52-173.spectrumnet.bg. [78.83.52.173])
        by mx.google.com with ESMTPSA id ft17sm32704813wjc.14.2014.08.10.08.13.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Aug 2014 08:13:40 -0700 (PDT)
X-Mailer: git-send-email 1.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255095>

Some user-facing porcelain messages in Git are hard to understand and
hard to translate. They confuse users winthout providing proper
information and course of action. Here is the list of these messages
(starting with "-") and my suggestions (starting with "+"). The patch
follows in the next letter.

-Huh (%s)?
+Wrong choice (%s). Choose again.

-Clever... amending the last one with dirty index.
+You are amending the last commit only. There are additional changes in the index.

-confusion beyond insanity in parse_pack_objects()
+fatal error in function "parse_pack_objects". This is a bug in Git. Please report it to the developers with an e-mail to git@vger.kernel.org.

-confusion beyond insanity
+fatal error in function "conclude_pack". This is a bug in Git. Please report it to the developers with an e-mail to git@vger.kernel.org.

-insane in-reply-to: %s
+wrong format for the "in-reply-to" header: %s

-Two output directories?
+Maximum one output directory is allowed.

-Wonderful.\n
+The first part of the trivial merge finished successfully.\n

-Nope.\n
+Merge was not successful.\n

- ???
+ unknown state

-no tag message?
+missing tag message

-?? what are you talking about?
+unknown command. Only "start", "good", "bad" and "skip" are possible.

-Unprocessed path??? %s
+The path "%s" was not processed but it had to be. This is a bug in Git. Please report it to the developers with an e-mail to git@vger.kernel.org.



Alexander Shopov (1):
  Fixing unclear messages

 builtin/clean.c      | 2 +-
 builtin/commit.c     | 2 +-
 builtin/index-pack.c | 4 ++--
 builtin/log.c        | 4 ++--
 builtin/merge.c      | 5 +++--
 builtin/remote.c     | 2 +-
 builtin/tag.c        | 2 +-
 git-bisect.sh        | 2 +-
 merge-recursive.c    | 2 +-
 9 files changed, 13 insertions(+), 12 deletions(-)

-- 
1.9.3
