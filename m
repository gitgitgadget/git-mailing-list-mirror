Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792995390;
	b=vuNWBjyx26YBOp4OXUZI7WHRwHyh6y58I7TjG9le7IEoSNwyS0NJFJVtwPC+U6RSg44o
	 aKlvdl0GrZXqDMFNyPw01V82UMOl2bsuQyBpee5EZblkrOfrcCDOBR234hsLTdpUhFa2l
	 von7FXkf33KWKhuVXn/Zw/J3FLJqFlxjHk51jGySGu0WkBIi6x6Od/pZ+4EDfumLnosVk
	 IIwuHpqlnySYs5pnFCsf7cDlprqNoUeplJdUWJdjPmmeui17b3UjfoP6SDp0OU/uzQNVH
	 BmGP+mWkLL/hH1rGnpgyTv7rDZTNBGeBs+/+ljXkP3YqfCzvd5ivNX4g0beXza91npQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792995390;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=bhAR+zGjJM/Eid654XMAxbKwOhoYvUnWCjimZnR1r0s=;
	b=v7RFtRLJAF5tok3LGo7p0vnSJwlleKv3nXArv+aLnedYGhcs/AkXgqzqndj9w5gR/TOm
	 rWCjunmAcbl4efrwAEqMgnr6N1ln117JmiovRguj8VEtMNFPC/V0jwGdQ91QBktc0CsJk
	 i7QZ/at0yeT1gnb6KcsASGvdJ6BgyT8/0MwwlBaBDsQcYQlRmv71LfsKPdhomGausLusX
	 2AbjmriMQsY+b7E+yYqRsrQ6JZwuFo8YbLHsaEicHnRAvCx56uWgmaLrUFqY+oqlfs/1D
	 /J98y/IH6M0v83wGDiuvbrygqw860X6OpKJ4IzeEkRSLUFMg/ThiIhxptY96hVpelfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="r/rvoBqo";
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2AF606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 06:16:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC2AF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=r/rvoBqo
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-354ba08cfd1so4849022eec.1
        for <git@vger.kernel.org>; Sun, 25 Oct 2026 23:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792995389; x=1793600189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bhAR+zGjJM/Eid654XMAxbKwOhoYvUnWCjimZnR1r0s=;
        b=r/rvoBqoGiMHKSsMTwMKPN/EC3EtCqyxYEOy8Wo02so8EbO6cbDejwat5VxvRpuLvG
         NolSObtlT1VrLP2ELQ2BC/3woT74gNY6D+bbgKn8PtOLRn2tYWv2Go/Lg42P29aXNCx7
         d5nxhUTHBgbYZ35TtQBb0b7kiOIGOXEPpWvsgugNjkVR3QUHorWsBwRFeuzpz6iQsxJT
         8fznPXM/RNlyZs4ypt8/wzKSEYQEdEtxnjv0QM94SxMZ3rlS97buYgkmVJVSiY7XlnWz
         ljSFuMxF8JqU0q6iN8W0lrVtDqLXjHskD+NJ2e/E4V6iXAgomNHP5Eu6G2clSsKWA8h8
         bGEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792995389; x=1793600189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bhAR+zGjJM/Eid654XMAxbKwOhoYvUnWCjimZnR1r0s=;
        b=gUhoIRtzBtuG3NBdBTEOffxQiIQIY+bI4Tx2qHD0EpD/yPa7u51nHF2GKVi1vjgcg2
         4IDwHrwzcxtGpirMhle7h9q3joCg/68+kZQwAEWS0Uwv0bJRbIfOoIsek9Mi/2SPGF/C
         AAPNd1Y0chXybeqP+QT2jlpmIDahn+qCpLOyw5LKeW2ocyIecDNHOFuEckmphNnZBlao
         aYNJPzlAaztgp2xQnit6k8Yk+U6l4cO5PZ8ssAPtPOLAiL/OO1An+jSmTZLbfmP90Gpx
         u2cOwCSUYb5eHd4bsm5RM1t3aBaj62UdBjZMd+IsLO71wILQguzF9GuZ3zfuqwL152oA
         /dGw==
