Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 184841FD99
	for <e@80x24.org>; Fri, 26 Aug 2016 19:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752643AbcHZTRg (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 15:17:36 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:35326 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751610AbcHZTRg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 15:17:36 -0400
Received: by mail-it0-f43.google.com with SMTP id x131so7981156ite.0
        for <git@vger.kernel.org>; Fri, 26 Aug 2016 12:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pPgWvzK9lquZ8XwVAceEqjd9fWo1fGPO0F+3WLG4NSU=;
        b=hJJvhMIyXnzDlQlryrOvjhk/udWhvX3iez6eYKvv4N93KWCc1R2Ktr1+FmCJSbcBN5
         BEmXQi+t53EvAF+KcFbswVvOkPSH9UDkJ5lCUIXtSuAg9d0vHrmSmGeGI7wU3WajrpJ+
         PnuUg9Z6D8OlKUAQZ/fpzNy8xcfZHgR2CNgJQKXHz8lbazK+suvIK3C/gPGoL6X624HZ
         4BUJzyof+8/qWwVAhjopp3vFq+o5EF86lSxPtEo07AWgwaRvORhuC0DqYvyWf7W6b72g
         QoK6ZmMUU+DRnvWIAaQw0NKe1Jx9JZPbm6Eog2UItT4uDH767iZ3zeoXPCZTcEaQLPh+
         C7dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pPgWvzK9lquZ8XwVAceEqjd9fWo1fGPO0F+3WLG4NSU=;
        b=AJpMky81+X9911msrUPFWb0SS7rvSO6HBagMR4gMh4/v78l1nfilOSQWf0Y6XuV8rG
         0fGkVOQeo+3vbws7GB1IOVfp8NT5ulWwmUnz0+BCZxBUdZhrRqoYH+d5HwduCU+HaHVf
         GeCgBX8/18RmyXhP6UT3xERDng62kq3phdu2Z9qjaKKL12evzO5/+DaGp8rBK/sId9Tq
         MhHeib4LQU0FbwQLvh2jFtnaJbUmKee9bd2UEZBG7Qg5K718Ag42TaKmncqctrfSkiO0
         GrcSf7+L9KJs33SA8Eu51ZtBI5dinnTGWRFf3uHmLY7BZJeN3xYRGgo6m0Q+d9EObnJ+
         3hMg==
X-Gm-Message-State: AE9vXwP5o9ETfx1UqTHpcMwHHqB3OyJqo5s5ALsgc+aZXXq08eghutz5Wvw/wmFioUNcMOWpoxyfREL3pBzi7WKt
X-Received: by 10.107.131.38 with SMTP id f38mr5996968iod.173.1472239055184;
 Fri, 26 Aug 2016 12:17:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Fri, 26 Aug 2016 12:17:34 -0700 (PDT)
In-Reply-To: <20160825233243.30700-1-jacob.e.keller@intel.com>
References: <20160825233243.30700-1-jacob.e.keller@intel.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 26 Aug 2016 12:17:34 -0700
Message-ID: <CAGZ79kao12f8VTT3uxRvAUBhvbfSLjsYRjidTau3M-Kf81uXDQ@mail.gmail.com>
Subject: Re: [PATCH v11 0/8] submodule inline diff format
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 25, 2016 at 4:32 PM, Jacob Keller <jacob.e.keller@intel.com> wrote:

> @@ -487,12 +490,14 @@ static void do_submodule_path(struct strbuf *buf, const char *path,
>                 strbuf_addstr(buf, git_dir);
>         }
>         if (!is_git_directory(buf->buf)) {
> +               gitmodules_config();

We determined via chat that calling gitmodules_config
is not harmful w.r.t. correctness, but might require some
improvements in the future for performance.
(i.e. we may want to add in a later series a
    if (already called gitmodules_config)
      set flag "already called gitmodules_config";
      return;
into gitmodules_config)

>
>  char *git_pathdup_submodule(const char *path, const char *fmt, ...)
>  {
> +       int err;
>         va_list args;
>         struct strbuf buf = STRBUF_INIT;
>         va_start(args, fmt);
> -       do_submodule_path(&buf, path, fmt, args);
> +       err = do_submodule_path(&buf, path, fmt, args);
>         va_end(args);
> +       if (err)

Here we need a strbuf_release(&buf) to avoid a memory leak?
