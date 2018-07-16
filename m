Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 564581F597
	for <e@80x24.org>; Mon, 16 Jul 2018 07:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730072AbeGPICn (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 04:02:43 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:45750 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728460AbeGPICn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 04:02:43 -0400
Received: by mail-yw0-f196.google.com with SMTP id 139-v6so13841224ywg.12
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 00:36:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oujBZf0BfUZzm0gqBrZ+J0Dj5kR7p1DDrmDrkv5bsS8=;
        b=RS1hi6No7/f8favw2ShqFRgo+DsgKU+9jOC0aFaNdbxme0mUsN2Wfp1/s/eeWNLouh
         NZ33WOlCRuAPbPsx6y2AfM7bM68TT/X0gu5v3s5zu/04IXIsj8/MqWPdcbgRZL91Nf9/
         IhIR+hxh7cBXTGM1kRbNXpOCHHqfzq03OzlnihDPIoavE2+dtv9xoqMRL6H5cMYDDVri
         0Oy6VN0g4EurrO9ste397FPmoGI7hSPlUZdGF+Jv6gnGOfp0/ma30Hhd1zpJMqv+5nmK
         DPD9VWoU05BAahmM2vjRc/UH8j1uvjw699+t0BDSjvmTzzPcs/BD/iVvcTxj2pbsDQyf
         KG2g==
X-Gm-Message-State: AOUpUlHG519kbySZ1tC6SmJP795aIwwnBfmW84YNMV/RQvlXlg72aA+M
        KIo+fer/T5QWxpFacs4Y7DjqmJ9zr+cGRFJ6G94=
X-Google-Smtp-Source: AAOMgpcVibDyJr1KW/H4BDj9oTvn1RDgOsUNxX0FMCIxZln7q7duOApUuMC+9hhaRI+tX/C3xfixN5/EhEJIRKB3gLI=
X-Received: by 2002:a81:ae66:: with SMTP id g38-v6mr7663890ywk.74.1531726140108;
 Mon, 16 Jul 2018 00:29:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1525448066.git.johannes.schindelin@gmx.de>
 <pull.1.v3.git.gitgitgadget@gmail.com> <3d9e5b0ba383bab3a30b74a96a1d78557e168b7f.1530617166.git.gitgitgadget@gmail.com>
In-Reply-To: <3d9e5b0ba383bab3a30b74a96a1d78557e168b7f.1530617166.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 16 Jul 2018 03:28:49 -0400
Message-ID: <CAPig+cQB8p1Eo0qyfD78cfSY6N=N9i-KBw5UO2OULXfA8+A=tQ@mail.gmail.com>
Subject: Re: [PATCH v3 11/20] range-diff: add tests
To:     gitgitgadget@gmail.com
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 3, 2018 at 7:26 AM Thomas Rast via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> These are essentially lifted from https://github.com/trast/tbdiff, with
> light touch-ups to account for the command now being an option of `git
> branch`.

The "option of `git branch`" mention is outdated. Perhaps just drop
everything after "...touch-ups" (or mention "range-diff" instead).

> Apart from renaming `tbdiff` to `range-diff`, only one test case needed
> to be adjusted: 11 - 'changed message'.
> [...]
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> diff --git a/t/.gitattributes b/t/.gitattributes
> @@ -18,5 +18,6 @@ t[0-9][0-9][0-9][0-9]/* -whitespace
>  /t7500/* eol=lf
> +/t7910/* eol=lf

Does this need to be changed to t3206?

>  /t8005/*.txt eol=lf
> diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
> new file mode 100755
> index 000000000..2237c7f4a
> --- /dev/null
> +++ b/t/t3206-range-diff.sh
