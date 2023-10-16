Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A9230F97
	for <git@vger.kernel.org>; Mon, 16 Oct 2023 16:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKoZgv3U"
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD165213C
	for <git@vger.kernel.org>; Mon, 16 Oct 2023 09:41:34 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1ca72f8ff3aso7364345ad.0
        for <git@vger.kernel.org>; Mon, 16 Oct 2023 09:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697474494; x=1698079294; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ixqG5XfNoZX7wpTupd8PlgBdiy5I43IPqIJyNxaDyU=;
        b=PKoZgv3UoGCafjCxTSSIMG52CCAgsyyHGXcZCU4fVGYUhNEpXW3pg+3ct/AhGxWGZZ
         YkLrpwfEUhiYDTCmRKsgt5w/AOWWS3jhy18+oNyC2vnA/kG7yiOTqi6li56wl39uojoL
         4euII70jLJ5Bp413Z/N5Hy69AMKmNDX3xNpk+6ef2oMi3I1hEqG85wQByiIlR9qFDG8D
         qN/W8mPeOSpDkohn6keDCXzNaJdxGbE3mRlVQfpQQ28bfJKpQz7IC31mvNZ7sjfO+wEB
         yHwPW9kmaiGFJzQzs5D/nohUoIwgEoahpkveOGZp8HVyScT6WDiEi9Rt3j1IENLi6/x9
         xJmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697474494; x=1698079294;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7ixqG5XfNoZX7wpTupd8PlgBdiy5I43IPqIJyNxaDyU=;
        b=LtYFUWeTniKbyIMx0HMRqxXWjfGTy4gVJJSWEXgmi81aszT4OlR4MjveB9HU97m4OT
         XoV/zRNW3/AQ15yy27/zvQo0pQ+IM12mcyAIU29TKBX1EF2GwKK7UElxnbVNNf+4cJNM
         dShBDsNXqQ/R2W8X21cypRwGncFuVo7Dsx5plxaNJQEwUDoWDgDjXS/b9SfIteUD626M
         nKhaKYtSdSzumNNwDfspLx+87TGd8j0h0NCrAVyLRhiSOo+pp234IIMIBS9uGpSF6pnu
         /mJTqsN975bARLpV1N5SOLnzTb03bd/wmSE5eObs1+j2Rv3uuZyd6k9OeuDxawFWgLAj
         QZ5A==
X-Gm-Message-State: AOJu0YzUb6nGxP1QDf2aFhyQ6JaamnU/rkmjycBeFxbt13vJ6EtKSAuJ
	Cd7KYyBrnIGJW/1BlxiNCog=
X-Google-Smtp-Source: AGHT+IGBWYST7yD6sPxYOd5YAUB3kIM372mTNf3iuF0TMEAgPxpMmCJuQfWImunuzKnj/hF5dIxkvQ==
X-Received: by 2002:a17:902:dad2:b0:1ca:117b:455b with SMTP id q18-20020a170902dad200b001ca117b455bmr8301773plx.46.1697474493669;
        Mon, 16 Oct 2023 09:41:33 -0700 (PDT)
Received: from localhost (120.153.125.34.bc.googleusercontent.com. [34.125.153.120])
        by smtp.gmail.com with ESMTPSA id z5-20020a1709027e8500b001c9c6a78a56sm8915130pla.97.2023.10.16.09.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 09:41:32 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: steadmon@google.com
Cc: Phillip Wood <phillip.wood123@gmail.com>,  calvinwan@google.com,
  git@vger.kernel.org,  linusa@google.com,  rsbecker@nexbridge.com
Subject: Re: [PATCH v8 2.5/3] fixup! unit tests: add TAP unit test framework
In-Reply-To: <20231016134421.21659-1-phillip.wood123@gmail.com> (Phillip
	Wood's message of "Mon, 16 Oct 2023 14:43:00 +0100")
References: <00d3c95a81449bf49c4ce992d862d7a858691840.1696889530.git.steadmon@google.com>
	<20231016134421.21659-1-phillip.wood123@gmail.com>
Date: Mon, 16 Oct 2023 09:41:32 -0700
Message-ID: <xmqq1qduo6yr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Phillip Wood <phillip.wood123@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Here are a couple of cleanups for the unit test framework that I
> noticed.

Thanks.  I trust that this will be squashed into the next update,
but in the meantime, I'll include it in the copy of the series I
have (without squashing).  Here is another one I noticed.

----- >8 --------- >8 --------- >8 -----
Subject: [PATCH] fixup! ci: run unit tests in CI

A CI job failed due to contrib/coccinelle/equals-null.cocci
and suggested this change, which seems sensible.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/unit-tests/t-strbuf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/unit-tests/t-strbuf.c b/t/unit-tests/t-strbuf.c
index c2fcb0cbd6..8388442426 100644
--- a/t/unit-tests/t-strbuf.c
+++ b/t/unit-tests/t-strbuf.c
@@ -28,7 +28,7 @@ static void setup_populated(void (*f)(struct strbuf*, void*), char *init_str, vo
 static int assert_sane_strbuf(struct strbuf *buf)
 {
 	/* Initialized strbufs should always have a non-NULL buffer */
-	if (buf->buf == NULL)
+	if (!buf->buf)
 		return 0;
 	/* Buffers should always be NUL-terminated */
 	if (buf->buf[buf->len] != '\0')
-- 
2.42.0-398-ga9ecda2788

