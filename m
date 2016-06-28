Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C5B92018A
	for <e@80x24.org>; Tue, 28 Jun 2016 23:18:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752404AbcF1XS4 (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 19:18:56 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:36097 "EHLO
	mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752362AbcF1XSz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jun 2016 19:18:55 -0400
Received: by mail-io0-f172.google.com with SMTP id s63so31028773ioi.3
        for <git@vger.kernel.org>; Tue, 28 Jun 2016 16:18:55 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=mdnSf5dNJpFDC2QteAzH2m02mLeV7tgGwRoXgkrDMcQ=;
        b=GmJXQVdTcxMVujehiMlHHi2PHQKjJKBBZ3rsZPPCVjcbIiv0n5BSmM7BBZI6LsEv/w
         qpi+2PoUrVGuzKIQJ7dmaGt8lzutc7JEbFS9FBnjJITF9naA7T8/QZsIiPPEGnJMc31w
         8/aMNfGRHK2aIlVcIVQU3+ZjDFjenZR49H06L3rQzbDEIHzLPDR+NzyuEHI592RLffdg
         gpLo0ut6tRGwjpuYqkGVtju1cX7jWl5tAzS6a+R/ndzoE2h/oiA7156lwYBl78BgVyCx
         tOKwCCnyVI4+OuJ6ysfUDGvTFleX7W/saPqV7lSTEuJhYDVWSmPsj4XwbCHuv5Ez7Xqo
         7AEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=mdnSf5dNJpFDC2QteAzH2m02mLeV7tgGwRoXgkrDMcQ=;
        b=ACFu9vOBADo+kA/n1GYbaI2pCORY5SS97n/oMDf7MWgIhPS/MEyQ59MRV4CWH4QQHV
         Eovkjj8tG1fvMTwDuERiFiWq+LEx4lSLnfHefFOuJ0KumpOPzkMkLFO0MkL+BVCOEjON
         Eid1kK3V3ZBvSiV0bKqETF6Kq2hM0qCqFV0q0f06xgRdqAIRyw/f+x1/D2VEMTkCKoVU
         8MrwgfN576HC1R3HnrZLBKLj1f91zwN347nwHVB2Et6D99H4ANKvGctAMI8m3jL4+1g+
         ccxHyxy2UXJYSCN6UYtZ+O+c2ZQ0gcfkvVNRrhJf8P2O7l4dI5hgLOE4/KNf1iuGQuuJ
         2IjA==
X-Gm-Message-State: ALyK8tJ12h4D2ED2RvHKOmlGKU8Hj3skNKyfbrfhTBb1Pz2E7gp+JSc156UOvsU7h19a/S1kAMJYHyVVWSE+cg==
X-Received: by 10.107.47.41 with SMTP id j41mr6124981ioo.168.1467155485428;
 Tue, 28 Jun 2016 16:11:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.0.30 with HTTP; Tue, 28 Jun 2016 16:11:25 -0700 (PDT)
In-Reply-To: <20160628172641.26381-3-pclouds@gmail.com>
References: <20160626070617.30211-1-pclouds@gmail.com> <20160628172641.26381-1-pclouds@gmail.com>
 <20160628172641.26381-3-pclouds@gmail.com>
From:	Eric Sunshine <sunshine@sunshineco.com>
Date:	Tue, 28 Jun 2016 19:11:25 -0400
X-Google-Sender-Auth: qnTFqa94oyCO-Sf50DAw752QKx8
Message-ID: <CAPig+cRFZg1z5mhKiO7=0a+bCbdhJ07FubUstNrHYmKUrTc6nA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] config: add conditional include
To:	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
Cc:	Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Sebastian Schuberth <sschuberth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jun 28, 2016 at 1:26 PM, Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
> diff --git a/config.c b/config.c
> @@ -140,9 +141,89 @@ static int handle_path_include(const char *path, struct config_include_data *inc
> +static int include_condition_is_true(const char *cond, int cond_len)
> +{
> +       const char *value;
> +       size_t value_len;
> +
> +       /* no condition (i.e., "include.path") is always true */
> +       if (!cond)
> +               return 1;
> +
> +       if (skip_prefix_mem(cond, cond_len, "gitdir:", &value, &value_len)) {
> +               struct strbuf text = STRBUF_INIT;
> +               struct strbuf pattern = STRBUF_INIT;
> +               int ret, prefix;
> +
> +               strbuf_add_absolute_path(&text, get_git_dir());
> +               strbuf_add(&pattern, value, value_len);
> +               prefix = prepare_include_condition_pattern(&pattern);
> +
> +               if (prefix < 0)
> +                       return 0;
> +
> +               if (prefix > 0 &&
> +                   (text.len < prefix ||
> +                    fspathncmp(pattern.buf, text.buf, prefix)))
> +                       return 0;

Are the above two "return"s leaking 'text' and 'pattern' strbufs?

> +
> +               ret = !wildmatch(pattern.buf + prefix, text.buf + prefix,
> +                                ignore_case ? WM_CASEFOLD : 0,
> +                                NULL);
> +               strbuf_release(&pattern);
> +               strbuf_release(&text);
> +               return ret;
> +       }
> +
> +       error(_("unrecognized include condition: %.*s"), cond_len, cond);
> +       /* unknown conditionals are always false */
> +       return 0;
> +}
