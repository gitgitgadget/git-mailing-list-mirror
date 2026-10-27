Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793089886;
	b=OICMwUTe+MglCmWNMU0IqrcN7iztdF+kXHqxNA7CWCEtUb7Q1w3Ru4xiFNDj7n/w2bYO
	 xwY80npHjlS2k9WX23VeHmOsf5cffWTpheX2+3qarl4e8dyjAJLrjWvZE6fOeMfvU2Ivi
	 Wlr5wvNur9iXb6EGtAOnGZNVJGvPZVrMbbeptahvh7jq77e2fuUI2qL0TVfNSgONek3Bt
	 UID4LIZ8DuU5BxXPBpcewcASgpB73Avui8JolkjVgHsfg5ELQ4R1QKnz47kUCylwvt5h+
	 cSveKHjo6MsndNk18tJTa1RKluFYwvYNqz8u1sHjUkw0obne0mcIzZqAeYi9U0Be24g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793089886;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=DsoHakK29hVVvmPVD1+S+deia8pkwE60m1oQXeXthJc=;
	b=GtyrSeltdGeyoGCANapCOZzHR7MG9LluCLSmif/0Sxve1431XOFDWCn+rwgR1dTi/MDU
	 5tWO36m1SQk0K8R4dbY8QRh+DzLIQ0UlZTIbOsiMoX17oZzVGI4Z5yitXGmjhHSQNV4l2
	 rIkAtRBPhaYfl7MFarA1oFDKdTrRZhhl682s/nL9UEZlUKOIgQsTsAlNP1DD6JKXWZLnq
	 VOOIyeS3smHcu+yw3zza2MI8stYWK7OoN7b/wgTeX6bcEbcbgpag79fjfURMNTLH3YWUg
	 M085S0LpgOm66NJITVJeRzpmN3eQ6u6k/mbz2MTQn1bjuj3QArkr6Hzx1lOlnZ+Z3+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="URhaqs/B";
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C338606A321
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 08:31:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C338606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=URhaqs/B
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-36a0f27c9f4so1273831eec.1
        for <git@vger.kernel.org>; Tue, 27 Oct 2026 01:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793089885; x=1793694685; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DsoHakK29hVVvmPVD1+S+deia8pkwE60m1oQXeXthJc=;
        b=URhaqs/BgOST8Hzk/TdyPezDgAh57TCD3xjWOFiZrIBfIkfmjTPiXPBGY1MFDnu88P
         dNvQVmw0pOo7yk0mPwJYkCkSLDQKz5krzkcXCCXKn/KFHNl7DfxbmgrAKmD7sAdiWjuq
         oItynr11B8jHR9umXhKRvGr+odmfQSmo/UbCEGRMJZifmBpF82cQfKvf64B7VIMK11bM
         fiQRhWHD6rgMDOSDzMr8fOB2MAvshpX2e8HArnVu4LlmG/KB8n0jbdBc5HyT1Y5RJUhq
         A2jW5CKiOdrlLnDTna9muMXYx4dJ0OLzojS2NXHoVlPYnsIrBRu1qKs0qqE2vZlx4K/T
         xmNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793089885; x=1793694685;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DsoHakK29hVVvmPVD1+S+deia8pkwE60m1oQXeXthJc=;
        b=kQ5jE6zz0ROxRpzWj03hrv46HBWXBD52wrfmB9OSB7oV83AMipvTTevkGPfl0zo2TY
         WKKduZBEcn4z3xAf0ywkbN/qar7azHHPKbWXoJjIFOoJK2ooDFmtx18PHYlL1MhYCwsW
         T2Mh71HQzfqriQl9nZ6VBcljLQGyfpVRnNTN9y/1TnnN4Gj3gJ0zZm2axGDfFRRbrw9V
         gaLWkHtNFK7XL7A+zTvA9x/QawzQIaIUH/JGYYps4LCpaGH/kU7pniQm38vtCm5bCEDb
         ha15VZ6SyQDFnBipOQt72JzsSLf2BbQmRL7au0LfIGT89FQW+2dbO1xBmy4eLWCL4NEa
         Q4Ow==
