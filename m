Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9B93644CF
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 22:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784069334; cv=none; b=d3iZ9gxpyaDdnXte2adD7nR/1PboBj6uGpqlElEjLpq+1oeVA4kqSvXLyBlhla8m5d5VSYOuBOMmtsM5sc6pWxSKtrKn5B97TZnYkPKbah8aKCcEMhs9XhyCBWRqRv4uX6HWAHminqITfmQfFePQyl3N2cIsjzz0omdhCSuz3iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784069334; c=relaxed/simple;
	bh=hBcXB4/MZ2qiandxi0tb5lmXZyTUNl0HN3iRN+0u4o8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=HqRtdJ2Yb5NrYNqXJAHHnzVaOzRmg5nKC6IvYLiJzsb1HqG0Cz1Imkd8QK9Tes3ieBG+WukcNzgTrWGf8JWZQVtDch5hDA8Jb75rsED73LlvfxWCbpKvJuWSPjWPICRNLVIRzUTz8eTYjIRkC8nIfSxbdPKoCigwBc4GnaL8QaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hjwBCpPx; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjwBCpPx"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7e9dc546f40so42536a34.1
        for <git@vger.kernel.org>; Tue, 14 Jul 2026 15:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784069331; x=1784674131; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1lmKKOy9qNJlPi0r5GCaMfQJVRWGA7FF3QlA6yt/sNw=;
        b=hjwBCpPxTus4UWZtcVmuPdcGBd9RIV+H+YviBPAM38zG48poiZXrw25UB/ZQYlafqG
         KQsTDLzeaPih1jxEVls1cjm60OeH5rtoEa6RGSrUhk7IkDYf8lIM4zKiSMVUOfUwN7UD
         WquxZ9a2XzhdITBH/aj0Yszz3Nxaj8Sly78Vhuylgvi5QZEH534In6Y+nOHz5m9UplP/
         qzPN/aG75PfpcU+OsbQoLjzy1etFhsw95FjOLoWzl2dmwo7pblqUPvGAwHnH/11kXmks
         2XJk/6n+cy5tf/YE/7ZxADaRxn0RnTZMdYxM9ChxsStEFZPJd+rzTBI3hcaYVuDZTc2M
         vUlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784069331; x=1784674131;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1lmKKOy9qNJlPi0r5GCaMfQJVRWGA7FF3QlA6yt/sNw=;
        b=WoSA5wOSm/PWc3ZJK9zvK/JAQVihedGHqUQt2oJvihIKZh/VQz90iCkbSux4OQ8xbP
         J40NzUePH6GIY2DX3mCUzXTlkEZ2K5PlGgkwjM61Br3G72ahFsGygQfn4YeSAsFUEa51
         6f3EaGNBMz/2DQ5hsaFS5BWMMdXeS++WYxtOtX1TQ9lCue4Bj5DjAtyNHfamstcyQmXe
         AfHKg4NGVE1YTtnJnDu429ggCq7UFh9zPHiclkKsER8gfLWAh9PPXVjO1H1M3QOF3h7r
         3YZ79GYSor7Tpa+/OWQgXWWULE7pFcDbrcP8kes9/8l+BN+XApVPz/utvOn73Igu+q+M
         0REQ==
X-Gm-Message-State: AOJu0YxbO+kJaxB5hVofQwsVnTkuhBzpe7ScgsTkW86TwPqL23X9iMwg
	wKFKImAScnDnl0GZA0YumhY59A/UoCo0K2twuuX4uG3tmexIEIXbQofTXDppYg==
X-Gm-Gg: AfdE7ck434w5ypTn7GBAH6WSnAPqr2LRsTdQ8/tqaPWJ7Zwln8ewx01Z9nfCzJuzLZs
	OHUf+FF07+qdsMeENGmkk5FZy+rDk12vc00zKAmm3eTmBKP6aM7yOXD6nXHdSBWZGTzj9V30rUl
	4zZukum4mDa3Z/BlQiS81tmjLTq49WEjwHM3hZwuCiXe/FbwcipGjv9TBy64pEQdWrVAzxYReuV
	EaUTmFJCqTRD03QIdyIle9WJCr46tu+FtkSd0fc5Gfn5NlEwFwN7wfr5SdeA7H4LbLeEmsIOApf
	JfrU824Shke2f2QRppfZGgdVYl6GtMWUnl3iwck0m8PaKWsk0kT+bYDcDnlJ/cOxkasL0ra6taC
	wfwbjvJ2bZpe72wdWL0UqlMoNFpRhmb/e2KrKyAc01xjZ/aWZxRdEikcw2llW47ytOtse9wAlcK
	SEyGG+SrnMA5dSxwnJ
X-Received: by 2002:a05:6830:1044:b0:7e6:69f:d208 with SMTP id 46e09a7af769-7ebf25d32b7mr7686727a34.2.1784069331127;
        Tue, 14 Jul 2026 15:48:51 -0700 (PDT)
Received: from [127.0.0.1] ([52.173.178.217])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ec2183a28fsm7023631a34.24.2026.07.14.15.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 15:48:50 -0700 (PDT)
Message-Id: <0692704d45060a62579b50dd7a2f07da04f435c8.1784069325.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2179.git.1784069325.gitgitgadget@gmail.com>
References: <pull.2179.git.1784069325.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 14 Jul 2026 22:48:35 +0000
Subject: [PATCH 02/11] config: propagate launch_editor() failure in
 show_editor()
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

show_editor() calls launch_editor() to open the user's editor on
the configuration file, but discards the return value and
unconditionally returns 0 (success). When the editor fails to
launch (e.g., $EDITOR is not found, or the editor exits with a
nonzero status), the caller receives no indication that anything
went wrong.

This affects "git config edit" and "git config --edit": the
command silently succeeds even when the editor could not be
started. In contrast, other editor-launching paths in git (such
as "git commit" and "git rebase --edit-todo") properly propagate
editor failures and exit with an error.

Check the return value and propagate the failure by returning -1.
The two callers (cmd_config_edit at line 1315 and the legacy
cmd_config at line 1478) both propagate this return to
handle_builtin, which translates negative returns into an error
exit.

Pointed out by Coverity.

Assisted-by: Claude Opus 4.6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/config.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/builtin/config.c b/builtin/config.c
index 8d8ec0beea..1307fdb0d6 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -1313,7 +1313,10 @@ static int show_editor(struct config_location_options *opts)
 		else if (errno != EEXIST)
 			die_errno(_("cannot create configuration file %s"), config_file);
 	}
-	launch_editor(config_file, NULL, NULL);
+	if (launch_editor(config_file, NULL, NULL)) {
+		free(config_file);
+		return -1;
+	}
 	free(config_file);
 
 	return 0;
-- 
gitgitgadget

