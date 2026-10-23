Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792764303;
	b=NG9kbAozDhAaUd52oZNCzsXtelykJuL6KEpenLdvdo4WMOywHpaF45FrnOlyBT5xoI42
	 oIxgZ4Hp5nBjNyuPhg2RovhVjSDezn/z/wxlOuU6FXOfPOWvZwHHtjxg3s7Wp9FaAHTYu
	 E5Em/TuOrQHEfpvs8HKni8jlNsRVF1fY6PeTr9szY6CtLWg61kgF80piqlDtQhkm1hR1c
	 17s8VkWcJs1nd8CnEYKxztRCZEq20IF5QtnEj/liYebLx6hjSnEoe2fy31E9T1UlaVdXs
	 DKqG9iluTawY0zBYWxcrQviKOubWVNN8pes8nB3zwp8NqY28AEVUN9Vibb7WPM/VgBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792764303;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=atLJWz8cXQbgEe1TNShMXj7VmM7iFZBbO+F6RiNZk0c=;
	b=SNudIojhKGvioeKWL+tPiPdKPSyKyR1CU/pMQK2vYVVRmFqJKYAphYFI3Us/k3sA6mL7
	 YDMQDA84AOLjPSB/uoXNftM0fz6OtLz60nvR+fcvzdwwE7B5jCkpgAia0i7XIFV5RR55+
	 IiQ1MVgPBj+xdHuYXOHGBlfthb/cBzcxx5Mo1Mc5PG7E8yt1QTfSQNqEdZY+lOtscEGTk
	 L4PpPHmD/9UjKbOvTST/QydlCjfN8ly6GlslFa4I2GLyjn0TPjWDRWNUCxjmM74EZeVWN
	 ees2WijPEcsNjh2gg79ak7QdvoU9k7hOeWt36T/0eLQNcjhqWuD4nL0XFkGzOo9xMWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FYfPHXf6;
	arc=none smtp.remote-ip=209.85.222.178
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECB4606A322
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 14:05:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2ECB4606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FYfPHXf6
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-93cb1c0e851so66549885a.0
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 07:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792764302; x=1793369102; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=atLJWz8cXQbgEe1TNShMXj7VmM7iFZBbO+F6RiNZk0c=;
        b=FYfPHXf6uUmMgHPKTU2yUrzkcQ4FV1hr+wpn60151GdfC1ug9JMrivXDEB4GbOxPEF
         puIkxMHpnu0dOZAWVuN4BN+F5jeiR7dm0eKBq0ticIzEY0FoiLIzQnFUyCYwlo1bXpxs
         qq7NO+TcPjiSYQohkCUDPKIsB318j8ZWOYBX1omayS6MeR6Swvru9ClBRIejtLugJvzG
         j/DpvmBTup/leC/Y8ubo27h9r4jrexdwzjETsAnHVlxO2kltUF5eMLSJTnh6IzI8ZA2Q
         OXR3p6IkYv4Uz2fUWWx7YhepMdwBpY6Sbe1l8+dVnvPSIDPcLW0sE4h8Cy9WviKGUVZR
         MtUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792764302; x=1793369102;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=atLJWz8cXQbgEe1TNShMXj7VmM7iFZBbO+F6RiNZk0c=;
        b=mcVAXRPDHbvEP+FpNW5NFSGEq+SQ46FGXTs6xcCye/YCrPTJM8677Y69A94Hlb3LVT
         u7cFHRVoWxvv1SlpPSoSfuVx3qZcEbjdPzJyphU+umaJuMt9OdyRf/31LpJfe5EvXBff
         Nt+Bxz3FDt2AYh/MZcr4rvi36OIPusW33vOlHvVWPcTp+4V1cOox8+/auqcDCPqjS/9I
         sx4gRXFMOSu5HgOX5XKzaEDCuYiK64zyZSkYT+n7iPzY/ClbueLd2Giov+x6HNtPEBFS
         GWGIUHKa/zyoczRSFep3pr1li4o3Us0L7dh1SUmg/KwgBWATo1S9+U1qTiD1YRp7PUpM
         ZXbg==
X-Gm-Message-State: AFq9FYKrgs9tEvgvH6RFaR8SzxG/ZhWCFyLj04vVUg1YoAUtpIL4tY1A
	ITcgoRrG30/CdMh2ob3vlF9AE/0oloncjldWYnw6ROol3fuOHKQ0Q4vT8EjGUOHueLs=
