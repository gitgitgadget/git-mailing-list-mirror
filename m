Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497FBEAC5
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 07:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729669227; cv=none; b=YY7LuVCVKqo+M3n3C6i4L7gNyGbUr0hUwt6lk4EkyuH7OGCORa/FSok4VXIfdYBxDRu9m82neowfMWLl9S4h6CGJLXNAzVAlBup/jThzPBpYLnQCAzVBNtFR1cbCetgM7twTgvXCUK9HQrnxroXOpwnjuy8foF8ZfFHQm+0FSRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729669227; c=relaxed/simple;
	bh=XsaAm5p0aZY0z+UgR14N+yKmwycSaeuk2ADSjvK95IA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=iVccwUGSHnKDgFrHPe5Rt18vZU80CtIBDo5bMtuFRidIiFvPJ+PusuB0Lxhy0ZsAWZgGOQkralqupf5Pomu67DYNeTLxelB9zerLxiD6QGSbY6KVA1keATOhdhWW1e1K5IUKA7FZ1as5DqVZSOYmG+RobFqIukrbsKRpR9Lg7Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AYgHBufT; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYgHBufT"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539f58c68c5so10119838e87.3
        for <git@vger.kernel.org>; Wed, 23 Oct 2024 00:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729669223; x=1730274023; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LiFKmWLgseiw2SOy+x3UfRVoSw2ANAb8T5gb3gxsA7U=;
        b=AYgHBufTYDq4oRcgZkjU1NKP2WLciEKtfaeh8SxGUWOIc/b9Vkom4hIN6fLsdvD846
         cMaGMkDpkXkNnBzsHBPm9/2r26cw4MrIgdec3Y+377nudLzNbS7guV7rSn7JdQ9wHeUJ
         DaH1Q66BCOcUHmcwxlRJO31JX6a6s/lyMTkOSXwRUTW9JaBH0MjB3v6gRrRyWh9uILPR
         UflRbc9l1mZprOxjubxZ2iCFHnZJg3btZxWYHn+3/XfaFy6KUEWUL7oy20gKZdLGQRpE
         XDGs38rrjngp6d1WYXUJaEE9J3cb0gmBVJ3qxEluJvbHl/bMt5nQdhcTHxEh5emiCTlh
         sVww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729669223; x=1730274023;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LiFKmWLgseiw2SOy+x3UfRVoSw2ANAb8T5gb3gxsA7U=;
        b=kpe8OdJL4jcmIf9BZvU9Tcd1GzYj6yx5x+5X/UVx5tPnUjehAuiDqTTBHjecBpgD3i
         We2NKgor8FLD8cBUnAGfi0Oq1RsSOKgPlaF2WyR/uciAkTtcKtWbZI9PtCPA1ZBc/9/C
         cG7Bf70HS0ZTOOr+MzPY106IROEzdJN97AvB/aimHw1q7eWQxRx217O/7tpnsIT7eI4k
         rzHzXOb1w/8hafgavFDQIO01qeYLxUIBt0Z8fiRgQ05AO3s5Pw73zmCw9/9k+MDvUXQh
         1hH7OCClLZUQNXiwSfI16ZGuxLQGI/CVYv0Whpm2I/zdDUYJFZsP3LaeEd0ywUkrRUkJ
         AI5A==
X-Gm-Message-State: AOJu0YwIQ1SMjyF9lO/QD7pdWE6sU5EIuhDvD6FJ+/vOsTuY63tScBPY
	UlecRlMyr1KglhSDCrA0Pu26iDck7018Ekcx6FOfT9gcvTkbero+DX/SHQ==
X-Google-Smtp-Source: AGHT+IHJidAcgDP2LOwCcPMzNcgBPQIYG5B7UUZME43AfvO/qOt7yP0HAXKg1npVnmhptDCv8lG3dw==
X-Received: by 2002:a05:6512:31c3:b0:530:ab68:25c5 with SMTP id 2adb3069b0e04-53b1a315bbbmr1225594e87.2.1729669222524;
        Wed, 23 Oct 2024 00:40:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912ee100sm436284866b.62.2024.10.23.00.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 00:40:21 -0700 (PDT)
Message-Id: <pull.1810.v5.git.git.1729669220.gitgitgadget@gmail.com>
In-Reply-To: <pull.1810.v4.git.git.1729634937.gitgitgadget@gmail.com>
References: <pull.1810.v4.git.git.1729634937.gitgitgadget@gmail.com>
From: "Usman Akinyemi via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 23 Oct 2024 07:40:17 +0000
Subject: [PATCH v5 0/3] parse: replace atoi() with strtoul_ui() and strtol_i()
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>,
    Patrick Steinhardt <ps@pks.im>,
    Usman Akinyemi <usmanakinyemi202@gmail.com>

Changes from Version 4:

 * Fix incorrect indentation and remove unnecessary braces to avoid
   confusion.

Usman Akinyemi (3):
  daemon: replace atoi() with strtoul_ui() and strtol_i()
  merge: replace atoi() with strtol_i() for marker size validation
  imap: replace atoi() with strtol_i() for UIDVALIDITY and UIDNEXT
    parsing

 daemon.c              | 12 ++++++++----
 imap-send.c           | 13 ++++++++-----
 merge-ll.c            | 11 +++++++++--
 t/t5570-git-daemon.sh | 26 ++++++++++++++++++++++++++
 t/t6406-merge-attr.sh |  6 ++++++
 5 files changed, 57 insertions(+), 11 deletions(-)


base-commit: 90fe3800b92a49173530828c0a17951abd30f0e1
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1810%2FUnique-Usman%2Fr_atoi-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1810/Unique-Usman/r_atoi-v5
Pull-Request: https://github.com/git/git/pull/1810

Range-diff vs v4:

 1:  d9c997d7a9c = 1:  d9c997d7a9c daemon: replace atoi() with strtoul_ui() and strtol_i()
 2:  da9ea10e4e1 = 2:  da9ea10e4e1 merge: replace atoi() with strtol_i() for marker size validation
 3:  8982dca646d ! 3:  9b2b2dc8fc8 imap: replace atoi() with strtol_i() for UIDVALIDITY and UIDNEXT parsing
     @@ imap-send.c: static int parse_response_code(struct imap_store *ctx, struct imap_
       	} else if (cb && cb->ctx && !strcmp("APPENDUID", arg)) {
      -		if (!(arg = next_arg(&s)) || !(ctx->uidvalidity = atoi(arg)) ||
      -		    !(arg = next_arg(&s)) || !(*(int *)cb->ctx = atoi(arg))) {
     -+		if (!(arg = next_arg(&s)) || (strtol_i(arg, 10, &ctx->uidvalidity) || !ctx->uidvalidity) ||
     -+			!(arg = next_arg(&s)) || (strtol_i(arg, 10, (int *)cb->ctx) || !cb->ctx)) {
     ++		if (!(arg = next_arg(&s)) || strtol_i(arg, 10, &ctx->uidvalidity) || !ctx->uidvalidity ||
     ++		    !(arg = next_arg(&s)) || strtol_i(arg, 10, (int *)cb->ctx) || !cb->ctx) {
       			fprintf(stderr, "IMAP error: malformed APPENDUID status\n");
       			return RESP_BAD;
       		}

-- 
gitgitgadget
