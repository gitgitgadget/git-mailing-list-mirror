Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794311408;
	b=NoYHV8QqqJ2aojXwyYN1PV7LeRdj+ZB1bR+wyh2seDnNYuutPJoy8UaZuUFjOT9t8pZs
	 z4XvFQ43rBIBygz2HIkJTsxNUKjIq/oXq9eVosZmEAV36R+WTD7ZiHPOJ6XRU7a8is7Qi
	 bx9mKPf83H1UGfx6vsk3QlggoZ+1I2ZiiWnoNeZ6TYuFHVhXYQC+G5yj5MWloesoDc+Z/
	 w2YpFgpeOxwiuvRNkBF9L8fcto8azxy5bF3ETsmIpOgi4ME6hfDEnH5QkrxktAz8vvbH8
	 lzEK/cXCwIqqdhv/E1GqvfXuuG2HvN87iz+euAVCeMq4qjVg60rk/faK1HoAZ4bEOUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311408;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=PW0N6K9uUWat772ss6x53VohDnYfp56mQMLfv38fHcY=;
	b=nI+jx1F7L9gEZ//VTwjL/41WvKnKokF/HwwAMiEo4ZXtkRxInviam7iEuC1GDsCMadLM
	 0VaOkDU1dmtE+NWa97C1oAaVVU7q9dOC2iWujq1kbpFDSVpFvW4erP4CpwFR+57+YRtSZ
	 zH0j1bvzTptlDSsBLJYe/V47GB7r/hFYx3Y5yOHW8U8YQEaOTuY9K3isDK3pnFdccG7Ni
	 8FWDlpiNU4NM/b03JAp/+AFtzKxQTBcp4gYSXdVpZL/a/IR0dWTixZgNWxXoiCCzBhoyM
	 ygAStycjmaVUTx3DNvcAJvwkXnxttn7YLNlaghgLGBBeWTItTh37Bxq8wHc0T/gr61w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O0dLhPi8;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253E960A6F6A
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 11:50:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 253E960A6F6A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O0dLhPi8
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4b79502c27aso19508575e9.1
        for <git@vger.kernel.org>; Tue, 10 Nov 2026 03:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794311406; x=1794916206; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PW0N6K9uUWat772ss6x53VohDnYfp56mQMLfv38fHcY=;
        b=O0dLhPi8TCy6T7JdmIkc65fJfyWfptBqKysB1YcWIDPntSfF/rnCZ++1Ygo+N4C/QZ
         b+yDVcEYmywYicVH8q+i0YiyC8eZ/b6p4Vaxr0f/z5VRc5Q3sDO41jXh7rry45AIEL2A
         WbMNle0UnQ/WjOyzatdceqQmifBP0QXHGZXjmCQk375U9PK/ywgQ3Jr7hlb+w3Fi/EdB
         pwMwP9ZHAd8wHleD3T+sfTSq2WKvVmmo3kFS5ydu1okvL8rlg2V00hmqd5jshu6AF4m0
         dkm/U54uU3PRVbnEdrnf6/Y6rywDr5VhXUD6rg2dF+sIpxKogz4zVSMEjIKhlfVgwE/+
         OXyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794311406; x=1794916206;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PW0N6K9uUWat772ss6x53VohDnYfp56mQMLfv38fHcY=;
        b=YJnuvur9WKnY/pRHlPUa6l3KQX+tLEnAe2gVc7nq+OyCZ0VKJdgStKjkKXpJ+0k/BV
         p9kKzDRobJfY+w3lEAwpN+VHsYapCXdDfbEIfs+0iVVflMEN9YFQVDbNWIAY+IjgBPXY
         WDXWRtQrne1adcwcoOH9gvYK8Fa+6Mp70CIU4wyK6v7fIGMrns0Gw3k69COGdF/D83aE
         eER+fjcXAwkCWMUfysE7pbDMQbTnVLTBTnOWzt8jkipIfcuQerkgojB6kXq4oUX11SQM
         JWJdnjboZWzn+Bi6l67mpv51nvtZSutdzkJNweVJryDl6jr2vgbEoG1Y6vQY8IB9xntY
         PgBA==
X-Gm-Message-State: APuU4Z/2UleKXEdqVRKBZf95Usj3V5AHTeY4QFPDFiYJrlQYZeBjwBxf
	6Zr9EQPU/v939RNAYzMrWI9LWje5yoA73cLT60g2jqcFeAZ9WZaAtwSGIhw65w==
X-Gm-Gg: AYBFou3fEEmU++vpGz+qO8Jybvnq30uVRG7EzA2IKAgA4cbSSDNBz+8GatSZyM0m+4n
	nYtWWm9JQo/D7CkW9+g4tfPCBLe18ojDKk3aFTyyUVBvtHVq3nvtgVe8YAaNWRcy04k1SHo7+3G
	oZsL7qLPB+RjhPtWlocad/fyCnRUPN4vu62q91sfc3CD8cncc7QhZ/eVnVUEhll67fMHY6d5YBt
	LFahTz9xK+mNOnB3V6EqXECBd2ySOfrTlU5rC6LX4woiwBcryr7BMWY9yNbI20G3FdHNDYh8QnJ
	ju1p/t8x23LD1R04fG8WmY5buhApfejXTbdvl9fVyarerr9DR05x1w6DSYSVM82l5499nLEHHaa
	75kv8Vo4XlsBO3bHr7zC/XvZLda/V/naBSsStY2D+OVsFwLuBR1EnHVBPN3NlPQxtL6UOs8BU95
	B3Mtp4lmLVQjgtKg2YyZEDVos2e8KLU8t8crpEkGtBQvg5OClVslloyIoiZsM5ayf+Xg02BdqSB
	yYNxZb5x+68yizHn7OxJ80OWOndG2Qb7TR6FISYZfw8Wu4a0qCkakS7RgiiXtYXfXIuN3c5A9C3
	ro5wx4KXx/fYQuGcpxm/M21LwdiaVvIZ/gY3lqOxM4JsUUiQicK7xlBrdb69UXAvKLWAewNtvoF
	eICr1tOe1MgqS6A==
