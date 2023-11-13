Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5903A1CA9F
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 10:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UhksqixC"
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF2CD78
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 02:24:23 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-32daeed7771so2402308f8f.3
        for <git@vger.kernel.org>; Mon, 13 Nov 2023 02:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699871061; x=1700475861; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JLLoRClaRsY1Lr1KRBPf00edL9rjXGTDv1wSMzbaP0M=;
        b=UhksqixCPWQ6OKnrJYp92dt5jvqsxLDx8MReK63lu45KrQwnRUsMaZTmCA3cezmsrn
         QG79+6iv2hXCUrUI73TtPfETSrb1r19zUOrfs6RcmjwqzH9Rll2q3jTn5hb41evmLep1
         USCdrevQSoHXhZLr2SKecLZDInYNnm6l5USxP182tg8wZKnBeCW8lMTbrDzRMG7v7zsr
         R6xvWV8Pl4w4CguvvBXa8fCLIpNS/le/Y5bG/KKpcpZkxyu8isG9CGnlCLqrzEc4FvD2
         q+iJk4F/6dF6h+M6ZjkHqElgkD6IqD0FFcCNa/4jrTVva18M4qFKLsJIiYcLtjC6Aecq
         fsRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699871061; x=1700475861;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JLLoRClaRsY1Lr1KRBPf00edL9rjXGTDv1wSMzbaP0M=;
        b=b2wFxRF8S0vgsX7LZxE9GtvtCOxZU6iS0qAamU3m/PYrd5XozMjNVXbfoYwsNA/J06
         q7nfSu+QkDUNjRKrPPVFXAlIkyPw5+qp9JLyVcU+Ir6VnQr1Zm79fMaxL50FNBTNpVtv
         KNprnsIfWETO+2UhMDI+Ta/sNkfbz49DAPXgKzyWNZ+7wcGm+djKhhYolxylG98Cb/Th
         8FLRR6MnEogljRlwhBoETFF8QNVhuyj3Zdo1fNCPBAtZu4C3mlPz1dyGUBucKEgKfedf
         v6u5/Npzt50rN32TQZaLm0f+3y/XVUPdRE1VxeuxP2gUic4ivC/f5JalGAowc5TYeHec
         bXmA==
X-Gm-Message-State: AOJu0YwUBAxEtElq9TDbpoCXs30TIyYAK+pcxAG78vD3GVaJN2ztmvI4
	Kkb6s5w6UBMCo6rTOzw9AN/FlvOilRs=
X-Google-Smtp-Source: AGHT+IFSSd76ceupoSRBEl9Of6/ephExeVzJ4Sz0TdoQ7Md6AvzHCqqgxyFryjpV/R9IZwCVAWcXLw==
X-Received: by 2002:a5d:64ee:0:b0:32d:a0a9:4785 with SMTP id g14-20020a5d64ee000000b0032da0a94785mr4350853wri.7.1699871061023;
        Mon, 13 Nov 2023 02:24:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g26-20020adfa49a000000b0030647449730sm5157093wrb.74.2023.11.13.02.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 02:24:19 -0800 (PST)
Message-ID: <7bace397b4a4ea49c1ad5b931a0d07493fe44a16.1699871056.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1537.git.git.1699871056.gitgitgadget@gmail.com>
References: <pull.1537.git.git.1699871056.gitgitgadget@gmail.com>
From: "Haritha D via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 13 Nov 2023 10:24:06 +0000
Subject: [PATCH 04/13] fixes for build errors Handled git pipeline errorse
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
Cc: Haritha  <harithamma.d@ibm.com>,
    Haritha D <harithamma.d@ibm.com>

From: Haritha D <harithamma.d@ibm.com>

This PR has fixes to enable build on z/OS

Signed-off-by: Harithamma D <harithamma.d@ibm.com>
---
 convert.c          | 4 ++--
 fetch-negotiator.h | 2 +-
 fetch-pack.c       | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/convert.c b/convert.c
index 17cc849efed..da05f6c2e51 100644
--- a/convert.c
+++ b/convert.c
@@ -1313,13 +1313,13 @@ static int git_path_check_ident(struct attr_check_item *check)
 
 static struct attr_check *check;
 
-static const char* get_platform() {
+static const char* get_platform(void) {
 	struct utsname uname_info;
 	char *result;
 	if(!uname_info.sysname)
 	{
-		result = (char *)malloc(strlen(uname_info.sysname)+1);
 		int index=0;
+		result = (char *)malloc(strlen(uname_info.sysname)+1);
 		while(index <= strlen(uname_info.sysname))
 		{
 			*result = uname_info.sysname[index];
diff --git a/fetch-negotiator.h b/fetch-negotiator.h
index e348905a1f0..2e19ef247f9 100644
--- a/fetch-negotiator.h
+++ b/fetch-negotiator.h
@@ -47,7 +47,7 @@ struct fetch_negotiator {
 	 */
 	int (*ack)(struct fetch_negotiator *, struct commit *);
 
-	void (*release)(struct fetch_negotiator *);
+	void (*release_negotiator)(struct fetch_negotiator *);
 
 	/* internal use */
 	void *data;
diff --git a/fetch-pack.c b/fetch-pack.c
index 26999e3b659..f40b90dfa65 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1232,7 +1232,7 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 
  all_done:
 	if (negotiator)
-		negotiator->release(negotiator);
+		negotiator->release_negotiator(negotiator);
 	return ref;
 }
 
-- 
gitgitgadget