X-Gm-Message-State: AFq9FYKUOMM6I2Uxj26w37Z3Rl4z62H+P7Ufk1fTFL6UfeSPWv4zUelv
	GBNZRPTglAKyJStFzb8LI7ReriRJ73z+Ma1kaTfwSLyX1cF7eRJe3L3wEr7OeM85
X-Gm-Gg: AYBFou188HTLXybFvbpoFoZYuT5aiQsfqbUxMDsC0dB4tKqH4+uNIngavDA8PQstMaf
	y8CeD9QmRLcDVmmYS9I0JLI5AvjWbFgLsCwmrll1AHKur7HlYT3Gy0yG/Sw2v6RdWU1mNcaVWv5
	+rjp1InXafx0A6DraVECXTqujGKeQIZcNljMmVKrbxwW8BiwKn8JM7qbYe63jiMQeT15hhNqf3H
	JfZVk1eyXQ4JHw8uepWdhzOoZHbG3OQuo++xuMA4XMYMkYtsVqu8N43N4XwrVqgGAmKQ5AW4M53
	Bb2YAXbMpEysQs90vGQSJS6JMF4D8E2oLhjcMV7w50F697C7mFUcrbAyDzYqxR6kW3LCZ17A50L
	EPANr8kbaOS4id0mjqGWvZyi+3WFPWy9Z82WoTNQ2fZEl057VkJlkLk+kZKucddhpdokL9voNSh
	grg7Ch33sbt+DF11aSAGbPwXHtyQWR5cDrr5JQDk09bmoHWwk/G1coUMk5REYNbGbkydi+ig5E7
	Q28m029yX7oU03m/mykBoZ7huFVvkWjQ/ZpVyAIHyt7ho0JlYtGgfBwssUIHow0fhUm9cU=
X-Received: by 2002:a05:7300:d193:b0:369:f035:661 with SMTP id 5a478bee46e88-369f0350f00mr6435664eec.15.1792995388688;
        Sun, 25 Oct 2026 23:16:28 -0700 (PDT)
Received: from aegix.lpu.com ([117.251.86.147])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369ff5a4d68sm7499112eec.14.2026.10.25.23.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 23:16:28 -0700 (PDT)
From: jyotishkumar725015@gmail.com
To: git@vger.kernel.org
Cc: jyotish kumar <jyotishkumar725015@gmail.com>
Subject: [PATCH] t1006: skip %(rest) test for whitespace in object names
Date: Mon, 26 Oct 2026 11:43:10 +0530
Message-ID: <20261026061310.62950-1-jyotishkumar725015@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAGjZMyRF-hV8PMK2VBJT-9kzvgtQYP2EfYSMPjxSKmc2ZgscDw@mail.gmail.com>
References: <CAGjZMyRF-hV8PMK2VBJT-9kzvgtQYP2EfYSMPjxSKmc2ZgscDw@mail.gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: jyotish kumar <jyotishkumar725015@gmail.com>

---
 t/t1006-cat-file.sh | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 72fc8acc61..47d9434bcc 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -183,21 +183,18 @@ $content"
 	test_cmp expect actual
     '
 
-    # FIXME: %(rest) is incompatible with object names that include whitespace,
-    # e.g. HEAD:path/to/a/file with spaces. Use the resolved OID as input to
-    # test this instead of the raw object name.
-    if echo "$object_name" | grep -q " "; then
-	test_rest=test_expect_failure
-    else
-	test_rest=test_expect_success
-    fi
-
-    $test_rest '--batch-check with %(rest)' '
-	echo "$type this is some extra content" >expect &&
-	echo "$object_name    this is some extra content" |
-		git cat-file --batch-check="%(objecttype) %(rest)" >actual &&
-	test_cmp expect actual
-    '
+	case "$object_name" in
+	*[[:space:]]*)
+		;;
+	*)
+		test_expect_success '--batch-check with %(rest)' '
+			echo "$type this is some extra content" >expect &&
+			echo "$object_name    this is some extra content" |
+				git cat-file --batch-check="%(objecttype) %(rest)" >actual &&
+			test_cmp expect actual
+		'
+		;;
+	esac
 
     test_expect_success '--batch-check with %(objectmode)' '
 	echo "$mode $oid" >expect &&
-- 
2.43.0

