Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795633588;
	b=DwIYETDFugzBQZvty4wrmkQNo4REsa/WXEcK1gQlBIHDLslUOKFEBzBIR9/nHUgYH2G/
	 eoHu4lO1iqGX0/6cSjVy2W70jbDz3jb3Zhk7el70Boe9xW/nSLEmeK496sK93VwqI0+AS
	 Q+Unt9JA3m4MFpEUi2TiE+jpQ2A5P0Zh+8Os18FmMnSASXC9G2zyKX9fVTGooEYOlmsFu
	 jah43hRmjvQbOpnMMmo75ic3AXWxnPUdYhMWAvhHnQjdOOiVZK6CY/IBjRl5SNTAG/Rs5
	 OOGAiTtLOq+N6lKhP7j15xhgJkFGi82lXYaWUFJrUPJcSG5BMd6PUbYyR+7TgqioW9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795633588;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=q4LZdSn7vOGFs2G+Bg0sik22RyimpXv3uhxkKqDfEWk=;
	b=4VJCzxt/gVQXikRi1ORPL/uxeGJrAxinvI1JXOflfDwghATFKKb86IW9KcADtIrOwLW/
	 gJTj4c4SIy34Nr2esGig5c/5yDCG/3hufmCbaigzCFJtPBvM/rQW91HKwuW+HXKrdGdy/
	 22o6oFN48xn4NfCuQp3iYdDH9rWj51v6MSK9Q6kLirYPI/uSdFo/ucqdfn/7rPX8P69MK
	 UFUmX0LsjPwjz701DUo8Kv/ZFBfmxS1j2t3wlO7sYflIYVMpV1Eb+YSjgIZb4sAYBs1Jm
	 B32hDcWoFzvaW2ivyPcne1C/urzkjDls4z0ONsmfWx27clG48VWJ3Rmu9Kl6e+62LUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=woRdkUTU;
	arc=none smtp.remote-ip=209.85.161.47
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6E0606A323
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 19:06:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A6E0606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=woRdkUTU
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-716c0217635so7286244eaf.0
        for <git@vger.kernel.org>; Wed, 25 Nov 2026 11:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795633587; x=1796238387; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=q4LZdSn7vOGFs2G+Bg0sik22RyimpXv3uhxkKqDfEWk=;
        b=woRdkUTUxss7O2isHeW+LD8lMc4FFTCJSnmS0hlc15XELnthTpxU9/piCpn8f85bmi
         iK4omnqz1DyoX9koI690TAKI0tIjm7NM7sBmRCOkHJ1HFhEnKxCgQnZxFBK12T+H0VF1
         LjHgzcw6Hw+16DdZU/z/mUqOXPpsl+6TGiQoRso6MBrptZtyV5AhORycyTxyni13X7AR
         BIIn67oViOfcGJ9hCzJRw6zIAKw0XwEZu0TSMQN9phZGn4x/E9strVt6/vefcrJZ6eh8
         1+Pr2dIxXNYz1zRcK2qLgw3gD9+imY9De6kq2cmktaOgoYIphv7ORKPfnJGnzOruxOQd
         1BlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795633587; x=1796238387;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q4LZdSn7vOGFs2G+Bg0sik22RyimpXv3uhxkKqDfEWk=;
        b=Ogd8bIAgEYJmjMpKyyTfqiRJKibhVUL3hG491FgQAfwoMayVrCv6Atp3Cd2JUH14qa
         LXZAaUsxhNK3JyZk+6vsPd1fkIUThm8h7aB4qYXgjzBYSXtfwy2yO8ezQzu8/+Ht36bl
         Tyq0/DlEKg42w/QTZ29Z0bAOQs1MpmYNmXBbEUiDTKhjqmgjYStKE18aXHBGM63kATNQ
         wz4sNheJdETyDW9ZlRV/6Wkp9Vcg0yM/XsmQvJ2snNpvB+TusNbryib1dCSuP/kavRFq
         hcUW3iPKm9rOW9oxib6DCOIRFRZzcgAzY19CnBv+blQVkFSX2Qr2r9sWxIbI6K2g+lnE
         kezg==
