Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792437563;
	b=iKWUGCnQgt7cDyhEk5Sxc81c0pHl2nSjJSqDwnz5GjINEoPxxtASz8/JkDCy26Ae43zM
	 Jx8dYK7vDYN495hVrd4STkP6jDlOYoCpjvKDd80DIlUyG3NrjzD7s2CZN/aFtkjMq3ZVV
	 Xa2zPtvOxNsFrG8yTQjHWS+0zQtKek1h6mnPgur0IFfu5LkKBJk9DE4ezEpCTkWx60yyp
	 30uiauIjcvHFwZxT2b/NkqfzDVYXFNpT1u3yixUy1UhU77d+aD+FfGQKpWrLO6oj5cbBa
	 ICyucnPizIUEJfzhq/XTQingbYJ4tTGcepKiKWQaCMUveH45cQzZxhT2NMK/G0r4bGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792437563;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=UxxBfuXY6wGz9DZdm6JHGf101sIxwmuwgP7VUC8jiGI=;
	b=Ubipf2VEzohTnknRRLsIvgE09pOxbUKlO1Sz8z6h+kDwDgXgHdJgaNPaoGRSPIdztPwZ
	 wjHVaFqEVIUqKpO74u+XAD0WiJBfvXiA+qxpPssVOkDI1eVRth7/eGl6xkMQhq6071Ucc
	 uluriHD1UAeeMQxD9zRWC9jA8lovZF6DJHT8ezNhkBGy3L942kDFu2b6Z66pPD2fedctH
	 vBE+oaM1fILpKN9Je4b20KI1sm9G9XLVmGR1Z2NzCs37hlpZIZjHKMDAhy1ZyZqHx34nQ
	 +Xhrjdy1onUxVYuT+aiMy1AkFEVpGE3bzLd1oDTe0TQg2meCtcoRusMpOQvaxj9lBOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LCR4N0hy;
	arc=none smtp.remote-ip=209.85.222.171
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82ED606A33F
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 19:19:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D82ED606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LCR4N0hy
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-93f20b304c0so238759185a.3
        for <git@vger.kernel.org>; Mon, 19 Oct 2026 12:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792437562; x=1793042362; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UxxBfuXY6wGz9DZdm6JHGf101sIxwmuwgP7VUC8jiGI=;
        b=LCR4N0hya5THcCWXKD2YQbe+K8BkwaLPr9dVOydd7jZszxSSRDFSEjDm7Waj0Y0NrG
         EXusG4VbVNOsxhobLnl2vF0kWWix1Xw/Ck3VLRr/zGA3SUAes9Mgzu8TH9euMXPQqiMQ
         I+x7o7K2XxG1yjtJiuVXU9LKjqgDXMAKZDyWtfPoPYZqUELHJzRp3HGI2A6sNue0Xu14
         Pl3NMBWLwfTIWV0zOlptcpFORYIXrx7aDWGknqf2nlkYJtPGQSMjE0Ec/LL9hYYmIprB
         kgPkJ/izhMMrLrlSqOMfJjnclh1Xrb+vSXJGGlk8snAetvvmUG9cddXi+h9q+JxRmUMD
         ltAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792437562; x=1793042362;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UxxBfuXY6wGz9DZdm6JHGf101sIxwmuwgP7VUC8jiGI=;
        b=ycAtrWyJyTx7LmYr6JCbT3hGcxhJ+zXlz1iBYC3kmGVoNtFkajrSBsARlqnGMl553V
         1OVDk1BSL04tFZ1Nga7PhJCR5MxII7TqwftForTAUuMyqb4CmV/hJC08LjuZsCvxRxZH
         WTS9S6Pe1QbUCyOo5EARLCaUh7lkGqDUh9zrGnC/4yOBRz0Pgm7ngR+RPf7IEh9oNR3G
         KDkpBCHfU81Jb4fMG1xLo7d5PVguC5IWQl7k5BEsn9PIYpYZVgdJIMAADt2HpbHdyrJ6
         VsRlljD6CuMWGf684/7AeYXzusQzoIjqhQ8u+WfOzaGFedXqc7Cj2pgbBVvUl1eULf3v
         oShQ==
X-Gm-Message-State: AFq9FYJftAryyeiPpCB0pfV5eVSblnPcvWNY9haRjdQ0bs+eECijq/Zd
	ub36aQQkjD1p9S7NpjNO0I9qtGfNrFgQu7rlxn5ogExmrNrKTFEdc3qJLBfUog==
