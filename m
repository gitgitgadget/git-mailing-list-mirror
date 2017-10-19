Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48897202DD
	for <e@80x24.org>; Thu, 19 Oct 2017 19:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752722AbdJSTeA (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 15:34:00 -0400
Received: from mail-qt0-f181.google.com ([209.85.216.181]:55608 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752614AbdJSTeA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 15:34:00 -0400
Received: by mail-qt0-f181.google.com with SMTP id v41so15823465qtv.12
        for <git@vger.kernel.org>; Thu, 19 Oct 2017 12:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4dlGNFfh3fBhl84rVWo/GWrIGLq/un+ZD7lD2Sl3Pes=;
        b=SwMBQrSJ9icUv4/C9bEddpJW/wz2enHbmAi9qqGhWKj6h/XSTlaPr2Aae1/4hMThOJ
         2yIe/dwqkjHPb22u8mY2q3LHx0TZkGlKTRblPNirx/8dwAdzcZRWQqro8pAPKiOAnfVX
         eGhyIKpvf8Hq6r11XRZNgSjHYfqEFyGaMsbhEoi32gAHIcRce2wbQerfXHsWNr4tcyVp
         QDb0bbj8tZYAZ4lubU0F+vj8madpb1IKy3NJaKklMuG798tGsezdC+zputLagoT3oG2I
         D9+kPd4A3XvIKIh6UQQ/8Ka5NYfjBQfBz8z5FNowDJJtc1QEtK1L2kvDE2Pgp/Dv8dYR
         gxhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4dlGNFfh3fBhl84rVWo/GWrIGLq/un+ZD7lD2Sl3Pes=;
        b=pw9MvllE4Cl6KPzuO2pvadlEP/ruIbvLPNyiHqqbaqeeRHMAWlTm6CnAb8XXj+TGd2
         AxEBJIt0QaMI7zaEZIHCKZwbGnryAprCuYkeC/BsNp7umkMCxFNK11FDmJ/GnfIEcpxX
         4+lDyLTa0kCeOdvkFu3s1Cx9wkep1WM2e8NA9xtS2arikrbcPDeWuy1xjZe6kLLHHRlf
         Dz7PMQxY7fhqfoCTbX38pK0iEeIBOwVDB/dSqZsWD2lqCMBjQufzeOUv1zU4PkyEEHFI
         fQy0Yb37KX5I+zfc0hoYprd5BW9j5vDALxSNe4edS2rlCRgkk5PzLWHhaLOaQ4LTDH4p
         gZAA==
X-Gm-Message-State: AMCzsaUEPCJvfBaqdo6Nsz4p6487EAR0FFDzA5+INRzKz/3rQcUNVIcj
        gAFp7kz+4R3wrdwNFiQEmTYDItL6brcxz8uwVpIGoQ==
X-Google-Smtp-Source: ABhQp+SG0DxgE0PdmEoIwQCrDyLm/vuOJNJhukChLRuXY+HutO2S8EAMinW2Veo7+5JTXOGBNhGBbIPHW9XqRdd2aHs=
X-Received: by 10.237.37.71 with SMTP id w7mr3693504qtc.299.1508441639204;
 Thu, 19 Oct 2017 12:33:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Thu, 19 Oct 2017 12:33:58 -0700 (PDT)
In-Reply-To: <20171019160601.9382-5-jamill@microsoft.com>
References: <20171005205443.206900-1-jameson.miller81@gmail.com>
 <20171019160601.9382-1-jamill@microsoft.com> <20171019160601.9382-5-jamill@microsoft.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 19 Oct 2017 12:33:58 -0700
Message-ID: <CAGZ79kacr868zQOXNJ889MY+cgjprU328syaQX4mY1qdm-c4rw@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] status: test --ignored=matching
To:     Jameson Miller <jameson.miller81@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jameson Miller <jamill@microsoft.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 19, 2017 at 9:06 AM, Jameson Miller
<jameson.miller81@gmail.com> wrote:

> +test_expect_success 'Verify behavior of status on folders with ignored files' '

https://stackoverflow.com/questions/5078676/what-is-the-difference-between-a-directory-and-a-folder
We test directories here?

All tests are testing --ignored=matching, do we want to have at least one test
of "no" and "traditional" as well? (Just to see if the parsing works;
we can modify
an existing test for that?)
