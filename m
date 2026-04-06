Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D1C34D4CB
	for <git@vger.kernel.org>; Mon,  6 Apr 2026 18:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775500710; cv=none; b=Jd1sPC6SA2s8aFH21Hv/gBY8R9yEhoDmvxgTmXt4KlH95fjeVcv+YPuMnNUWD4/VZBHQur6J9NJ1PAytUpnRo1seVg/OFSLz53q77O66P8WNYTMSBItHQ7Sl1SIO4M/DVYGBCv2pNAEJHXadJ5Y+4AZa5KCRNLFHLbiuBpD6khg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775500710; c=relaxed/simple;
	bh=7zIplN2DQGpvxhG+n4AnS+wtD0ZrO/SIdHeENSXE/PU=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=UUmm+D3eWTDYCaKO1pJgz6ah/n2La0XRPyPMwG5POKDYEThGesdCIg5oz59mcGsB3qfai7ywX4Bm/q3T58UZ+gVmJG8IvfxCTh0xwYzbl0pf4QokCXjEzVH1FxZZAfX+SqvqbZfuuhKYEBE2UZ7PVec+mRh+ZbrALVZwlQ6HTs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ieVNmKmj; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ieVNmKmj"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-89fc349b5ceso71481416d6.3
        for <git@vger.kernel.org>; Mon, 06 Apr 2026 11:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775500708; x=1776105508; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CJIYOmDBqozbvQolI3rpKMQgX6P7rIX0+o0J+dBZa2Y=;
        b=ieVNmKmjelcg+snG/4433br5NDvX8uWIBRwufBHSv6YEc6G29RDVtl7l5TqUu5+hJC
         HpSCoaoyZRDlvLOpEO1V7bHHAI4HUqPrJkU0kGbkl6pxn9l+Cev8n6zNRxXsfMmo9q4r
         5V9EExg2munUigMaaEUKobAu5xtEFiKh4pilitj6Y/Hiwte1pr8Crb6v8EYu0bfwos96
         aTPaTYbSGIcJNKt3HPEwR8nV5eWha8G9FPokumWO5rrxNyb/udxdcRNhs8K927MYGjsM
         CQba21jKd0LsFYiSZFYnfz/M+kdJfX6CVQyt7jWo15oEQ91jffjBrV+8uTVZn1eietM+
         TIDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775500708; x=1776105508;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CJIYOmDBqozbvQolI3rpKMQgX6P7rIX0+o0J+dBZa2Y=;
        b=cXRtXBMTN5quXpSoLp9Dni8Og4/5VrrB77FQwC4zKc8CFiGnhPmYne2AU7KZCwe8Pu
         4lV7MG57lzW8OUnW6DebP7u/2VTKAx8qX1Wy+bhoXqUUt9kDHlqudGwCZHmdIPigKrG8
         wA7NbTR1SwkoaxLEQ6h63ww8W2zBx4MYm2E70dKbPxokxc5Q+kXdtQYp629MsHBILrjb
         hGNEdFPlkhYD6r9yBHKkXtuc7r/WD7YJFjnNzOdZcy02/pmKkA1+VjnNG0mnrrSCBVUa
         QGuFNkuUp5ZJGcu5xRVarK/oMdIQYG2BnbnTVbrgpI3QYodbiUL1w2XCma4P/hFS5zPg
         oZhA==
X-Gm-Message-State: AOJu0Yw5EI663+FMdOqvJxY9CfaTFWNPMVvJR05YDzvIrXDf7iO+jzjP
	zH9R4M7tpNulUajiYNYDdDXgwLm2Hxe2HgvTruHii8dfIrXFOyxAgtu82aTw1w==
X-Gm-Gg: AeBDiesj3JCT+77OEt3Uo7zak1si4xpq4jI/MDMd5TjBqzbnFPXVpdkdnEHYGDtrTLJ
	03LMOLWZqNe9QvDyyo0rCLdDSdirHE1XYh+sxYiqh75tOJALP0wJJC83UxsJewIBKUVX3QDrqG6
	NHTuZcb18Ef4rY28SMdM4OEYsF7v8QjPoW4JSktWlFbXfaItSZqu9W9tijMhMes+RB9PNgsIMy6
	w/Zed+7PPqIvAgYQ7FBQDOnjL8gikwpcwIIRawHPCcAXKH2JDDtvMOIrZ0s1W3Kyqseso1BQawL
	KKy0jamKSTQldF78SwXYbfAaYzrYE4K/J06c5tYOMLMctYVTMnrbisFfiEiLo/oHQcxgW5r8Cuv
	0zsc/VW2Ovqg2rNnHKUvJsqPqeNl8EzsIVA8136JN9U20N+Q6dNGkwaUeKf7j1bi9Mix9/Yb6NK
	1dszm4g9mnDCqBWBIwUSEaWJIS1F4/
X-Received: by 2002:a05:6214:600e:b0:89d:b093:936f with SMTP id 6a1803df08f44-8a70568c757mr209724196d6.52.1775500707983;
        Mon, 06 Apr 2026 11:38:27 -0700 (PDT)
Received: from [127.0.0.1] ([135.119.132.152])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a5979d92fbsm158554406d6.48.2026.04.06.11.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 11:38:27 -0700 (PDT)
Message-Id: <pull.2084.git.1775500706920.gitgitgadget@gmail.com>
From: "aubrey via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 06 Apr 2026 18:38:26 +0000
Subject: [PATCH] parse-options.c: display subcommands properly in check_typos
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
Cc: aubrey <aubyomori@gmail.com>,
    aubymori <aubyomori@gmail.com>

From: aubymori <aubyomori@gmail.com>

Before this, mistyping a subcommand with one dash (e.g. `git stash -list`)
would display a message telling the user to try it with two dashes.
Since subcommands are parsed with no dashes, this is incorrect and simply
results in the help message for that command being shown.

This commit changes check_typos to check the command type and display a
proper message for subcommands.

Signed-off-by: aubymori <aubyomori@gmail.com>
---
    parse-options.c: display subcommands properly in check_typos

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2084%2Faubymori%2Fmaster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2084/aubymori/master-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2084

 parse-options.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/parse-options.c b/parse-options.c
index a676da86f5..2c4530bb8c 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -633,7 +633,10 @@ static void check_typos(const char *arg, const struct option *options)
 		if (!options->long_name)
 			continue;
 		if (starts_with(options->long_name, arg)) {
-			error(_("did you mean `--%s` (with two dashes)?"), arg);
+			if (options->type == OPTION_SUBCOMMAND)
+				error(_("did you mean `%s` (with no dash)?"), arg);
+			else
+				error(_("did you mean `--%s` (with two dashes)?"), arg);
 			exit(129);
 		}
 	}

base-commit: 2855562ca6a9c6b0e7bc780b050c1e83c9fcfbd0
-- 
gitgitgadget
