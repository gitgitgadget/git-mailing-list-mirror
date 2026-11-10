Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794311407;
	b=Dfr/z3nXIarTpG2ZmzWfirrOBwGO6N9AFFmUZEMI59A05UVi3aFlBGTK2vpT0SuNP5TS
	 exQxKPwWLY+1jQvEuEn4Z2FJXRgY/dgelS+i1uwOOTpqCz2YhNt2NHBcNDGphAmj+FAg4
	 KnNpUkmcWSCBIGDWuk7/fZH1U8HYwIHWh/w6S05LR2DKw/PcY3hmUoSze8jdfoB68AqX6
	 EEjt8SfWtiOC03qxx4aTRs3us+kZ2rij19Pnpcbik9xjD7E/8uhjYvkZlV6KnyAOrMlWB
	 i/hlYuepeE87+uvtjb/S+DZTmC6DHyME+atfyz0AsOw/E1YkzIlJs3d3LBnQUu2eWeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311407;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=9nwOOca+niFkpt6G/3sN2+8Ho1EEIZCbgoLqYw0fsr4=;
	b=mB8vXhzsPcBSzg7gHeQ4apsQ6OZs4hzJEwWYhCI4hW7WyMexNx+0aoW+KWzkDbtOVqtB
	 HEmifo+dJyiKK3j07DgX4qxVyqo6+G35FrjU1DxtjkDV1TiUbiblu8RcoIX5OE3RtUGJp
	 Iy2F0YUSPhK70OTg1la3xbwUIhRhim+Tkd8RV92HLf7u4tFra3ub1AXWDET+sVbXt+KmW
	 NlQu70mS6n/KNHbfJxyGVBNrghb0FscIRjdLXrS64InRamG7nsKFrmfEwpEOKDm0Xtwmh
	 0IdhlH7A/SdF5/fC0xB/QX6Yk11Q7BZKYxO/tuE2L0bWalIsDsE/BTipMyBxiQAavGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RWPU4Me9;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14A960A6F4A
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 11:50:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D14A960A6F4A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RWPU4Me9
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4afe2d546f9so25969125e9.3
        for <git@vger.kernel.org>; Tue, 10 Nov 2026 03:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794311405; x=1794916205; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9nwOOca+niFkpt6G/3sN2+8Ho1EEIZCbgoLqYw0fsr4=;
        b=RWPU4Me9sRt74TwFfWhZrHQPoRx8G+9Wg/RPKYLMrKJqmlp4odE4fsWljk5KTSjcug
         XMAMzRO6HXSg6TiK1m/8I8mn+qX5kRakO8nD35Hea+6vClKAgn4AxTGs1/wOV5n6iC0b
         1LCCZiUVGKZUy+X0TzFit1W9iaEuqWqY923k+ojjepfMEFzEF2DddhNWdG3t43kltKYO
         JGxMREL33erz7gnBhLuGQVy7brsVkbOqRRGXzr9NMf9cmUfw/2Qpyietg5C2K+o+NShm
         FH+JUljNtyRgk98Fh+Q91yJiCId3Ph8hMetKvXGXEclRWZix1hezvwByucPBUVFfWRw6
         amIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794311405; x=1794916205;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9nwOOca+niFkpt6G/3sN2+8Ho1EEIZCbgoLqYw0fsr4=;
        b=AUFvB2DVBasIxuXaReAd7Ji0qmsm2t7/MKEl/nYmo6po1QySFXK2jS09I116djrSQH
         q4R5Q3WIq89dHjvG5CRQqj7X6bR7ES9IRznosYQk86twj3ylQbIrkNQZuXKyuY0uWgQy
         rFj0Dqxdek6+9sdgKUV+NJx2ZizcLm0O9rt6bmXVB0FfcdUzHCD2tEmdaAiIeCD1JCBR
         FKkhj8BLFEVHCsJLfj5fNOfBVkLxOXA4xTa7LTOk1wS1Wnc7r79+Z9UjN3BHwq7KPfEW
         W6sfsXmlapgaZjb9DA/ESNUhhQTS5XNUDZV9gnTBliGIarkWQIycrGZRPpX3su+WEKS/
         0Gew==
X-Gm-Message-State: APuU4Z9gDKVFe/N8pO1BLdAblRNDwtqZ3O288rAudWWRa61vz94iFeAh
	5nEdfXNK8iGMr9/dvwTcvgOWR/RYdMpsZvVp7OaG+JRuednO6ZA57hFfEXg+kQ==
