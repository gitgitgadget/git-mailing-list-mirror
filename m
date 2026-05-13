Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B9A280CFB
	for <git@vger.kernel.org>; Wed, 13 May 2026 13:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778680729; cv=none; b=kGuyhW4flR0wnJCgGRr2nCLTTD7xeg9gzOJ3hODA/hAT78SbuCLkUul2QvER5gPU+j/r57gZrWvFqJapd5YirEuVSJFGElGM3qaBI+DP4D5NQs1kzkLmdNdsDs3/jfq/gejpxqL3dpRGlt+Y1zcIBXDsLEei/YeCkGTFD0SqZrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778680729; c=relaxed/simple;
	bh=k7c7U4IJZrR8ZoWRgMdD/bjNgnSOLUeTqS3MU97WFhg=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=asTFDOaNeK7Nj53+9q2mdedSAmKiHd0dc+Snw6hXSCUqJaBenB7J/rwTduOtAO3VmvNWGbXypMFLfTNqh7bhvzn2B3gVpNsF6t18hYpkfFaWayNcdytH24SO6lx6/2K0EHKNuTvPn7yRA1+nSOvfMbv84y575g3ZeQLOqIqvjmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p1dW7XCf; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p1dW7XCf"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51306c36c3eso62188971cf.0
        for <git@vger.kernel.org>; Wed, 13 May 2026 06:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778680727; x=1779285527; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ljDuBwxcJLUNdq8fbWC/Hdl3mzOCgwGaPIXFVMRwpy8=;
        b=p1dW7XCfnORrhBZOe299y13gZ4DzEzZ8d0Gnr97ucipru0xK0jT3zT4i1gsdx1bgDq
         9fLs+ZbtsphUf6pa7cHJO57Ifz3dkMA2D09hFIE3YJWcfh+KY4i2Ob9z1SsYKrva2FCo
         Lam/twBt82C6dGMHLc8YgLM/x0+CCmzDqQj4+66CL2pIEiifbVg7Ghe4QCOWknDcpNDi
         hlAsbcXzAiymsu2kt3pa18QpHxCXlPzo84yD/HnODIa7yxPKJ0zFklAHWDr8E41jGd8j
         KKUWbddOwyT4PkdQ/gBS5XY8fP/5LKmleB2DmmQs0J+xuQsnqIOU6gru2xFpjNyVGCtb
         SxBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778680727; x=1779285527;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ljDuBwxcJLUNdq8fbWC/Hdl3mzOCgwGaPIXFVMRwpy8=;
        b=NUv9txGOmxxUyurTZA6RGajW3IeYyxRL6lIgcNz0CFxVI2eeZdQd4aFR6e2IUMKH7z
         b4Z+/fGDxWxgfSg84+x2sflDfZz1mOHfCUfl6YZQA4fqZpj3MEKBfImwlFtS1LKq3vEG
         6S6kQWdx+J+NacuRkqUm5tj9WI/wRECLnmi1PenQ+Bsie+Rwq7fkEzQ6OWzQOOoADsHW
         xF8fB0IIF9i/wK41jVboB/bSRq5xaMB0hWBIaMkK33S7YriJ9utSV2Zau+qA4HtnWeui
         04ONjIDDQwPTNdvzGtK0NFZSvIPE73r98cZvnFhmbLCpqTHgGFioLyV6C7JEV8K/gK1k
         eBDg==
X-Gm-Message-State: AOJu0YwW10asAQbkpHVYI3bGol1uLkPFQACGxwnjMjVHWgyFvW3YPHDw
	rb3Lfpe4hw6W8QTUzMCLjY58qPwH7RsRrqqDj59yLHoO+t4PSDnVsD7qFoi+qA==
X-Gm-Gg: Acq92OFmTxbEz0b6rQkdqpVQEF7bqMpxImtivGGiKzzt8k0nwbDOhge1Wmgx/GTEbsk
	wNK/GY4Dr+7kV3cvBVQFx2wWqkOCzS88De8c4lKZ7V4Uw+ceQdoGSqEKLKE4sbhNYNMR2k8ZlNC
	LFkfttElgnsF6Z9wt6XPWjZrDo4VRuXqRqQ3dZo6fGjwBTDw8HoNcO/yCl3qD2MnalCh7fU5k0o
	qooFD3vaQUXQ/2sp20ubbqQMkYCrNdf6PCezs131aP8n/uSGHlsY18PfZ0WC5JuG1GNvLVroanq
	M0sqH/cg+tSDpfURsK/AMAsVIBTiIUizKiHxd45kOlnYVu/Cd1nQT76/tl0ypHf+W+7104hp6WO
	8l0cM594t73f67cIWIDQnDkKJ3yQE3w/AiTk3EEOXSW273p6Z2wYLgSLeUrMvRCxwX7XbdKzLOr
	MgJyaFr7bmpnjqkwf7LT4lijJ7Ag==
X-Received: by 2002:a05:622a:146:b0:50d:9174:cf27 with SMTP id d75a77b69052e-5162f4a88f0mr40111791cf.20.1778680726626;
        Wed, 13 May 2026 06:58:46 -0700 (PDT)
Received: from [127.0.0.1] ([4.227.135.147])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8bf3aed2920sm155322476d6.7.2026.05.13.06.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 06:58:46 -0700 (PDT)
Message-Id: <pull.2302.git.git.1778680725459.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 13 May 2026 13:58:45 +0000
Subject: [PATCH] config: suggest the correct form when key contains "="
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

When a user types "git config foo.bar=baz", git_config_parse_key()
rejects the key with "error: invalid key: foo.bar=baz" but gives no
indication of what the user should have written.  The mistake is a
common one for users who reach for INI-file syntax or for the
"--flag=value" convention used by other command-line tools.

Since "=" is never a valid character in a config key, treat its
presence as a strong signal of this specific mistake and follow the
error with a one-line suggestion in the "(did you mean ...)" style
used elsewhere in git, e.g.:

    $ git config pull.rebase=false
    error: invalid key: pull.rebase=false
      (did you mean "git config set pull.rebase false"?)

The hint is emitted only when the offending character is "="; other
invalid characters (newlines, "@", etc.) keep their existing error
unchanged.

Signed-off-by: Harald Nordgren <harald.nordgren@kostdoktorn.se>
---
    config: suggest the correct form when key contains "="

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2302%2FHaraldNordgren%2Fconfig-hint-equals-key-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2302/HaraldNordgren/config-hint-equals-key-v1
Pull-Request: https://github.com/git/git/pull/2302

 config.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/config.c b/config.c
index a1b92fe083..6e658d71d1 100644
--- a/config.c
+++ b/config.c
@@ -580,6 +580,10 @@ int git_config_parse_key(const char *key, char **store_key, size_t *baselen_)
 			if (!iskeychar(c) ||
 			    (i == baselen + 1 && !isalpha(c))) {
 				error(_("invalid key: %s"), key);
+				if (c == '=')
+					fprintf_ln(stderr,
+						   _("  (did you mean \"git config set %.*s %s\"?)"),
+						   (int)i, key, key + i + 1);
 				goto out_free_ret_1;
 			}
 			c = tolower(c);

base-commit: 59ff4886a579f4bc91e976fe18590b9ae02c7a08
-- 
gitgitgadget