X-Gm-Gg: AYBFou3535QP/niZQR/2WDOLhgJrfivN1Qq//XYdVkwA52i0HDK2PAJQj0jJDo3BiuT
	sPq6P6R/yDZ4m/nPa/ZXZUjUTmJ5i+uchgS5DekiiHv7X0f27Fq1EiSkm/dBE7Zs/M1rNoWt3fR
	38QOOuMVweMSXSPe/6FX7r8Er5cJ7NCsp77AGZJpmaUD/SADg99SbWnoorLvgqVGK5DJ4zAycmV
	uY8eLW3nLTq+nmvIcQuGpepGG/ta9mgiVhFF+Ln9i8nVgsc9DWswjtvjNa01PBR8CLypD6McFTU
	WYsomAiuJ7d48V+8DB4mYs1NClt9eTBznmwA73PUUwuuqctEpOQJVsS72rgyw5TEd1CciMxZx2U
	6AaTWkfAZ8zsDHWxT7mFwGOXrgh32nPfbcMlspk3JmSB33FR0fRUrE4/LP9rlH/LPb/2lq5bcEY
	N2FN2rRPWAobhEfEhQ4vT4EiuCHvBoJgJ4XsrhXL2g4OEEhm93Bd1xMFFY6Zg132aPpq4a/nA+T
	oICAVGrDK4E
X-Received: by 2002:a05:620a:440e:b0:93a:2239:4ac1 with SMTP id af79cd13be357-93f29cfcc5emr1430398385a.32.1792437561692;
        Mon, 19 Oct 2026 12:19:21 -0700 (PDT)
Received: from [127.0.0.1] ([20.115.103.84])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f4b081a5bsm34985685a.17.2026.10.19.12.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 12:19:21 -0700 (PDT)
Message-Id: <94129fb718c0fd961df78550f6633752d474f825.1792437558.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2456.git.git.1792437558.gitgitgadget@gmail.com>
References: <pull.2456.git.git.1792437558.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 19 Oct 2026 19:19:18 +0000
Subject: [PATCH 2/2] imap-send: accept messages with Subject before Date
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Patches sent with git send-email cannot be fed back into git imap-send
after fetching them from the mailing list archive, for example with

    b4 mbox --single-message -o - <url> | git imap-send

which fails with "no messages found to send". imap-send only counts a
message when its From, Date and Subject headers come in that order,
and git send-email writes Subject before Date.

Accept the three headers in any order within the header block of each
message. The copy that git send-email --imap-sent-folder pipes to
imap-send then passes the same check, so the special case added for it
in 04133f5bc4 (send-email: add ability to send a copy of sent emails to
an IMAP folder, 2025-08-12) is no longer needed.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 imap-send.c           | 37 +++++++++++++++++--------------------
 t/t9001-send-email.sh | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 20 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 6f76bade35..6563c8f693 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1453,32 +1453,29 @@ static void wrap_in_html(struct strbuf *msg)
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
 	char *p = all_msgs->buf;
 
 	while (1) {
-		if (starts_with(p, "From ")) {
-			if (starts_with(p, "From git-send-email")) {
-				p = strstr(p+5, "\nFrom: ");
-				if (!p) break;
-				p += 7;
-				p = strstr(p, "\nTo: ");
-				if (!p) break;
-				p += 5;
-				count++;
-			} else {
-				p = strstr(p+5, "\nFrom: ");
-				if (!p) break;
-				p = strstr(p+7, "\nDate: ");
-				if (!p) break;
-				p = strstr(p+7, "\nSubject: ");
-				if (!p) break;
-				p += 10;
-				count++;
-			}
-		}
+		if (starts_with(p, "From ") && has_required_headers(p))
+			count++;
 		p = strstr(p+5, "\nFrom ");
 		if (!p)
 			break;
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index d1393ef197..1f77c14315 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -2863,4 +2863,39 @@ test_expect_success $PREREQ '--compose handles to headers' '
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
+test_expect_success $PREREQ '--imap-sent-folder stores a copy of the sent patch' '
+	test_config imap.tunnel ./fake-imap-server &&
+	clean_fake_sendmail &&
+	git send-email \
+		--from="Example <from@example.com>" \
+		--to=nobody@example.com \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		--imap-sent-folder=Sent \
+		HEAD^ 2>err &&
+	test_grep "^Sending 1 message to Sent folder" err &&
+	test_grep "(1/1) done" err
+'
+
 test_done
-- 
gitgitgadget
