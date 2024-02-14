Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA41D30B
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 05:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707888707; cv=none; b=rxUpud4T1U5uqYlMg6OokS4Ptx9Dmo++EuOYz9W1QHj4MIaugMlEcx59rAq4jhQObD7L51wgvIhTt/+xFw6CEaSbAN9xTwxgftohq3dO0MYOEXo2PlUpNXuxjsSo5tL9rf4ZvbjW5aIvWFp4eiR2lo2s4XkHfExFz7eW+Gzbi0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707888707; c=relaxed/simple;
	bh=wdZ6EgeAjkZNrjuEEieY+k8oVACHrTs6n0DHOVDSYeE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BL5OyVj9cOT3Q+ZRxc6Vvzpq830Ly2k0fBgoKkCzLxyU9PPE871wwyppfKU+4Fhce/gd/t7sfQ25XBTg4S8RcYbsvSMEV2guzE0Zx11wHyxhs4N5LBp3pRawoWWtsrQLCsC54Sw3hpVSCFUrHzBm53NNXbUo2FXLr+4A/Nc/cTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L/+SZJOt; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/+SZJOt"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d746ce7d13so43891755ad.0
        for <git@vger.kernel.org>; Tue, 13 Feb 2024 21:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707888705; x=1708493505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g+aEfZK7HagOqA8W6H0NtNdddUQP+jWGG8COKf8AS4M=;
        b=L/+SZJOtH3awdSYPHLhovFy97XqxgutqnYyObHvoFrhqRQT0W7ByyVPNT61OXC94O6
         WbbLluYVqPUauS85gJ4ztHs8rex8WTGGMxY0HsgdZ0dwVCraMm4Ty7SFVkQrGc+VREHu
         U6cZiEYxHClHJstbksfyLB0h3XrsXEUM6wI9QWayJG39BaJOpcJ5axFKKy5dIPU9be2m
         vz5rbQryq/FlXd8Gw+DyLWisogLiL+xAvHNA1V1ROZf2o7Lcrn6cwBHJj5bmb9/S0Ajg
         ww2eNC6dWtkBFuAnd7rtHbP63L/EdlcnAoqxp1JX2aHUj0uXCKDolrTgrnnKdAu0kIHl
         Knqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707888705; x=1708493505;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g+aEfZK7HagOqA8W6H0NtNdddUQP+jWGG8COKf8AS4M=;
        b=XvBwSU4K0ZcCvlc01PCzqbAIZtwuPZbmAJ11hoNFHHSKGYAPCZqWir9EZedoil+W+Q
         dXTlVNZAsIHOjHBHdiPY46KakcGH760j3qi5R5O3Jfn5HRRj4uMVXXsmZcI2YJTE7Q5L
         5W4mjtRL8vav+xCM9olUfiqaa+AMc/cjX8SqIOT5Zm3GqJ6wWpqPjNuIEJ4MeGm7RbNg
         JGJ7cw1GylJxVIRv7ADUlrjLc6CcbcycE1nukxewnXDkkxGSnlwGDlMRDP4c5kaXVpuR
         iHBhSZL43XlmqdNKCavnZfnTV8Hu4BKYgSMB8F9d2idYpzGRJMuJD3rJWxB11jxJ96Wt
         71UA==
X-Gm-Message-State: AOJu0YyYYA7DIFKnB2UskdOFVHhrhliSF4ayx8NyEsDRPH5gEDCgTb5q
	dpvMMDdF9HLfKzm3Rxf+JZUZJ6bCxKVzrG1SaAlAbFa4GNMh70Z3QFnG5PsStIY=
