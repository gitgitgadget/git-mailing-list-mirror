Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793521303;
	b=v5EMcTQB/S9oql3wqTZ1qyopWuFe+yqpi3o/aYuOaKyycNNFKvm/FTnZdv1u+mIK0WQp
	 xhujjvxaVwPBL8k+NMrfu8ZAk+w7zGaWm5yjkHg0//losWHOJqmFruyuSRSK3r4qm/xJK
	 wWFCCJkEQpBcQRo77x9e0lMZEHAdBAUbLdwlfrgksOo73zwubkS7pXOID1a74IvHnOYGZ
	 39LCq8Sxm2KUZM3XE5zrmz/3btXzlXLzLq7z/knHmRGAyKRnpCuCfXK8x4gurMrNiByFI
	 fH2jCGTIAa7Bslzig4/fn74KIsWkOs/6JAbXvu8a8DpGjlzQUogA6WwS2g9m/PEw5mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793521303;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=vDDOPHtG4qbmV4ha0GoG534v9zMp8A9WMn5dk+9bB1c=;
	b=2rCkTnz1XtlKALmw+tAjYNwoGjQFgBKlH5VNcH18nsybmLxs2hWJn3Ongq4LXRf5AG2j
	 jnIMSZopKgiZy90WhKAQpMK/cHx0vba7cZI1iU1DwgpjkL8fKJXEKZ8uX4XHlhjfEvQne
	 IeKLX50L+tg14wYUrH7Qddo33do6TF8O/ZAYJjOWZs1ZWMv3rRk0FUNBMvMq/MFDYN4Id
	 7QM8jIVIBD+s0HQUARV/rna4o4rrKB62fJ8rKotiKHn5wr8VzKixSqlVFwhospns7nl0a
	 V5IUUJ5R/J/bPMfr7Z5C282mkGN0qUoniQ/FmUBBIGSv72j/eichdfbPK3Y9yeiDsYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BRKE+V5p;
	arc=none smtp.remote-ip=209.85.219.48
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54217606A32D
	for <git@vger.kernel.org>; Sun,  1 Nov 2026 08:21:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54217606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BRKE+V5p
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-91c11468b5fso22591246d6.0
        for <git@vger.kernel.org>; Sun, 01 Nov 2026 01:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793521302; x=1794126102; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vDDOPHtG4qbmV4ha0GoG534v9zMp8A9WMn5dk+9bB1c=;
        b=BRKE+V5p4JlWbXEqCHW2MV+9uPNtIgl4tG7E0QO/TNHXvPuvATHfVIQkjz+gR0KgIr
         qjEGsxlkvMyPFhLu6boNZJksaIpdv5JyUdgKCBM+ecMtxeZbC07qIWA11RouTMT2Yq1+
         ACpwqyDPp54L88au5b/7kKUCJ5C0ItrDqw27q9HCbNHB0GazgIwujtdapPOvsqATQ7eW
         8C+8YdpHrgT0Eygf9T9IepAsEsjPMFP4XFgDEByCC52Gi3BMN1JOQULoKyDadm8yYObf
         7x+PWkKxLkPzhPe0AcyDxqzTvsEW9LlVlFMy3uI3+y9NiGoBNlJ9szvyxkwFU3OFpsWt
         oaEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793521302; x=1794126102;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vDDOPHtG4qbmV4ha0GoG534v9zMp8A9WMn5dk+9bB1c=;
        b=02Y8luhttGQMfOu1QXdvoMG8RPNzUC3kyVdYdpy9ceZXOltp+v8/AG7gKCnnmL3V9t
         xDxYx/go/K1Qd5871RcbMO3hvW1X/PLKI7dYLeYeQhE8gNmlouJoNAPscdVoO2tjIqyX
         TevrSirIcoHLi7+URtlyUeVcyNcHu8v3mMFdZ+m0kcP+W01t+1EkNGl9THRbsmmNZDdr
         Lu3Ya/pEAdTigBK3v/VI5YnnGakKmG4boQzuqY8zcM0fUUPyX4nJY3UzidfgteEtqONa
         8UFM7WzjGsTNRUHOGuzMWFTVv0b5uYT5wyIS6XEFPO0ZwJOcvu/0RZtdIC9Nwv0iSN9c
         eYHQ==
