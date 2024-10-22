Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6157913211C
	for <git@vger.kernel.org>; Tue, 22 Oct 2024 05:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729574632; cv=none; b=iQyt15pkofLnWDtpO87kjmijEhW9FW3goKQRZkhbUODeCAfPBN0TI0qsmkH/audHI1VkRN9LnZfva5K6Q+5YAn1VfawbYjJFm2VosXy3ODn2vfFUGpYXOVmcXAV4LBpnpZ6qWrMDG69TZ9gbRsDKTiOOwPDpUlAMBsLX5jaaTV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729574632; c=relaxed/simple;
	bh=37eIvsVESLXLyoI6O5Hzp3/HE8UXk+PVlwfWePSa1M0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=S1w77xjWcdBysJ+R4tqnNn87JCEAUI45XSsNO10LjIkqKvUETQLQISan5fS6NKyoX4icthsTmKuX8XKiXVYJzkqcy9bc+J7LBcFjC4+4nEQXOC7luVc6pQGWEczwTGg7HXN+d6YCNDnlRdjEy6igJeCOUebDImOhv+kJNJbLqvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NlvTft9o; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NlvTft9o"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5cb6ca2a776so1837270a12.0
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 22:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729574628; x=1730179428; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ljjAwwc49VPeSHdsjTz8xOsjWNLz4b6qMHM1WZ0Hi1s=;
        b=NlvTft9o296S/yR9DgTMDvlqO0ggo9ap7BKPMJSBDUxLcmUb0z50gC+9PlAboICw5W
         6EG/DcYrvWDPdiTx3CfGWHAMoNSckUdrAR9Y0mj4HfKqybODlD+BPa50gGYi+i2e7gBN
         zptQFfZ/67BQ6FdbduQtNRN+Z2X/43HHG4rZ5o8xfktKmW/hldy61CCJrQeSKXTJvSb5
         jbd4vnW7DUDd1NCopYqIgon+visfTEeJXVDyzH8MYTblheDp7LCi7CgCZ06lDEeaCM6C
         TC1JKx2c12Ku82SjtB3yGjU7wc1awtCj98VliPNmnb9fjRdMq6CGOEjr5ovioiUEKI3+
         7Mhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729574628; x=1730179428;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ljjAwwc49VPeSHdsjTz8xOsjWNLz4b6qMHM1WZ0Hi1s=;
        b=duooSTF8lfQ+pUanUkHUhXPKFoxBeqxAU/uYDn6jIqsDYZh3UnUZ8xTfyswiLj65mq
         kS8eaiiIyW8eVwykKRYO8otyFq6ortbJiUMizb3QVECSpZ+7okrLkidhdedT29QnV5zm
         +D1HMMuFiGM/Zoad9X+lUiN2hwE9El1p6s7zHZr80ndU3gfDKeVfS2YjnvOEUG8MxxRD
         xCCjgnkgjl5knxRf4UetDr5H7g9wvszR4h1N104iY6GScEzK7DHJEwUBKNyOBdm8ICmF
         ITchweN96ULT5EnEmIO05VXy6/MUHOlpk9aKTIrMoLfHRROlTFXSwwSKJg/fgXlTW2wD
         y8SA==
X-Gm-Message-State: AOJu0YwqvLvwRfOJjx1h87W6lZTYjwgH+KUyP/4gc24BKCFxw0sIy+HK
	UO19B6oVWfgMTG3iyMW4v1100qVyYqbjxQdpXfaodClBXJ562Mx0JrlgyA==
X-Google-Smtp-Source: AGHT+IGjJZr0knIiK6PR/nUMRVlAcGyy6jBng3s9nV7idVspOlABp0A2fBADI9coR+We4zYHqnd9Qg==
X-Received: by 2002:a17:906:99c2:b0:a9a:238a:381d with SMTP id a640c23a62f3a-a9aa8a0608cmr175928566b.52.1729574628171;
        Mon, 21 Oct 2024 22:23:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a91572113sm287995566b.168.2024.10.21.22.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 22:23:47 -0700 (PDT)
