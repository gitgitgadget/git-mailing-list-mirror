Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0C8B1F404
	for <e@80x24.org>; Mon, 19 Feb 2018 18:36:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753483AbeBSSgm (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Feb 2018 13:36:42 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:39549 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753444AbeBSSgl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Feb 2018 13:36:41 -0500
Received: by mail-qk0-f196.google.com with SMTP id z197so13382063qkb.6
        for <git@vger.kernel.org>; Mon, 19 Feb 2018 10:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=VWex5VxIX5rA/zFfrYp5AR5FWclrn8jrV0W89CAOg4I=;
        b=X76zib7zdZhjxuFKEehdBuHj25zJQQ6stbTMeff3GNe4UgJOtyPp/wkcaxlY3Ws6+4
         o5n1GCqH9RjWBKSdpt76piYKLCYgYLV7/ylQdkVx59bSDJ5fU+FYrJT4Jy2Wadmhc9QK
         jrrNaPiDs7hD+feGSUlxWXgra6PzCdJG4ldzgOuHN543dXi6qeUtB0Ku2ynMRWrIp6iR
         0VjjF0wH4iCtEgPQP28XjZRUjsK4AgYiVu2GtLVodJfdxkOUBr3aV7IFr/20+AEQreIA
         N63Cw0GlmR86/ON7k7u2kZUpVwOmXe96m71lUV+XwV7REwvqCBJmoza6SzE1ga57Cy+1
         6bAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=VWex5VxIX5rA/zFfrYp5AR5FWclrn8jrV0W89CAOg4I=;
        b=UMqgC0jn/3bL7Xh2BNd3l9CFzhGJzd9EL1JqN9HA+EqXtno7PmuAjOBYTriBTXOSRv
         U+Va6zRCq5x6nZVlzPq3bqJq81egb1cQsln7b5H97I64nyc/Wa+5Z0jT7bJgvjtzRfV0
         tkriA1TiltO0KUiFEgXIZ+PDtAfpmzMXkU9uWDA+eqgoQFmLxaGaGkrHiPmuYuxjjkgW
         ZtcKlZRY3Yko28mHRd/NJe3egMCJm7DeGUy23tBZBZluSNlS13Exjm4hiYqpeH/m58e0
         Kixj8QKG0UDcYycdp6nBr8mYj19zkLu0D7pGnb7OIQ/AWyHKBUq1r9bJ5Rq8cWxknTBv
         PRow==
X-Gm-Message-State: APf1xPBFPRWpsBv/Pty6sZM6nfBSX12uxiBNzP7CFINP6E7f6SAiFHYM
        roqUDFtj6OVJ0BcyvpQWMemjwrfSKOAyjA8tt18=
X-Google-Smtp-Source: AH8x226fYuit4oRktAKPqUM/VhucgCGZjATM6XLKYC/YbQ/Rd8NpACExlGNbiG7SEbfy8oLv4JlKRDHYAr5BwnqocI8=
X-Received: by 10.55.49.74 with SMTP id x71mr25695935qkx.133.1519065399588;
 Mon, 19 Feb 2018 10:36:39 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.143.26 with HTTP; Mon, 19 Feb 2018 10:36:39 -0800 (PST)
In-Reply-To: <20180219112910.24471-3-phillip.wood@talktalk.net>
References: <20180213104408.9887-1-phillip.wood@talktalk.net>
 <20180219112910.24471-1-phillip.wood@talktalk.net> <20180219112910.24471-3-phillip.wood@talktalk.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 19 Feb 2018 13:36:39 -0500
X-Google-Sender-Auth: 44Wx7M4UsGUotm6c7HtTbTjbzdQ
Message-ID: <CAPig+cTUdw+eHOfj9=wt6DRR5xfaQxg-qQpF1VFfArY1uwcHnA@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] t3701: indent here documents
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 19, 2018 at 6:29 AM, Phillip Wood <phillip.wood@talktalk.net> wrote:
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Indent here documents in line with the current style for tests.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> @@ -22,14 +22,14 @@ test_expect_success 'status works (initial)' '
>  test_expect_success 'setup expected' '
> -cat >expected <<EOF
> -new file mode 100644
> -index 0000000..d95f3ad
> ---- /dev/null
> -+++ b/file
> -@@ -0,0 +1 @@
> -+content
> -EOF
> +       cat >expected <<-EOF

Minor: You could take the opportunity to update these to use -\EOF
(rather than -EOF) to document that no variable interpolation is
expected inside the 'here' document. Probably itself not worth a
re-roll.

> +       new file mode 100644
> +       index 0000000..d95f3ad
> +       --- /dev/null
> +       +++ b/file
> +       @@ -0,0 +1 @@
> +       +content
> +       EOF
>  '
