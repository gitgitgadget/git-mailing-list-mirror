Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254E82D839C
	for <git@vger.kernel.org>; Sat,  2 May 2026 05:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777699735; cv=none; b=JR/ny/8Om7CeKsLmVKbHiwjuaK+2Bhb19YPZxaiNI4gBEpqw16MO2mbbyYZpwZY8EB1BdIHQhop9AfV741LfkujBy3BM9WUGSSVx327ujFglZr8um083ICFXFMLtLgKMJVAkCjgAQVNZ9XDPBZRM6v0JdFMirhyPG5mnRQrdaRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777699735; c=relaxed/simple;
	bh=LkGdUreL9Vaw63FpspvkprOIKWAIvC/JtmV4i6zHeRQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=gfjUib0nl2GwGuUHlJnLrlIdeiKZLrsJ1qxUyYjNJ65GaP8wcgSenVUi684l3stedcBQ9lUd3c8YY4L9gLRqLOlQu76SYxe/KTncLSw5b0/Xn84Pl+tcdG5LVuWresHsxkbbxR3r7EGRrnjMNHySPONBFFoVLGNPwOszxTDCj6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JcYn+XN/; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JcYn+XN/"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-50d6b9bca48so34153951cf.2
        for <git@vger.kernel.org>; Fri, 01 May 2026 22:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777699732; x=1778304532; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SxTuOFenopdaGsVedGOoozOJf0WWp21sJjG5eohJVt4=;
        b=JcYn+XN/e5mXCV2jfS3BBYYCjij8x2jycnvMzo88TrvTjeI2OySKNS8zlBSfqapzJS
         Rc2W4omr1elNhXj84H6SybThskPNTFN/MRsyjXFdj1jA+OW84byf1u84e7ImEKrmMRzG
         4BIBIPExD1rMdkrTHjRZqfYW+YhF/671dn8ighfs8+uEi2jY5tIxH756uVhVFe2Xl2FU
         ANWNdK+G3yDxQY0f32wlXMDEUM/VjSqGdE5uQwuxwI7utkGF5IXyyS4juBs1IhIOku/Y
         Z8JvTUoEoe1j+UWD58q85VVj15fzRc23Qv2cadrTpi/qOZNmngBSm7jJx6Q3mKfHRbYO
         5Y2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777699732; x=1778304532;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SxTuOFenopdaGsVedGOoozOJf0WWp21sJjG5eohJVt4=;
        b=OhiOA/bMBiEBmCQcxR0RFKJNcmVK+Q1DMi9a94HdvbhZmyKygfE8CJb/zMlRi5tHLr
         6yo5k+3ZF8UO31ZsHGTPWKBn/akgmil1VWePEJW91Vyup+tSOik8SMZJWkBJMXksZLNy
         RW5kdmnM6V9SzszyGEoRlZGYZO1YsNZDBI23aXc9/pBF75hzaS15/vifeUIPFchpATB6
         Gx3kNleorVawKPqQElS6ZxyfjCSXBDm0xcb3myRKXKAJjbzXiTionFNYL7732XfJv5Ue
         7a0ISVqmd9n4zQg1wOu2Bt0IF0FiluR860mRto/URO2lRYzRsDrg5rWo0206JeMZWE4v
         qqBQ==
X-Gm-Message-State: AOJu0Yy/QdR0DoW8O+VhczioL2QQZWFUtwy/SOaOu2TDrjJTiJw0KG77
	S8Rz5sebVxruyhXkrNmkMB/MQJY/aZ6ul47eAWaJ7pz4gluByugLgM/8ltadvQ==
X-Gm-Gg: AeBDiet3kmSxWFVX7lmCXCWwcpQ8KBlzjzZK6Tmcupmcr+YRAwm0NRS9iHY9LjjxPKF
	VqN0xrlxjetu+2vSATox8G6QDwaezk+qC1ASTSy4BIG9AhRWLvMIGbhLjjElSA5wfifmgzWCYb1
	C7NYwHqXLPCv5W20k8T94uBQ+u4pVg2bonYvHTQy79GznVQQv1+9/w5RWczcLS28nWeBieDr5ju
	OvzjuLZIqxkAl6lE/2hGUuzC3X8wuGH4A08bFyO7yFNn9CuhEmUd1TRHg/Vfdq/lsXsIzf+OYht
	1QOcKhgkMcqh8KVwZTaoyV33fJLSMxLZLnGbpiWtDIio2QGHyaTk8CBGXKfVReVWoGYv8CRUCYs
	jMOFGDWHglrmiZ4ZDe5MmWKANzrDtHIJolPL23Ckm6a2h340m2ymQCGCXj/1zMNxZoXoH3Zdavu
	oxViiuofIsu2WgzC8d/RwtaOJQOI/hBDJmWpDs5nY=