X-Gm-Message-State: AFq9FYLa4RH54fVa09yfM1wryCTEUTC/zr6JuRSfW9QTf21wZT3QveZP
	J0g6dud1uvCGAtZ/cbd30ubFgHNWCxTvXitDxd5JJ+oB2x/E0O/O04cXmwLQ0xVm
X-Gm-Gg: AYBFou01/ymwFfTycgP33MMVAViD1r52Vdq0Dgcc6zPpvznFkWwyd8u4y33JYi7HdLH
	YdZrWaLP2bNTMjRo26eykGSjc/LBiWU1GoIFTpgXQxf0rVN3i1ZwvHwbPbKuH02jWCZ0eRVXkNh
	tAYGeFRBh+FkSoNte7Qixdah5xYOW6Ap5A4Twfumn4hqlxaoGhaBujXc5CsE4ACK65axPWRNdW6
	fnP58uMxT0jg6ZFYzKlDLDteViOw4MYbY4EJpCCB/GlWoGKGyg2cJEEyINMBWoRa86dQd+z6/L/
	HFaI+EeDG+VJHiNyi36AFPFqYHuqcNv/PL8oj+ceJGy5ToSUf2ToCJgVj5rL3yzWl1JCjEZF6lr
	CrTWao+544yrA1dhicgb7aoKn1v0FwCN/L2ov3oRkt9qDAkeF8KycG0pAXBNv+rVTrDzLQsa6uh
	e2r4S2/NkUmx6nluR7unkzGkMVsL34AN7WghrvR3EggbB39oMKBj1DK65pdqIydIbSvY0ABQvCv
	YS8ylaOjFBL16fw/boM5kqx6KN21Qgo5dB7KtAv/FOJcQfwgqJT7CNm5Fk=
X-Received: by 2002:a05:693c:41cb:10b0:36a:279:c93f with SMTP id 5a478bee46e88-36a0279cf79mr6577703eec.33.1793089885182;
        Tue, 27 Oct 2026 01:31:25 -0700 (PDT)
Received: from [127.0.0.1] ([20.169.77.163])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8d93663sm36846473eec.13.2026.10.27.01.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 01:31:24 -0700 (PDT)
Message-Id: <919e38c31d83d3cb01aae49e59112868ea9a1fed.1793089879.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2456.v4.git.git.1793089879.gitgitgadget@gmail.com>
References: <pull.2456.git.git.1792437558.gitgitgadget@gmail.com>
	<pull.2456.v4.git.git.1793089879.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 27 Oct 2026 08:31:18 +0000
Subject: [PATCH v4 3/4] imap-send: check git send-email copies like other
 messages
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

The copy that git send-email --imap-sent-folder pipes to imap-send
starts with a "From git-send-email" line. 04133f5bc4 (send-email: add
ability to send a copy of sent emails to an IMAP folder, 2025-08-12)
made imap-send count such a message when it has From and To headers,
without looking for Date and Subject. Without that special case the
copy would not be counted at all, because git send-email writes
Subject before Date.

Now that the headers are accepted in any order, the special case is no
longer needed. The copy carries the same headers git send-email sends
over SMTP, which always include From, Subject and Date, so it passes
the check for other messages. A To header is no longer required, the
same as for any other message.

This makes the check stricter when some other script writes an mbox
with a "From git-send-email" line. RFC 5322 requires a Date header but
only recommends Subject, so a valid message from such a script may
lack a Subject and would no longer be counted. imap-send has always
required a Subject under any other "From " line, though, and only
refuses an mbox when none of its messages are counted, so treating
these copies like the rest should not affect anyone in practice.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 imap-send.c           | 15 ++-------------
 t/t9001-send-email.sh | 13 +++++++++++++
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 8977a934f8..706c517e51 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1478,19 +1478,8 @@ static int count_messages(struct strbuf *all_msgs)
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
-			} else if (has_required_headers(p)) {
-				count++;
-			}
-		}
+		if (starts_with(p, "From ") && has_required_headers(p))
+			count++;
 		p = strstr(p+5, "\nFrom ");
 		if (!p)
 			break;
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index d105fcb41c..1f77c14315 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -2885,4 +2885,17 @@ test_expect_success $PREREQ 'imap-send accepts a sent patch from the list archiv
 	test_grep "(1/1) done" err
 '
 
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

