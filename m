Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D584FF84
	for <git@vger.kernel.org>; Mon, 18 Dec 2023 17:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+uIgLmH"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40c39ef63d9so37801875e9.3
        for <git@vger.kernel.org>; Mon, 18 Dec 2023 09:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702919362; x=1703524162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nN4DfdpArwrKVByjALoZ9NzShecVtii9ZrAgnsBBunY=;
        b=m+uIgLmHIz1PbFukdUgUSLg26yXh1pRTL1iE3DCznRfhBF8mdVC5V4PdTNbWtzut3j
         XO4ikXXbUjDQ0HlrtHqI3LEHa6JP7I1MAwvEmvviazujZHqerxn4EhZEe0XLMTxbLeG0
         qrgL41Usi/PucyaQHTi7MWmvpHwmcxOwyCm94lgiRYtl85fLov9toBVwMoMkvMu4Hrxc
         nZ/EkVkkmb5OLkiH3jNdgIHYBSIhbaFR09HxihLlRxnlx+9gA/pNkObijFJtXO0tG9Zu
         yq0kDZ1YBOfZGN/RfsOULfcaZokId7cSMyQvnPcro/7YJ66mu2BaZx4583VIh0QByE0A
         Cwgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702919362; x=1703524162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nN4DfdpArwrKVByjALoZ9NzShecVtii9ZrAgnsBBunY=;
        b=HUblXW53GZV8yq3mIo0wne3rKBdT8iY0FXqlWFHlpZK0cc75lAJTg+5/rpQsn6VFuK
         3SYUnLBZ7ZGMvNNwBUGWtc0fumhlARU3yNmwmOlBq0PW5BD5biinUJQNHRq3SKUk2Y1L
         1bkbEI2gW/BTb8qS17YNhw6eVHaZkNLXQUwxc6189FgxfDyfM92KsYs+3xLpqzesvQJu
         RX7fMCu00sfZV9T4xAax1JE9xw+mThvrk/wlivlZdOJpZ/EBDB1kfZRdcK0DSLhkRkDQ
         YjuySnuG1WsiTNNRobqMWqUr5c1mALfOvldFLPnjkWMPzHdXTa2wKnPdjSSY674kZIEP
         SsVQ==
X-Gm-Message-State: AOJu0Yxij7iR0+XQpB7xSRQ0rO/lT6POwCH6GoDH6hGjb9CSiEZ0Btax
	kg3IdIZwSQm2yT8ykdFH0+U=
X-Google-Smtp-Source: AGHT+IF4h0iJutMa67LNgmXZ9m2Op/YGml+OaUMTukSdrx3n8asz1xj0M963oZdR5bfT0S/SFXoSVA==
X-Received: by 2002:a05:600c:4c94:b0:40c:29a7:641e with SMTP id g20-20020a05600c4c9400b0040c29a7641emr8918447wmp.118.1702919361704;
        Mon, 18 Dec 2023 09:09:21 -0800 (PST)
Received: from Michaels-MBP.fritz.box (2001-4dd7-e0bf-0-39a6-bdd4-29ba-7091.ipv6dyn.netcologne.de. [2001:4dd7:e0bf:0:39a6:bdd4:29ba:7091])
        by smtp.gmail.com with ESMTPSA id vh6-20020a170907d38600b00a0180de2797sm14342420ejc.74.2023.12.18.09.09.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 18 Dec 2023 09:09:21 -0800 (PST)
From: Michael Lohmann <mial.lohmann@gmail.com>
X-Google-Original-From: Michael Lohmann <mi.al.lohmann@gmail.com>
To: phillip.wood123@gmail.com
Cc: Johannes.Schindelin@gmx.de,
	git@vger.kernel.org,
	mi.al.lohmann@gmail.com,
	phillip.wood@dunelm.org.uk
Subject: [PATCH] rebase-interactive: show revert option and add single letter shortcut
Date: Mon, 18 Dec 2023 18:09:12 +0100
Message-Id: <20231218170912.73535-1-mi.al.lohmann@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <c2489476-f23b-4c03-8651-d6a8799ff67c@gmail.com>
References: <c2489476-f23b-4c03-8651-d6a8799ff67c@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A `revert` in an interactive rebase can be useful, e.g. if a faulty
commit was pushed to the main branch already, so you can't just drop it.
When you are already working in a feature branch you might just want to
revert said commit right where you branched off from main, so you can
continue working on the feature you intend while still being up-to-date
otherwise.

Another reason why you might not want to drop a commit is if it is a
work in progress one and you want to properly fix it later, but for now
need to revert the changes. That way it is a lot cleaner to structure
your branch like this:

    A---B---C       (B is WIP commit you cannot use as is)
=>
    A---B---~B---C  (temporarily revert B (called "~B") directly after
                     it is created, until you find the time to fix it -
                     at which point in time you will naturally drop the
                     revert commit)

This way you still have the WIP patch, but "your history is not broken
the whole time".

Signed-off-by: Michael Lohmann <mi.al.lohmann@gmail.com>
---
 Documentation/git-rebase.txt | 3 +++
 rebase-interactive.c         | 1 +
 sequencer.c                  | 2 +-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 1dd6555f66..75f6fe39a1 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -911,6 +911,9 @@ commit, the message from the final one is used.  You can also use
 "fixup -C" to get the same behavior as "fixup -c" except without opening
 an editor.
 
+To revert a commit, add a line starting with "revert" followed by the commit
+name.
+
 `git rebase` will stop when "pick" has been replaced with "edit" or
 when a command fails due to merge errors. When you are done editing
 and/or resolving conflicts you can continue with `git rebase --continue`.
diff --git a/rebase-interactive.c b/rebase-interactive.c
index d9718409b3..e1fd1e09e3 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -53,6 +53,7 @@ void append_todo_help(int command_count,
 "                   commit's log message, unless -C is used, in which case\n"
 "                   keep only this commit's message; -c is same as -C but\n"
 "                   opens the editor\n"
+"v, revert <commit> = revert the changes introduced by that commit\n"
 "x, exec <command> = run command (the rest of the line) using shell\n"
 "b, break = stop here (continue rebase later with 'git rebase --continue')\n"
 "d, drop <commit> = remove commit\n"
diff --git a/sequencer.c b/sequencer.c
index d584cac8ed..3c18f71ed6 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1767,7 +1767,7 @@ static struct {
 	const char *str;
 } todo_command_info[] = {
 	[TODO_PICK] = { 'p', "pick" },
-	[TODO_REVERT] = { 0,   "revert" },
+	[TODO_REVERT] = { 'v', "revert" },
 	[TODO_EDIT] = { 'e', "edit" },
 	[TODO_REWORD] = { 'r', "reword" },
 	[TODO_FIXUP] = { 'f', "fixup" },
-- 
2.39.3 (Apple Git-145)

