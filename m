Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F3417736
	for <git@vger.kernel.org>; Sun,  2 Jun 2024 15:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717342962; cv=none; b=F2pr0dtI5p+0HEGhmJKjRMdn7NBYy359l15MFkcCa1cLu5nTPfn8u1CfKmIyVYSqtfZUBNsxRRdJeKpNWSBf5PAgGDoBlrXxzE5yVBIImmle18vw147c/1N5tHx4VbIknx410WLbYebG5CDMY4EEt5xUaCBFGQU0k7q21TwpjuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717342962; c=relaxed/simple;
	bh=9buze0qX/HHkBRJA2x3k2wct50Sd5TTM45xW63hS89I=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Qu14Db3H4CYUSWf628Fimyuww6V0AyQlUDMQO/l/PBN6YcSUviUmaxHfjT9jL0wESvedqR1wZMFrd4ERyebRFerrdljLhnrVLpw5kRBnkT7xPNVLeNacRKdyuGr3hMRoZqg8pnwaad34O1ZeDQMNlWlfgEz/Hc6itsawuWxe68A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJbaVt+k; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJbaVt+k"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-35dcc681f70so1628304f8f.0
        for <git@vger.kernel.org>; Sun, 02 Jun 2024 08:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717342959; x=1717947759; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ogt71lu0MFbaoK6gslrbrwDHm7w5iJ2MfFkPK48AauM=;
        b=DJbaVt+kXpA3ToQFyMtOw8wQobSc30Ku+HrB3knPIyfuD5YWrq2GqJvqmKsuuoMDVL
         PnRmKjazuNBIy4NmwwPCpF27c4woMbQahedHrMkmnxA7JdW0pBHAK3aZ9n3jF03kgaso
         clZxq5ZzxteItqOgqT56RWoD1AIVceVj3+aGptXpaKC8kVEvA9CsycoYAO/9kN/rNGz3
         9kkGTL46EBRood+0+FcdYGSkwE2PHeIqwWZQQ8FO9xSBDcKlKJhqzF4z9KFM98THODd4
         WRE3ee7JycuIFdKQrfoLVKc6EVrMXR6DqnbyKu1SEk7f42oLwwjvubg+B2Xp5btnDzdH
         ZZiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717342959; x=1717947759;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ogt71lu0MFbaoK6gslrbrwDHm7w5iJ2MfFkPK48AauM=;
        b=Q/y0yM1cJ75a1oQAqMPdn7bmboP9PzXrjY+oSBsKy7n/DReAgM02Y5uUgrjZnbd+tz
         ImdoOfaTPzXUrdiJbInS3nPYl4IfM5fmrQoCyq7grnvZ0k6RQRJEDO6fK5R5yqD9rCYq
         9Yj9QneRlugTa2sNHcccUuB8farjQAR7abkstha0atcd3CX2yLgticczh88EKdSXzADh
         431k6+RoTja51OvCRlqX6Y0puDnzUlmDqgrPdxOfiQzxmtH7SVfvxeXbDo8SS1SZMJiz
         coTZliSeDj0xX5Oq5UIYoA1VKDto+mmjwGhwnk2WMlOJk353CI+LskREOmgo/TLqq/gL
         1iWQ==
X-Gm-Message-State: AOJu0YyTc4iaWwJCElLdMLNz3osxr6hhOAdo2yXbYisIKRiefEMof3OK
	44MeGWCdsuq7raPmv0m544AtSseUPNA2NetrfLtV224TE6hr2uJwUkAdaQ==
X-Google-Smtp-Source: AGHT+IGlWldJdQYHE5sbTJ9bFmW0gYoXRsjZQobspPjVVWB1TIagfTr4dXsA3wxbPA3dSgereBUn+A==
X-Received: by 2002:a5d:5683:0:b0:351:c615:8165 with SMTP id ffacd0b85a97d-35e0f3414e8mr5268126f8f.66.1717342959308;
        Sun, 02 Jun 2024 08:42:39 -0700 (PDT)
Received: from gmail.com (12.red-88-14-51.dynamicip.rima-tde.net. [88.14.51.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd066ff17sm6392396f8f.116.2024.06.02.08.42.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Jun 2024 08:42:38 -0700 (PDT)
Message-ID: <de0a68d0-245f-4641-a467-8678d5c7ae05@gmail.com>
Date: Sun, 2 Jun 2024 17:42:38 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 1/6] add-patch: test for 'p' command
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
 Jeff King <peff@peff.net>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
 <199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
 <b7e24b08-40a1-4b18-89f6-e25ab96facaf@gmail.com>
Content-Language: en-US
In-Reply-To: <b7e24b08-40a1-4b18-89f6-e25ab96facaf@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a test for the 'p' command, which was introduced in 66c14ab592
(add-patch: introduce 'p' in interactive-patch, 2024-03-29).

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 t/t3701-add-interactive.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 6624a4f7c0..6f6d174687 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -590,6 +590,22 @@ test_expect_success 'navigate to hunk via regex / pattern' '
 	test_cmp expect actual.trimmed
 '
 
+test_expect_success 'print again the hunk' '
+	test_when_finished "git reset" &&
+	tr _ " " >expect <<-EOF &&
+	+15
+	 20
+	(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]? @@ -1,2 +1,3 @@
+	 10
+	+15
+	 20
+	(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]?_
+	EOF
+	test_write_lines s y g 1 p | git add -p >actual &&
+	tail -n 7 <actual >actual.trimmed &&
+	test_cmp expect actual.trimmed
+'
+
 test_expect_success 'split hunk "add -p (edit)"' '
 	# Split, say Edit and do nothing.  Then:
 	#
-- 
2.45.0.97.g9fa538478d
