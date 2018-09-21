Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 678711F453
	for <e@80x24.org>; Fri, 21 Sep 2018 15:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390398AbeIUVJq (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 17:09:46 -0400
Received: from mail-qt1-f181.google.com ([209.85.160.181]:40361 "EHLO
        mail-qt1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390267AbeIUVJp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 17:09:45 -0400
Received: by mail-qt1-f181.google.com with SMTP id e9-v6so1654545qtp.7
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 08:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=8fUbWJLDtuw2a0gmrWLHpGdTlYIN37jCU/uhLComxjM=;
        b=HHdtusq4xKhLGqz9Cz/rRIbLTgNQdUi8fDpatzeKNtOWywatDNB5rJ9E6jsqxIIbWf
         N1SjxiEWJBYC3CR2R2E9kIVOnJ0raEl2zjKdb15O+Q1FcbY6t4hw4Cvkrw5ea5CfCjLM
         MSAk81SxhULy5Ml4IVS3eylhe8XbWWS7tDJMDDFiTQon28MP9F5I7/cQ8gOucmFf5kH3
         cVijwpUsUKIJDybbvfEtH6XuVtnRoVY/LjDKsjmC5RacUv5/M98NElr5wDKZB0ciKAZe
         zAlSF8PquDdncHH/QaiJqlvQma0ytI9QLKp7+khnJw0nZsgGB413HtxZ17IgVUqZDNZy
         Whag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=8fUbWJLDtuw2a0gmrWLHpGdTlYIN37jCU/uhLComxjM=;
        b=dsbYAIhdCagWGqO9nfRciyZLvEvkg6tueYlmqZAYhn/olxnWEJryJek9MIxnQgzOPD
         1JF1ULEU3s1FUK/7FqXGReyn3+ZimLOVbd9b+ugRHch29vRitMnoKnG1+XKBB315lh1b
         GQ4UFkNNsJU8iRmY0IAr2pWAJiYJQ9/0FDpPJWA+XehAviXt3RZg4ITy+X83Nv8CVLDf
         M+PFjxDFKQouicSSc2720UAcg8+/76BxKElhD5BxeD/RdIH/jlT0TlFmDDBFBT8R+em8
         iHTblBOtZ80mrjvl8pNffTUL2ef2iUyDAI5eQVAOUcb3gx1xkYpaSkREcXgZ7sk1Spil
         aKcg==
X-Gm-Message-State: APzg51C6YzIQVLe1ndhKx5g3F+knAI8c1bBIfLYfQs4zmJ11EJBEC0ek
        pvwMwClq2nxY3L3bT4HMoPs=
X-Google-Smtp-Source: ANB0VdZeJby0Fk88ZZEgRngWCZ6o5RV2P5pxwwI7+VVv6VJCGvAnh7USYj3GeIpr+35LA8zfo84kDw==
X-Received: by 2002:ac8:6a05:: with SMTP id t5-v6mr32640681qtr.249.1537543223752;
        Fri, 21 Sep 2018 08:20:23 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:f452:f7ab:45dd:bf7c? ([2001:4898:8010:0:dd88:f7ab:45dd:bf7c])
        by smtp.gmail.com with ESMTPSA id t139-v6sm2907464qke.58.2018.09.21.08.20.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 08:20:22 -0700 (PDT)
Subject: Re: [PATCH v3 0/1] contrib: Add script to show uncovered "new" lines
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     peff@peff.net, Junio C Hamano <gitster@pobox.com>
References: <pull.40.v2.git.gitgitgadget@gmail.com>
 <pull.40.v3.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ee607ff3-b13e-b034-f0cc-03ee458e187e@gmail.com>
Date:   Fri, 21 Sep 2018 11:20:22 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <pull.40.v3.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/21/2018 11:15 AM, Derrick Stolee via GitGitGadget wrote:
> For example, I ran this against the 'next' branch (22e244b)
> versus 'master' (150f307) and got the following output:
>
> fsck.c
> fb8952077df     (René Scharfe   2018-09-03 14:49:26 +0000       212)            die_errno("Could not read '%s'", path);
> list-objects-filter-options.c
> f12b8fc6d3b     (Matthew DeVore 2018-09-13 17:55:27 -0700       56)                     if (errbuf) {
> f12b8fc6d3b     (Matthew DeVore 2018-09-13 17:55:27 -0700       57)                             strbuf_init(errbuf, 0);
> f12b8fc6d3b     (Matthew DeVore 2018-09-13 17:55:27 -0700       58)                             strbuf_addstr(
> f12b8fc6d3b     (Matthew DeVore 2018-09-13 17:55:27 -0700       62)                     return 1;
> list-objects-filter.c
> 77d7a65d502     (Matthew DeVore 2018-09-13 17:55:26 -0700       47)             BUG("unknown filter_situation: %d", filter_situation);
> f12b8fc6d3b     (Matthew DeVore 2018-09-13 17:55:27 -0700       100)    default:
> f12b8fc6d3b     (Matthew DeVore 2018-09-13 17:55:27 -0700       101)            BUG("unknown filter_situation: %d", filter_situation);
> 77d7a65d502     (Matthew DeVore 2018-09-13 17:55:26 -0700       152)            BUG("unknown filter_situation: %d", filter_situation);
> 77d7a65d502     (Matthew DeVore 2018-09-13 17:55:26 -0700       257)            BUG("unknown filter_situation: %d", filter_situation);
> 77d7a65d502     (Matthew DeVore 2018-09-13 17:55:26 -0700       438)            BUG("invalid list-objects filter choice: %d",
> list-objects.c
> f447a499dbb     (Matthew DeVore 2018-08-13 11:14:28 -0700       197)                    ctx->show_object(obj, base->buf, ctx->show_data);
> ll-merge.c
> d64324cb60e     (Torsten Bögershausen   2018-09-12 21:32:02 +0200       379)                    marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
> midx.c
> 56ee7ff1565     (Derrick Stolee 2018-09-13 11:02:13 -0700       949)            return 0;
> cc6af73c029     (Derrick Stolee 2018-09-13 11:02:25 -0700       990)                    midx_report(_("failed to load pack-index for packfile %s"),
> cc6af73c029     (Derrick Stolee 2018-09-13 11:02:25 -0700       991)                                e.p->pack_name);
> cc6af73c029     (Derrick Stolee 2018-09-13 11:02:25 -0700       992)                    break;
> remote-curl.c
> c3b9bc94b9b     (Elijah Newren  2018-09-05 10:03:07 -0700       181)            options.filter = xstrdup(value);
> submodule.c
> df255b8cac7     (Brandon Williams       2018-08-08 15:33:22 -0700       1738)           die(_("could not create directory '%s'"), new_gitdir.buf);

I updated this output, but then forgot that I had a "commentary" of the 
old diff below it. Please ignore that portion of the cover letter.

-Stolee