X-Gm-Message-State: AFq9FYL+4gtSp0zApm5ADzBKjQIwUa6udUC6eJqyIy0ekEM4MYfQNukM
	vhJrKa+pG7DoXzUEYpfDabgTXSQengAG1D3kqucPhndndt73/RjUojBBwSNm+oXFwlM=
X-Gm-Gg: AYBFou1JXqWs1xe7ArK2VMjP5EvPiz9cLoPG4Q+VSxSxpxiGzCWHCP0Q4v5U40i4f9f
	xJwaH0iVO9R/GSQRa+DZbpUDB0G6aEuFSKNq0ZoXTWrXoOBIlqHX7jM4cAyITJgvcR4nQFcoCd5
	U5gOFk6fJDicuwUT+6mDKQb0ny07Txos2R+eOOn+Iv5hV3XdAUWfYcZUhWxKvPjs5kPeAGDk6t9
	qZzAH/4yda+6Z0K3v3mlLlrM0SBu3Eponc+UGLjqsZJ68Y3ywk03b51fzL5mFkNz+fUuB0zqmjX
	3vBGYxvjkaSUtA/zSpgmcgJiydouze3jt5XGkS9uXVBn2xUZeIwh3TdAqvVynhf6iKkqFymKTeI
	vl3enqCFGwavE6EwNm78KpL+3Y3pzGzcfyORJ51qqcxKJG+OCC6AUBg0EuCd+am/RDOa0pDELab
	bvbHySfRgs2P2HQ5zX/pg5udsDcFZT/yOT15Aph85fjjoKXxs9kFooY1pa70UyexM0yoK/BXfWj
	IMWIraSLc5+kylPrIBDnuAMmdJ9Xz6LGSAds0towipUdbxPXiLaxHi/3KeTZIG2K6+i5KtLXy1+
	xxi4dmDP/bXsFNfndWrfCDBQQ7ZtuaE=
X-Received: by 2002:a05:6214:5543:b0:917:aa8e:474f with SMTP id 6a1803df08f44-91ca4b1ab34mr106887066d6.23.1793521302360;
        Sun, 01 Nov 2026 01:21:42 -0700 (PDT)
Received: from [127.0.0.1] ([20.119.79.64])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca7f26f1esm61578716d6.13.2026.11.01.01.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 01:21:41 -0700 (PDT)
Message-Id: <fa90c64a5cab1964988a84b61f4b7af0d9e8b4ad.1793521297.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2456.v5.git.git.1793521297.gitgitgadget@gmail.com>
References: <pull.2456.git.git.1792437558.gitgitgadget@gmail.com>
	<pull.2456.v5.git.git.1793521297.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 01 Nov 2026 08:21:35 +0000
Subject: [PATCH v5 2/4] imap-send: accept messages with Subject before Date
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
message, which ends at the first empty line whether the mbox uses LF or
CRLF line endings.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 imap-send.c           | 25 +++++++++++++++++--------
 t/t9001-send-email.sh | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 8 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 7e74c37a72..391bd8b96a 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1457,6 +1457,22 @@ static void wrap_in_html(struct strbuf *msg)
 	*msg = buf;
 }
 
+static bool has_required_headers(const char *line)
+{
+	bool from = false, date = false, subject = false;
+
+	while ((line = strchr(line, '\n')) &&
+	       *++line != '\n' && !starts_with(line, "\r\n")) {
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
@@ -1472,14 +1488,7 @@ static int count_messages(struct strbuf *all_msgs)
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
index d1393ef197..4611e6d4a6 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -2863,4 +2863,42 @@ test_expect_success $PREREQ '--compose handles to headers' '
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
+test_expect_success $PREREQ 'imap-send ignores headers in the body of a CRLF mbox' '
+	test_config imap.tunnel ./fake-imap-server &&
+	q_to_cr >crlf.mbox <<-\EOF &&
+	From mboxrd@z Thu Jan  1 00:00:00 1970Q
+	From: Example <from@example.com>Q
+	Subject: Fwd: originalQ
+	Q
+	---------- Forwarded message ---------Q
+	From: Someone <someone@example.com>Q
+	Date: Thu, 1 Jan 1970 00:00:00 +0000Q
+	Subject: originalQ
+	EOF
+	test_must_fail git imap-send --folder=INBOX <crlf.mbox 2>err &&
+	test_grep "no messages found to send" err
+'
+
 test_done
-- 
gitgitgadget

