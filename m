Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E56E820798
	for <e@80x24.org>; Wed, 11 Jan 2017 23:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757779AbdAKXrf (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jan 2017 18:47:35 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36222 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754039AbdAKXre (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2017 18:47:34 -0500
Received: by mail-lf0-f67.google.com with SMTP id h65so264611lfi.3
        for <git@vger.kernel.org>; Wed, 11 Jan 2017 15:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8kiBbxYfqCyjXNdcwXv+4NcCa3fPDJ9jQcjjQXWozMM=;
        b=OQCfC+RHqEa+1CVBmVtvh/0VhCrNqpope66xJmjbSrYg7xrJmlBjjzuP4L8uWNJcXr
         wg/dlpNnpsv8/36TqfULGP2OK2avFN2X2E8yKOfMprn7wn5ux7+Y7Q0KGMuD029GbmO7
         KH6+Bk1sSoT/F1nyTY3eUjVd7oI9a81ZLE7mx4Ai9H4///JbpR++/OTvR9rERg1DXyP2
         TND4vR+uR1izHVbmT36s2EBmiNognCHaWOGtgdbHl3R12TaLtmm4YetbOdTbF6yKn5aG
         ikf0SGdVRXlA9Cl0V4yg3MPiRqyOdMTN9MEAafXAhoxRU5u5uGtIi0uWp+4vJG2eJJoD
         a4Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8kiBbxYfqCyjXNdcwXv+4NcCa3fPDJ9jQcjjQXWozMM=;
        b=IAKxJtnW9GAK5Rq1LtZIGD3fztEzjFRbFWab7uhDAsN0PW4jj98VnIkWdE3VSsSzgO
         UyxLom5e6R2ua4tGqk0Urq2CQAi6DeC+CnQxFAw5IMb0S9jLfIbJQpdfDq8C1IxjFlqF
         C8PrEFxdoRei85q4AN7OEM0Jj5PUOcR8nGFU/ijpL/tQnArIFdtJUDdTdWh7sg5h6k+v
         NyulaZ6pzawAXbdPUznQ+7HALahWeMgmhxGO0i0siqYoWTwGOfVQ85u589ho06m2GLHW
         Oa3D08QhFc0JmXHbWuLALbkdaCj2pb65AyTizwIu++05eKrWYXJondX3MLzmUFiDJ3GF
         9tQg==
X-Gm-Message-State: AIkVDXJKHFwx9RvoRA9ZbbmY56jhdoyuZYvsesOaOrw0unECtqO3FJ/+AEbUWQbSxjHsruLUyk5i11Ifut5JdA==
X-Received: by 10.25.27.145 with SMTP id b139mr3698760lfb.114.1484178446744;
 Wed, 11 Jan 2017 15:47:26 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.14 with HTTP; Wed, 11 Jan 2017 15:47:06 -0800 (PST)
In-Reply-To: <20170110084953.15890-20-Karthik.188@gmail.com>
References: <20170110084953.15890-1-Karthik.188@gmail.com> <20170110084953.15890-20-Karthik.188@gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 11 Jan 2017 15:47:06 -0800
Message-ID: <CA+P7+xqV+CJwP-0_27V26UZbkDzBqbdstGw_Rq=8c3SkjAq2bA@mail.gmail.com>
Subject: Re: [PATCH v10 19/20] branch: use ref-filter printing APIs
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 10, 2017 at 12:49 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> diff --git a/builtin/branch.c b/builtin/branch.c
> index 34cd61cd9..f293ee5b0 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -37,11 +37,11 @@ static unsigned char head_sha1[20];
>  static int branch_use_color = -1;
>  static char branch_colors[][COLOR_MAXLEN] = {
>         GIT_COLOR_RESET,
> -       GIT_COLOR_NORMAL,       /* PLAIN */
> -       GIT_COLOR_RED,          /* REMOTE */
> -       GIT_COLOR_NORMAL,       /* LOCAL */
> -       GIT_COLOR_GREEN,        /* CURRENT */
> -       GIT_COLOR_BLUE,         /* UPSTREAM */
> +       GIT_COLOR_NORMAL,       /* PLAIN */
> +       GIT_COLOR_RED,          /* REMOTE */
> +       GIT_COLOR_NORMAL,       /* LOCAL */
> +       GIT_COLOR_GREEN,        /* CURRENT */
> +       GIT_COLOR_BLUE,         /* UPSTREAM */
>  };


What's... actually changing here? It looks like just white space? Is
there a strong reason for why this is changing?

Thanks,
Jake