X-Gm-Message-State: APuU4Z8yYKwYpyQI+Dwyj7QF/7b146phsMtO/4TmNiufaFRh59E2TDq1
	x3VmqPxVSRwCOZ06Cd8/k4/EpiZ0fP8Mtpdma1II7BvAqqxwS1FwOM2NyhVz/ySs
X-Gm-Gg: AZFdTZczAGvtyJLIDANbHVjDHENWpCzGODwIRumj0NCtWQ68AkI3gzutoJurgWpyAb7
	pF7WPnBfNgMsgK9jl19N0BH4Rq47fn7Hib+ZuApzD24yUUg4YOL8BjMmPWH3B3hZTqNoUFsF9YB
	7MDNglqSljtr3lZcYxCzxqklnAylOylfGqQA+fUnO71nYD+kPAbrTvWXDU9XnHNYSY2UK2UjWxC
	4iiT0+oXLNL/N7BzQC181y2TPCOyvZmxtM/7KElcIFef3eEiJ9rDTgQihBvO8nrBSAOLTE2Fv9Z
	OIWP1foZYHXgWbfl+jHwSAMZ0HPs8RXj1aV+KB9DqGjaoNSG89ZXSlfi1qV7kK4u9nzQQIL0r4R
	E6S2riV7NLazmi4s8B6uUbT9WHctlO+jOa3tPIPJmyHCUyrCXTBMawfqtJRscB0opU6X+DLvVQx
	SIloBkwibEXyfZOWWwDDZkSnS6XKe/gUY/hSpwqWi5hZLSPhm2xwgbkJksOcvCnmZ2+IthDpcd0
	VHaJG5vYAFqzHC89cCSNQu3gGJcfogzcWHAOR2cxBlt1qUP+m4FylxnZxByTPLeZd2GU9t3H5Jv
	/y1B7bPaxGjosUb7azxOTuGWQadH81U+
X-Received: by 2002:a05:6820:820:b0:71b:42de:9787 with SMTP id 006d021491bc7-71b42de9ef5mr10972516eaf.22.1795633587312;
        Wed, 25 Nov 2026 11:06:27 -0800 (PST)
Received: from [127.0.0.1] ([40.124.78.245])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b865900ccsm574139eaf.6.2026.11.25.11.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 11:06:26 -0800 (PST)
Message-Id: <9c7036a75d4559c1a78d2fe4ea0b23610b7a043d.1795633584.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.v16.git.git.1795633584.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v16.git.git.1795633584.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 25 Nov 2026 19:06:18 +0000
Subject: [PATCH v16 1/7] fetch: do not apply --refmap to a refspec with a
 destination
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Matt Hunter <m@lfurio.us>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

"git fetch --refmap=<map> <remote> <src>:<dst>" stores the fetched
ref twice, once at <dst> and once where <map> sends <src>. That is
harmless while --refmap has to be typed on the same command line,
but a later commit lets a remote configure a default for --refmap,
and then a refspec that names its own destination would have no way
to say "store it only here".

Apply --refmap only to refspecs with an empty <dst>, which is what a
bare <src> is shorthand for. A refspec with a non-empty <dst> is
stored there and nowhere else.

The opportunistic update of remote-tracking branches through
remote.<name>.fetch is left alone, so "git fetch origin main:tmp"
still updates origin/main.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/fetch-options.adoc |  4 +++-
 builtin/fetch.c                  | 31 ++++++++++++++++++++++++-------
 t/t5510-fetch.sh                 | 12 ++++++++++++
 3 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/Documentation/fetch-options.adoc b/Documentation/fetch-options.adoc
