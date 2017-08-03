Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B06261F991
	for <e@80x24.org>; Thu,  3 Aug 2017 18:57:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751911AbdHCS5w (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 14:57:52 -0400
Received: from mail-lf0-f51.google.com ([209.85.215.51]:37311 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751739AbdHCS5v (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 14:57:51 -0400
Received: by mail-lf0-f51.google.com with SMTP id m86so9860429lfi.4
        for <git@vger.kernel.org>; Thu, 03 Aug 2017 11:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Uom3N6OQCPrt0tGAnaz6L3rKG1m6+JiEqHJOoX75wac=;
        b=n2nMbiMCRIR/vJtrNozK4bLoKWApm5gY8Q5uv5nkqMnaswk7u0O8rv/aCNytKP5i4J
         dly/eQ0PdJ3K2hlkRkwGtiXsXwmH26r5YMg7gzuB42AjFBVI9mLcACjEBjiRwqYHCaEW
         1nvfe8OGdDNBa93mEa3pUbg3a9vGzVn2EX4j9l4eb05lPkKNFiIfF7aU/RgrQ2lMBdIV
         llX9GLKt2VBKqvsaQU9XGMqyFFWK8EFSs9rimGySTpbbj7Hvl1EGgkdP4NkQyiJgw23L
         pbIf250SURkYncMErNPbLJxiBTM6VHgyblY2g1/4BD/zV/Rq8SQ7viD0cDM81mbcE0WG
         bMhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Uom3N6OQCPrt0tGAnaz6L3rKG1m6+JiEqHJOoX75wac=;
        b=Nyxl/WkdcbZv1zpgwEJFDtUtkeiVqRcLGd6a+EQJkflTdfaEDBVO1oFrOBjN6yyjst
         qwaMtIhiugwEky8zZvVo6c9bJLPE4vDOegUy/HIECEMbJe1m1ZVEglvwDVcGnTh3TqWt
         3xe5EmVeDJQUESINW4JGvwJxERpQapQjerA4DKs2uUqsQxo1Fuz3F5P3qhnEpVzGj3l3
         Ja5bFOi+1RWh8G45YrFAvG/XxD1i9vdTaJDBNlHFEm5AdNSqX63V3uPah3qezmhc9xhV
         MVX8UE1zbW2rvq9QBnYRhbAf9sygnRvLYEmCVMe1Wj8HQ3ak0FdMHaFjwtFqVn/628QJ
         HbcQ==
X-Gm-Message-State: AHYfb5gmtQEhhPDery1XjsVBpND95W2ogiUZ1kfLWq+CTgQJ3bnFLhjg
        O4RMnFw11xWQjmwsTsEhc1Uhi1Y+ZELE
X-Received: by 10.25.15.221 with SMTP id 90mr973323lfp.220.1501786670258; Thu,
 03 Aug 2017 11:57:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.1.130 with HTTP; Thu, 3 Aug 2017 11:57:49 -0700 (PDT)
In-Reply-To: <20170803182000.179328-3-bmwill@google.com>
References: <20170725213928.125998-1-bmwill@google.com> <20170803182000.179328-1-bmwill@google.com>
 <20170803182000.179328-3-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 3 Aug 2017 11:57:49 -0700
Message-ID: <CAGZ79kaZcpZ-6+=19CbW1v+h-njguXZH9z9GMYA3Ci=acfreKQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/15] submodule: don't use submodule_from_name
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jens Lehmann <Jens.Lehmann@web.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 3, 2017 at 11:19 AM, Brandon Williams <bmwill@google.com> wrote:
> The function 'submodule_from_name()' is being used incorrectly here as a
> submodule path is being used instead of a submodule name.  Since the
> correct function to use with a path to a submodule is already being used
> ('submodule_from_path()') let's remove the call to
> 'submodule_from_name()'.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>

In case a reroll is needed, you could incorperate Jens feedback
stating that 851e18c385 should have done it.

> ---
>  submodule.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/submodule.c b/submodule.c
> index 5139b9256..19bd13bb2 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1177,8 +1177,6 @@ static int get_next_submodule(struct child_process *cp,
>                         continue;
>
>                 submodule = submodule_from_path(&null_oid, ce->name);
> -               if (!submodule)
> -                       submodule = submodule_from_name(&null_oid, ce->name);
>
>                 default_argv = "yes";
>                 if (spf->command_line_option == RECURSE_SUBMODULES_DEFAULT) {
> --
> 2.14.0.rc1.383.gd1ce394fe2-goog
>
