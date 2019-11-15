Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D968F1F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 01:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbfKOBBX (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 20:01:23 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44519 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbfKOBBW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 20:01:22 -0500
Received: by mail-pg1-f194.google.com with SMTP id f19so4876763pgk.11
        for <git@vger.kernel.org>; Thu, 14 Nov 2019 17:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=csO+CsC/WW6HjQhBgusXd9iivYBxHPC1TaV716GdHAg=;
        b=bEpeUWIQObfgSEiAvWQblRGbrE0pfhGSObfJpLswjfzBa+pr9ooEFVh5aWrMwYe97N
         D1S2v3y+TyXRx4Pslunub2FpSh4ZYSUKQfTIXQhozgUhwFvL1Oz9GfoungVnfE1wluDb
         EAWHASSx5QuYqXW7KwJz5WIjEdSkHOgDTtvEugrx5xm48XTAJKRb63vnJWai7BpUDrdX
         1Dc7ir6WIoXOIMMF1FIvjuelyd0zo2ETSpTBpjp2g92BsX6VYlUbRep/dqlytcVGBogM
         SAToSizDDbNu01W/UGdL4aSuIokb01ojYfQzuEN952z0fVGMSMN2VYWeoJ10edlVgA9g
         ZGQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=csO+CsC/WW6HjQhBgusXd9iivYBxHPC1TaV716GdHAg=;
        b=M2SUEWXuefs2NNKVkvRaJm7E5EdmZP61p+Qp1kMmkIuEKzR2+kGfepVojQ/w/2I5G/
         rw6fHLRFfxfcbX6P6VrQhuOTy7UiMLG86CsTo8uCP8z12z6CJhZXFV29pLAkoFtQGomq
         GD3wI/0gGE0Eec1oGgH660FhwCSJZ82hSuijLniJJokdWcFU0srmcy1bfKZm55ikOn47
         O9ZAWbbMuw+GTogL5ug+Az1q6dd/m5PR7Sxg7uXOsPVVd5pd5spLDva0ao5/Eu19HgAr
         EIuQjGgtABSYOKhIbhfF6U5QeAPO7M3QbMAudSYvPexz+3swsZPZHgVbhRuQKdidLXE1
         XbxA==
X-Gm-Message-State: APjAAAXbFNoUoMyTHz4RvRIOS0KQgWoPAxBgLQQRAbwsr8CLCwCIv05B
        xMXZr5zguc0S2h1g7b29VTksnGD7
X-Google-Smtp-Source: APXvYqyOHLXYNx2Xd4aSvFVUzIZhPMYs7RwYpbIc5AC19va5W/HLKAjLyIoiSGMtGX4wKPNBHvWvNA==
X-Received: by 2002:a63:7c18:: with SMTP id x24mr1952422pgc.390.1573779681661;
        Thu, 14 Nov 2019 17:01:21 -0800 (PST)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id v14sm7546114pfe.94.2019.11.14.17.01.21
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 17:01:21 -0800 (PST)
Date:   Thu, 14 Nov 2019 17:01:19 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 21/27] t: define test_grep_return_success()
Message-ID: <3f79d23b40c0586d0351f4d721097be4f7ba26b8.1573779465.git.liu.denton@gmail.com>
References: <cover.1573779465.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573779465.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a future patch, we plan on running tests with `set -o pipefail`.
However, since grep can return failure in the case that no lines are
matched, this can trigger a failure in a pipe in the case where grep is
being used as a filter.

Define the test_grep_return_success() function which acts as a wrapper
around grep but always returns 0 so that it can be used in the situation
described above.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/test-lib-functions.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index b299ecc326..dddc4cc3b1 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -990,6 +990,11 @@ test_i18ngrep () {
 	return 1
 }
 
+# Calls grep but returns zero even if no matching lines are found.
+test_grep_return_success () {
+	grep "$@" || :
+}
+
 # Call any command "$@" but be more verbose about its
 # failure. This is handy for commands like "test" which do
 # not output anything when they fail.
-- 
2.24.0.399.gf8350c9437