X-Received: by 2002:ac8:5d43:0:b0:50d:66b6:1564 with SMTP id d75a77b69052e-5104be2583emr30065531cf.14.1777699732390;
        Fri, 01 May 2026 22:28:52 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.224.103])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53c0e7f27sm56112146d6.32.2026.05.01.22.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 22:28:51 -0700 (PDT)
Message-Id: <2b32cb71a359b936095f41e7c482e8369ddac786.1777699722.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1715.v3.git.git.1777699722.gitgitgadget@gmail.com>
References: <pull.1715.v2.git.git.1777677310.gitgitgadget@gmail.com>
	<pull.1715.v3.git.git.1777699722.gitgitgadget@gmail.com>
From: "Matheus Afonso Martins Moreira via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 02 May 2026 05:28:41 +0000
Subject: [PATCH v3 7/8] doc: describe the url-parse builtin
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
Cc: Torsten =?UTF-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
    Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
    Matheus Moreira <matheus@matheusmoreira.com>,
    Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>

From: Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>

The new url-parse builtin validates git URLs
and optionally extracts their components.

Helped-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Signed-off-by: Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>
---
 Documentation/git-url-parse.adoc | 80 ++++++++++++++++++++++++++++++++
 Documentation/meson.build        |  1 +
 2 files changed, 81 insertions(+)
 create mode 100644 Documentation/git-url-parse.adoc

diff --git a/Documentation/git-url-parse.adoc b/Documentation/git-url-parse.adoc
new file mode 100644
index 0000000000..9d0d93da4a
--- /dev/null
+++ b/Documentation/git-url-parse.adoc
@@ -0,0 +1,80 @@
+git-url-parse(1)
+================
+
+NAME
+----
+git-url-parse - Parse and extract git URL components
+
+SYNOPSIS
+--------
+[synopsis]
+git url-parse [-c <component>] [--] <url>...
+
+DESCRIPTION
+-----------
+
+Git supports many ways to specify URLs, some of them non-standard.
+For example, git supports the scp style [user@]host:[path] format.
+This command eases interoperability with git URLs by enabling the
+parsing and extraction of the components of all git URLs.
+
+Any syntactically valid URL is parsed, even if the scheme is not one
+git supports for fetching or pushing.
+
+OPTIONS
+-------
+
+`-c <component>`::
+`--component <component>`::
+	Extract the _<component>_ component from the given Git URLs.
+	_<component>_ can be one of:
+	`scheme`, `user`, `password`, `host`, `port`, `path`.
+
+OUTPUT
+------
+
+When `--component` is given, the requested component of each URL
+is printed on its own line, in the order the URLs were given. If
+the URL has no such component (for example, a port in a URL that
+does not specify one), an empty line is printed in its place.
+
+When `--component` is not given, no output is produced. The exit
+status is zero if every URL parses successfully and non-zero
+otherwise, allowing the command to be used purely as a validator.
+
+EXAMPLES
+--------
+
+* Print the host name:
++
+------------
+$ git url-parse --component host https://example.com/user/repo
+example.com
+------------
+
+* Print the path:
++
+------------
+$ git url-parse --component path https://example.com/user/repo
+/user/repo
+$ git url-parse --component path example.com:~user/repo
+~user/repo
+$ git url-parse --component path example.com:user/repo
+/user/repo
+------------
+
+* Validate URLs without outputting anything:
++
+------------
+$ git url-parse https://example.com/user/repo example.com:~user/repo
+------------
+
+SEE ALSO
+--------
+linkgit:git-clone[1],
+linkgit:git-fetch[1],
+linkgit:git-config[1]
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Documentation/meson.build b/Documentation/meson.build
index d6365b888b..32c8606a80 100644
--- a/Documentation/meson.build
+++ b/Documentation/meson.build
@@ -155,6 +155,7 @@ manpages = {
   'git-update-server-info.adoc' : 1,
   'git-upload-archive.adoc' : 1,
   'git-upload-pack.adoc' : 1,
+  'git-url-parse.adoc' : 1,
   'git-var.adoc' : 1,
   'git-verify-commit.adoc' : 1,
   'git-verify-pack.adoc' : 1,
-- 
gitgitgadget

