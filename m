Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793089885;
	b=DCPlS2vdFiFpZlfvsUGFAhyHjgCpikUVEH1hOg/TXYxdeNtaHPXYC3fWB4UB3DoQIzAT
	 DEkeds2ZwavIo6Wr1KErIEgXAdFB9S7fR48KtNI/B1qCVR3Xk+fZp5PK5fbKsHBsdPWjs
	 a2FHjolBjp8gETLihFOJtVOQ96Z6jYP7i7MNNXvHbTfjPz5GsEoRmXcF0ccScFCTIX7FY
	 i+HqIEvUunm8xJ3Q8nwfpSgq5gi67fB3D8VTO03BBkIht8J/Eu5jOCT55gebKXq0ZQRRK
	 5Uno36aIxG7nEWouacprmSsm4kKLg8UaU+RDWgzWxUpuvPDVdfjBpySmFR173BIB7ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793089885;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=s+b4NqKO7zGT5iQGUWXJj2JG6GDA+oc9CGXMdDTRzy8=;
	b=QT5WqqBh8fmX4RFAHQMnQ5GDQWz861F2lwIS5k4Aa9G+PrLV3xCPog6L79kvXLCrA6Xw
	 xRZxXb6HK9XmuaBDDw0uNBX/YFsowyc1KicIOFZgtieI9W0wfd/Hb5VgWKy0AOUfL5gPD
	 4P34LogoZ8V8/2u3biL/pTUSaXSHueHc8AmcHMDhC4GqAEzL+pVUl20hCdR60KzIO0gbt
	 iBqK1rpoO26Bssu648AepVfFWzh4uJb3+dYcEZpPPEFSex2PHtSJlMcpTTTfeNLlHO6zk
	 zaQcotQ/pjXzpU2j5/hOs+RXCdDxM1VZSlv2Mql8JYvsiLkcFOn72GxW0kCFQ7Hpr6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=k19uhN4g;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EFE606A31B
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 08:31:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51EFE606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=k19uhN4g
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1438d9363fbso726066c88.0
        for <git@vger.kernel.org>; Tue, 27 Oct 2026 01:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793089884; x=1793694684; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=s+b4NqKO7zGT5iQGUWXJj2JG6GDA+oc9CGXMdDTRzy8=;
        b=k19uhN4gbIkB1O6hra+n0bWFX3vIvgsiRq5fF50XAjbNrIMR2cXwwYmDeMGUWXh0FY
         OkHA0NsipgSWeURjpA1h7cBpKPECMDAex0hJ4V8jmD5lhqzSIIXgOviDLCJ3yTpIY1yn
         gOhgj1DhTV2YhctqMXfMSA2K3uOVYIJNOYj/VyctoQKYnJwY52mwuGdBDD7wK/fSoTpe
         2lsiJgDbOHYdc0RbmJw4YsXeylhyhPP9MNuP10V1UNyAnrWrO5WYy7tUJ7rFDZp6Y1Al
         LuY1/LgBV1IGgv9XiMnCgnzS4q1V2HLjAEzO1GTvnHsEmiCwRYmZptkUltRqQP3rMP5W
         F3ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793089884; x=1793694684;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s+b4NqKO7zGT5iQGUWXJj2JG6GDA+oc9CGXMdDTRzy8=;
        b=O0RvtsHzsR1D0PmKfqfFvKmOUiXU8DGAdMqJz/YX9ccK5X8zNcsQwSdFoqE0jJv2Om
         xS0Jb3nxzLF39/XWiHO1MV2qZqryubnsusNfGEMD1Szcq92gd+yVfrVp1Pvsqam8pop8
         oA71qhs65RIqYixhIrGTkyyowTRx53It+FtX7YL2OGdIgIjoIdptILRTwL3QLsmWG2Zc
         AnWN6nu2yYTEFLOh1gP/CAEFPJX1UQUTXr3i3f9hI6FI1kr+IxvXxuK2fMYSuauKCmNQ
         v3PpmbeOGB4YYk5E0prP9Kockv6XJxdgTAWVpHNZyhYCa5R1JSOh/m//upaZA6HZfgBY
         m4IQ==
X-Gm-Message-State: AFq9FYJWJn+PaabiF4nRU8Ridti63WToRhOiFl+QH9d04Pz1HXFoULd8
	DXrTBO/zh310BU5K2hukATxLntiOStTtWJivVm7ijK8H11NCQ83aZgMyrDJoKY9c
