Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448F4407590
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 13:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782739167; cv=none; b=pn7V4tX/iU19pXgQ/moUVio00XaMfgs+jR+sL8pR8ehRn2DJiixgRV8xp+1MVPpZ4dr7IzHainzKNmbQ2ELc6aWA0fENL0WYVQyi0Bwl++ehogasfi5057U9OoPtr8z2SVBWdUFXLvpvT/NVDRd13sMzIPIsXHv+T9Rzxeqau9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782739167; c=relaxed/simple;
	bh=73Hk7u8EY0Ddr40zA5XoEIBnWFSSoq5faBNnE719UHU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=cBSl0wZ5OMrRXRySsk8wE0A+381AawAM5HJnPB4UW7rNdsviENPvvgHlk8m8BwbGMs5mg2NJihKtZi8BUnGCiEPCbO8aeVjfUsUVPoha7J3p9yLVIoToUeBUA8SjCBqggLeQOh+U4bqT6r1jYbu0zPJA6Dzk/FMAFrNVjQ5qII8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VXv236Ha; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXv236Ha"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-519ff1c8b8bso39985621cf.3
        for <git@vger.kernel.org>; Mon, 29 Jun 2026 06:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782739165; x=1783343965; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=usNe9gaNeGps9xBFeyyR+lsf2bmPTSCpnaNFbHq/hnA=;
        b=VXv236Haz8WkSFU6nMb5P/LSfCkFY3wtUKFw4L5bOJFx/eKFV79kBDeUU6YjiALkzz
         E9r+RVRA9jAmi3uBNxy7XrNLU/yMhGjJDrv3TxDcHrr04Kn8EECPGTMOKBq44C/NXxUi
         Ls2ljqutbNliIYGhy70tZhuJWymLNQKjF9OeSLG5lG6UD4ASIQNH9rmBKMqihvEDdRSL
         HbHhJc9bHLzdOPLVRbzlSJLgXC5BiSe80urPmBQIeb8BQvbzCxYx/ystpn2CY+ix1MMR
         ZOkk2Fd4q/4XYcYvy9dtJjUZgR6pc35l11pIMgUMJZCqtELF2Wd0tBiOfMbBVFWJthr8
         VZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782739165; x=1783343965;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=usNe9gaNeGps9xBFeyyR+lsf2bmPTSCpnaNFbHq/hnA=;
        b=VZXZL6/wVPRNllq1ExPo7hnXMt10BcozyDO9yYgMOhsY0pHlSj7uUL7TyCB0fS/XII
         CH0GWpO+SpQTW6+57UMGWGUj4KGKpV6nSoaEX5gsJyUWaUq/vjkrq89k7i21BDUSo2zF
         KW2sFXgMk6ZNIkISeeEQtGDwg45xjEyLF8MURUeyMTWi99XnbjHeeQhfWlaJ6dn9hELV
         aRiuX6r5JsOgsVw1yUYqdnxJyTXuQ3tjCjEcn1BOSOrFHwCUbo+r403jGcyVjtJi5LaZ
         8Q/CaqR311GRiqqrxj15qLr9wMG8nuvsRds/zG97lSQiujYYoNarwK345l7JOK3QUj+D
         3/PA==
X-Gm-Message-State: AOJu0Yz0KIg3JFk4E4vhqSla4VdrgDeGWmc6gN1YpdnIM7yTlr4p+6w+
	GOcCjP+aJH1dxHYK1GMf/7Y5LeGikefl6YV9f+u4zyxm8m+Brwy9XFQkAmUYCA==
X-Gm-Gg: AfdE7cn6JmyqUK3Z2bIFTRHb27sDmxcaDfhQi9yHhSo7Uoy8G2+/mvc7lyzbqg/Bx9z
	fk9yPd+ry1HrhLtK3qpYa26/tM3d47ZYqIT1H6oBVq1SjavDh09ff/I+qDn46rf/S0jZ9pw544M
	OXh7BIc2mROanBG8teJgSFmKX/wBETCOQlzst+8eJSnA6hqqlWYDRWXRBvL8KT4/FrCaCJtpFZi
	qU8DyES/0Va1vC0k63wkByXdI3RXaOSvkXXc7iStF2KK6D/Q32TZwXVToNhasmWTxinXcdOBZQh
	Nf1TGdg4V8J20T9qyon3A/zQZMCPTwM0tMZeIfzsQK9QyuiBdbOdY6MqvkzwZZovWfYD3ijq46H
	7j992svZqB5X8PCnyi9eaihEypyeU81KRwNJEDSbF8TSB0GGGh0VJSNMV+8JkGFkFhPCUuHOhi9
	euiLj4pEhfmZcQ6sw=
