Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF2A1E8855
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 19:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730833374; cv=none; b=quOX+GStw8FfnATB6WOB638Fj6+yKh5mUy1OM6emrSNrexhYGSg/8UHgzdwJaiPKqhZtTyrEu3D6NfuqBAafMA2ALLlcQagAXKddq8kEMJHJvwYWP32lIVfdx1RdMSCWXMPpWjydFwtlptUmf2ntP8sCcZOl9vkmQ8o8SOtjAyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730833374; c=relaxed/simple;
	bh=W7OUk9oMM4+yQ0IEIm8DvvHeWV3vpH8Lrh+gNk7YQOU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jBEF+Hci3F9TTTw5qoOuds/+6SU9E1M/zv7Mj8p+6ieFW0HzANnXlWMnISYtrLE1AVx6+gClGoy5H/e0W5La2iTmsNNMgj06f620e9ztc2WGWlt9uKgYyj6UkRlUFPveAMfzTbv+S6IAZiudUdCyddL6shnmXlPZS3ssGt9Losg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EsplmIpo; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EsplmIpo"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20c693b68f5so63046875ad.1
        for <git@vger.kernel.org>; Tue, 05 Nov 2024 11:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730833372; x=1731438172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sfsTf2t7uxhnAeCjUxBFYTAsPj3pGjMaKWD0UFjmv18=;
        b=EsplmIpoHZ2UDKZz41+evljHaswWYmsLDjF65wUeh5UsXjExhjD5TmNWdqPBY2u4uz
         EhlzjW1KbMFbDRAAkvOWUMVZDgfXrnn91C5s2cSh6pNC8GrY8Vcs2J8iFtr6JPgldlHm
         KggmV2hz2QPI3DEDweT2mdr73veyAZPGQ5+iW7JQQAcfv66oYxtvqYz7sIoYEkhrv+xl
         SMXR9Rrzj2fkAK9471GPwZHM/3/YiCAUqGVR8x1DsXedLwLqatEUnBy8AKv17S3e/PXm
         E+nxYwuxc4jBfn1GO79tO8T2AUDCRKrWKV5Lp53uiTmuL5M66fDPiVkBvn5cuOgOHLUZ
         ME7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730833372; x=1731438172;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sfsTf2t7uxhnAeCjUxBFYTAsPj3pGjMaKWD0UFjmv18=;
        b=ALtKKI5IAM0RakdR/P3FFnOzFiHBNO89OLDYVGEaUh4XTVbj1q5Ugr9tN+fwyjervs
         DLJYgAJ6CBgwvk0uDvgTuTm5ppAxDrBxqedf3HI6iHK1jYFRBnC5HATQqKyl9eNfFZ3m
         9eGdd6r+SKSsRbaxwgR86FmwVt5Jpn3OZfbvAzImplWnj71R8BxkIusLUm+d2frEc5dm
         6D/qNtO1/MQ0ssVxvgo1t9sJo72Z9dzV1X18xoBHm3zCXf1qTNYHgNEjtf/2lQBsdqoO
         mxdG2axqehsmTT+M19ER3DPt+MjjWhLHj32fmV2zTIC1T5GNd1fKB9DJeGOFjFsgECzA
         wuNg==
X-Gm-Message-State: AOJu0Yzdp33j/HVga3Rm+4ocAEawI/TfGteRFpaJp3BZoz/MrGJySS38
	5PoGvqUz8AzBpcXw8NyzQZqjVv7Xe+3ETRsRVuCm4ELMfNElow2hrWVRJFg2
X-Google-Smtp-Source: AGHT+IHi5mSC2ZUBisBNpr3fkmBB/OCbXjeLaseCC9tl2UPisN0ABH6rduocO8jqH5TANSQBGmJ0WQ==
X-Received: by 2002:a17:903:32c7:b0:20c:c482:1d66 with SMTP id d9443c01a7336-21103b25486mr278447955ad.35.1730833371866;
        Tue, 05 Nov 2024 11:02:51 -0800 (PST)
