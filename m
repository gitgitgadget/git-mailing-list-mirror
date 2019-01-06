Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E10EF211B4
	for <e@80x24.org>; Sun,  6 Jan 2019 17:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbfAFRxO (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Jan 2019 12:53:14 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35994 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbfAFRxO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Jan 2019 12:53:14 -0500
Received: by mail-wr1-f68.google.com with SMTP id u4so40986553wrp.3
        for <git@vger.kernel.org>; Sun, 06 Jan 2019 09:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NZKwrrflTCeJy9FSI5QwiANtA8/1pupvBBC3t/pG+3c=;
        b=jXBQAi7lf3EdFLoJWuSOWaBxKn/QS/jtO6RxpM17OqEUsbLARURd18aGmufYHATfbw
         V9CYFHmneEUgVSoCmdmvehLIOSH2qflz/Hv7yf3hvy+lG29s/J7+mV6XK/m8J3oVLzda
         iQzyqVgsTb9+sbY3fCyc+3IfAlKGDlfOm7m1/etFBglsTppWUB0MAcv4AG6ovCr0hxqg
         kufrF3I7mZnArcOKz/FSH3Ihqsg1458ufpWPtPA4K/3R4UkkFiXQGFR0wjGVbPY2rs/E
         uhgnCgJGCqtWgGHrqHg8IBgDYHFJcb7mxEbItWrFvCz8ssgGUVh/nKNhEE5T5wEVdpuO
         PWCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NZKwrrflTCeJy9FSI5QwiANtA8/1pupvBBC3t/pG+3c=;
        b=B7thN94DSjxFH+WQ1BJWqZuQJFqmskt55PL/WfBXT4FFKW0x4FsvkxBwYU8nk9aaze
         Ig00qUE7NhaWrX4ltGy4VLPqS7m332TwrIhJp3ovvmcJCeJGz7tE6FnnXPmx3mpNHurz
         wsji3gKpqIciHe6Jd893KeMmqMH5UUjFEhdyoWHbOLnt0/vKtk+i4CSjw4i6ZLFPl0M9
         fHUrWBLNNR8uC2YARyaxyWfL+DFatnp1wkhMLfhaS3huPUanfm1xRtW/JSjoy9BDBUHX
         abji/Fj10zahUvbFlNdCQIJXumE/5foBcL7rsqv5MYLkEmB/Eri/CTqCu6gmPlai4jBg
         33Bg==
X-Gm-Message-State: AJcUukcAJUVMj9xT2l6czsCfjmebPzE/Zia/6lNnErq4n6CaCuEJ/Pnn
        bNXa/CynSksBRxVwl+ajQCE=
X-Google-Smtp-Source: ALg8bN6mo+uLPvHGPGNvSkXY0K0iRjAN52214NRkFdtQPmel0/PDkC35lI3DuRU9GPAPu0rtU7MwOQ==
X-Received: by 2002:a5d:5443:: with SMTP id w3mr46311516wrv.4.1546797192254;
        Sun, 06 Jan 2019 09:53:12 -0800 (PST)
Received: from localhost ([2.24.105.63])
        by smtp.gmail.com with ESMTPSA id o81sm9829859wmd.10.2019.01.06.09.53.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 06 Jan 2019 09:53:10 -0800 (PST)
Date:   Sun, 6 Jan 2019 17:53:10 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
        Git Mailing List <git@vger.kernel.org>, szeder.dev@gmail.com,
        Jan Palus <jpalus@fastmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/1] Revert "t/lib-git-daemon: record daemon log"
Message-ID: <20190106175310.GC25639@hank.intra.tgummerer.com>
References: <9d4e5224-9ff4-f3f8-519d-7b2a6f1ea7cd@web.de>
 <20181125220138.GK4883@hank.intra.tgummerer.com>
 <20181126164252.GA27711@sigill.intra.peff.net>
 <20181220164150.GB25639@hank.intra.tgummerer.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181220164150.GB25639@hank.intra.tgummerer.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This reverts commit 314a73d658 (t/lib-git-daemon: record daemon log,
2018-01-25), which let tests use the output of git-daemon.

The previous commit removed the last user of deamon.log in the tests,
there's no good way to make checking for output in the log
race-proof.  Revert this commit as well, to make sure others are not
tempted to use daemon.log in tests in the future, which would lead to
racy tests.

The original commit had one change that still makes sense, namely
switching read/echo for "read -r" and "printf", which relays the data
more faithfully.  Don't revert that piece here, as it is still a
useful change.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 t/lib-git-daemon.sh | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/t/lib-git-daemon.sh b/t/lib-git-daemon.sh
index f98de95c15..fd41229a8f 100644
--- a/t/lib-git-daemon.sh
+++ b/t/lib-git-daemon.sh
@@ -54,19 +54,11 @@ start_git_daemon() {
 		"$@" "$GIT_DAEMON_DOCUMENT_ROOT_PATH" \
 		>&3 2>git_daemon_output &
 	GIT_DAEMON_PID=$!
-	>daemon.log
 	{
 		read -r line <&7
-		printf "%s\n" "$line"
-		printf >&4 "%s\n" "$line"
-		(
-			while read -r line <&7
-			do
-				printf "%s\n" "$line"
-				printf >&4 "%s\n" "$line"
-			done
-		) &
-	} 7<git_daemon_output >>"$TRASH_DIRECTORY/daemon.log" &&
+		printf "%s\n" "$line" >&4
+		cat <&7 >&4 &
+	} 7<git_daemon_output &&
 
 	# Check expected output
 	if test x"$(expr "$line" : "\[[0-9]*\] \(.*\)")" != x"Ready to rumble"
-- 
2.20.1.153.gd81d796ee0
