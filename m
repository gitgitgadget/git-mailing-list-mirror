Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76933D62
	for <git@vger.kernel.org>; Fri,  2 Feb 2024 00:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706833118; cv=none; b=GbxE+tHOJIWkegolEJq9icsDYqinxQnshm5mFqF/Zo7KaK0R+nl07v2mdqIuj9znoGQGqL/2B+1bq6bJac9p8yb+2VIKa1Jm7IlviQcauAd4Nx4nH6tKZLCd22CWwg3vjqUOGyAawbQ2gMB9jaKAnsrZR2qFBzjdTriMhgt4/Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706833118; c=relaxed/simple;
	bh=BvCbM0bLHPQyaud67nTGRGqpnOu2seS4NRaCYZJeR6A=;
	h=Message-ID:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=lbuqhEPZKlyV9Yj8PFLOnpen31Qmqhq+Fe2mmwG9Wp8+vlqAtF5JgsCBv+A9yKNbx2WbtUVvfpSHat/VdmUrujVo7oiw45NkMFDA0TeDrobvpYZXJ59Vr030arcvlsyN3EwEFX9bmV/zXq8mtbvCtvOJj6OMVQqtNYghfHxuFkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Re9hmeL9; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Re9hmeL9"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33b029a1c8aso1410233f8f.1
        for <git@vger.kernel.org>; Thu, 01 Feb 2024 16:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706833115; x=1707437915; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BG7cuu0kKLks0dl69VkOWmnpKxCJEULZX2CNdclc1qI=;
        b=Re9hmeL9sgGerrGlbCxWgwMPmHTOCy0SrpAzwTVbu8ranui7Yv4y1nKAIMETDEcE7m
         uvfsPtLWjulplT91WWGJqp2NYyfBqMeosb0bauJw7P5PRFza/PNtVid+ikNqzf5BfqDY
         6RamNkGrhmE76lS1sqghl9ZdwHbwfly3E79zSl01pUfuvvoAqr0XdZ4riLypRrxEWLkg
         s8V+SFcOua4XEWQvk5ReaGqoiX9zn7MLoJ+JFagO41Q7cA62jaK94zf19WkpW/zdsank
         8DB9Ub7N10bgk/Ji39SJAo0lgZtPqnFtVsgIxeIvD7DBwlyDxBYM0lamw4hlKczxU51w
         Jquw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706833115; x=1707437915;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BG7cuu0kKLks0dl69VkOWmnpKxCJEULZX2CNdclc1qI=;
        b=BL6gLxRIyGTswImaeeZ3mhTzyErUIYjiWuyn31R1siIJJ7fWuzzZ7ao5IzEyQSeDlj
         k52f7s7urh2CBQS5MvtwOcqPaIxgnlG+icoD10Tp0wm35a0tGYWd0sMjDIWob8fR6oRi
         f7W50TaH5v5HnoWvTpIfAwK3yR4eQk5A7frhplBlQY8ZfJmQhJ1iLobu4kfPyDC/x3uF
         FiF3l9/Ag+YNEvE38H2W5XzHrfnJABlE2Ztgc4GdLzQUm08OPmbHI3iVUrDsTGWSzJre
         rsei1EjXBrjLLQxgm47UPsDAtETq8VDN5aJpJ+Mjlm/keKDEd62FRoDkn1/LiG2Hgkkj
         X/ig==
X-Gm-Message-State: AOJu0Yye8dA8l0gKyXiS1EpnyA9tLwQ5cAl6MfsGP7xZiTAEk4MNgitw
	FAh6TfTFQ1WJNVDdB5UOHvcJ/fFiIl7KZKsk+hW9nagX9FCcoKTiKqaH0kn3
X-Google-Smtp-Source: AGHT+IFIyuKfSEo95w13zgFq4atilAu9WzlLrwMxU7ymbdKiS9umbp5UjxmtWLjO6A2TRc4vzwZ6UQ==
X-Received: by 2002:a5d:570c:0:b0:33a:edc0:d491 with SMTP id a12-20020a5d570c000000b0033aedc0d491mr422925wrv.20.1706833114599;
        Thu, 01 Feb 2024 16:18:34 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWIf+lS7zQIa1/nC2YoPApk71u28gwK8shHQKDdZkjtdu3n209kB5DDp8d8j9lzFgNfPGfxYUW//Qn2p8Sb7j/pAWaRGCRmQwGOC/Yfsqr39PX5o/FXjvxC5a+ZWQrtHRlAvfSuk6cD7sHVIaVs
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y4-20020a056000108400b0033ae593e830sm620836wrw.23.2024.02.01.16.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 16:18:34 -0800 (PST)
Message-ID: <pull.1664.git.git.1706833113569.gitgitgadget@gmail.com>
From: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 02 Feb 2024 00:18:33 +0000
Subject: [PATCH] imap-send: add missing "strbuf.h" include under NO_CURL
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
Cc: Elijah Newren <newren@gmail.com>,
    Christian Hesse <mail@eworm.de>,
    Taylor Blau <me@ttaylorr.com>,
    Philippe Blain <levraiphilippeblain@gmail.com>,
    Philippe Blain <levraiphilippeblain@gmail.com>

From: Philippe Blain <levraiphilippeblain@gmail.com>

Building with NO_CURL is currently broken since imap-send.c uses things
defined in "strbuf.h" wihtout including it.

The inclusion of that header was removed in eea0e59ffb (treewide: remove
unnecessary includes in source files, 2023-12-23), which failed to
notice that "strbuf.h" was transitively included in imap-send.c via
"http.h", but only if USE_CURL_FOR_IMAP_SEND is defined. Add back the
missing include. Note that it was explicitely added in 3307f7dde2
(imap-send: include strbuf.h, 2023-05-17) after a similar breakage in
ba3d1c73da (treewide: remove unnecessary cache.h includes, 2023-02-24) -
see the thread starting at [1].

It can be verified by inspection that this is the only case where a
header we include is dependent on a Makefile knob in the files modified
in eea0e59ffb.

[1] https://lore.kernel.org/git/20230517070632.71884-1-list@eworm.de/

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
    imap-send: add missing "strbuf.h" include under NO_CURL

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1664%2Fphil-blain%2Fimap-send-include-no-openssl-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1664/phil-blain/imap-send-include-no-openssl-v1
Pull-Request: https://github.com/git/git/pull/1664

 imap-send.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/imap-send.c b/imap-send.c
index d662811ee83..f2e1947e638 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -28,6 +28,7 @@
 #include "run-command.h"
 #include "parse-options.h"
 #include "setup.h"
+#include "strbuf.h"
 #if defined(NO_OPENSSL) && !defined(HAVE_OPENSSL_CSPRNG)
 typedef void *SSL;
 #endif

base-commit: bc7ee2e5e16f0d1e710ef8fab3db59ab11f2bbe7
-- 
gitgitgadget
