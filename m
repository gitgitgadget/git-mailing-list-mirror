Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6ED271F4C0
	for <e@80x24.org>; Mon, 14 Oct 2019 20:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732638AbfJNUWd (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Oct 2019 16:22:33 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40763 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732598AbfJNUWd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Oct 2019 16:22:33 -0400
Received: by mail-qk1-f196.google.com with SMTP id y144so17053977qkb.7
        for <git@vger.kernel.org>; Mon, 14 Oct 2019 13:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xBOTjpHe+YiCsSYsHNLAORPO/aWcubthbNmJTy5V/dI=;
        b=GK7EdiD+3rHK9Kb58ittJQ7yEd/iMWgVbGfegg52H9jUmFOFXyo4oEd6QGTtzSQXkF
         AQHfq4Ip5Zfhl6ThGkco6/+jfydDNCEhxL1+1mtuArOBP8Lc/E/FyRCiDtx4nVnrbWD0
         r4uQg2a6gLxHdNyXo/8b1s0OQuEUAbGDiUeasJ3PiA8Uu9kZ7KZqgjKfOjIVkX5hYoyy
         lL6zvUE/0WRa9opoJGouM4Z46LkyHQ31ExuMMkFji14ue9EFVIwpnorzrXPeeZrk0P7+
         75hm3Cdx2ygxm/A9wOIH9TrZBCZahZUT8adLOr1p6HyGsbeXvtGLdr+6R3m3AkVi5PAb
         rwVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xBOTjpHe+YiCsSYsHNLAORPO/aWcubthbNmJTy5V/dI=;
        b=J47zJale8dl4aFr7xXqV5uRGxfXTJZD4rLnmfaqxRIxc6zeKtI4kJ+YGLNBp0LJppG
         WxOpgecylUoudXkxgToVmyi3cSKYhxspz/01nNO151XEY9aBKupnYv5DfJx/EzryZj5t
         J0FfuYhElsgN6EEoLqiWlqDXK7ABF8DrZmYDkt39MPcFh7XxMWFjG8SjnsZdZzgH7Abh
         st9cbjm+7BHVvDuEgTNhrxBx2n6A5iwNxpESoC98YkZjBC39EXVrF+N+s5mF2WaiV4gS
         rVDQKkRyTOs0xWwrjokx4VaKaJ+ZN4TCsz6ETWpP0e96HgAA9JAMKdNVnOjgT24JKGLP
         /WTw==
X-Gm-Message-State: APjAAAWYjB842Qg770/+y/mAbhq1lHH9f4C+wh+aAtBBOtlVfwmza5DG
        /PagTLZajrmYOQwBC0Jx+2g=
X-Google-Smtp-Source: APXvYqzflj0apI0grmtz1xY+fs/c72KXbTl5deWOMUcBUp37RUZC6ZFfGJqphhLfQ+IHlVMmZMThew==
X-Received: by 2002:a37:2f81:: with SMTP id v123mr31709774qkh.252.1571084552003;
        Mon, 14 Oct 2019 13:22:32 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:4807:bd77:fc97:8ac8? ([2001:4898:a800:1010:f93c:bd77:fc97:8ac8])
        by smtp.gmail.com with ESMTPSA id f27sm8111458qkh.42.2019.10.14.13.22.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2019 13:22:31 -0700 (PDT)
Subject: Re: [PATCH v3 02/17] sparse-checkout: create 'init' subcommand
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.316.v2.git.gitgitgadget@gmail.com>
 <pull.316.v3.git.gitgitgadget@gmail.com>
 <08bb6fb7f31b92395df4db10bf47e9a9c01257f4.1570478905.git.gitgitgadget@gmail.com>
 <CABPp-BHd9sJ=HcM-VQaGpd5TV-A0JL5NWG6zdDReUJrMnE+FwA@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <91b9126d-8b50-8648-d5c1-25e4c6c68f8b@gmail.com>
Date:   Mon, 14 Oct 2019 16:22:30 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BHd9sJ=HcM-VQaGpd5TV-A0JL5NWG6zdDReUJrMnE+FwA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/11/2019 6:14 PM, Elijah Newren wrote:
> On Mon, Oct 7, 2019 at 1:08 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> ++
>> +The init subcommand also enables the 'extensions.worktreeConfig' setting
>> +and sets the `core.sparseCheckout` setting in the worktree-specific config
>> +file. This prevents the sparse-checkout feature from interfering with other
>> +worktrees.
> 
> I'm afraid that might be mis-parsed by future readers.  Perhaps something like:
> 
> The init subcommand also enables the `core.sparseCheckout` setting.

I like the paragraph below, but the sentence above is repeated from
the earlier paragraph.

> To avoid interfering with other worktrees, it first enables the
> `extensions.worktreeConfig` setting and makes sure to set the
> `core.sparseCheckout` setting in the worktree-specific config file.
> 
>> +enum sparse_checkout_mode {
>> +       MODE_NONE = 0,
>> +       MODE_FULL = 1,
>> +};
> 
> So MODE_FULL is "true" and MODE_NONE is "false".  MODE_NONE seems
> confusing to me, but let's keep reading...
> 
>> +
>> +static int sc_set_config(enum sparse_checkout_mode mode)
>> +{
>> +       struct argv_array argv = ARGV_ARRAY_INIT;
>> +
>> +       if (git_config_set_gently("extensions.worktreeConfig", "true")) {
>> +               error(_("failed to set extensions.worktreeConfig setting"));
>> +               return 1;
>> +       }
>> +
>> +       argv_array_pushl(&argv, "config", "--worktree", "core.sparseCheckout", NULL);
>> +
>> +       if (mode)
>> +               argv_array_pushl(&argv, "true", NULL);
>> +       else
>> +               argv_array_pushl(&argv, "false", NULL);
> 
> Wait, what?  MODE_FULL is used to specify that you want a sparse
> checkout, and MODE_NONE is used to denote that you want a full (i.e.
> non-sparse) checkout?  These are *very* confusing names.

I understand they are confusing, hopefully it makes more sense with
the cone mode later.

* NONE == "No patterns at all"
* FULL == "all patterns allowed"
* CONE == "only cone patterns" (appears later)

Since this is just an internal detail, what if I switched it to

* MODE_NO_PATTERNS
* MODE_ALL_PATTERNS
* MODE_CONE_PATTERNS

Would that make more sense?

>> +static int sparse_checkout_init(int argc, const char **argv)
>> +{
>> +       struct pattern_list pl;
>> +       char *sparse_filename;
>> +       FILE *fp;
>> +       int res;
>> +
>> +       if (sc_set_config(MODE_FULL))
>> +               return 1;
> 
> Seems confusing here too.
> 
> 
> Everything else in the patch looks good, though.

Thanks,
-Stolee
