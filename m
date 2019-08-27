Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3526D1F461
	for <e@80x24.org>; Tue, 27 Aug 2019 04:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbfH0EFY (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 00:05:24 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39730 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbfH0EFY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 00:05:24 -0400
Received: by mail-io1-f66.google.com with SMTP id l7so43065062ioj.6
        for <git@vger.kernel.org>; Mon, 26 Aug 2019 21:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RLA+auV5w3B4S445lrANQbbCFiyXgx8XVCPcuC5rVkY=;
        b=QwMRFytNukuCdacFkFy8E+n0Aj4xM8JQsCyrylAmY72PbZzznlvBOhpsl8NfKVX7yB
         6jsI8kCW9UOS0QOjrJv6/EgfLVF+yFGM1z7feaIwR5ASdRlwFL2lwY0Re7F+RyJqyfZw
         ST7jC5Ar8R9KACVOKLgP/SLzBErrx5vJdtA/yIjTaFka/qeD7d6poDTvmjqJRki2mxMF
         1+FJDxdH3R56+kv+oPyY9uUutjzzrcY+ThFgdxkOaPI/bfUNVKAgsZ+Rk6w2cRTe3rfg
         Z3Y4tgyvG38nXTmKavVB6XSsIHBWkY2Mr0VB+pL6UiLlpk9k2NygmGRfpQxxupfK7YJz
         rK5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RLA+auV5w3B4S445lrANQbbCFiyXgx8XVCPcuC5rVkY=;
        b=amEmZX1WUKFmcr6kPYrCgn1eOzYOcWGkcWYBrfeEdQTpbq1+IME9mS2U7kAxGvvDYe
         G9ero7rWUtY6zIjhbQFTtFeWkoAV03Y0N5JX64Zu8s2xjFZKSmMkNLNHeAGWT2yYZeFo
         I9Or7E118wjNWRrhDVdssYnlrH4JE30onggtjytH6BkFVOdsUb7wdUwp6pOthMpG595A
         kN3oVWav9bNExWrOF8ryT729uoYwlE/1RLfJ+U6xnsL1WCtQk8LFrsqdHvrDPtxk3oGB
         G7cxOYUWA31UeAAVgZeIJ3iOVaCdn41LA/cf+9X8zCeyNBQrKV70HNlzPbjKhcoBbdVN
         uBJg==
X-Gm-Message-State: APjAAAUUtMNzJbI5F8OSKEtVmIaTARNV95JydPrKbuu0aJqPEvEP6I2r
        o9MlQjmEY8LGda0rhSkgXU2o49Gs
X-Google-Smtp-Source: APXvYqzIKEMVdD6H71hExzeUIRX1iv1pBhiBulWLvae4swAwSUtZi43Lr4d+XL4oOvitJHpVmsLD3g==
X-Received: by 2002:a5d:8444:: with SMTP id w4mr3449764ior.51.1566878723132;
        Mon, 26 Aug 2019 21:05:23 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id j18sm5935944ioo.14.2019.08.26.21.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 21:05:22 -0700 (PDT)
Date:   Tue, 27 Aug 2019 00:05:20 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v2 13/13] config/format.txt: specify default value of
 format.coverLetter
Message-ID: <4e429e1989173e07bcb9b622b732e46bf3dab828.1566878374.git.liu.denton@gmail.com>
References: <cover.1566635008.git.liu.denton@gmail.com>
 <cover.1566878373.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1566878373.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/config/format.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/config/format.txt b/Documentation/config/format.txt
index 414a5a8a9d..cb629fa769 100644
--- a/Documentation/config/format.txt
+++ b/Documentation/config/format.txt
@@ -77,6 +77,7 @@ format.coverLetter::
 	A boolean that controls whether to generate a cover-letter when
 	format-patch is invoked, but in addition can be set to "auto", to
 	generate a cover-letter only when there's more than one patch.
+	Default is false.
 
 format.outputDirectory::
 	Set a custom directory to store the resulting files instead of the
-- 
2.23.0.248.g3a9dd8fb08