X-Google-Smtp-Source: AGHT+IGPjjKAevMAX69yaoJbTesZxZzSxUEYJiJSk5vi9n4vxd46F7LDPcMYOxxuw/mZ3b9LZK5hHg==
X-Received: by 2002:a17:903:1110:b0:1da:1e60:f9fe with SMTP id n16-20020a170903111000b001da1e60f9femr2011774plh.54.1707888704851;
        Tue, 13 Feb 2024 21:31:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX6r7Ik1giF1wnW4QCHEQAn0JN7LEdlI37wETt8ZBfibxcOh0qC/i0IvEF46rFSWUUZohjSnMIyp6f2EOKh0GeIbfXbcLQwkFQQPVEay8rnR4OGUBoA6JbU55rT9mXN5L80CNdGRHaNbXsXIDqd9+bdfCkiSLl2UaihrURYEGVYs1ixl3XNRLSwD6JXJu1y+DO8nndey/R2PqW8HzgrfiwBzfUSAQPsGyYmP7IeodIJtJPVkTs8KmFpCLFfnWfX4WH8IyvVYAxjdVmG0UfPQRYa84pazy7V2NgeQv27MD7xCFg87HLXGwA3pCrH/fTow6O1VDB6MpCvoE4N+2lSpSIohgXGjap2j5I/HzTBcygF9qv+R8xjEoJCIuyJZeQgJZ4585Blk+v+vQMrRS5CdY3pz4jogpRPaOGkBKYaaxKRAcmuQeAXxGcX63dyD1nk+IqWDE+EEFqhtUhtYsEkjBHiiQmqim10+Q6Ri6j6rkpInNyHhpdj1MhRtnhmkJOZwS4/XsQwG0epPzENF4qVP+AOVDUoGiGBWWfQuWWTh/zsRaxKNSXQ2NlbXcWnZfNEOxlxCNIfwGOCXUeGxahYJKSgAQ8=
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id kh14-20020a170903064e00b001db5b39635dsm355940plb.277.2024.02.13.21.31.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Feb 2024 21:31:44 -0800 (PST)
From: Jiang Xin <worldhello.net@gmail.com>
To: Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>,
	Alexander Shopov <ash@kambanaria.org>,
	Jordi Mas <jmas@softcatala.org>,
	Ralf Thielow <ralf.thielow@gmail.com>,
	Jimmy Angelakos <vyruss@hellug.gr>,
	=?UTF-8?q?Christopher=20D=C3=ADaz?= <christopher.diaz.riv@gmail.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Alessandro Menti <alessandro.menti@alessandromenti.it>,
	Gwan-gyeong Mun <elongbug@gmail.com>,
	Arusekk <arek_koz@o2.pl>,
	Daniel Santos <dacs.git@brilhante.top>,
	Dimitriy Ryazantcev <DJm00n@mail.ru>,
	Peter Krefting <peter@softwolves.pp.se>,
	Emir SARI <bitigchi@me.com>,
	Arkadii Yakovets <ark@cho.red>,
	=?UTF-8?q?Tr=E1=BA=A7n=20Ng=E1=BB=8Dc=20Qu=C3=A2n?= <vnwildman@gmail.com>,
	Teng Long <dyroneteng@gmail.com>,
	Yi-Jyun Pan <pan93412@gmail.com>
Subject: [PATCH] diff: mark some diff parameters as placeholders
Date: Wed, 14 Feb 2024 13:31:40 +0800
Message-Id: <1e33662683b43e93889b4b3493a0edc2e3483920.1707888478.git.zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.32.0.rc3
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

Some l10n translators translated the parameters "files", "param1" and
"param2" in the following message:

    "synonym for --dirstat=files,param1,param2..."

Translating "param1" and "param2" is OK, but changing the parameter
"files" is wrong. The parameters that are not meant to be used verbatim
should be marked as placeholders, but the verbatim parameter not marked
as a placeholder should be left as is.

This change is a complement for commit 51e846e673 (doc: enforce
placeholders in documentation, 2023-12-25).

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index ccfa1fca0d..c256ef103e 100644
--- a/diff.c
+++ b/diff.c
@@ -5599,7 +5599,7 @@ struct option *add_diff_options(const struct option *opts,
 			       PARSE_OPT_NONEG | PARSE_OPT_NOARG,
 			       diff_opt_dirstat),
 		OPT_CALLBACK_F(0, "dirstat-by-file", options, N_("<param1,param2>..."),
-			       N_("synonym for --dirstat=files,param1,param2..."),
+			       N_("synonym for --dirstat=files,<param1>,<param2>..."),
 			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG,
 			       diff_opt_dirstat),
 		OPT_BIT_F(0, "check", &options->output_format,
-- 
2.44.0.rc0