X-Gm-Gg: AYBFou0rNBM3YCk4v8d1tGN9x83wMvFByXg+Aw8OQjpsKFgVFnW2Tyah0qAn//PywFi
	mrl2opWmN0ey0YLZqXewePKg0ZDCGxQVQ2Rq0g1+G4qF838gMTfJUQUS6IsRaeHbiG4kgnNaRH1
	jsSOCrNCPqAX1WGw1MN29ylG4ycKwQEvEQYnT3wq9yiTTadpWC7KUOJr/HrLeWV49PTS7ttp00Y
	iuL0AmmpeYmHKBNU48yTyHiukn7dcNc5rqtV/BXLj5z8spfUf5OR6kvJRP1pssbjEGcbmMzusfk
	h7n2EOhRVhx4AHvRQL7/FcX+wdWOs7mungwDxWKkirRYBAooktsBxplIJOK2Gab2mrG0p0izfsA
	3/+/Vnbdk7UdB7X3cL2fd0SmnZHb61x8yQ/miHmwmwJ40m4rJHEK16H6gmHIPE/A1xDqBlc/TKV
	ByRLPgiZQaLqDrt1lQQ1uCEO06pKicaBkh8ZaBouDEQ1zYefGJgFCsJIbThFX8VyE6NNV+BtoMy
	cZlX2hdb52qTmWMIg+lH7VfVNRSj/Md2ljT843hu0M0+t9nOESjuZMQ0w==
X-Received: by 2002:a05:620a:2704:b0:93c:9d56:a860 with SMTP id af79cd13be357-93f6f7891ddmr429832085a.19.1792764301968;
        Fri, 23 Oct 2026 07:05:01 -0700 (PDT)
Received: from [127.0.0.1] ([20.83.174.58])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9404722eee0sm25556185a.14.2026.10.23.07.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 07:05:00 -0700 (PDT)
Message-Id: <2bd9850822605324882794e43773c4be9127bc9e.1792764293.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2237.v4.git.1792764293.gitgitgadget@gmail.com>
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
	<pull.2237.v4.git.1792764293.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 23 Oct 2026 14:04:50 +0000
Subject: [PATCH v4 3/6] doc: git-rebase: link to new merge conflicts guide
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
Cc: ps@pks.im,
    Jeff King <peff@peff.net>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

Remove some of the detail about how to handle a merge conflict, since
it's explained in detail in the new guide, and there probably isn't
enough detail anyway.

Leave the steps since rebase is special and has a `--skip` option which
the other commands which cause merge conflicts don't have.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-rebase.adoc | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
index f6c22d1598..da70aff498 100644
--- a/Documentation/git-rebase.adoc
+++ b/Documentation/git-rebase.adoc
@@ -46,10 +46,7 @@ If there is a merge conflict during this process, `git rebase` will stop at the
 first problematic commit and leave conflict markers. If this happens, you can do
 one of these things:
 
-1. Resolve the conflict. You can use `git diff` to find the markers (<<<<<<)
-   and make edits to resolve the conflict. For each file you edit, you need to
-   tell Git that the conflict has been resolved. You can mark the conflict as
-   resolved with  `git add <filename>`. After resolving all of the conflicts,
+1. Resolve the conflict. After resolving all of the conflicts,
    you can continue the rebasing process with
 
    git rebase --continue
@@ -62,6 +59,9 @@ one of these things:
 
    git rebase --skip
 
+See linkgit:gitmergeconflicts[7] (or `git help mergeconflicts`)
+for a full guide to handling merge conflicts.
+
 If you don't specify an `<upstream>` to rebase onto, the upstream configured in
 `branch.<name>.remote` and `branch.<name>.merge` options will be used (see
 linkgit:git-config[1] for details) and the `--fork-point` option is
@@ -1284,6 +1284,11 @@ include::includes/cmd-config-section-all.adoc[]
 include::config/rebase.adoc[]
 include::config/sequencer.adoc[]
 
+SEE ALSO
+--------
+
+linkgit:gitmergeconflicts[7]
+
 GIT
 ---
 Part of the linkgit:git[1] suite
-- 
gitgitgadget

