Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81BC19D092
	for <git@vger.kernel.org>; Wed,  7 May 2025 02:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746585212; cv=none; b=o9EqovXFGMlNTK29ju5YGYDipN+wIUAJX7tmCNnDOrmcM2Sw8SKmBpcD0T+nw0F9b3kVMrovYF/s2izH7M+aAKSHXAEY0dRIpvj17pywd6d1B4FiNcI/a82azfgcUTirLgfK2P8zVrt2bxIbVm77uiuQ1Hs4BmHmk17GP42WEs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746585212; c=relaxed/simple;
	bh=rzwtTXzoWV7TrL71Bo3kDh0u/HvkgPFoLv3oD2XIEYs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=LIBbK3kBKRsNDpAKez/dUalvctqyY+UAxBZJMydW5TgBi+r3YAk5NiHrVSCM8cFpTW18SmAwdOqLMgH80qJ81Q5kV7/2a/4BTsbDWLiq5TN167Eey/fboyme/nMeHN8761wSwOYJAT10yI/qC2Lt2gc0bOjaGF5B4EaZ3DtSdHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AGZUtLRm; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AGZUtLRm"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a0af41faa5so691683f8f.2
        for <git@vger.kernel.org>; Tue, 06 May 2025 19:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746585208; x=1747190008; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F5cwTOpmUyd/ZK3JwgmFDqdZUjTPhfiLk2Sxi7RmF74=;
        b=AGZUtLRmfTX877mBzbZtG5OqrLfAm0TbafYy6IQnWrTDw6nQUzbAklsyNpIGtjpRPR
         +UoSHn0Pxyy+lbqwA/DBfxrhL15fzII3VLTuEeqz+PQ5t0QdpPEj70e5xdH3Cw82Wm45
         98OX4m38m2mgXy9KhHJXdrTaSAZshrknWHlK/ajemCB2x+qqsHpi9ik8MfUOxvJnx/xB
         wRRsoJn4CPoHRdeTfK/MBDcuu9aVx8km5ih1dEzhvkpYFJ4OBXe4Xphff1xWsFO8BCuv
         h5PPEoq6umPoJd5ubzb6aup0/0Zp7IrCNrUej2rUKd/fvY/zza7bOhVL7/bi2szhAUvD
         2fDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746585208; x=1747190008;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F5cwTOpmUyd/ZK3JwgmFDqdZUjTPhfiLk2Sxi7RmF74=;
        b=kKdRa452qfnjybW+hA9PKcq0jm8PFurJaKSENhz8SiDPVjgnQ41CnrcNvHnYbOMTxy
         xka+1lZUfaUH7HvTIfJPS8iBahSZfywV6plizDpsIArFdmpPDG+vKkYh73EQVNVGPJFY
         wyLWcdRyEYpdPoqjSLMhUl9fyUduLbIFQhIjPWL4uHwngto2/kpyu/uPfGbElJOuZppz
         tiGwznL+3ziDriTAfG30jnGuDXGQHpQ0ePD4Qkr/hbbbfiXxYT/+8qh/FMiM1SfrW1kF
         QnvE02yiXQlHkfZ4jjl7WKmZpWCvfvf9kttJeS1OFrHLtcg5wFXZ3LgoCW5PWjKkxTRl
         yEVw==
X-Gm-Message-State: AOJu0YxYvoi4kj9zsABOZksJVjskgrVuVtm7sLSzVwHCBTjoiyWCmEgq
	F8cfa7uHpyNzWrKiMDvkzY80Uj1iTGqWy26YypShRL/3g1aAmne8NN6ndQ==
X-Gm-Gg: ASbGncsW0mLZHToMsghrpiKX09BlyMLxIk94H8neS9irjMEBuHZbXYulFX6WHbfhxlR
	M4cvdo2g5+Ck+K++DsOt+ksxGT04B1vUSmYMxx4Q6AWglv+eCQbajhKSbINVPdTysq3EgEeScCw
	taDAQsX2fUsb6lj+6Jsb4LQz28UyEMlyA1kqhDmDRNps1x4IRKk6NKpx19BEFzZyfLY/H4Z/Qhi
	SDMrCqj7ly484qqSqy2cyrDsKy+AiwkjfPMTsjFxvOvUmStu95cbJGSF2RxSPM1gcJKBMzKLtgi
	YpH9GsHysne1kwW9p04ycr5WsY2XsBuTyL91geLrmsrKc0tX6c9x
X-Google-Smtp-Source: AGHT+IHFZW5ODayMNvEzwSmAuwbW+3M5g26Dz+Ytyd9AXZK7i92HJhseqHJwoJD1PcHdHez9nfLigA==
X-Received: by 2002:a05:6000:220e:b0:3a0:7a8f:db22 with SMTP id ffacd0b85a97d-3a0b4a2368emr1159358f8f.24.1746585208285;
        Tue, 06 May 2025 19:33:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099b0ffbfsm15109958f8f.80.2025.05.06.19.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 19:33:27 -0700 (PDT)
Message-Id: <a9cbca6bed308f2b563eca5d7707c6bc30aa4603.1746585203.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1954.git.git.1746585203.gitgitgadget@gmail.com>
References: <pull.1954.git.git.1746585203.gitgitgadget@gmail.com>
From: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 07 May 2025 02:33:23 +0000
Subject: [PATCH 3/3] fix: use strvec_push_wrapper to prevent ubsan failure
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
Cc: Lidong Yan <502024330056@smail.nju.edu.cn>,
    Lidong Yan <502024330056@smail.nju.edu.cn>

From: Lidong Yan <502024330056@smail.nju.edu.cn>

Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
---
 t/helper/test-free-unknown-options.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/t/helper/test-free-unknown-options.c b/t/helper/test-free-unknown-options.c
index 59d732da23ca..7369dfe379d6 100644
--- a/t/helper/test-free-unknown-options.c
+++ b/t/helper/test-free-unknown-options.c
@@ -8,6 +8,12 @@ static const char *const free_unknown_options_usage[] = {
 	"test-tool free-unknown-options", NULL
 };
 
+static char *strvec_push_wrapper(void *value, const char *str)
+{
+	struct strvec *sv = value;
+	return (char *)strvec_push(sv, str);
+}
+
 int cmd__free_unknown_options(int argc, const char **argv)
 {
 	struct strvec *unknown_opts = xmalloc(sizeof(struct strvec));
@@ -17,7 +23,7 @@ int cmd__free_unknown_options(int argc, const char **argv)
 	struct option options[] = {
 		OPT_BOOL('a', "test-a", &a, N_("option a, only for test use")),
 		OPT_BOOL('b', "test-b", &b, N_("option b, only for test use")),
-		OPT_UNKNOWN(unknown_opts, (parse_opt_strdup_fn *)&strvec_push),
+		OPT_UNKNOWN(unknown_opts, strvec_push_wrapper),
 	};
 
 	strvec_init(unknown_opts);
-- 
gitgitgadget
