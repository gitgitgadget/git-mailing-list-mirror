Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FE630B508
	for <git@vger.kernel.org>; Mon, 16 Feb 2026 13:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771248226; cv=none; b=dRbhW1AZtHPTbOqEPYMgXeQqOWD6ZH1GvfTM1FmLChlN2RNqSwUCk3NO9IseWyK8B5D0ROw1QTVUUqJFtRDKk3dNf2o+DjqsyNtBeLoGRMXWNFhxVn3+nqq4wDzYpzefCWPSS7xmCMOkdWtsgimpWgWArvnOXP63QB71pEH/Twk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771248226; c=relaxed/simple;
	bh=U5rxdEzoK5k+W3fnMl0Efoa0ELRJhMo3o4beXj9hzCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ht6owqLQXvs5E7nrMU67dQ6Gf8EZwMKHr/g387jfm6W4Y4D7G9IA2xmaqfgZVKVg7w3A7/JHF3d4nu4MRyWXhU66XMBy+1ZKRNnU7/NIru+CI5YO9A5uSlFl1BIcivHsvMJOi8f/l5IuKBAyH4Ypb3cEBnXdlMZitSc9UkVIDIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6EvtiXY; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6EvtiXY"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-4836d4c26d3so23406135e9.2
        for <git@vger.kernel.org>; Mon, 16 Feb 2026 05:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771248223; x=1771853023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q7VaWIaYKcqkp5o2SRvCxZUXuEGnr+aYsoYFSRhDk3Y=;
        b=Y6EvtiXYJOyHf8hz/vFsGcmCpyvLqjprIxdfyY9Xsa5fhXh9ljKoIjHXdZGGI3FN0p
         flrjZXtuVGl5ddw86+KFCSxTVf74jSOOTaKKzjL1Vh+b1LuzB8dNEKFAQzYXoXmkqnSV
         rt2N0sj/BFevv0bJfoKXpIPHk/A7YevslR+wGa8DuchhMP4cvjPD4fFkvel50Sr+oxxP
         8UvOhfOJLplwolN1srTS8P7swhyUj8mbrgIoSbCfN675qCtoGUleccJ7g5ovwrZqcf1r
         pVKXnw88fQdiPTx+HIXLameVjVTSGryMh66pxso3tPUNbM2MvjGWpIfQCRFWKEHvihbg
         OCfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771248223; x=1771853023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q7VaWIaYKcqkp5o2SRvCxZUXuEGnr+aYsoYFSRhDk3Y=;
        b=veJzUIXByIQxobK/iSuSctA+16ESp8wOiNziuuqBAxn4BgA5oJKY6HEfC81egeVCpm
         6ok3nIuG1D2RVOE+p3Nc6h6urEzCN+FV9nxWNZOnZOOYTojfhl0K1LGeC4sHkNQyUp7o
         1AXdw6nt8sUxfjxk69T2SvFkPiPCEPn0Q8F+wew6truglU1yg55fNDnc/kn0kJJgP6xw
         u+F00e07SYdqDEpsUpzF6uvYrhT2tgpCQUs8x+0A5TZrAI80ADaRC9O7Ixe/lMzGST/p
         FLAnQtXlSeRUKhesP416BEAnM4H+7Wixrp1vE8OyJfYH+3UIbk39obBUrvHffZg6GKN5
         p0vw==
X-Gm-Message-State: AOJu0Yw9fEIj0pR8XBXb4eJLhDlxCjIoqj31xSI6+D2sQTNMwxbRi413
	sWqBPvbXlSk8zgVCDm3tag+/R3lPQKiiqHFd/q82oZpUtBTwuYNd2G1PoVOdmEQf
X-Gm-Gg: AZuq6aIOniHaNobVwzRu0jlM+gSlyqNreP2qJdIUR6Ky/PbUkYB6bavTet13hoXy4he
	nrI8fJim8ux5iacp2N5SBKl2JLrQRMajELut6Pi0gAfXCg8QmH4LjMgBW7KYVxp2nLYF9rlxxG6
	DQXcDcwZUeL1aZnoHe34daV3P+iqLem8zPAOEQuGQXcralpCD97GfHh5phevJs6h3RqYaLILIFC
	oYjrEfB3H3y508FkVfxOYCjp9r9H50KV1vvJrT53XGCVeoC0M+ixApoIX+mfdeE/ILlOWekw7LH
	ff+dIUccowrrOacdu1dwQ4LkGDL7Ckd93G/Y5cxlFCEJ924Nlyr+ym3UeMfuQ9rx8FtGQI6cPV1
	fHwIqS+y9Z/AVNBO5kERx/e7qXzuM/nPm4KBJ7krivAqOqVEE5sscyBULnjh41R1/Rh9Hle9lpv
	cl40pKFRDMyc/Lsaou+A6fXFgL9qD7VU1+NXWL/HRKfzeG+RJebwFdC9BDejVPHxL9NLZkbjQon
	G2laGd109dPiqG/etlWyHHtEhnGFVz6DYNnDUckqNEbvYMQXA==
X-Received: by 2002:a05:600c:1c21:b0:483:47ae:7c00 with SMTP id 5b1f17b1804b1-48373a3eac4mr196067395e9.20.1771248222460;
        Mon, 16 Feb 2026 05:23:42 -0800 (PST)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48370ac3564sm235688025e9.5.2026.02.16.05.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 05:23:41 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <avila.jn@gmail.com>,
	Jeff King <peff@peff.net>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 5/9] doc: fetch: document `--filter=<filter-spec>` option
Date: Mon, 16 Feb 2026 14:23:11 +0100
Message-ID: <20260216132317.15894-6-christian.couder@gmail.com>
X-Mailer: git-send-email 2.53.0.77.g4627d513d6
In-Reply-To: <20260216132317.15894-1-christian.couder@gmail.com>
References: <20260212100843.883623-1-christian.couder@gmail.com>
 <20260216132317.15894-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `--filter=<filter-spec>` option is documented in most commands that
support it except `git fetch`.

Let's fix that and document this option. To ensure consistency across
commands, let's reuse the exact description currently found in
`git clone`.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/fetch-options.adoc | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/fetch-options.adoc b/Documentation/fetch-options.adoc
index fcba46ee9e..1ef9807d00 100644
--- a/Documentation/fetch-options.adoc
+++ b/Documentation/fetch-options.adoc
@@ -88,6 +88,16 @@ linkgit:git-config[1].
 This is incompatible with `--recurse-submodules=(yes|on-demand)` and takes
 precedence over the `fetch.output` config option.
 
+`--filter=<filter-spec>`::
+	Use the partial clone feature and request that the server sends
+	a subset of reachable objects according to a given object filter.
+	When using `--filter`, the supplied _<filter-spec>_ is used for
+	the partial fetch. For example, `--filter=blob:none` will filter
+	out all blobs (file contents) until needed by Git. Also,
+	`--filter=blob:limit=<size>` will filter out all blobs of size
+	at least _<size>_. For more details on filter specifications, see
+	the `--filter` option in linkgit:git-rev-list[1].
+
 ifndef::git-pull[]
 `--write-fetch-head`::
 `--no-write-fetch-head`::
-- 
2.53.0.77.g4627d513d6

