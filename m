Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC11B21841
	for <e@80x24.org>; Wed,  2 May 2018 11:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751428AbeEBLlq (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 May 2018 07:41:46 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51879 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750954AbeEBLlp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 May 2018 07:41:45 -0400
Received: by mail-wm0-f68.google.com with SMTP id j4so22257795wme.1
        for <git@vger.kernel.org>; Wed, 02 May 2018 04:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=iJ4JsNMjw/1hP+jKDpueYcv0puf/tQUtaOdLNxcFIYA=;
        b=bMH0/frFfQoQ6QUj94EtADJIvvLXWUWe3B4Jo0zhcJRa3Xw2h3UvctmDndj4EETPHI
         Z1bL6ZzEZ/UNKsrcSpW/8qQvXnL58mc5bfrph7juKi0iD3JLQalI4aAQQ7nES/Q6yDcl
         iOoQXUJy0S4fsU4sDLXrNMPMNZmDediVnFOpvV4wCWhvwfiAMDGnnza01msRndYsuqC5
         9yjlU2BPasxvZbYptFCcWRN/C6t/8z4ba1i9j/9DWhaMmhti6U1u/WrOhGGdJVPhk8Rh
         pbwfYWDmtLKY0iUkcRUGbt770HVq9zQC+uypYTnA/ga1W2B4OwqcoBk0Ppe6ZxD+EU5C
         RYog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=iJ4JsNMjw/1hP+jKDpueYcv0puf/tQUtaOdLNxcFIYA=;
        b=KV8u/oYJZS4Pvy6+I8zl/dXOxOgeZ4bb+s+7PNdUo8gwspERdmxnl6sqTdRZS+tQ1m
         ZWzE4lgX/LxOKrWNqYjOUrAXU6Lrb3Xb0esDYb/EUyaWNCQJbgxs/jfBntMVPIKSP1nU
         mbjaqrFiaV9ebMFS89vXJEbjxwJitTgGsK0gl0kwT8PgjhfnKiKIukh69AcVqzPQd0qM
         ZRfqgWf9QNeTpz3IJVbmF6cmqHGss+ssU/gWX2N9Sd67VF9bfg5WIl015an/lx7M7NZB
         Si3WDCe6655VmQgt3NfbWxlmb6OF/uP3JaRTBdWVGJqLvzeADUFiD+UdxK6NseuWIHZR
         hNXw==
X-Gm-Message-State: ALQs6tCRtAejVZGKrEfNo4xk4LpcCUEQCFEFgPOVoRS8YYObM5zzKYxg
        w33LDx+ykY23UbDuQGPvbBU=
X-Google-Smtp-Source: AB8JxZqR+lEon6ejeRPGNQ9FAWo/ac2Jg+nYQxk8Q80Ib+HH82NrfmmCBWkJKNerlMS8a5bS+1c7FA==
X-Received: by 10.28.211.1 with SMTP id k1mr3741860wmg.43.1525261304043;
        Wed, 02 May 2018 04:41:44 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (egn45.neoplus.adsl.tpnet.pl. [83.21.77.45])
        by smtp.gmail.com with ESMTPSA id z72sm12086685wmc.28.2018.05.02.04.41.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 May 2018 04:41:42 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH v4 09/10] merge: check config before loading commits
References: <20180417170001.138464-1-dstolee@microsoft.com>
        <20180425143735.240183-1-dstolee@microsoft.com>
        <20180425143735.240183-10-dstolee@microsoft.com>
        <86po2gfgpp.fsf@gmail.com>
        <214dea35-a89c-4115-a51a-5110c4e53314@gmail.com>
Date:   Wed, 02 May 2018 13:41:38 +0200
In-Reply-To: <214dea35-a89c-4115-a51a-5110c4e53314@gmail.com> (Derrick
        Stolee's message of "Tue, 1 May 2018 07:52:26 -0400")
Message-ID: <86h8nq1dzh.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:
> On 4/30/2018 6:54 PM, Jakub Narebski wrote:
>> Derrick Stolee <dstolee@microsoft.com> writes:
>>
>>> Now that we use generation numbers from the commit-graph, we must
>>> ensure that all commits that exist in the commit-graph are loaded
>>> from that file instead of from the object database. Since the
>>> commit-graph file is only checked if core.commitGraph is true, we
>>> must check the default config before we load any commits.
>>>
>>> In the merge builtin, the config was checked after loading the HEAD
>>> commit. This was due to the use of the global 'branch' when checking
>>> merge-specific config settings.
>>>
>>> Move the config load to be between the initialization of 'branch' and
>>> the commit lookup.
>>
>> Sidenote: I wonder why reading config was postponed to later in the
>> command lifetime... I guess it was to avoid having to read config if
>> HEAD was invalid.
>
> The 'branch' does need to be loaded before the call to git_config (as
> I found out after moving the config call too early), so I suppose it
> was natural to pair that with resolving head_commit.

Right, so there was only a limited number of places where call to
git_config could be put correctly. Now I wonder no more.

[...]
>>> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
>>> index a380419b65..77d85aefe7 100755
>>> --- a/t/t5318-commit-graph.sh
>>> +++ b/t/t5318-commit-graph.sh
>>> @@ -221,4 +221,13 @@ test_expect_success 'write graph in bare repo' '
>>>   graph_git_behavior 'bare repo with graph, commit 8 vs merge 1' bare c=
ommits/8 merge/1
>>>   graph_git_behavior 'bare repo with graph, commit 8 vs merge 2' bare c=
ommits/8 merge/2
>>>   +test_expect_success 'perform fast-forward merge in full repo' '
>>> +	cd "$TRASH_DIRECTORY/full" &&
>>> +	git checkout -b merge-5-to-8 commits/5 &&
>>> +	git merge commits/8 &&
>>> +	git show-ref -s merge-5-to-8 >output &&
>>> +	git show-ref -s commits/8 >expect &&
>>> +	test_cmp expect output
>>> +'
>> All right.  (though I wonder if this tests catches all problems where
>> BUG("bad generation skip") could have been encountered.
>
> We will never know until we have this series running in the wild (and
> even then, some features are very obscure) and enough people turn on
> the config setting.
>
> One goal of the "fsck and gc" series is to get this feature running
> during the rest of the test suite as much as possible, so we can get
> additional coverage. Also to get more experience from the community
> dogfooding the feature.

Sidenote: for two out of three features that change the view of history
we could also update commit-graph automatically:
* the shortening or deepening of shallow clone could also re-calculate
  the commit graph (or invalidate it)
* git-replace could check if the replacement modifies history, and if
  so, recalculate the commit graph (or invalidate it/check its validity)
* there is no such possibility for grafts, but they are deprecated anyway

--=20
Jakub Nar=C4=99bski