X-Gm-Gg: AYBFou3l8JcXkHXbFNZa0nhmIUjX6f78rJoaFW9ILMq7kPew162tasxLN8mY1x6P7cc
	1wCmIaqnhh5SIlsoutnScr/MBTCyDMaJUv1zZ4kcIy2HD7ZnU1nkHlDlrgE/i/aPeS/eC3vEot0
	z9kyv5OJQA//TQooMMI49uacj2/2Yu+0IP4zxyu0BnA4FysGeHAPyaT/3469AsuBGlsDAz6g+gM
	GpLMxpPpBG0qnSD1nfKwpqpZWYMV7bZuT2YKpz5E176VXKwo9q6W3aSccaqbwwDboJApXF+TMDw
	cCVDFtFvnoAWGeX96DPnPJjUOoQdy0zK7g7GNAu45Ct+dtYBUo5kOjucGlf5YfewS0tn2alynZ5
	bNB3vdx5UyWXV6uTwRqujR4p+2clk0hjy0NzvfTSn+qGhEyZpLULe9pjF5jBSPCGtjls93Kh8We
	JVXqiJfY9/AVddD4qIS2jiUWVhrpAVBKS4zStlltNznUbVYgYYXqsSKj8RygYDb40PUIvLmFcw9
	K2h3XFMcYjSgm/geDFpL3JCsQEpbDxHjgrx8/me2yPlapkde2sy0jC0LApSsbBEbtuzhGx0PqOd
	0kmLZXN0Z4dga/MLfxw9GZz1ZsXlKjwFk0TiQTMYrM/ZzdwNlyRUoDZViPJQpzCOANU=
X-Received: by 2002:a05:600c:8488:b0:4a1:e0d5:293e with SMTP id 5b1f17b1804b1-4ba0234a004mr38650615e9.21.1794311404994;
        Tue, 10 Nov 2026 03:50:04 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:1917:82b:d709:897d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba02005762sm60715995e9.2.2026.11.10.03.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 03:50:04 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 10 Nov 2026 12:49:46 +0100
Subject: [PATCH 01/20] t9300: move 'fastimport.unpackLimit' to the required
 test
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-kn-fast-import-tests-1-v1-1-dbd9ee502aae@gmail.com>
References: <20261110-kn-fast-import-tests-1-v1-0-dbd9ee502aae@gmail.com>
In-Reply-To: <20261110-kn-fast-import-tests-1-v1-0-dbd9ee502aae@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1246; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=QH30yN/1p00dsGcq1Jj1ss+27vJo21UtkWTCkxn2VkA=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGrzBOQdUvHoOpKVWSttYO0vdy4Ngu5zsb6OQ
 sx078OybM6ZEokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJq8wTkAAoJED7VnySO
 Rox/uKEL/01qkTxMEX6jPpILmQ1KnZx44evd9XUJhFOHOoR7xNlhGFsUtXkp7fqSM6lvVLDEyti
 U14fF/MxKuISZViDO0zrR3FkJ/UHVenIrzAPrxbGbFfmoxzYmXr7nXRoARC/qPQ6XWY8b8pba2s
 9BRYfX9wjH7cXsXiA28n4KyAI20S0wlDWm00OCt4+r6wHkOX3sb8FqX3gRRSEmI36NS8mGw9DX4
 bFirEMVHs1oMtv+5zY6FL/wvQxO53/n7y6Qj0/wQocSjGcsz7qJgEwOD5eTWDdmkeHrc/xxW+gA
 4N5truze5AbB2nOq9wfgvdCrfqdjpe1LjQhrCkMCztxNGF9BiApZdBKp2tONrSvH6+T6n9MaZv4
 iMDcRw2PNYul9QVGZDizuc5DReOVqDprnFks/uzGvh/VRoxJIPKTNdCYAjdiNnLb5/zcmLgQcL0
 3Ifm7zU5PCDIaV5Fdie41KkLEIFhr0yQfXQPGJOgSRCdtyoFlPyJvkqmcgd7uGuVGnT0O+hkYt7
 dI=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The 'empty stream succeeds' test sets 'fastimport.unpackLimit' to '0',
so that the following imports write packs for the 'verify pack' tests
to check. The test itself doesn't need it. A following commit makes it
run in its own repository, where the setting would no longer reach the
tests after it.

Move the configuration to 'A: create pack from stdin', the first test
which needs it. The configuration must persist for the 'verify pack'
tests of the following series, so set it with 'git config' and not with
'test_config'.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 t/t9300-fast-import.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 73c6e3d448..fb23492202 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -38,7 +38,6 @@ echo "$@"'
 ###
 
 test_expect_success 'empty stream succeeds' '
-	git config fastimport.unpackLimit 0 &&
 	git fast-import </dev/null
 '
 
@@ -47,6 +46,7 @@ test_expect_success 'truncated stream complains' '
 '
 
 test_expect_success 'A: create pack from stdin' '
+	git config fastimport.unpackLimit 0 &&
 	test_tick &&
 	cat >input <<-INPUT_END &&
 	blob

-- 
2.56.GIT

