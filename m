Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E81EA201A9
	for <e@80x24.org>; Fri, 24 Feb 2017 13:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751346AbdBXNUH (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 08:20:07 -0500
Received: from mail-oi0-f43.google.com ([209.85.218.43]:34484 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752104AbdBXNT6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 08:19:58 -0500
Received: by mail-oi0-f43.google.com with SMTP id 65so10274034oig.1
        for <git@vger.kernel.org>; Fri, 24 Feb 2017 05:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gGjVXYorn52ELV/U7fTsZTiG+dx2HsDn/4mLnMZusNw=;
        b=DAV+XV0JTnhKgLbCNrMJZGAyHO/lLRl6pPs2D1uZuAPJUosYtkGtMcWZAu7ZxkHWcD
         Apw2gA5HBa/+Ge1uvqQeFiqNlhn9YsBsBIUVcTuBenUfEjtziOA56p7L5RAQn0RnO3jj
         w40PIGmC7DCK3qjR5frg/RzExyRAgeeFQt3mdT169eB4Ja5rDu3q+8u8kTDYV9IpTF7O
         pMPC8+DF3iuh9ASHZz4ca2Ew+q8BcJJ7syq2gzetfFQBpW1/Zi+6iukhZtEWexktr14o
         TsZtNOxpsZES8HOT7x4IKXmPRL+Ndd9PhtiJWJ5NgHVNm1IVzgGEx3p1k/tGixB1+Jl3
         cv6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gGjVXYorn52ELV/U7fTsZTiG+dx2HsDn/4mLnMZusNw=;
        b=oAxegb67mJnsU9FzV6txldl1/e7FQie3KREheN3IPmmWj6QcfLf1ZtzY+pOCR92yNk
         qccOJFijhkara40L/5F3gLXJW1zuexQGVRvPhGb7CCt3ngReySjen8gFQkYojCt+dneS
         yQLUzZWqJgaSy/u8kqAL4h6AhDW7od4r0ajhFK0nAqa7FfQvUwgOlVMws+G2O2oe3YQm
         VLuj4aVg2/OnTcu8TBD5JMOgc2loooeqeCfE4NmsMEfEpJVGy1gONgC4pDEh9kahmAiO
         Dtrs0Q7Yy+qBwflcHsUCQov7llr8YBisZWoaCT2J1PKWXxmZfrsscWy1ppwS9avgbJMG
         CX+A==
X-Gm-Message-State: AMke39m5X/czVt+EJ8wYJpzyxGcVFiOHhN1C/0bt+3yKcjYt86WP6pDD3nN+WkexH3gKdYVuDtmnKiE+LfGBIw==
X-Received: by 10.202.60.67 with SMTP id j64mr1561357oia.124.1487942316779;
 Fri, 24 Feb 2017 05:18:36 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.158.84 with HTTP; Fri, 24 Feb 2017 05:18:06 -0800 (PST)
In-Reply-To: <20170224131425.32409-3-pclouds@gmail.com>
References: <20170223122346.12222-1-pclouds@gmail.com> <20170224131425.32409-1-pclouds@gmail.com>
 <20170224131425.32409-3-pclouds@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 24 Feb 2017 20:18:06 +0700
Message-ID: <CACsJy8AFJBCs0LhUW3K9EsbKScyE7obGjf6hTT3DZjdn-4mLbA@mail.gmail.com>
Subject: Re: [PATCH v6 0/1] Conditional config include
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Sebastian Schuberth <sschuberth@gmail.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

And sorry for duplicates :P Somehow I managed to --dry-run correctly
the first time, then had _two_ 000*.patch in the command line. And
send-email happily let me shoot myself in the foot.


-- 
Duy