X-Gm-Gg: AYBFou1oqTUgfVuNFi0ZT7sG0tmHlxnspQv7w6g2r95XbNkUOorLJzHzQHFP1wMXcjQ
	aSqGK62EZI/Tl0vdC0aRM8tnUQaSk0xQ2JHW5q1EDRV8kuV3ZR5bVfNB718HcVzaxJffRynqGk3
	E8vki8giJUX9m8emv0Z1/ahegkc2rPNWRjM/cRhAJ+fkmrTFyp/lPN6VwZEBZynVjX1Fbe5tVjN
	Syt8GTilZhW3gnzVVBDDjM5pRv0fGfGjdkj13RgMWjNPjib5tHpce/jwZu5uNhUBktkqwoM833R
	3knj2D3vSKzIGVrsfkG+Bo9Ol7yCMGdqwc9ku8dnf8+wSWvNs5D3PIOrw2alCM/+G37ApJMmmef
	pdD08DSVgNjY3DEkGbNe+Mn2+CEl1g7skVAZR8toeAPpr/8wwrlJx0q/GkXdVHwfFJi7C1IuKQw
	lgud1RPcKTHT/oMFiJYfgyUgHNKngq08jpyeBaoyb/3OA1CWocqlzURYinAMT7SFoDB4hRTYCXC
	w7j4QokaZjdYrH5X+/yh0RnksNd3pqmFNCPdgNDm6y7lU7nR3M9Qgcbpg==
X-Received: by 2002:a05:7022:47:b0:14e:5e6b:e6e2 with SMTP id a92af1059eb24-1a3c904cc2fmr3226305c88.18.1793089883955;
        Tue, 27 Oct 2026 01:31:23 -0700 (PDT)
Received: from [127.0.0.1] ([20.169.77.163])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a249c331sm65949032c88.17.2026.10.27.01.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 01:31:23 -0700 (PDT)
Message-Id: <ad3158b3367d00fb78d2fa5a55b82d5f634c3d61.1793089879.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2456.v4.git.git.1793089879.gitgitgadget@gmail.com>
References: <pull.2456.git.git.1792437558.gitgitgadget@gmail.com>
	<pull.2456.v4.git.git.1793089879.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 27 Oct 2026 08:31:17 +0000
Subject: [PATCH v4 2/4] imap-send: accept messages with Subject before Date
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Patches sent with git send-email cannot be fed back into git imap-send
after fetching them from the mailing list archive, for example with

    b4 mbox --single-message -o - <url> | git imap-send

which fails with "no messages found to send". imap-send only counts a
message when its From, Date and Subject headers come in that order,
and git send-email writes Subject before Date.

Accept the three headers in any order within the header block of each
message.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 imap-send.c           | 24 ++++++++++++++++--------
 t/t9001-send-email.sh | 22 ++++++++++++++++++++++
 2 files changed, 38 insertions(+), 8 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 7e74c37a72..8977a934f8 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1457,6 +1457,21 @@ static void wrap_in_html(struct strbuf *msg)
 	*msg = buf;
 }
 
+static bool has_required_headers(const char *line)
+{
+	bool from = false, date = false, subject = false;
+
+	while ((line = strchr(line, '\n')) && *++line != '\n') {
+		if (starts_with(line, "From: "))
+			from = true;
+		else if (starts_with(line, "Date: "))
+			date = true;
+		else if (starts_with(line, "Subject: "))
+			subject = true;
+	}
+	return from && date && subject;
+}
+
 static int count_messages(struct strbuf *all_msgs)
 {
 	int count = 0;
@@ -1472,14 +1487,7 @@ static int count_messages(struct strbuf *all_msgs)
 				if (!p) break;
 				p += 5;
 				count++;
-			} else {
-				p = strstr(p+5, "\nFrom: ");
-				if (!p) break;
-				p = strstr(p+7, "\nDate: ");
-				if (!p) break;
-				p = strstr(p+7, "\nSubject: ");
-				if (!p) break;
-				p += 10;
+			} else if (has_required_headers(p)) {
 				count++;
 			}
 		}
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index d1393ef197..d105fcb41c 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -2863,4 +2863,26 @@ test_expect_success $PREREQ '--compose handles to headers' '
 	test_cmp expect msgtxt2.to
 '
 
+test_expect_success $PREREQ 'imap-send accepts a sent patch from the list archive' '
+	write_script fake-imap-server <<-\EOF &&
+	printf "* PREAUTH [CAPABILITY IMAP4rev1 LITERAL+] ready\r\n"
+	printf "1 OK\r\n2 OK\r\n3 OK\r\n"
+	cat >/dev/null
+	EOF
+	test_config imap.tunnel ./fake-imap-server &&
+	clean_fake_sendmail &&
+	git send-email \
+		--from="Example <from@example.com>" \
+		--to=nobody@example.com \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		HEAD^ &&
+	{
+		echo "From mboxrd@z Thu Jan  1 00:00:00 1970" &&
+		cat msgtxt1
+	} >archive.mbox &&
+	git imap-send --folder=INBOX <archive.mbox 2>err &&
+	test_grep "^Sending 1 message to INBOX folder" err &&
+	test_grep "(1/1) done" err
+'
+
 test_done
-- 
gitgitgadget

