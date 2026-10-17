Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AA02AD0C
	for <git@vger.kernel.org>; Sat, 17 Oct 2026 06:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792219245; cv=none; b=lFmj0rKLVdw/9HbitmUhRmXNksBSgkjwMV9y0O+HC5Z4qCdSxVhCMiCmHpP/cRN8q1epMH9oLuxG+3e/JGpxNFOQeRo/YWsY10pHnahQ/SaWlMOJyT1oKBFS25RkacDhrqHOg1X2otIldJ1fvm3x11tBWBlpDdBqvmzv0qx1pUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792219245; c=relaxed/simple;
	bh=Fa6ENnsj4BevhocNgyqGxO7Mipu3NGEvrEujAAnB4ws=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=goPLqyFHUX2HLt3TD4i0+yN7ndSPKUYerHLhU9L8NY0rJEBkWqYO6pQdNAEs8cIkWhEtxpf9mLbn7EShAYq4pje8/8g9fsK/ZOYuhu4JONlaEyCfBxPVg5g3Io/+E6r1DDeScHNQuT0HuaCfT5quo1g0+lLlhdBwEqdtpsdl8LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZqUN0EcD; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqUN0EcD"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-53648215f9dso3356961cf.2
        for <git@vger.kernel.org>; Fri, 16 Oct 2026 23:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792219243; x=1792824043; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=m1WPQrQLzlW8Stcgb0aVPSVP/Cblhar/0XFkMnUQLn4=;
        b=ZqUN0EcD3A0PVBPNRrROk5nYARU9gVqemBeabcpn8B/+PDuvimCqP0JqImBlkuhkcF
         D2kbckeEFtsbiBCNSWT5eIR8JiRSlJlJgJMKZClyEpY41G8VnlZFZiEBr+WKoXiUomWp
         VaTWfehcPTBcEn1ePNwuWvtaOCxfGdtcOPpTvLH1xwtWBoYkeao1TTzigZOUOysV8Gg4
         IU3uhbgke+EF7RVEoQ0UqqcCBOraV0LvyEbTHRQ7B71adfNv5I3XELmiThKalZdqsFzS
         44Omu5EfuQqBTybJ4pJkZhmCgRI91C3HQQLrIa60Ra2Eo8zXm2dBreZHH+i6KseL3+66
         ETyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792219243; x=1792824043;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=m1WPQrQLzlW8Stcgb0aVPSVP/Cblhar/0XFkMnUQLn4=;
        b=Fk/5NL6WtP6YhYR0zdN7J2Iq1GkMA8Z4fbGWyVtFNEnOF8Y9G9LGzlSwmRBsrhZstg
         Zly08ajwbQVJZmfn2OEIyTfo3hksNe6Ep85l+nPHHV1NkjOVklUi1q7aIO7fCMfyqbTX
         mJvQr92PFjrEmzJeLalJRBIECC6O+tsyDdyTDainjvNMgme99JflwwVN7pqp8dFaPjat
         Ow109XeiMe7DqckbwvwkjvqHttMcpx3RNRy/gsA+CI6lAFzunzTUIgfyvJBQF/ELl3qv
         cZxIhXd9gbfwxvM5zauL64Twx+gYuRRFEvfKzQ8ZbvfG4kbyIgQ1QdVo9CgLuWPFv6Hg
         ck0A==
X-Gm-Message-State: AFq9FYLmteBUqrKnx+8vvGTMS4sQ6iCTFTHNusycU9iIFvBR5nWhch9R
	0jPIutIGvCLkPhYILfPmXVtI01ZY/wanI8kb5mNcO8iM86R5EMvMXsJRh/QTP6Iv
X-Gm-Gg: AYBFou0IOqbmcihe0FrjvbC7U/ebHsF3a5LGNdaTyAC/mVKwr0t7cTKtNc60AgJ/fBK
	Vo+3M5rnDDoXU0cAc7LzS8Om8AaiE8w+4PKqPoprKAH/jAjWnk8V+0SAVA47USHAK+Yg4T8W8jB
	/tiR0PlDIuYOb/mG2EEem4lgMemOsOWebKygmg7NCPILH7Fp4EcudqOhj7HBTamSa4XxwTQfjSZ
	Lx0fQ7NOco9cDyLloAidnMUDDDCG/e6cOVJsf/t/atl6wilK9N9fvSWgSjOpwG0UYIs+OXdbI77
	Tmp+vArtzPKzuCNYHv2w5uY9ywgDSAQHSv09jpqN8nkX2LGISY70NTWGJYp7YcG+03M3uxinalN
	9KNoONecpqDO4dI1Yi9n0xI5eN9ruPBrUMw1k5FeoYjPlbov1vCHp0w30olPSrLb9V9bDRwFRjp
	7Cim9RpLu98WaI9fi+6BX2wM6tjThpcPQIbAnBgN97+Z4uuMdMKKOHDTfh1f2phYfeE17Pia2Uv
	/jP
X-Received: by 2002:ac8:5707:0:b0:536:4221:e3bb with SMTP id d75a77b69052e-53645fa9996mr26887341cf.21.1792219242706;
        Fri, 16 Oct 2026 23:40:42 -0700 (PDT)
Received: from [127.0.0.1] ([172.203.254.212])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5363455e7b0sm31817321cf.11.2026.10.16.23.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 23:40:40 -0700 (PDT)
Message-Id: <pull.2447.git.git.1792219239440.gitgitgadget@gmail.com>
From: "Ammaar Bakshi via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 17 Oct 2026 06:40:39 +0000
Subject: [PATCH] difftool: translate "combined diff formats" error message
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
Cc: Ammaar Bakshi <the.ammaar.ic@gmail.com>,
    AMMAAR-IC <the.ammaar.ic@gmail.com>

From: AMMAAR-IC <the.ammaar.ic@gmail.com>

The error shown when "git difftool --dir-diff" is given a combined
diff format ('-c' or '--cc') is wrapped in N_(), which only marks the
string for extraction by xgettext and does nothing at runtime. As the
string is passed straight to die(), users always see it in English,
even though it already has translations in the po files.

Use _() instead, and adjust the indentation of the continuation lines
to match.

Signed-off-by: AMMAAR-IC <the.ammaar.ic@gmail.com>
---
    difftool: translate "combined diff formats" error message

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2447%2FAmmaarBakshi%2Fdifftool-i18n-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2447/AmmaarBakshi/difftool-i18n-v1
Pull-Request: https://github.com/git/git/pull/2447

 builtin/difftool.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index bc7b2ea443..13b3d3ce47 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -450,9 +450,9 @@ static int run_dir_diff(struct repository *repo,
 		const char *src_path, *dst_path;
 
 		if (starts_with(info.buf, "::"))
-			die(N_("combined diff formats ('-c' and '--cc') are "
-			       "not supported in\n"
-			       "directory diff mode ('-d' and '--dir-diff')."));
+			die(_("combined diff formats ('-c' and '--cc') are "
+			      "not supported in\n"
+			      "directory diff mode ('-d' and '--dir-diff')."));
 
 		if (parse_index_info(repo, info.buf, &lmode, &rmode, &loid, &roid, &status))
 			break;

base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
-- 
gitgitgadget
