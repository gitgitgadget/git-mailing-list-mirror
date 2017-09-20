Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7BCE20281
	for <e@80x24.org>; Wed, 20 Sep 2017 22:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751547AbdITWG4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 18:06:56 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:54127 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751465AbdITWGz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 18:06:55 -0400
Received: by mail-qk0-f173.google.com with SMTP id t184so4136909qke.10
        for <git@vger.kernel.org>; Wed, 20 Sep 2017 15:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=omZqnCwE7yPjVONkgCG1nQTTJ6D+B7AGyOu84Z9hb28=;
        b=a/snqTxUTsQGJQ2y4O+iJ+YEN7SkJ+HCwnJaiFlA3mJ5WfraHbnE0O3xKOWS210qAV
         mcU7tVFOTtfVUCkkCxxQhu1w3btlk8n6Y1roX96+65upeqhlswptGVFOKPBO3AdKtBee
         2EomrCd5QFmMdjcxQcsQqDU0y/VQBpWKvWTUxHATMV8J81dDOU6HOpJOMht9sKlAhpeO
         OAW8IdazuYZCj9yip37zQTrjW93dwP/0e4xu4yVbfj47HpL3xHf2YwiZCYbAqP6YcWbr
         8/sqPUWuOmE/muo+yUlAmhl4z19oV7x7ekDjMnl07EdWzBXi4a7Owa01UNZ9PIAe8M5a
         UTEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=omZqnCwE7yPjVONkgCG1nQTTJ6D+B7AGyOu84Z9hb28=;
        b=mNXKpdHKYAaXFdFSTlrRm4qoF8Z+Vaj+8L0mOZuqaPSdsrjSJqwByTYDisY3v2d+HL
         Zq43RC/vggRnEU8GTf+Pge2yvfVc/p4nMQa5us/1fy3+WxD6vYZ0e6yAcRpDPuBOHEQn
         Gs10SZQQc5pp9oDrR1spYMxxvwCDtlTmqRZK8/7A/wjqjl5PLUzocNUg1MI151e6wJ8n
         fyYy32c+nWL/eazoqOWp9+pHirICAFiuTAMwqkmfd74Kq8qTU6RKiqHncYXUsjIdmlxP
         uLL5Ve7bYV+jqsSMHmos5+EgyScDOX9+UrsljqjxEXk1z5eoQGqionmAOQh8+LRQWadu
         mxCQ==
X-Gm-Message-State: AHPjjUhbJsTYCZtj9ST/0qLilAi7KkQNx9047m0lUU1IfSBUI9NDPkK9
        YB9/Nfqx45enVFpUL0uUSM5U3qXtoXRcJldy9l70aw==
X-Google-Smtp-Source: AOwi7QCM8sYtl+WN5AMj6T6nqLfGZNijuJkNS/fWjjyHjGBberSzh31Ht1pet7fBl2EpMH1C42pBR1wSUAAsneRgVvY=
X-Received: by 10.55.150.199 with SMTP id y190mr293160qkd.180.1505945214727;
 Wed, 20 Sep 2017 15:06:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.51 with HTTP; Wed, 20 Sep 2017 15:06:54 -0700 (PDT)
In-Reply-To: <20170919192744.19224-3-benpeart@microsoft.com>
References: <20170915192043.4516-1-benpeart@microsoft.com> <20170919192744.19224-1-benpeart@microsoft.com>
 <20170919192744.19224-3-benpeart@microsoft.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 20 Sep 2017 15:06:54 -0700
Message-ID: <CAGZ79kaJWDWGgqRGTdgc+RjVxAb52CpUCk2DCotSksni4cH1Ww@mail.gmail.com>
Subject: Re: [PATCH v7 02/12] preload-index: add override to enable testing preload-index
To:     Ben Peart <benpeart@microsoft.com>
Cc:     David Turner <David.Turner@twosigma.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 19, 2017 at 12:27 PM, Ben Peart <benpeart@microsoft.com> wrote:
> Preload index doesn't run unless it has a minimum number of 1000 files.
> To enable running tests with fewer files, add an environment variable
> (GIT_FORCE_PRELOAD_TEST) which will override that minimum and set it to 2.

'it' being the number of threads ('it' was not mentioned before,
so reading the commit message confused me initially)

>
> Signed-off-by: Ben Peart <benpeart@microsoft.com>
> ---
>  preload-index.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/preload-index.c b/preload-index.c
> index 70a4c80878..75564c497a 100644
> --- a/preload-index.c
> +++ b/preload-index.c
> @@ -79,6 +79,8 @@ static void preload_index(struct index_state *index,
>                 return;
>
>         threads = index->cache_nr / THREAD_COST;
> +       if ((index->cache_nr > 1) && (threads < 2) && getenv("GIT_FORCE_PRELOAD_TEST"))
> +               threads = 2;

Adding these lines is just a bandaid to trick

>         if (threads < 2)
>                 return;

to not return early as the commit message does not discuss why
we set it to 2.

Do we need threads at all for these tests, or would a patch like

-    if (threads < 2)
+    if (threads < 2 && !GIT_FORCE_PRELOAD_TEST)
         return;

work as well?

That way tests can use any number of threads, though
they currently have no way of overriding the heuristic, yet.

With this alternative patch, it sounds to me as if the
issues kept more orthogonal. (specifically "Do we use preload?"
and "How many threads?". One could imagine that we later
want to introduce GIT_PRELOAD_THREADS for $reasons
and that would go over well in combination with
GIT_FORCE_PRELOAD_TEST)

It seems to be only an internal test variable, such that we do
not need documentation. (Is that worth mentioning in the
commit message?)

The test to make use of this new variable is found
in another patch I presume?

Stefan
