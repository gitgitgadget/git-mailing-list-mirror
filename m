Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16DE8201C2
	for <e@80x24.org>; Tue, 14 Mar 2017 18:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750948AbdCNSkS (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 14:40:18 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:35441 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750904AbdCNSkR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 14:40:17 -0400
Received: by mail-pg0-f46.google.com with SMTP id b129so94592997pgc.2
        for <git@vger.kernel.org>; Tue, 14 Mar 2017 11:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JKkBvH2sU0RbYIUYmsHBpUiazPcKt8qymQDBbrPsDm4=;
        b=gY76EbDWI/QDUbBnWT0yktB6UrdbElF6WfEtEbPuQM+1E/O2NHwRhdAmzecS2m6h6y
         VCzUyOhzashpfw6Ha9VGM/bqaiGrqSBI2YM+AlrhzlGXwYQ0vPguHjVAyoWze2vg1zn8
         tfwhptWBzTecJ6bIAoHmjLeqxbZby1niOxoP6XA5Bs8OWZTgABcgt/Csi6BK6G3sWEPe
         wySn838+JYlznIVkLEaCTa8BJOdLmPeTU3ij1mNztE0Fj0A7WofMyMEqdv45PWwnhkSh
         XueMPcUrAgjF/djvMV44UE3t5GFDc87eIVARazeLnWsPYxMx8C/FIMla2ayRX6MhnLXg
         IyoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JKkBvH2sU0RbYIUYmsHBpUiazPcKt8qymQDBbrPsDm4=;
        b=MC468isBpNVb/vIq5LcyJAqJb10Wc0WF/QzPt7hP97i2BXYFhToXAd0paOJMOIVtgN
         y4UqbUu03ezTEk9KDstbfl1eSUN5G5s7Owr5uhH1//Ii2UzGaDLXEtO2HTNngkVvkGiA
         GVOp0Q1k8Ony8o9MM1a+SmRLCEJBnuhmweJrfOsJ368S3UsoPFlqkGP15spJX5qKTtGB
         1+lR5aGZchlvESfDO02HRh0Geh6jY80TGnvqfm0CeMxBR/5QTPrutKSRUcC6sxqyy8Yo
         oQXeAkQGLA3UT0TRyA8oU6Xn4bkedYkF5mLOza4vI4o0ihjRwIu6F56iSrT124W6aSVR
         D6qw==
X-Gm-Message-State: AMke39maVAF1L6QeJ1/mRC8YIhmLtUUz6AffBVAoLSVdvdKnD9VQMbi+YB0hafHkWnnDWIn+6CveEx4TbRgOCUYW
X-Received: by 10.99.98.6 with SMTP id w6mr44819160pgb.223.1489516816382; Tue,
 14 Mar 2017 11:40:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.187.5 with HTTP; Tue, 14 Mar 2017 11:40:15 -0700 (PDT)
In-Reply-To: <xmqq4lyvka1i.fsf@gitster.mtv.corp.google.com>
References: <20170309012345.180702-1-bmwill@google.com> <20170313214341.172676-1-bmwill@google.com>
 <20170313214341.172676-5-bmwill@google.com> <xmqq4lyvka1i.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 14 Mar 2017 11:40:15 -0700
Message-ID: <CAGZ79kZ20Jy_A8SPJte7U0iZZB97P0Sn_PqAMfwp40sAj6Y=RA@mail.gmail.com>
Subject: Re: [PATCH v3 04/10] submodule--helper clone: check for configured
 submodules using helper
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 14, 2017 at 11:06 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Brandon Williams <bmwill@google.com> writes:
>
>> -     /*
>> -      * Looking up the url in .git/config.
>> -      * We must not fall back to .gitmodules as we only want
>> -      * to process configured submodules.
>> -      */
>> -     strbuf_reset(&sb);
>> -     strbuf_addf(&sb, "submodule.%s.url", sub->name);
>> -     git_config_get_string(sb.buf, &url);
>> -     if (!url) {
>> +     /* Check if the submodule has been initialized. */
>> +     if (!is_submodule_initialized(ce->name)) {
>>               next_submodule_warn_missing(suc, out, displaypath);
>>               goto cleanup;
>>       }
>> @@ -835,7 +827,7 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
>>               argv_array_push(&child->args, "--depth=1");
>>       argv_array_pushl(&child->args, "--path", sub->path, NULL);
>>       argv_array_pushl(&child->args, "--name", sub->name, NULL);
>> -     argv_array_pushl(&child->args, "--url", url, NULL);
>> +     argv_array_pushl(&child->args, "--url", sub->url, NULL);
>
> Even without this patch, we already had an instance of struct submodule
> available in this function, so the query to .git/config this patch removed
> was unnecessary?
>
> I am wondering what was meant by the comment "We must not fall back to..."
> that is being removed---is that because sub->url can come from .gitmodules
> that is in-tree, not from .git/config?

Yes. We want to check for the submodule being "initialized", i.e.
having a url in .git/config. (and the struct submodule reads in both .git/config
and .gitmodules and overlays them with a given precedence order)

>  If that is the case, doesn't the
> change in this hunk change behaviour from using the URL the user prefers
> to using the URL the upstream suggests, overriding user's configuration?

The mentioned precedence makes sure to have the right order:

    /* Overlay the parsed .gitmodules file with .git/config */
    gitmodules_config();
    git_config(submodule_config, NULL);

such that the sub->url is correct as a URL, but not correct as a boolean
indicator if the submodule is "initialized".
