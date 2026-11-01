Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793521304;
	b=Y2j/Rl/xrhHDSAc6Tue9pfVenZH06t599eTHwiRYSAyASD93s88AMrkvNAl8Z6nbcnwJ
	 xxzyWvo6TL6F91NmIIhZK2yKw11VhQ6+3PzFG1QJGbDEr+aoxIrHi9bjusO1Nr80T/hJk
	 D7T1JgvBS4jeg+/8l0F+FiLY6lhH3II3nrprJLHv5jswkqsp/JmSqt71sBSjPXyPFMT5Q
	 Z/+NULjX/ieo709S85a7dKtrG6JNA3q/dr8thgvl1ozQED6FFh8bfyBu8x8GDXjbyN/c4
	 4w7GWhTPTqLlNMAIyoNaarjhW34KgAuHNsJs1Sb6zDVY83U60CUA9Lb/2XtXNeB8s6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793521304;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=7IYAgBG0B81gCaYWeW65eZtsRarOYC12k4yQ36vQdP4=;
	b=s5nFG1EvyH4ca8bcn/f4+W/AIzURrlhfxkP6lGz9re1N+Ls1Kbje8dljBQuyVIuhq0/k
	 mBVSbRTHCVLbKmabILNrda9DV1ZPqFyjQww+Xs0M9K/LswPsDIHU4SQ4HUq7MnKVLbgip
	 K/VGuJ7ZPGHcBBX27tZD5YheCZU/wgAZR2xM6L1dfK0MuqxgFS9+S/P5kP6IgZBLtV5bt
	 uJk5SpQgiHlqEu2eReIcDl3O81vkeEQBeOvpZSMXoGiVhYHQGGeak976itwvz5MdDcAqA
	 kULhpIKD8NXKNmsHwaHqJQzFqxzJkwt9YINXC2IHe5HHz3ZsE1qVksKvql/1CcENpbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mxEzA6dA;
	arc=none smtp.remote-ip=209.85.160.171
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C16F606A332
	for <git@vger.kernel.org>; Sun,  1 Nov 2026 08:21:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C16F606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mxEzA6dA
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5363316fa0cso27482911cf.3
        for <git@vger.kernel.org>; Sun, 01 Nov 2026 01:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793521303; x=1794126103; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7IYAgBG0B81gCaYWeW65eZtsRarOYC12k4yQ36vQdP4=;
        b=mxEzA6dAGPlwkJ5akMkF9/Fdqj7Jl1Z7XAf4AN+TI9b7MYLOGL2+H2syKVlJattxYi
         1dny/4fmYhhWFKO1Urb5EMHSwoxAUkiQZPcJ1r7uxHxSI5f2WvUoJphgd38g/AQdJqfv
         tW1AOx4uYa58cy2ICv/4m5hZl2QhLjVNHYN2QcWvISu8WqFS7MAKYA4D6RF/OpvLkrsh
         tSc+W4qffNs/J1/JZ3nYSQlxvvnC42xxhWJ0r9q2Exe5h1B3YZa8K8+HJ+/pxshqPDcI
         LAuWS3b5rtR1c8o5mgoh7A6kckXkyVUTU5A0mfGgdNbqxfIySm0F6MxUDDxM+ekT4HLs
         YwMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793521303; x=1794126103;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7IYAgBG0B81gCaYWeW65eZtsRarOYC12k4yQ36vQdP4=;
        b=p8AL+EZIdSZFn/d9gpTfsAkbbX/5yatsmIRpluLySRTM7Kv546Re2pyXBTbNe/Y2TF
         +WPO+B1LhFX1KH1/gSdh/SEi2wPTW/VTqOQmjfCTK3cet8hxiA0L/jbOSlzjhjSGfmny
         /cAV2MrNjH6dE+SoHHKSGiRLTCCsa1bUJ6HK60Rp+sEzART2EjLmjcePZaVAfG8DouN1
         IVxNc39q9S4mLhS6oDyXb5tpq/XIJ7KMAhZ21jbtgovzXZKGd8mvsWCqFN7TckYkU7rO
         nohA5JNjvNpFGdPsGlEl0+FKNqgyIeyJSShplwQMrNtggY5WuXk+krO1z/BD2HGxjqJg
         yQOQ==
X-Gm-Message-State: AFq9FYKd+nY+iCDDhu6S9LBgJpFA3ZpRTuAOKjzKkZNl3ho1D6eTcwnz
	IEgwIEP0IRLKzWJoMmmZu0zkMVjsq1Vcw+8F31+fkF3ZLG1VHCTN+k40f+eo32C08ic=
X-Gm-Gg: AYBFou3+5iEjcJDY6ajmzk3zCeceZLWI1M8h1XqxE1r+USEfmNnzvgzW8ImJIjUACi/
	RHJTugDVrI89lMazuoVJmXmfljasXhlg4phf0YAVc9qWSata8XGVOlSzab96e0JE35hEyL/NaQI
	bmyPnIy2ztBhXwxyGyzD+Qs/UTnmm264U0UZcYxCTzUu0782LJhSpdBoiFz6advkVObegDYlpDT
	RbwQEjWkJJhYf3tpKrtnLN0Y+Kv2RHsCuzFdKhLbuDQp/LqrGm9Otle57si4wzl0wNp/llGRV2m
	OaSkOTXMICmqr1diKT2mKfT8m5nFtUD62RVMXfUHVYYzrsJZnmFzWhCnAMo4kfh+YnfXf5ojBPK
	T5p5Dv9rGsHLnWjX/0ee1sGqKbIr7bJB9jacw7Ap6AsUPupn2aoY+ugM6+VNoAQ44B4bnpUXwQO
	TAn+tG8HJ5dXZ5n1yBvv7Q0MkljgwwII8vbpNxLV8dXZJuvLfhwoSwymw+PnPN6UByMPSIMPUN6
	amb0gDLGZDINMVvIZ54x3o4HZyao61Zb8+f7/N9ppppRkUHuePhq+VjcCFZSJ4CLKkDGgtdCY22
	bdssPz317MP/9525fr7SqYjjD/4VqNA=
X-Received: by 2002:a05:622a:1dc9:b0:536:55d2:c41e with SMTP id d75a77b69052e-542b723b183mr109569161cf.40.1793521303197;
        Sun, 01 Nov 2026 01:21:43 -0700 (PDT)
Received: from [127.0.0.1] ([20.119.79.64])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca7f254acsm61702636d6.11.2026.11.01.01.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 01:21:42 -0700 (PDT)
Message-Id: <86461854867919ba4acd684ce360040fe6c9ddeb.1793521297.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2456.v5.git.git.1793521297.gitgitgadget@gmail.com>
References: <pull.2456.git.git.1792437558.gitgitgadget@gmail.com>
	<pull.2456.v5.git.git.1793521297.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 01 Nov 2026 08:21:36 +0000
Subject: [PATCH v5 3/4] imap-send: check git send-email copies like other
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
index 391bd8b96a..d7172078c3 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1479,19 +1479,8 @@ static int count_messages(struct strbuf *all_msgs)
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
index 4611e6d4a6..5e03b350c1 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -2901,4 +2901,17 @@ test_expect_success $PREREQ 'imap-send ignores headers in the body of a CRLF mbo
 	test_grep "no messages found to send" err
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

