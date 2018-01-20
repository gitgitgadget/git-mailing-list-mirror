Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2ABF21F404
	for <e@80x24.org>; Sat, 20 Jan 2018 01:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756037AbeATBJU (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 20:09:20 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:46772 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753054AbeATBJT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jan 2018 20:09:19 -0500
Received: by mail-qt0-f195.google.com with SMTP id o35so8205853qtj.13
        for <git@vger.kernel.org>; Fri, 19 Jan 2018 17:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=jH+YPOqGpkwkF007I0e1cI3GMxs3kFcZIO2R1wKp0aM=;
        b=RDxLHzmt5slMYeMBrvPMzswSF/3fTLfauZ/E/kHCWrHNWP4dgEiJvJBQJNDQYgW/3B
         GNQPwbYoucFH+FOnlbFOGGbtWBlP4sxUg6i1jDv8ZNA/HmCymVW0yVXMpwY/R2C/5fhZ
         dVrNvI4NQJjYJTn8VrIVUg58gG0ZltBZd7IDZowB/0civ7ma+qCHStEWaCmZX3BCCCgF
         GU0ukbza2td8YZOu+sCIKNeYn5xrYltCQ0bGOjhs83AIl2vEBHfa8kl1pIUZFc2pkLAc
         bJIaSIOP5w8VMY1Rndn8oJFxbRB7UvfdQsidLwL82eYZ7snWltldUBxCLl9diWoxJBtI
         KxNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=jH+YPOqGpkwkF007I0e1cI3GMxs3kFcZIO2R1wKp0aM=;
        b=DO4wIrnbhI4ETTz26ltsw30+YrShzspNLhJMFZtZ9YQ9i+DoDZLE5PeVJMKjIQHpSc
         6pIpbbn5oCC/aVWweute9IytpGPlzTF4wanc1HOfCK35Bn0OxMARBYzMxS0cy2/fieuq
         DpZBUbLri/upSg4rY63Gkg89CW2jZCvPYLe65KtrGVxQfkoClEPz9eSzhqvmLtAo95bX
         MHXUkrYwiaIvVZAvTD9Hybh02n6hIiyWjL7V+7L055wZrkUY3+er0I1LVTBPnQPVIiR6
         apBDmLzQvMWUxarAWKAJfcM+iYIWNlip2MywPsaY7EGV1Uz1LhWTX9yitKy8QH0+pNsj
         Q9/g==
X-Gm-Message-State: AKwxytf0JZW25PVhyBq2YaeEksBtiZbR4YHc6YHr2QBrUSB+U/p82MAi
        GhNTQoit1ADDAs17bGg674y77bAVPudPKgWJ63c=
X-Google-Smtp-Source: AH8x224TErc8LdsRC1VUjiEuvELqcFDmqUT71x4FKj6vGjnLlNs8wV5Wo410vInLWIrvy0YNOa0DejfUnnztYLhXe5Q=
X-Received: by 10.200.9.42 with SMTP id t39mr536712qth.74.1516410558422; Fri,
 19 Jan 2018 17:09:18 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.175.239 with HTTP; Fri, 19 Jan 2018 17:09:18 -0800 (PST)
In-Reply-To: <e3c3c703f8eae723c4fbbd08d2c329d81179dbee.1516225925.git.johannes.schindelin@gmx.de>
References: <cover.1516225925.git.johannes.schindelin@gmx.de> <e3c3c703f8eae723c4fbbd08d2c329d81179dbee.1516225925.git.johannes.schindelin@gmx.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 19 Jan 2018 20:09:18 -0500
X-Google-Sender-Auth: CzejHzYcJH8mWss4V6hYmMI1QBs
Message-ID: <CAPig+cRcj7nDv1+nmzw5WiOBLPB00EBv-tz=6sLAzM3iXLKvFw@mail.gmail.com>
Subject: Re: [PATCH 8/8] rebase -i: introduce --recreate-merges=no-rebase-cousins
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 18, 2018 at 10:36 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> This one is a bit tricky to explain, so let's try with a diagram:
> [...]
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
> @@ -57,8 +59,13 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
> +       if (no_rebase_cousins >= 0&& !recreate_merges)

Style: space before &&

> +               warning(_("--[no-]rebase-cousins has no effect without "
> +                         "--recreate-merges"));