Message-Id: <d0aa756d2d07f6fdb7450b9b6baddd2ea2c99a7b.1729574624.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1810.v3.git.git.1729574624.gitgitgadget@gmail.com>
References: <pull.1810.v2.git.git.1729259580.gitgitgadget@gmail.com>
	<pull.1810.v3.git.git.1729574624.gitgitgadget@gmail.com>
From: "Usman Akinyemi via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 22 Oct 2024 05:23:43 +0000
Subject: [PATCH v3 3/3] imap: replace atoi() with strtol_i() for UIDVALIDITY
 and UIDNEXT parsing
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
Cc: Usman Akinyemi <usmanakinyemi202@gmail.com>,
    Usman Akinyemi <usmanakinyemi202@gmail.com>

From: Usman Akinyemi <usmanakinyemi202@gmail.com>

Replace unsafe uses of atoi() with strtol_i() to improve error handling
when parsing UIDVALIDITY, UIDNEXT, and APPENDUID in IMAP commands.
Invalid values, such as those with letters, now trigger error messages and
prevent malformed status responses.
I did not add any test for this commit as we do not have any test
for git-imap-send(1) at this point.

Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 imap-send.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index ec68a066877..8214df128e5 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -668,12 +668,12 @@ static int parse_response_code(struct imap_store *ctx, struct imap_cmd_cb *cb,
 		return RESP_BAD;
 	}
 	if (!strcmp("UIDVALIDITY", arg)) {
-		if (!(arg = next_arg(&s)) || !(ctx->uidvalidity = atoi(arg))) {
+		if (!(arg = next_arg(&s)) || strtol_i(arg, 10, &ctx->uidvalidity) || !ctx->uidvalidity) {
 			fprintf(stderr, "IMAP error: malformed UIDVALIDITY status\n");
 			return RESP_BAD;
 		}
 	} else if (!strcmp("UIDNEXT", arg)) {
-		if (!(arg = next_arg(&s)) || !(imap->uidnext = atoi(arg))) {
+		if (!(arg = next_arg(&s)) || strtol_i(arg, 10, &imap->uidnext) || !imap->uidnext) {
 			fprintf(stderr, "IMAP error: malformed NEXTUID status\n");
 			return RESP_BAD;
 		}
@@ -686,8 +686,8 @@ static int parse_response_code(struct imap_store *ctx, struct imap_cmd_cb *cb,
 		for (; isspace((unsigned char)*p); p++);
 		fprintf(stderr, "*** IMAP ALERT *** %s\n", p);
 	} else if (cb && cb->ctx && !strcmp("APPENDUID", arg)) {
-		if (!(arg = next_arg(&s)) || !(ctx->uidvalidity = atoi(arg)) ||
-		    !(arg = next_arg(&s)) || !(*(int *)cb->ctx = atoi(arg))) {
+		if (!(arg = next_arg(&s)) || (strtol_i(arg, 10, &ctx->uidvalidity) || !ctx->uidvalidity) ||
+			!(arg = next_arg(&s)) || (strtol_i(arg, 10, (int *)cb->ctx) || !cb->ctx)) {
 			fprintf(stderr, "IMAP error: malformed APPENDUID status\n");
 			return RESP_BAD;
 		}
@@ -773,7 +773,10 @@ static int get_cmd_result(struct imap_store *ctx, struct imap_cmd *tcmd)
 			if (!tcmd)
 				return DRV_OK;
 		} else {
-			tag = atoi(arg);
+			if (strtol_i(arg, 10, &tag)) {
+				fprintf(stderr, "IMAP error: malformed tag %s\n", arg);
+				return RESP_BAD;
+			}
 			for (pcmdp = &imap->in_progress; (cmdp = *pcmdp); pcmdp = &cmdp->next)
 				if (cmdp->tag == tag)
 					goto gottag;
-- 
gitgitgadget
