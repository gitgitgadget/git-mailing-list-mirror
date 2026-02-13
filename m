Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EFE26FD9A
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 17:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771002514; cv=none; b=qAfzHjvQ0cl2PXwHGpDNlqreq4qfOJsF4LG14pab5lcHxKHkgA9AgpCxVudzEj5+Z9fIS0gSfnrsMK70845Av9xCAivwqMbOI+VTXhqsirZKvZOapmXZ+2wRzwFTiONX0nYctDSOFt3ma7lERrfJXo73YdSVOwVHvxyZem3wvzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771002514; c=relaxed/simple;
	bh=ElWEf6vxEvx11om9F+FJqn0R6jzN2E3I4EwKtd4qAkw=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=lq/bW7m2PzDnJGuPr4S52X43TEBgWM1SDS+Y+d6Xvn0r2hwrIewuYf7q/JaFIitrM5ac7QPia/o9yiw1aW0//mZR5IEmSrf+HR22SgNBtuVwM2JN7wLr+GF5O+tSE0Gl7sEnYc5qsszYrrq9NX6eVlZI0ioVnm9d++YiaTOJmYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MdGjPP7l; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdGjPP7l"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-126ea4b77adso1534553c88.1
        for <git@vger.kernel.org>; Fri, 13 Feb 2026 09:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771002512; x=1771607312; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+eMJWeNPgWzLR/QidOXj+iulPexpzc+9A+gMao92/3s=;
        b=MdGjPP7lXN8DVKsUVHyjnlAjEBp/jtx0J2i2sgl5L68xLoca/RMi/P3joY22YSB6ab
         5jxsqg+QTN/UKxIGBRs9REJ8mtyaj9wLa8F+98yKIgizgsLYipgrwrOuIpJif3a0RkoV
         gVkziS+IJPbdGv2uvGhq7fFwAW7HQrizhDweSiSpAw5QJLRuWPN4EPJSIIgy/4CpaWsb
         7G4J/4fCUGUtRL02m6Te56zoo9SYkcWScvvcB5GYNSvDYL8Nqooe/ybmgl84dIaoXPEw
         GwDNoqey05GmofB7JJObcZ+RfjA8RmELmhFEDadOWFIKWhGwFu2J1Z5RuoavmB3Vrav8
         Je1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771002512; x=1771607312;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+eMJWeNPgWzLR/QidOXj+iulPexpzc+9A+gMao92/3s=;
        b=GRkfXSOoH77VaPHICwOgFn3pQq79ojZBzc3iIzqdFVQyZAHiWJM5dCyHlhgFkXDQrZ
         3RuVPLKkV3VS0csqGA5YFmKiyB6sE2C5PofNpnYdRxI8fc0+ypf6xQ9icrXRemhDkzG6
         fBk2w7aLynlrCXsm1/XanzAZeu3RYCx1wgskb5Tm64UeQ63jIPqDZc3AeHn1an1rZP3h
         9s1Ds/HasgdPcs8CluXJio9SmscDAMGmbJD9FJ0cwEI/WO6rPxtmW7BIlsfAoreqtBvF
         DqMB4MJo8sMCUM5tL5vWHqpO7EljKFCVTXi2dZ/hzfRQSvZe43TYfw6TE1PwyHmkixd8
         sKZg==
X-Gm-Message-State: AOJu0YyVeF6tjihcGOq0DFtZxYpphLR9nra1paBQodnbW7F/CMxkcX9i
	dfQlCpE+XzrRgH6ZzvgIa2MEePXkl7WT7XjBUOLRemKwnf+zZJDIpg1PeLvIYw==
