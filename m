Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE5001F516
	for <e@80x24.org>; Thu, 21 Jun 2018 18:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932891AbeFUSxV (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 14:53:21 -0400
Received: from mail-yw0-f172.google.com ([209.85.161.172]:39109 "EHLO
        mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932866AbeFUSxU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 14:53:20 -0400
Received: by mail-yw0-f172.google.com with SMTP id 81-v6so1528939ywb.6
        for <git@vger.kernel.org>; Thu, 21 Jun 2018 11:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vkt+5q7Ojm62HcTQR1uxnVt4EAjI8u6urG/9YJIzBC4=;
        b=q7qVQhD9ZzvIbf2DYDKL/h4DhI9Q6XpG+p1CZUaQOK7ZgP1SB5lXSmTD9s++SO2qdh
         ktweOq4o0mj9Ya3SH4e0e8kFzGxqUMkVmZynsWcVuLCCqkYELnQ4WsHTzcQ6cBm/oY3j
         yTVeBTnTFqySeyYPzIrV4W29XXXlf5V/M9C8MN+Z/5ISjFzi5atjl69iYVFMlNxa2QsG
         R/q5wk/SVT6ktLsbpIIAKJgGvYVMHr8p8Lx7rajFZ1oNaOfF86qcdyZ2EIJEPDEguxbt
         siOZfWoLaHeHHfK83MJrBfzYB2re1BRJbR/aR7FOGKzyti/0VXO5/5fYjm9GE+hS+PxG
         vGMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vkt+5q7Ojm62HcTQR1uxnVt4EAjI8u6urG/9YJIzBC4=;
        b=gdM9xuSuiAuh5Aop+oK/yQIsdCn6cC1FgAoOQedwIOOgVSJbBVDnp6vk883DrgLiFD
         Azc8uYlGXFbYHfb4tx3Pc/eHICR3kij8lYCCcXVwtnrdqH1inxEXK3XJDZOexrGkm9o8
         ElGFGTkDHqXcf22G2YURFD2dI5kC+e3n76QoqKVzIOfT3Dk5A0fuKRnfZC0SbgP3kWyE
         nMT0VPHMCeHBYgNn9sarMgnAowXKA/ewClfGbYb4dmEsrFe2g7LBHlszfByb7pT038gy
         UieNZ8DIOH6cq/+rJBygeZ+at7mVIkYcYjpbST7nw5UNmUZIezsr6nvd2KBpTChe0wFG
         fTqA==
X-Gm-Message-State: APt69E0ZRkdempE6tu2VfhN78ok7+eTSf0VrNQP9KqgnL/xmAiUBDF0R
        0Iel4vjSFk84TN8mMHEkz7CEd2XX3q1SFs7wiZ6cU4a9
X-Google-Smtp-Source: ADUXVKLACSpNIVcGAAVF+uImyhAT2N4W4+70CHJH+SbXXjr2z9c06hra71taiwFeoYxfm8sB9mIYIIZH8XqGw9KQuuc=
X-Received: by 2002:a0d:f442:: with SMTP id d63-v6mr12802131ywf.238.1529607198896;
 Thu, 21 Jun 2018 11:53:18 -0700 (PDT)
MIME-Version: 1.0
References: <20180514105823.8378-1-ao2@ao2.it> <20180514105823.8378-2-ao2@ao2.it>
 <CAGZ79kag=1h506FGg72_F9Rmz4nqPN19kaywfTtD3WnNWnxD9w@mail.gmail.com>
 <20180620200634.13b47725cfd1e2dfb1cd482e@ao2.it> <CAGZ79kaMbGdJjooqWLiNOabmujhNKKKJQb_HrZ4YUMVMQ--KbA@mail.gmail.com>
 <20180621155438.31b244a9d5d7b4723f85ba89@ao2.it>
In-Reply-To: <20180621155438.31b244a9d5d7b4723f85ba89@ao2.it>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 21 Jun 2018 11:53:07 -0700
Message-ID: <CAGZ79kaxMiPEaCTCjgwHjc8uQ58eCTquYiDN5WM9Vs7j9FTMSQ@mail.gmail.com>
Subject: Re: [RFC PATCH 01/10] config: make config_from_gitmodules generally useful
To:     Antonio Ospite <ao2@ao2.it>
Cc:     git <git@vger.kernel.org>, Brandon Williams <bmwill@google.com>,
        =?UTF-8?Q?Daniel_Gra=C3=B1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> OK, the fact I was overlooking was that the "config_fn_t" argument
> passed to config_from_gitmodules is what we are actually worried about,
> it's the config callback which could allow generic config in .gitmodules
> to sneak in.

That is the precise point that I was trying to communicate. :)

>
> So, from Brandon's message I derive that using the gitmodules_cb from
> submodules-config.c as a callback would be safe, as that's what
> repo_read_gitmodules already uses anyways, and it only allows submodules
> configuration.

I agree.

>
> However, what about avoiding exposing the dangerous interface altogether
> and adding ad-hoc helpers when needed?
>
> I mean:
>
>   0. Move config_from_gitmodules to submodule-config.c as per Bradon's
>      suggestion.

That sounds good to me.

>   1. Add public helpers in submodule-config.[ch] to handle backwards
>      compatibility, like: fetch_config_from_gitmodules() and
>      update_clone_config_from_gitmodules() these would be used by fetch
>      and update-clone function and would not accept callbacks.
>
>      This would mean moving the callback functions
>      gitmodules_fetch_config() and gitmodules_update_clone_config() into
>      submodule-config.c and making them private. The helpers will call
>      config_from_gitmodules() with them.
>
>   2. Now that config_from_gitmodules it's not used in the open it can be
>      made private too, so it can only be used in submodule-config.c
>
>   3. Use config_from_gitmodules in repo_read_gitmodules as the
>      gitmodules_cb function should be safe to use as a config callback.

That sounds all good to me.

>
>   4. Add a new gitmodules_get_value() helper in submodule-config.c which
>      calls config_from_gitmodules with a "print" callback and use that
>      helper for "submodule--helper config",
>
>   5. At this point we shouldn't worry too much about the .gitmodules
>      content anymore, and we can possibly extend config_from_gitmodules
>      to read from other locations like HEAD:.gitmodules.

These two would actually align with your goal of the original series. :)

>
> This way the number of users of config_from_gitmodules remains strictly
> controlled and confined in submodule-config.c
>
> I know, we could end up adding more code with the helpers but that could
> be justified by the more protective approach: we would be using symbols
> scoping rules instead of comments to ensure something.
>
> If you think this may be worth a shot I can send a series which covers
> items from 0 to 3.

That would be great!

Thanks,
Stefan

>
> Ciao,
>    Antonio
>
> P.S. Always relevant: https://youtu.be/8fnfeuoh4s8 (I swear it's not
> Rick Astley)

heh!
