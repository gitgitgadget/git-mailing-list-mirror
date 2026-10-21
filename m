Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792566480;
	b=zwcjm5WD4XwL0bklBrMSJrljUxk3J5yLoawVU+ewo+7Uq2io1Bkn91Gt6Nh6y/5ZU7Hv
	 W5NT0ygR9brR6pBg0FuJmXSy95ClMaDesxe0RP3RPDin32Y6obJahLQUl62n6v2vJmyV+
	 cLDpQxP1GIwRjSu4JvfQ5eX/tCqGNn+FrekcNLpEfQFKP/pZP1i7rzxfC25dEb0qcvhaD
	 KasjNzMO42LMmslL6DrBngoUebbrTPDXZwTUeHBoRgium2XYouDM5YbC4BgoWAVEvuHK8
	 KBQAghwdaHosfcrfA6m/+YzMduEEc8DYuiq9OidH/YOEb0NcgL0WjoTBVLO4IAIGHLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792566480;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=+cHqsy1wEnSSj+/Yiexo4ywQzOoCeRs8fjzpYZfHryw=;
	b=uOKRQotJUwotrGkwuJcKdwYLxzWZ27dPoG2t4UhcNKgg3zZqBciUwJHYJg0ZCAy03f2L
	 nBv51wNJ2h7dS+SU1/Da1+nxyhn0u0/oZEALl+/XLY7dkOloZgH7c6hAT3+UQdzbUlLIg
	 UQG2KcXm3clKoJvsiPiP7ngFQX46UXi4ilbeR6MOJ0PXxYWeOVhy8k2vNIDi4Z0/kL2GL
	 rQRMlUF2aUJjFkHud8p+pL9qKUPs6oqIHWAmcvA/6FBYsGvxG4h3/i70LEvUDWnoO7t28
	 IhbLzKye0BwRvdmBhobL/TnmEFkGk/99TI6kFle0KJQ/vPRjQnkI11gv4q4+wIpIQww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Vc+OySqC;
	arc=none smtp.remote-ip=209.85.161.50
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC225606A31A
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 07:07:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC225606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Vc+OySqC
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-703be215729so121076eaf.1
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 00:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792566479; x=1793171279; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+cHqsy1wEnSSj+/Yiexo4ywQzOoCeRs8fjzpYZfHryw=;
        b=Vc+OySqCaHxWsnPpTVzlcQm4A/coRx02M5skyc4aBMozchjo25W7FK4D7YWgZwf7oa
         DkJc3Y6kl/vwS2WPrPhWp4pByZzJt/5wCtmZ0Qo3sarxcFvskQSzg0vxwfXtKnJH8sbH
         +ta49+8CT62ep8eaIQjFeY7ar2aNSw6h4J3tw/OU3IUHtuJXXjexTOnamgqcATJnsGxV
         SJJbK/OlmkyY8Gii1DN1TKvyKexIt/5doB010YlAmquVHjfaZiE70wgHfoxOmAaVtHXC
         7kFHFwMjb4ZgeNXh1HTZ3nNX0Sbf9lyxioshrpfLVu2cUVs2t6OKCQJwm4kPZt47tgb4
         Soqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792566479; x=1793171279;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+cHqsy1wEnSSj+/Yiexo4ywQzOoCeRs8fjzpYZfHryw=;
        b=u6gGDlsBUr4ot/o5TUBEEbcxbZgOMT8k01IJ419moMmm2c57grHBWPKkBbFObbtyg6
         GwSTEAXp5P0hv0nEHFVC+o2yGCdQW7il9Ervt7AJOChOxjfQuvpH5PmMEsTLAcF9vyZB
         rcOWmjea1AmJSwjcW2Qk0mRpPQJfNn38MjwUHmsdzIZgp190Ycs+xPvGoyGyA2mFajEx
         R7pt7RJV5LuaS7jyxj02edYVIeWpnpzrSdqOT9PjIWlyhAsL02GaRezge+4AxlgEHzDL
         rsln/EhVN2qAqVSvt9IhOHEMaYrFZdef+l+UIymP1Io5wWHlEsDHr6p/2kwyLN/OSZrJ
         HrYA==
X-Gm-Message-State: AFq9FYLS0RUDyFEEK8ucdCaHvtu+n7gvIKH4yresAo4vWRmlHDKbo/KB
	Uvu/ddOK1ZHDU5CogACYvu14UYWG/Qdt07lC649tNWqDYxQS3WegnDVMcmnDbw==
X-Gm-Gg: AYBFou1PhWSrrvVFp/mHR95vzr6fj5rjq6AD6Nqr1g8WyP/mbOFiAy0TQ/hVAq+sJ4X
	j5naqKmofafukCSqyMsY93aOGXu1m10SaXchBpuPkyVFQyyLWbINjhSb9vbdjTnD+xLXMYlre6d
	Bu9yJtcs0c95kNIxbo8qSKep4V8KqY816oPVGMtgqwFwiZdSZU/RIWzNOw+QC1pnEZBbKtK1vwu
	T5QT1Db8F+egQgdCMzXra1LXNjm33BRgQsq1kF00CKpGW/DfV41Ocy2RuuzzCa6wTBaWgbKsuF0
	cZGASombIk4CWdCu2UkqI6snJXbqec2gFYStfSGJrDPwQMnOaeSXZgJSUglCzcQ9dCEwvXZyBpo
	BIutgXrGOCVIRywz6EFbEaJPovNQmHsE3KRkAurtcdGOHYVdXqFf0guLb12GcenqrTtLyacMVnH
	GUt51lXjM88REBoAKATYxg+Y7dnbz1jZwMaI0TyhxcI1W+poOcmoUfV2Ys8PBtrVhLGlfUPMOtM
	oLGQ2ZqiQwSgDT0O7i/LVmtYg0yp+Bvbbu3HlHN+7gE34LqIi4jaoC5O1IL
X-Received: by 2002:a05:6820:201b:b0:700:5251:43f3 with SMTP id 006d021491bc7-70942a735fcmr646578eaf.78.1792566478628;
        Wed, 21 Oct 2026 00:07:58 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.200.81])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a7d616e848sm1440434fac.7.2026.10.21.00.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 00:07:56 -0700 (PDT)
Message-Id: <c42827a1225e49db2e0855638e4e76a06f7d9eba.1792566469.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2456.v2.git.git.1792566469.gitgitgadget@gmail.com>
References: <pull.2456.git.git.1792437558.gitgitgadget@gmail.com>
	<pull.2456.v2.git.git.1792566469.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 21 Oct 2026 07:07:49 +0000
Subject: [PATCH v2 2/2] imap-send: accept messages with Subject before Date
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
message, and match their names case insensitively as RFC 5322
specifies. The copy that git send-email --imap-sent-folder pipes to
imap-send then passes the same check, so the special case added for it
in 04133f5bc4 (send-email: add ability to send a copy of sent emails to
an IMAP folder, 2025-08-12) is no longer needed.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 imap-send.c           | 37 +++++++++++++++++--------------------
 t/t9001-send-email.sh | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 20 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 6f76bade35..7ae2eeddc9 100644
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
+		if (istarts_with(line, "From: "))
+			from = true;
+		else if (istarts_with(line, "Date: "))
+			date = true;
+		else if (istarts_with(line, "Subject: "))
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