index 47dea1de8e..54c5c8f671 100644
--- a/Documentation/fetch-options.adoc
+++ b/Documentation/fetch-options.adoc
@@ -239,7 +239,9 @@ endif::git-pull[]
 	specified refspec (can be given more than once) to map the
 	refs to remote-tracking branches, instead of the values of
 	`remote.<name>.fetch` configuration variables for the remote
-	repository.  Providing an empty _<refspec>_ to the
+	repository.  A ref fetched with a refspec `<src>:<dst>` with
+	non-empty `<dst>` is stored only there and is not mapped.
+	Providing an empty _<refspec>_ to the
 	`--refmap` option causes Git to ignore the configured
 	refspecs and rely entirely on the refspecs supplied as
 	command-line arguments. See section on "Configured Remote-tracking
diff --git a/builtin/fetch.c b/builtin/fetch.c
index c646bc6698..0ee252e353 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -274,6 +274,23 @@ static void add_merge_config(struct ref **head,
 	}
 }
 
+static void map_refs_without_dst(const struct ref *ref_map,
+				 const struct refspec *refmap,
+				 struct ref ***tail)
+{
+	struct ref *unmapped = NULL, **unmapped_tail = &unmapped;
+
+	for (const struct ref *rm = ref_map; rm; rm = rm->next) {
+		if (rm->peer_ref)
+			continue;
+		*unmapped_tail = copy_ref(rm);
+		unmapped_tail = &(*unmapped_tail)->next;
+	}
+	for (int i = 0; i < refmap->nr; i++)
+		get_fetch_map(unmapped, &refmap->items[i], tail, 1);
+	free_refs(unmapped);
+}
+
 static void create_fetch_oidset(struct ref **head, struct oidset *out)
 {
 	struct ref *rm = *head;
@@ -530,8 +547,6 @@ static struct ref *get_ref_map(struct remote *remote,
 		filter_prefetch_refspec(&remote->fetch);
 
 	if (rs->nr) {
-		struct refspec *fetch_refspec;
-
 		for (i = 0; i < rs->nr; i++) {
 			get_fetch_map(remote_refs, &rs->items[i], &tail, 0);
 			if (rs->items[i].dst && rs->items[i].dst[0])
@@ -560,14 +575,16 @@ static struct ref *get_ref_map(struct remote *remote,
 		 * which has FETCH_HEAD_NOT_FOR_MERGE, is not removed
 		 * by ref_remove_duplicates() in favor of one of these
 		 * opportunistic entries with FETCH_HEAD_IGNORE.
+		 *
+		 * A refspec that names its own destination is not
+		 * mapped through --refmap.
 		 */
 		if (refmap.nr)
-			fetch_refspec = &refmap;
+			map_refs_without_dst(ref_map, &refmap, &oref_tail);
 		else
-			fetch_refspec = &remote->fetch;
-
-		for (i = 0; i < fetch_refspec->nr; i++)
-			get_fetch_map(ref_map, &fetch_refspec->items[i], &oref_tail, 1);
+			for (i = 0; i < remote->fetch.nr; i++)
+				get_fetch_map(ref_map, &remote->fetch.items[i],
+					      &oref_tail, 1);
 	} else if (refmap.nr) {
 		die("--refmap option is only meaningful with command-line refspec(s)");
 	} else {
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 5b27f1d5bb..38185e192d 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -927,6 +927,18 @@ test_expect_success 'explicit --refmap option overrides remote.*.fetch' '
 	)
 '
 
+test_expect_success '--refmap is not applied to a refspec with a destination' '
+	git branch -f side &&
+	(
+		cd three &&
+		git fetch --refmap="refs/heads/*:refs/remotes/mapped/*" origin \
+			main:refs/remotes/custom/main side: &&
+		git rev-parse --verify refs/remotes/custom/main &&
+		test_must_fail git rev-parse --verify refs/remotes/mapped/main &&
+		git rev-parse --verify refs/remotes/mapped/side
+	)
+'
+
 test_expect_success 'explicitly empty --refmap option disables remote.*.fetch' '
 	git branch -f side &&
 	(
-- 
gitgitgadget

