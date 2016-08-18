Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4BA41F859
	for <e@80x24.org>; Thu, 18 Aug 2016 07:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752954AbcHRHjr (ORCPT <rfc822;e@80x24.org>);
	Thu, 18 Aug 2016 03:39:47 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:33674 "EHLO
	mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988AbcHRHjr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2016 03:39:47 -0400
Received: by mail-yw0-f193.google.com with SMTP id z8so960076ywa.0
        for <git@vger.kernel.org>; Thu, 18 Aug 2016 00:38:10 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bPJHD0FWxcVX2hfmyskNH39YCp814iPM2Q/saTVj/bg=;
        b=I2UhRW3+Un4vO4isEkvQr+8QOIQ+uH+6+CwB8hSiijhanHi/eJU1KwABZUuWu14K7k
         +QTJ7Cpp7BhdrhPrxtvausd+zjxYdg+k/XEdvmWvEOcyL3A74bsYyfOQA4l21S6Owsjl
         i2rGX4nSC8TnGDdaLUAdyXD03TbJtR/vLGkQ3XngpjPzD2ycYRIc8CMGXRG43oZAHvB/
         9AiCh065aBF+YK1yY72wBpPdCJE8erOcUIh9ZFfRcb/AkMHCnwRfowcd82hvBjDxbx2s
         BJRN15oJWpD+9gGFwkPDmvS6dRGMZjj1Lw/aKN5uQtRYr1VMyqEyoqbBYit+MWquBqgk
         0h1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bPJHD0FWxcVX2hfmyskNH39YCp814iPM2Q/saTVj/bg=;
        b=O0PmrcdrubGDyZ4518AASWlsg39QMcHR+Fa/A5CILsf90FcOis+Q13LZVewpVyl4Fv
         wfzVZAGLYS57X3zJjrkn8Kc3LqDzh7pyt2bZAPHi6KYQt1TBVI1xQyQtBKD1whD+uw3O
         xCPA/8g+/WPVk6N4HCDvWw2i+mvm7dY8gpTvSgDq1vzWNyrsMy6/IFBy9847Owa5+8V4
         zQjxu4/XtbOyMgtNUgKXhhn2eVXTuce52OmO3FOBsVkRXW5TmaX1WaMIZhg/xe4mr+BB
         I6AQGrftgruiNeGSfsSOdSYP11SYBqnqCZs9TRQ6gpyywmamsaU2KIJr7Q8eKpXLv7yZ
         Yw0A==
X-Gm-Message-State: AEkooutzo+FRjfqefBkIqCI7HVoU4MGIoEWakh3rdlsnVFv4VWnwaWEa4Q1BuWcy+CIrzMntT9YIWD+MJYSxQA==
X-Received: by 10.129.95.70 with SMTP id t67mr568186ywb.284.1471505890173;
 Thu, 18 Aug 2016 00:38:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.50.199 with HTTP; Thu, 18 Aug 2016 00:37:49 -0700 (PDT)
In-Reply-To: <20160818070023.GA30666@gmail.com>
References: <20160818005131.31600-1-jacob.e.keller@intel.com>
 <20160818005131.31600-7-jacob.e.keller@intel.com> <20160818070023.GA30666@gmail.com>
From:	Jacob Keller <jacob.keller@gmail.com>
Date:	Thu, 18 Aug 2016 00:37:49 -0700
Message-ID: <CA+P7+xoifLexpG0Me4XuCcxN_XYBVQyTrha_RSO8m-R5LfZUOg@mail.gmail.com>
Subject: Re: [PATCH v7 6/7] submodule: refactor show_submodule_summary with
 helper function
To:	David Aguilar <davvid@gmail.com>
Cc:	Jacob Keller <jacob.e.keller@intel.com>,
	Git mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <stefanbeller@gmail.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Aug 18, 2016 at 12:00 AM, David Aguilar <davvid@gmail.com> wrote:
>> +void show_submodule_summary(FILE *f, const char *path,
>> +             const char *line_prefix,
>> +             unsigned char one[20], unsigned char two[20],
>> +             unsigned dirty_submodule, const char *meta,
>> +             const char *del, const char *add, const char *reset)
>
>
> ... and here too.
>
> There's an ongoing effort to replace unsigned char sha1[20]
> with struct object_id.  It might make sense to pass "one" and
> "two" as "unsigned char*" instead of hard-coding the SHA1-length
> here.  Alternatively, we could pass in the struct object_id*
> instead.
>
> The [20] in the show_submodule_header() function above is
> pre-existing and not added by this patch, but that function's
> signature is touched by this patch so it might make sense to
> tidy that up while we're in here, possibly as a separate patch.
> --

I'll add a patch to the series that does this inbetween these commits.

Thanks,
Jake