Received: from kousik.local ([2405:201:c006:3236:6b67:58eb:c90c:e15a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211056ed953sm82373895ad.35.2024.11.05.11.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 11:02:51 -0800 (PST)
From: Kousik Sanagavarapu <five231003@gmail.com>
To: git@vger.kernel.org
Cc: Christian Couder <christian.couder@gmail.com>,
	Kousik Sanagavarapu <five231003@gmail.com>
Subject: [PATCH] t6300: values containing ')' are broken in ref formats
Date: Wed,  6 Nov 2024 00:11:34 +0530
Message-ID: <20241105190235.13502-1-five231003@gmail.com>
X-Mailer: git-send-email 2.47.0.230.g0cf584699a
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document that values containing ')' in formats are not parsed correctly
in ref-filter.

The problem here is that ref-filter, while parsing the format string,
looks for the first occurence of ')' and marks it to be the end of _that_
particular atom - which is obviously wrong in cases where the format is
of type

	atom:key=value

where "value" has ')' somewhere in it.

However formats having a '(' instead in "value" will parse correctly
because in a general format string we also mark start of the format by
making note of '%(' instead of just '('.

For example, in

	%(if:equals=somere)f)%(refname:short)...

the string that ref-filter should compare against is "somere)f", although
since the parsing behavior in these cases is broken, we instead compare
against "somere".

While in

	%(if:equals=somere(f)%(refname:short)...

ref-filter rightly compares against "somere(f" as expected.

As a side note it should be mentioned that values containing ')' are
legit in %(refname) (and other atoms like %(upstream)).  Meaning
the parser wouldn't err out such values as they are legal, which is also
confirmed by - say the refname coming from

	$ git branch '1)branch'

or a remote name coming from

	$ git remote add 'up)stream' 'some.url'
	$ git push --set-upstream 'up)stream' '1)branch'

since none of these fail.

Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
---

This raises the question of what can be done to parse ')' in values of
the format correctly.  It seems to me like a clean solution would
involve a huge refactoring involving a large portion of ref-filter but I
maybe wrong.

So this patch also hopes to open up discussion on not only solving this
bug but also how in general ref-filter currently parses and formats
atoms and if it is the way in which we would like to do things in the
future, which would in turn also be helpful in the long term goal of
merging both pretty and ref-filter.

Here is also a simple script to demonstrate the difference between '('
and ')' in values in formats - as described in the commit msg -

#!/bin/sh

rm -rf /tmp/atom-test-dir &&

# create env
git init /tmp/atom-test-dir 1>/tmp/init-dump 2>>/tmp/init-dump &&
cd /tmp/atom-test-dir &&
echo "smtg" >file &&
git add file &&
git commit -s -m "initial revision" >/tmp/commit-dump &&

# using "(" in refname works good
echo "test with refname as \"bran(ch\"" &&
git branch "bran(ch" &&
printf "bran(ch\n\n" >expect &&
git for-each-ref --format="%(if:equals=bran(ch)%(refname:short)%(then)%(refname:short)%(end)" refs/heads/ >actual &&
if ! diff -u expect actual; then
	echo "		actual is different from expect"
else
	echo "		actual is the same as expect"
fi

echo "" &&

# using ")" in refname will parse wrong in ref-filter code
echo "test with refname as \"bran()ch\"" &&
git branch "bran()ch" &&
printf "bran()ch\n\n\n" >expect &&
git for-each-ref --format="%(if:equals=bran()ch)%(refname:short)%(then)%(refname:short)%(end)" refs/heads/ >actual &&
if ! diff -u expect actual; then
	echo "		actual is different from expect"
else
	echo "		actual is the same as expect"
fi

 t/t6300-for-each-ref.sh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index c39d4e7e9c..ce5c607193 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -2141,4 +2141,19 @@ test_expect_success GPG 'show lack of signature with custom format' '
 	test_cmp expect actual
 '
 
+test_expect_failure 'format having values containing ) parse correctly' '
+	git branch "1)feat" &&
+	cat >expect <<-\EOF &&
+	refs/heads/1)feat
+	not equals
+	not equals
+	not equals
+	not equals
+	not equals
+	EOF
+	git for-each-ref --format="%(if:equals=1)feat)%(refname:short)%(then)%(refname)%(else)not equals%(end)" \
+		refs/heads/ >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.47.0.230.g0cf584699a