X-Received: by 2002:a05:600c:c8a:b0:4ba:6d8:dfad with SMTP id 5b1f17b1804b1-4ba06d8e47cmr19841425e9.14.1794311406363;
        Tue, 10 Nov 2026 03:50:06 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:1917:82b:d709:897d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba02005762sm60715995e9.2.2026.11.10.03.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 03:50:06 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 10 Nov 2026 12:49:48 +0100
Subject: [PATCH 03/20] t9300: make the series T tests self-contained
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
Message-Id: <20261110-kn-fast-import-tests-1-v1-3-dbd9ee502aae@gmail.com>
References: <20261110-kn-fast-import-tests-1-v1-0-dbd9ee502aae@gmail.com>
In-Reply-To: <20261110-kn-fast-import-tests-1-v1-0-dbd9ee502aae@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2692; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=k7lwyriv3HyylO7yptODHea7EL6EghkmG1v5/R6vfaM=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGrzBOWtBWT2GeBUmDcBl26+coLcKKNsu8wVC
 /tTGQoqDueJnokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJq8wTlAAoJED7VnySO
 Rox/mhwL/0Z1xqQcN8JK2RgBxuL/OJ1x5ygLWHV8LAncLr79z47GPy4CGr2DBu0RSE1TOlGxqH5
 1GEWowHz4BROyDzvki57uGs5rWGdvx+SatWaOJCb/kAZvUfIkdIIfy9fhbi8xv24ZaUDheXiKGz
 YoQGvixNKVNGGjKebTmqeI5C8Sdj1fC4UG6PXJDeyfpoLdyIFQa/NNLUGpAcjq6AxXaKm1MP259
 ax43rUOt8XBIGJ0zECJH4B2a7R78l1JiWcXsN0uNyYPZpQEjNdmA6eUarYLrXrTUdtMoKTpDXu+
 LWwJu4Sp/HaicMcxpPKhF9z4smRhMApKqTmSxMXaHZge1RjzzmCwJFcZGJxvw7vL1t3oMwuN8R7
 AoBA07obnZZWpRYk03SIOJqQs61WF8nfhdUTNJYam6P3F5iHPSpgUjHh9IqCbQuDCgo0GoDhNVR
 IuT8b0PdR3aTFIziYkAaQksOckkMglvfIKOPe8kqnIab+AwhVZc/WKxfXdkHDpoMmgrizL7ppc6
 Tw=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Similar to the previous commit, modify the tests in 'series T' to make
them independent of state from preceding tests.

The 'ls root' tests list the root tree of the 'S' branch, using the
marks left behind by series S. The expected output is derived from the
commit itself, so any commit will do. Run them against a commit created
in a new repository instead. Run the branch tests in a new repository
too.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 t/t9300-fast-import.sh | 62 +++++++++++++++++++++++++++++++++-----------------
 1 file changed, 41 insertions(+), 21 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 1b34f6491c..76cc9504eb 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -3525,38 +3525,58 @@ test_path_eol_quoted_fail 'ls (without dataref in commit)' 'ls ' path
 ###
 ### series T (ls)
 ###
-# Setup is carried over from series S.
 
 for root in '""' ''
 do
 	test_expect_success "T: ls root ($root) tree" '
-		sed -e "s/Z\$//" >expect <<-EOF &&
-		040000 tree $(git rev-parse S^{tree})	Z
-		EOF
-		sha1=$(git rev-parse --verify S) &&
-		git fast-import --import-marks=marks <<-EOF >actual &&
-		ls $sha1 $root
-		EOF
-		test_cmp expect actual
+		test_when_finished "rm -rf repo" &&
+		git init repo &&
+		(
+			cd repo &&
+			test_commit one &&
+
+			sed -e "s/Z\$//" >expect <<-EOF &&
+			040000 tree $(git rev-parse HEAD^{tree})	Z
+			EOF
+			sha1=$(git rev-parse --verify HEAD) &&
+			git fast-import <<-EOF >actual &&
+			ls $sha1 $root
+			EOF
+			test_cmp expect actual
+		)
 	'
 done
 
 test_expect_success 'T: delete branch' '
-	git branch to-delete &&
-	git fast-import <<-EOF &&
-	reset refs/heads/to-delete
-	from $ZERO_OID
-	EOF
-	test_must_fail git rev-parse --verify refs/heads/to-delete
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit one &&
+
+		git branch to-delete &&
+		git fast-import <<-EOF &&
+		reset refs/heads/to-delete
+		from $ZERO_OID
+		EOF
+		test_must_fail git rev-parse --verify refs/heads/to-delete
+	)
 '
 
 test_expect_success 'T: empty reset doesnt delete branch' '
-	git branch not-to-delete &&
-	git fast-import <<-EOF &&
-	reset refs/heads/not-to-delete
-	EOF
-	git show-ref &&
-	git rev-parse --verify refs/heads/not-to-delete
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit one &&
+
+		git branch not-to-delete &&
+		git fast-import <<-EOF &&
+		reset refs/heads/not-to-delete
+		EOF
+		git show-ref &&
+		git rev-parse --verify refs/heads/not-to-delete
+	)
 '
 
 ###

-- 
2.56.GIT