X-Received: by 2002:a05:622a:1450:b0:51b:f40b:2fb5 with SMTP id d75a77b69052e-51bf40b3479mr60813221cf.17.1782739165165;
        Mon, 29 Jun 2026 06:19:25 -0700 (PDT)
Received: from [127.0.0.1] ([20.119.102.92])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51bf2b175e1sm38117331cf.4.2026.06.29.06.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 06:19:24 -0700 (PDT)
Message-Id: <c10ff61519d34a942037af26919e45b669071115.1782739162.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2162.git.1782739162.gitgitgadget@gmail.com>
References: <pull.2162.git.1782739162.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 29 Jun 2026 13:19:20 +0000
Subject: [PATCH 1/2] t6600: add test for merge-base early exit with clock skew
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
    Derrick Stolee <stolee@gmail.com>,
    Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

Add a topology where the correct merge base (M2) has a lower
committer date than its ancestor (M1) due to clock skew.  With a
v1 commit graph (topological levels only, no corrected commit
dates), paint_down_to_common() falls back to commit-date ordering.
In that mode, M1 pops before M2, acquires both paint sides, and
the !FIND_ALL early exit fires -- returning the wrong merge base.

Mark the test as test_expect_failure to document the bug; the next
commit will fix it.

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 t/t6600-test-reach.sh | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index b5b314e570..1090104220 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -49,6 +49,42 @@ test_expect_success 'setup' '
 			git tag -a -m "$x-$i" tag-$x-$i commit-$x-$i || return 1
 		done
 	done &&
+	# Build a topology with clock skew to test the !FIND_ALL early
+	# exit in paint_down_to_common().  M2 is the correct merge base
+	# of P1 and P2, but its ancestor M1 has a higher committer date
+	# due to clock skew.  With date-only ordering (v1 commit graph
+	# without corrected commit dates), M1 pops from the queue first,
+	# gets both paint sides, and the early exit fires before M2 is
+	# ever visited.
+	#
+	#        P1     P2          @7000
+	#        |     /  \
+	#        A    B    D        @6000
+	#       / \   |    |
+	#      |  M2--+    |        @2000 (correct merge base)
+	#       \ |        |
+	#        M1--------+        @5000 (clock skew: date > M2)
+	#        |
+	#       root                @1000
+	#
+	git checkout --orphan skew-orphan &&
+	skew_tree=$(git mktree </dev/null) &&
+	skew_commit () {
+		GIT_COMMITTER_DATE="@$1 +0000" GIT_AUTHOR_DATE="@$1 +0000" \
+			git commit-tree -m "$2" "$skew_tree" $3 $4 $5 $6
+	} &&
+	skew_root=$(skew_commit 1000 root) &&
+	skew_M1=$(skew_commit 5000 M1 -p "$skew_root") &&
+	skew_M2=$(skew_commit 2000 M2 -p "$skew_M1") &&
+	skew_A=$(skew_commit 6000 A -p "$skew_M1" -p "$skew_M2") &&
+	skew_B=$(skew_commit 6000 B -p "$skew_M2") &&
+	skew_D=$(skew_commit 6000 D -p "$skew_M1") &&
+	skew_P1=$(skew_commit 7000 P1 -p "$skew_A") &&
+	skew_P2=$(skew_commit 7000 P2 -p "$skew_B" -p "$skew_D") &&
+	git branch -f skew-P1 "$skew_P1" &&
+	git branch -f skew-P2 "$skew_P2" &&
+	git tag skew-M2 "$skew_M2" &&
+
 	git commit-graph write --reachable &&
 	mv .git/objects/info/commit-graph commit-graph-full &&
 	chmod u+w commit-graph-full &&
@@ -967,4 +1003,9 @@ test_expect_success 'merge-base without --all is one of --all results' '
 	grep -F -f single all
 '
 
+test_expect_failure 'merge-base without --all, clock skew, v1 commit-graph' '
+	git rev-parse skew-M2 >expect &&
+	merge_base_all_modes skew-P1 skew-P2
+'
+
 test_done
-- 
gitgitgadget

