Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792652190;
	b=tLsDe8GsEGXJ0RMgRm3HXWJiogjZmbIV/RJyiCwG6kx8D8F9SMaBg2XuegNAdMZdWSoJ
	 nM9tjFYTR8hn2DzsJiI6b4JXjoWdNWAZ993quh6CVfPwlorz8JhI4ULgpz5UiSaq04pk7
	 mJg3WlAIvVoUT+lwNn1Rw1fdq33Yw7VfAn4ur2Yv/upbtVqgcLoYa+NP+ZNtOs/cbtdVU
	 0ZPDNrcQYNbhtaeyfMYlM4Ux3DZ6JGqVgSiVVAUs2oLz7cy53F6SOt6wzS0gvTrYxqRms
	 Ii3cgooe40FB/Wdx3q+cjLdFaUPsxeV+NnoaKRaEWzxmJDLvhyGsSmZbnB2ey+3Ha/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792652190;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=Xf3n0SxNUxWiWCCTHT8ZSR6tjO/IxCOnI3tikxtDCAU=;
	b=sJWEEzLrVST7nCdmF/Rjd4273CBxZ4qnK/M8yU0GAT6S1YlY/S0Z9iadqYXbzkFttzhf
	 3f3N0JxdNNHKyIrqXgYO2gYhSdC7ESf009LDPgl5Q+W1l4dB+pdvNaxR2OypFfSUDhkxy
	 5Q2Joc1uVKTv8sJ2tEAQEmaJNxsrTA26OQhO91fUVbEbCR9E+jhwJmfxp/hQfqI0wQiIy
	 kvIurXPQB0CsAjyrC2Z8TCjkQBCPcj/rT9t7CGleoqdcuwXWO4K+zMkc4OQUmz8UFdvox
	 yvI6zU4CjEe1AGfdGdb1MnQ6lTNuCJVSIZ55S3doIm0WlFrMx9OODX1xaiMJXaIfubA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=f+TM+KDR;
	arc=none smtp.remote-ip=209.85.222.177
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FED606A322
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 06:56:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91FED606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=f+TM+KDR
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-93f079a63b8so155440885a.3
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 23:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792652189; x=1793256989; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Xf3n0SxNUxWiWCCTHT8ZSR6tjO/IxCOnI3tikxtDCAU=;
        b=f+TM+KDR9cZUBgf281yzgF0XmKElOKxQ7SmjvEEOjhZTnphgwamRe9ukqahNB/OoxR
         Sj4Wq/PWXn7lnnIX2xT3vVirhLEQ15Ob9nVK2KzM5mGFQ0Ui0hUHTb3sNhEAAa09iFcz
         2Fb5VUfHq+fLSj38AN3DPF/C41aBDAY00FfEwod18KJQw1ZtPkJ9YokEcezvqBl2XdH6
         5ndtB3sPGIwWDqa+pE/Ob+w01zrE5Ixen+4EC4HDtSby6CSwmfMGKpvmXfsbXiRpoQ+4
         sAncaZW9CvQggetkql3q0KSqNa9URqhdX4JI6gICiLppKfdKJJooYwLeaDYZGPh+larT
         2EkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792652189; x=1793256989;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xf3n0SxNUxWiWCCTHT8ZSR6tjO/IxCOnI3tikxtDCAU=;
        b=FBymIEEiL5F3ALGRkI2dDE4eWlW0ji2uR8APOpSV7xtuNfT3B+UU0j8pzU1RmB4/AR
         9c7Xevw6MflrqGsJLyLCcvlHlsX7HE0/YnXRu2ckwQ6e6s/37h0oIvIAjEDebQznSeRk
         kVvXEINl7GfCXYP9w+YgB7qj0cbo7YRurLvubv93NXIXhyk6LaAboOSADV76Hx3Md3qc
         8nAFupmwnd4r0x1W/ptuaWLDUzDca5J2Z1GOkRmBpfjCx1ybApkQ7gro3IfkuaTUebaN
         NJclR+RWSixuCktelPZ0A/DpVNyhrP4FxN7P+lPNS3lef8iMw9DcEm3LHGojXClTmJBM
         BAqQ==
X-Gm-Message-State: AFq9FYICkq8gyMbFFHKIzN2AgNmb0xQ68aJRlILeKM42HJ+szI6EOCdH
	c/mMiBnVRwcKbJbq4NWo8tjImW3bvElzxhZ7sg3vkv1Yh7AuaB7zzGAyId5cVDZF
X-Gm-Gg: AYBFou0gwURY+Cvjh9vOUSbkeh5ty/DySduvUtR577QV2HKTucUZkGKD8eQF9Ki00qX
	Lcp6djlxvbM6oB5xvMyOGfXjWf+luaYsrCozY6PLIL+LiUDX5chtm3m9PyXg+u3nibt5Bv8K8N0
	JlIcJK5Z5RB605FoAr2eRIcHVftp63tT9r8v8ZOqx8qaKozi95VY39OgPLCM4/HhiU80u3Oek5s
	LWM+PtC3Dy2T8QaVoLg+EnIKsauItl6MEKZE/9s3CPrLg9KB4NQv5zKcPQbYI/QTITH48YGfu2R
	i3BujSa5f6gfnT9ZTcQ+RONUE/kr/tyLFiuuF+pXcl265gTxt6lR7D3Og+QBLiEuNH2zAlPaNm5
	GwyvvOuhv5RJlH0C59QsgbJWcQRXhKRgbKagfsXd+HI4Sy81aY1h6/6Lxinq+spl7pwt0pJsM/7
	0Wm3afPFCULWJ7vBt/5OlysiL43MQOsKo1QfykRsNmzO7aF2XX22DH4L1ju6r6gniGLH7OiTbBU
	q9MueLt0Q5U5ABBLrks/X4gHM9Svr90YUpObgCcT0vGXs9o9sSq41Npw9M=
X-Received: by 2002:a05:620a:4515:b0:93c:c1e8:6504 with SMTP id af79cd13be357-93f57f0a157mr809107085a.23.1792652189601;
        Wed, 21 Oct 2026 23:56:29 -0700 (PDT)
Received: from [127.0.0.1] ([4.227.173.122])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f56d9a495sm450610385a.13.2026.10.21.23.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 23:56:29 -0700 (PDT)
Message-Id: <213c4950e053441ad81a0d5f6569e7a2ea63e25c.1792652185.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2456.v3.git.git.1792652185.gitgitgadget@gmail.com>
References: <pull.2456.git.git.1792437558.gitgitgadget@gmail.com>
	<pull.2456.v3.git.git.1792652185.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 22 Oct 2026 06:56:24 +0000
Subject: [PATCH v3 3/4] imap-send: check git send-email copies like other
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

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 imap-send.c           | 15 ++-------------
 t/t9001-send-email.sh | 13 +++++++++++++
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index ce2321d42e..1091825dfb 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1477,19 +1477,8 @@ static int count_messages(struct strbuf *all_msgs)
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

