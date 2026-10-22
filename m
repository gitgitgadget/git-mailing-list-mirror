Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792652190;
	b=b4Z8x/pJWeKQqNhtUkk1DsBl3r4qS/gl/lC9CQHY6uHyMMU9fE21fleY2xtbkNCEZeTd
	 ljMt2WTDcn1plpUJMEPnpWP955qRxr4ZNuSbPjtOYu57/PXmrV1bmc+Rz/oDvAGoBZo+C
	 dpIM9S99KPE8cyV7FsFg1ePSzwAflVPcfUH6w39l4Okr8KYlbYqg+UBF2HfXaAPWP3rXM
	 YN/xDmpP/yBOlPUnpMM8o9xFHrjrqA9Nq+kxLfpLLCWI0QKXcvR7H4LGNuLOeHbCq5smR
	 Cq1nLsRyEXIMyKLDNjygRc2KHah1B7fpTI+wISeCFlu3Xw2z8pMlUDuZNDFj1MZG2vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792652190;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=sGuWOQV6ev5E4dVRA2durYbGSbuTQAJfCsmM5GCA2aI=;
	b=SVv2CNS2+QmfYtoThvJ3FyJEX/S+3gzdX4d8qlAOThexfFPFTnnDBCgv7+H4imguWEN+
	 eXPXcHgAyfRgFf/6L3m/bQcCgA6dHSOGrzQhvf/eT7IHjTQVFp7fwvPwGGqkvPmRl9V78
	 W00sbVkm6+BTAog2t3PWVjVVkH5shpU9/7YRI204O18Cx7IU0uAyoIb3GfnEXmHTqx7uZ
	 CChPKoAGcfHbRKtRIUdIoLkr4rFV57UItfeVadORTVSVpHrEsFbfqrNNn3lwJS7YkWz/U
	 c/yDoOaATd05HRQbymbVP37z/EgtS1LvtgI6ZmfgbrPoGP+/utpzusPXfz4wus5S8tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=k230QSC0;
	arc=none smtp.remote-ip=209.85.222.176
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF76606A327
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 06:56:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCF76606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=k230QSC0
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-93ece7a73b9so186061185a.3
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 23:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792652189; x=1793256989; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sGuWOQV6ev5E4dVRA2durYbGSbuTQAJfCsmM5GCA2aI=;
        b=k230QSC09setVD3HhtcJf/2RsqP7iRxO/nGGquMU1xKdAxqL6QaxpZBBUbLY63zZUe
         r+EdFD6nOG02V+7t34FjcpwQp0CUhytDTpMuSoo13H4euOruajslnhAgASGW54e1eeTq
         O/hNjkubzgS5GG/WzFaeFw0S0z+FuRi+sJZoF3gGd6/rChvtyObveEykFPep2TznxCjG
         NQzpB1kNQynLg5VQCx+VqzcXT5iiVggopBcGqEDbgLmIc8zl7BTAlPeq6H4Z2Z5tnCSp
         0GvQUilHxU+l6Hp2Y7TWZFZ3mmtjFryPUII4b2r1n+//pKxQUX8Sup04oVfSeFKXGAJw
         Vi0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792652189; x=1793256989;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sGuWOQV6ev5E4dVRA2durYbGSbuTQAJfCsmM5GCA2aI=;
        b=ySRSX56YoWg6X8aQjo45jAZ/shekAS/rhY4FN4I3xXNMB7grb9149AJQv+bdZUz6ws
         FArt9Hpd4trDLvDlqzfh7qzxEJhXOOxHq32jR3Ke/cGxMbZ1xwlN9I6NQus2CU2Ock2L
         m6IDo8tcuOAvkwCGBndnwtjfribjils9RLEfS3Jux7ISt8dSWml+GGY/H7ntYH+o0N4j
         +mNjfnIeZ9fgHY08IvGzWbHW0rIJ4xKCWdUb/xE+PTjBZGUqIFzt8jLZcm/ICkSRvjle
         RYRCSZAxTuln1RqhmE8buEUi/vuyvBjAsleFBrmp0F1N6SUsScuFXYlTzoTdV/6uiZ9B
         qEFw==
X-Gm-Message-State: AFq9FYLskMGC+2KtVLBsTJsBxlwRZkbDN7KTbWYPitvF87XzVjR4UVMI
	K3+wxnVXta0s2uRwzEqsBzCbfIGTSr+7gwZgD0I+pTMbFX5CQCSYpj6m4qX5ZLVm
X-Gm-Gg: AYBFou18M5t6PVPHJI5iUOtAjr70U7TqeKuS11poLOg5qd3/U5jPPeKGLV3e7pQA0AH
	GjGg4DVMAFyzJU+QySe/tEsR5Jqziqrf7CnCq8LGoxNbVLuH0OD+u85PHG16spC/iO+w+I2Mr7S
	VZC9o/scRU9AJjqjlS2GgAFodFqDIBxWpINShd5GUk8pkKnlucZZgIxqQwXbA6M+dFsLf7h7XQP
	wGV9QjhGH41u5yvGXSzbfpmBCgxuDvaZXqVOIRedvNVShZ/igCDLantLHxnJRXfu+EZY+P+pJQQ
	jWCh2Ruyyfwp4e3tdoNqN4pkxLx3n7ZR0Y85RucdwUG4GYbjlTCUsXO92vGQzN5rb0oFK8VJSN0
	D426grcquMHQWbQ7PFMeSCa7CYe9KOAz6hthKou1WrLNgRFae+FsvN5Hn8+FpLhnia0QjtVH8sA
	OPgSdPWzblzqEWEkgj83f7JZY3Wmw4MOYwlAebNGQBZ5/6Vl1PV8ldlp9hvXePm1rc/kvtvsYJ0
	PwaZlUPnVAPKt/AGeCU9MzI4uuY3Oi/YsIQWZsjhwCbzpXy/BCbtq5HTvPZ
X-Received: by 2002:a05:620a:4403:b0:93e:5312:3c96 with SMTP id af79cd13be357-93f57f052c4mr853958485a.26.1792652188829;
        Wed, 21 Oct 2026 23:56:28 -0700 (PDT)
Received: from [127.0.0.1] ([4.227.173.122])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f56e1fd35sm446382385a.37.2026.10.21.23.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 23:56:28 -0700 (PDT)
Message-Id: <38214d9abf62fa4f8d179ce15e633aa1157ae3e3.1792652185.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2456.v3.git.git.1792652185.gitgitgadget@gmail.com>
References: <pull.2456.git.git.1792437558.gitgitgadget@gmail.com>
	<pull.2456.v3.git.git.1792652185.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 22 Oct 2026 06:56:23 +0000
Subject: [PATCH v3 2/4] imap-send: accept messages with Subject before Date
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
index fa326c4ae2..ce2321d42e 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1456,6 +1456,21 @@ static void wrap_in_html(struct strbuf *msg)
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
@@ -1471,14 +1486,7 @@ static int count_messages(struct strbuf *all_msgs)
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

