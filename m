Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10694202A0
	for <e@80x24.org>; Tue, 24 Oct 2017 03:37:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751280AbdJXDht (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Oct 2017 23:37:49 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:43217 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751259AbdJXDht (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Oct 2017 23:37:49 -0400
Received: by mail-pg0-f65.google.com with SMTP id s75so13421357pgs.0
        for <git@vger.kernel.org>; Mon, 23 Oct 2017 20:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=bX2boa7rBH/ef6Hjd1FhGy6yvalP+CtA/76knu6UAiY=;
        b=fDEWxqT3JjGnPbVzpi5HYcnPdFPO1oqTVIGkYbh1ol4xrhVj19BMWDiletjU2APS31
         mFiDD8QwIul+I2C0kxc71U38NTlvFdrai37PW4liw8cVp2p47WcaLtvf55rUsaYY0ghH
         Vgg3lQu8b/VLV/GoPpqMtkwC9xDoR8n18AoonPPtWQQ7d+nHbjhXAmEjpYhVKRAZJXIT
         kU/7P6wUyQFbP9SiIkAsHSNr1D17q+Ij4u7P9N1hhVj/6kJeMLKGkBw9sklRElcllG2y
         lTvymJ3qIBoQ2b5yyJFHLZmMHothDcXxjzHgwJoeeh6g1CWBC47P1PJI3JZrdvI+++2Z
         gopw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=bX2boa7rBH/ef6Hjd1FhGy6yvalP+CtA/76knu6UAiY=;
        b=bJsGGMaegnSkB83bwsjhjsfR+czBP3/KU47ZsBIQc9xrwG+3fKIc0dQlJbnDRmKX/h
         Z68JOQLEI8FM+Un0o+wB6hsFVJdqw7rhJN9yMF62j4y8fI8Wl/SoBfCv1aTCO3WXJauu
         ArrxCUd/lY6XMDyGMgN4uvJcNOJavMSROdIBw9oQNPXt0EpywbVHUyfOOMtIdf/KRyJh
         JLiecDoppI9bgpa/P7OiPBQCnyDmV0HvCzBvlXhv/WN+tkiELumagf5c5qns4pRCHF1b
         ODdcp8lkQjb0jZbHsrKsYWAPM2vZTomMrIIWzReocWvskImz7T/6dNRXQkHlbxWsBerx
         ifOw==
X-Gm-Message-State: AMCzsaXMADBNxOz2jIWBmCfy2pjyph2uUcaWZYfu+sha10SFPCirKnCX
        5zuDZdD1qU/I5/WrJCtXgEmcT2Bu
X-Google-Smtp-Source: ABhQp+Sx85sc32hXSZOxnigjkv/RM/qSo/xtaoiDIjbf/Cqg6RsjfDZMIV+0ipR2dr9WbzIjMskXhw==
X-Received: by 10.99.163.1 with SMTP id s1mr13686245pge.310.1508816268534;
        Mon, 23 Oct 2017 20:37:48 -0700 (PDT)
Received: from unique-pc ([218.248.21.162])
        by smtp.gmail.com with ESMTPSA id g5sm14326434pgo.83.2017.10.23.20.37.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 Oct 2017 20:37:47 -0700 (PDT)
Message-ID: <1508816263.3568.4.camel@gmail.com>
Subject: Re: [RFC PATCH v2 5/5] builtin/branch: give more useful error
 messages when renaming
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
In-Reply-To: <CAGZ79kZJAYabHArHkPPyqUy7LKQXyk7kqqmrqRcirGXZ4FYHJQ@mail.gmail.com>
References: <20170919071525.9404-1-kaarticsivaraam91196@gmail.com>
         <20170925082024.2691-1-kaarticsivaraam91196@gmail.com>
         <20170925082024.2691-6-kaarticsivaraam91196@gmail.com>
         <CAGZ79kZJAYabHArHkPPyqUy7LKQXyk7kqqmrqRcirGXZ4FYHJQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Tue, 24 Oct 2017 09:07:43 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1+deb9u1 
Content-Transfer-Encoding: 7bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 2017-10-23 at 12:44 -0700, Stefan Beller wrote:
> +static void get_error_msg(struct strbuf* error_msg, const char* oldname, unsigned old_branch_exists,
> > +                         const char* newname, int new_branch_validation_result)
> 
> nit here and in the return of validate_branch_creation:
> It would be clearer if this is not just 'int', but actually spelling
> out that it is the enum.

Thanks. That's a good suggestion. I'll fix it while dropping [PATCH
3/5] that cleans up the 'validate_new_branchname' function as there's
already another series that refactored the same function and got merged
to 'next',

https://public-inbox.org/git/20171013051132.3973-1-gitster@pobox.com/


-- 
Kaartic
