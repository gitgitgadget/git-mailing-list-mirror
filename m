Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9E2E1F462
	for <e@80x24.org>; Fri, 14 Jun 2019 06:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbfFNGu5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jun 2019 02:50:57 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:33068 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbfFNGu5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jun 2019 02:50:57 -0400
Received: by mail-ot1-f48.google.com with SMTP id p4so1698524oti.0
        for <git@vger.kernel.org>; Thu, 13 Jun 2019 23:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YFAtssP60gbnNhaVBnMS/p8tVwbgVq+U5wA4QGjsdRk=;
        b=AKBFp6lUsWEoipiONG1DtH/1KkGjGIE3I2rsSYvbiC64p0GrgQdaVaeMl6kyhwGl8L
         EvNerMExaGGh/iafAleCxQDNG289D5HF+N1FWxGxNT2uqqOLhcQOlqG4S+L4OIILWuqc
         Xy/ZeTkAUaA8sHUslyR2iSmMf5vXqQloPKMLfb/8cMQhIf2mdcq96rUaCDctqHPCQvin
         x0GaLkenfoM1HfJHXRzbJn1oUPmBmob4Q3Lg4N4jK25M4QI8etWQbGfR9fl6epacmaHt
         EZnLoaqIJbJYBsY/1tkXLCiQiitGjkIim5W6qDD27d1M3OoRvpJcDRl2wTGTE2fXG+Na
         wMNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YFAtssP60gbnNhaVBnMS/p8tVwbgVq+U5wA4QGjsdRk=;
        b=qdhWdCxQDWavh1QDgNMY3ZDaZDa39bl5i0nrGdVsr+QhsBFZHSlGtYk8SQTk04dAsY
         w80kJUMpG+YPiutxqRilH5+JS+AIgDfEoXHojFD2WsdQ2APn0kmhab5vrWH+sjyVHe0d
         ViBI/4/2U19rVu1GKbBXfUNEx6remZGxdRhp3fo9CCbkR/exkPUjuoz47TkSlMqALw5T
         bLqNeS7e7vQ9MUsUwjdSnlMDQhfLM8iHM9XzRuZDmMm1ChXwAoP27aQ0kH2xronUjOhP
         aC8S1JwJhkJ8URuFhN7Uo+758DFaFQzEsj+blxlV/bAF89yUX6OSejDAoxHAcKAukFNW
         VBiA==
X-Gm-Message-State: APjAAAVAMXUktQ/7BZZk9sl6Hlq9oWf59cNNwtbVwPGhCbcMPvfN28GF
        /f4oKbYBZyKDh/CfCWPH6vJmTyXknxk=
X-Google-Smtp-Source: APXvYqxJp4PNLJRFiPKys6dlY4R+a5XXDhgi6s9rIH+i6gJpna95yZs7Cds1ItQYwgkdiQIpea1QAw==
X-Received: by 2002:a9d:729a:: with SMTP id t26mr17133186otj.13.1560495056263;
        Thu, 13 Jun 2019 23:50:56 -0700 (PDT)
Received: from localhost (200-52-42-156.reservada.static.axtel.net. [200.52.42.156])
        by smtp.gmail.com with ESMTPSA id d62sm863003otb.35.2019.06.13.23.50.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 23:50:55 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Richard Hansen <rhansen@rhansen.org>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/5] completion: zsh: fix for directories with spaces
Date:   Fri, 14 Jun 2019 01:50:48 -0500
Message-Id: <20190614065051.17774-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.22.0.rc2.dirty
In-Reply-To: <20190614065051.17774-1-felipe.contreras@gmail.com>
References: <20190614065051.17774-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index b3c4588515..067738d93f 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -32,7 +32,7 @@ if [ -z "$script" ]; then
 	local -a locations
 	local e
 	locations=(
-		$(dirname ${funcsourcetrace[1]%:*})/git-completion.bash
+		"$(dirname ${funcsourcetrace[1]%:*})"/git-completion.bash
 		'/usr/share/bash-completion/completions/git'
 		'/etc/bash_completion.d/git' # old debian
 		)
-- 
2.22.0.rc2.dirty

