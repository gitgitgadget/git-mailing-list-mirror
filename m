Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27DA2C433EF
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 06:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235838AbiBQGzM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 01:55:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235820AbiBQGzI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 01:55:08 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3DC27F295
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 22:54:54 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id x5so2389499wrg.13
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 22:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7YuP0Nx5zpadGi0XMIQi9hW1TFbpV+oEB6DRVtErdrw=;
        b=FV+jM2cQmf/sjbU1iKGULuGUBk5lhGuEdUdtq2Prry91my7axW7I+ZZ9iiya/MqQ+I
         cAohdOS04A2i6mi4JoDsemRdS+vx55M+ryH/UHJ+7r39vbMDyhxmPyxtx0HMWSp7CYEJ
         3JrLX1uPTbl6qIkHa8CS34o6PQdT95QD7d1fkgXyLufBquGPv5TqfbgijZVB5ogCJ+Cl
         BX38kfNo97fAxmA2cz/hbzOgVhV1YrZUGE3eKwW7gx13c66e7DRv9U7wK5Zy/hSCuEAw
         aVaEdObuh83BmBZZFqs6bINgZF+2nqCLEn3/+dpQXtBawxtgHFewayFhcZP4JnaaYvUA
         P+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7YuP0Nx5zpadGi0XMIQi9hW1TFbpV+oEB6DRVtErdrw=;
        b=vNEd1DqN+2Y7ItaJgQq2rKEM1Z1rZMpVTqLp51hAbnb+hH7FitdgOM4UtYRAeJxq0t
         9sgEBwq3ryeZ6MO1atn8jCLZy1hPo0cyx+L7T+HGeFal+yxvc3yHNJMd28GN/5hkEDRk
         kAJOf28l9kIa0snADliAipGLxJwJtWo6Sn4yFhLpBa0HuzuxX0hOkcwxHa3eaEAnsP2d
         y7KWv4ktwwTT6Cd7x7yI5CY8DEUyZ8IfdQ0s8UViIiZnhr2L28zm6cPUHauiMRuDSZ64
         wJQf1gGOMw3ClPd8QP4YZueVGEt5F+etmovzF+gMMLaDLFicVYM29XAamRDQFazLvCYh
         KLKA==
X-Gm-Message-State: AOAM533Kz1WWS+EXrv6VG7XsHeDIZJZZwImdL5hZ8Z7KXRfA5Lzx9vmf
        8QJayXXfBQYVFNQG2ukntixMnd4TVfE=
X-Google-Smtp-Source: ABdhPJzSMz/3vO7h5zkSagc7LhGOCF5z7DZ5mAntD+qKKNcUn7qnNgjnP65P039ia/OC4O46ksRpdA==
X-Received: by 2002:adf:e8c5:0:b0:1e4:7c8a:21a7 with SMTP id k5-20020adfe8c5000000b001e47c8a21a7mr1151877wrn.516.1645080892936;
        Wed, 16 Feb 2022 22:54:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 3sm35131989wrz.86.2022.02.16.22.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 22:54:52 -0800 (PST)
Message-Id: <0c2ab523e74be6f39b82c8fc9c73b4ac57f9963e.1645080889.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1118.v4.git.1645080889.gitgitgadget@gmail.com>
References: <pull.1118.v3.git.1644985283.gitgitgadget@gmail.com>
        <pull.1118.v4.git.1645080889.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 17 Feb 2022 06:54:46 +0000
Subject: [PATCH v4 2/5] sparse-checkout: correctly set non-cone mode when
 expected
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>, Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

commit f2e3a218e8 ("sparse-checkout: enable `set` to initialize
sparse-checkout mode", 2021-12-14) made the `set` command able to
initialize sparse-checkout mode, but it also had to function when
sparse-checkout mode was already setup and the user just wanted to
change the sparsity paths.  So, if the user passed --cone or --no-cone,
then we should override the current setting, but if they didn't pass
either, we should use whatever the current cone mode setting is.

Unfortunately, there was a small error in the logic in that it would not
set the in-memory cone mode value (core_sparse_checkout_one) when
--no-cone was specified, but since it did set the config setting on
disk, any subsequent git invocation would correctly get non-cone mode.
As such, the error did not previously matter.  However, a subsequent
commit will add some logic that depends on core_sparse_checkout_cone
being set to the correct mode, so make sure it is set consistently with
the config values we will be writing to disk.

Reviewed-by: Derrick Stolee <derrickstolee@github.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/sparse-checkout.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index fcd574f5fc1..fb85a1459c3 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -403,6 +403,7 @@ static int update_modes(int *cone_mode, int *sparse_index)
 		core_sparse_checkout_cone = 1;
 	} else {
 		mode = MODE_ALL_PATTERNS;
+		core_sparse_checkout_cone = 0;
 	}
 	if (record_mode && set_config(mode))
 		return 1;
-- 
gitgitgadget