X-Gm-Gg: AZuq6aIttm0RFROk4F5tzhybzMovy0649pBIbIrzAjb6Q8jT1fQxxOhr5pFNGhJhM9d
	/rspf0+XcHJjepUEgfkRj6cOLTXSdMNRZokF2YrNNy8xkjSsXkUJXk565bF5qub6xQo3+mXxJcQ
	LzSHrKSJubreaHk3kSOnLRBuZWdfsRYBuxtkNT0hv1SVGiz/0RzPXHYT2ki+UCPN0Xd2bK0gwhH
	3iWClfc9s9VybrSiUNS3ZyzJPM68j0bxSvxPNDYEvPHs4cGjZcF1ZioUMTSWGMDxzV7EpQaaFpO
	XJZBO7I1v9BPi+i5mjIiZAyWldjPNK0eqxjk/mgakwYgPhvdlFhYrv1jvwe42JarjUh9Et1tVdl
	6HOUY1SkuFGxL9zJr42q1nu/kYCPwoBhqAoyWREl8G9tMoqMdxzjlksKxcf0kQftPR7YPydWd+H
	VlEQ/mAQn84JkOcMXJ20WU9wNfWDI=
X-Received: by 2002:a05:7022:b9a:b0:11b:82b8:40ae with SMTP id a92af1059eb24-127397b4a8fmr1469635c88.18.1771002512130;
        Fri, 13 Feb 2026 09:08:32 -0800 (PST)
Received: from [127.0.0.1] ([172.184.191.166])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1272a6f3279sm6335118c88.13.2026.02.13.09.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 09:08:31 -0800 (PST)
Message-Id: <pull.2198.git.git.1771002510709.gitgitgadget@gmail.com>
From: "Joaquim Rocha via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 13 Feb 2026 17:08:30 +0000
Subject: [PATCH] apply: strip ./ prefix from --directory argument
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
Cc: Joaquim Rocha <me@joaquimrocha.com>,
    Joaquim Rocha <joaquim@amutable.com>

From: Joaquim Rocha <joaquim@amutable.com>

When passing a relative path like --directory=./some/sub, the leading
"./" caused apply to prepend it literally to patch filenames, resulting
in an error (invalid path).

Since using "./" is almost memory muscle for many, strip the "./"
prefix so it behaves the same as --directory=some/sub.

Signed-off-by: Joaquim Rocha <joaquim@amutable.com>
---
    apply: strip ./ prefix from --directory argument

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2198%2Fjoaquimrocha%2Fapply-directory-dot-slash-prefix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2198/joaquimrocha/apply-directory-dot-slash-prefix-v1
Pull-Request: https://github.com/git/git/pull/2198

 apply.c               | 4 ++++
 t/t4128-apply-root.sh | 9 +++++++++
 2 files changed, 13 insertions(+)

diff --git a/apply.c b/apply.c
index 3de4aa4d2e..a44c54077c 100644
--- a/apply.c
+++ b/apply.c
@@ -5001,6 +5001,10 @@ static int apply_option_parse_directory(const struct option *opt,
 	BUG_ON_OPT_NEG(unset);
 
 	strbuf_reset(&state->root);
+
+	if (starts_with(arg, "./"))
+		arg += 2;
+
 	strbuf_addstr(&state->root, arg);
 	strbuf_complete(&state->root, '/');
 	return 0;
diff --git a/t/t4128-apply-root.sh b/t/t4128-apply-root.sh
index f6db5a79dd..2f446a4d69 100755
--- a/t/t4128-apply-root.sh
+++ b/t/t4128-apply-root.sh
@@ -43,6 +43,15 @@ test_expect_success 'apply --directory -p (2) ' '
 
 '
 
+test_expect_success 'apply --directory (./ prefix)' '
+	git reset --hard initial &&
+	git apply --directory=./some/sub -p3 --index patch &&
+	echo Bello >expect &&
+	git show :some/sub/dir/file >actual &&
+	test_cmp expect actual &&
+	test_cmp expect some/sub/dir/file
+'
+
 cat > patch << EOF
 diff --git a/newfile b/newfile
 new file mode 100644

base-commit: 6fcee4785280a08e7f271bd015a4dc33753e2886
-- 
gitgitgadget
