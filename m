Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF3836135
	for <git@vger.kernel.org>; Sun, 21 Jan 2024 04:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705810079; cv=none; b=oh4Al14gHs1Vf5KJSaIe7eOOj0Dh/2GErOVae/k3TeR9R9pE47Ma1DDCSKBux79KPK26YEWdHeixJboB7MKy/FayNuwrhr+fjOrWFZhfXj+oIjqKGiBmC5NXOnfcbvrsjngcWywYn2F29+bc2WIm59G/jbW0eGnjgnF9xQ+/Fr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705810079; c=relaxed/simple;
	bh=ykZnB+rLRdzE4Gms4J7aWNmERok45jWOsCYCFyWAlPg=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=OOto9zbuMQ6F0cB1f6XKFW7cNLTnYA0cS7yrtU4qZeNz1Dxhr4qPektM2jlTFNUlblQrykfiPeQVmBLiwfAogtC2LZ0aemjdAYL3BCBl+6bKcwwKEoVdzarIRQ9UAg4ecfWWxRfCfAxgSSlEHqVMDKU7Nbw2PbuYXH4Z9bm/JZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NyjJm5rx; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NyjJm5rx"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-339289fead2so936192f8f.3
        for <git@vger.kernel.org>; Sat, 20 Jan 2024 20:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705810076; x=1706414876; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Za5F1RY1A6lgmGl2PxagnObnp5gp3HUK6EBKLBB7jc0=;
        b=NyjJm5rxTfC7ZmWHuYhXHicxXQ5slH0Tk5DG8rFWK/86Te1pLmiURlmg9mcfrx5IfR
         WlCUXQLvZZOGafuyci1wjK4Dao72CUPJGV9lNJPiBunabtD/gR1PW6biEGeNyLnCYs0Y
         qYx8zH9T2FXX90Mv+RykrodpIbj746rkDRk67TyMAj0bYZw3OiCdXeqk2BEqaUgq7mGk
         T64QTF2ofhtllW8/I8AC2P6QPS3JzpfQjxM25NIj4Tp1nunuiB3xLaB+al7+J8uFs9nZ
         m8jPdmph0dAGkgC5zM4fR+mwXlhBwQXt5jTjzhsersiGK96uqt4p/NuFY6DxrnxTOAEt
         nx8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705810076; x=1706414876;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Za5F1RY1A6lgmGl2PxagnObnp5gp3HUK6EBKLBB7jc0=;
        b=H2gpLGR/S9SqXjnlcj4IICSInP/x8vQvv4nnMvLf4RhcL4JKEXO6N6ToFA+KlYIMqZ
         bMd/Co+6WMZXdocF0pWNSlneKOux1hfAR8cm3GWjNnV9Zph1CxobB/QOeHBGknUKGAmG
         mf2RdijeshD4PwCLPtHGjPgbBNFvkI94/klrt1REymNgJWqg0WXV7R0qX3Om0lAWcpTb
         SPNGxzOipCFxvhdGU2PQyJt+vsKgdPQvdmMDKEX+9ecgTedB0dTaOUfsB40SepO79vyK
         tp84oHLF5EdEQe0b6HWrLHCiaulHq9cBmiz1kl/9bCQUdYMPr6CwOWF3c+wBzSTDI7Z+
         rv8A==
X-Gm-Message-State: AOJu0Yw7t+tU1aP92wXSw4YjPRp3LJP8DbqDscCk23BW6mNM8s40OSkc
	Ek5g3rjq2u890KteIlMvRirN1P8Q778a0RZqQCNRKzTG4AEe/fsrVCNvB158
X-Google-Smtp-Source: AGHT+IGR5td/NzCo587MPO/5V6KvAqJLiHQ790B04H6AbVMYtFA83tfkvBwQfD8zl9rJPAHhFG+saQ==
X-Received: by 2002:a5d:49cb:0:b0:332:eaa7:56b0 with SMTP id t11-20020a5d49cb000000b00332eaa756b0mr1132335wrs.14.1705810076384;
        Sat, 20 Jan 2024 20:07:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m4-20020a5d64a4000000b003392e05fb3esm961333wrp.24.2024.01.20.20.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jan 2024 20:07:55 -0800 (PST)
Message-ID: <9991dd4bfa6747dccc12c8a5d9fe8d6ed95fdb52.1705810072.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1650.git.git.1705810071.gitgitgadget@gmail.com>
References: <pull.1650.git.git.1705810071.gitgitgadget@gmail.com>
From: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 21 Jan 2024 04:07:51 +0000
Subject: [PATCH 4/4] completion: complete missing 'git log' options
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
Cc: Philippe Blain <levraiphilippeblain@gmail.com>,
    Philippe Blain <levraiphilippeblain@gmail.com>

From: Philippe Blain <levraiphilippeblain@gmail.com>

Some options specific to 'git log' are missing from the Bash completion
script. Add them to _git_log.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 contrib/completion/git-completion.bash | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index a7ae2cbe55b..2f1412d85ea 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2180,6 +2180,8 @@ _git_log ()
 			--no-walk --no-walk= --do-walk
 			--parents --children
 			--expand-tabs --expand-tabs= --no-expand-tabs
+			--clear-decorations --decorate-refs=
+			--decorate-refs-exclude=
 			$merge
 			$__git_diff_common_options
 			"
-- 
gitgitgadget
