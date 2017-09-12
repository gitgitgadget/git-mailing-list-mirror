Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 752801FADE
	for <e@80x24.org>; Tue, 12 Sep 2017 13:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751384AbdILNlg (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Sep 2017 09:41:36 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:34905 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751313AbdILNlf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2017 09:41:35 -0400
Received: by mail-pf0-f175.google.com with SMTP id q76so5158399pfq.2
        for <git@vger.kernel.org>; Tue, 12 Sep 2017 06:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:in-reply-to:references:date:mime-version
         :content-transfer-encoding;
        bh=GRq8uE9prycit0GrSjzKDpQvKO/Xg+zIiDdmYLO1c6E=;
        b=pRBsoUSRaaHP/0PNv1HRTrd66PjuIqPtmDsmiZJJ5oyG5SHxt/8vRimW973iKmWN5y
         aODwK/zadJoAJGycvpxUhoxyVGhyTmYisdcY00ZmCVWm/HrlAePGkIEO0e3+URa7ds1T
         1G7V8ExYDGgI5ENxN9+Icb1AGJqlynEHCly8sekL96cdC57Jm3GuXAQfQKGk1vQO9Uk1
         W7FLgxO0Eyi57HpCeKVXMDdZ28qD5l+7vsWBJ9pK0Pk9sOQv/30163b9dxeY0FvpuQ8Z
         KLjTVxApAuqg7/TcLUeX+Q2z5mRdUKldMYyMo8PkRhhxwmj06LHUOWkKMv1mwCpToA0H
         3RVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=GRq8uE9prycit0GrSjzKDpQvKO/Xg+zIiDdmYLO1c6E=;
        b=ABQTZaaoslMrMCOwvqCI6RFYf8zGMF/SEGzHojJGW56PgaPPRrqjsKU13Y3F1e8s0n
         R959++Av2Ujt/rK4aTKCvKFDSzp80lANTByUMZsKizLNOuF0XtdX4FcN+wCVvYL/2jm5
         c+vCh0V0rOGFEkheGFhjPrFICLLuapTxu7dAE2D23jKUoUbPfbey+Pb4DoNC1uJUJkFz
         7EbP8P+pH5sopjjTP/RrA5/rFZHjxx/J7Iwcgmkc4lNW9lkuWe0rAmxhUVoyK7YoC3As
         Tk2KPNp1MG8n86ofTZdTED8EEDlZxCUEvFLp9Lr+fNruko8538YjtQ/4HygRNc5WkmrB
         ZjIg==
X-Gm-Message-State: AHPjjUj3hA5ZUSyP+wnHNH6PS0s1C7uTYW+vKJ+trowdmmW767mcXZdr
        Iw8FZqeZFa+RpNQJGI0=
X-Google-Smtp-Source: ADKCNb6d9SRXq4mQRJswTQ1k4PBtbxXu+pCmbMDt3txUK2OguL2JD+rWAE4pusVXpOQ/k9PCJh8xZQ==
X-Received: by 10.98.209.68 with SMTP id t4mr5850529pfl.315.1505223695360;
        Tue, 12 Sep 2017 06:41:35 -0700 (PDT)
Received: from unique-pc ([218.248.21.162])
        by smtp.googlemail.com with ESMTPSA id z8sm20430491pgc.93.2017.09.12.06.41.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Sep 2017 06:41:34 -0700 (PDT)
Message-ID: <1505223698.27800.30.camel@gmail.com>
Subject: Re: [PATCH 10/10] add UNLEAK annotation for reducing leak false
 positives
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
In-Reply-To: <20170905130505.him3p4jhxp64r2vy@sigill.intra.peff.net>
References: <20170905130149.agc3zp3s6i6e5aki@sigill.intra.peff.net>
         <20170905130505.him3p4jhxp64r2vy@sigill.intra.peff.net>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Tue, 12 Sep 2017 19:11:38 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.24.5-3 
Content-Transfer-Encoding: 7bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2017-09-05 at 09:05 -0400, Jeff King wrote:
> This patch introduces an UNLEAK() macro that lets us do so.
> To understand its design, let's first look at some of the
> alternatives.
> 

> This patch adds the UNLEAK() macro and enables it
> automatically when Git is compiled with SANITIZE=leak.
> It adds some UNLEAK() annotations to show off how the
> feature works. On top of other recent leak fixes, these are
> enough to get t0000 and t0001 to pass when compiled with
> LSAN.

My nit of the day ;-)

The above paragraphs seems to going against the following guideline of
Documentation/SubmittingPatches,

    Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
    instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
    to do frotz", as if you are giving orders to the codebase to change
    its behavior.  Try to make sure your explanation can be understood



    -- 
    Kaartic
