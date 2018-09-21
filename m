Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 539441F453
	for <e@80x24.org>; Fri, 21 Sep 2018 21:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391321AbeIVDeB (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 23:34:01 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40756 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391243AbeIVDeB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 23:34:01 -0400
Received: by mail-wr1-f66.google.com with SMTP id y8-v6so10476799wrh.7
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 14:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=No+fP6cFy3I6WtH3+TpKx1dawXXQWU5p1Fp7ZQo/kBs=;
        b=iirWtUd8V+inqLmav0u0yYlhmywqmxMb6yFgGrrBMZr9dI3q8ePsTI2YeD/rhMal1P
         uupmXbi+mfssuhgNH9CRfhs2RzR0k3IpVZlrjQTWDSgb+052s6FhLlExV2B1OOOtvgQN
         cBPxZQ+BDSre1cd2ZMQLLrZcjPMivcTjguayg0L33LURtIcFD6YQ3Ipc+kf9r6Rhni0U
         NE0BtJ2LAeM15lfq0d31Jh/ArYM8Cgz5qmsYwt9OzIR/EIZeuzwQ54AGo4NBgB8CpaxL
         0g1eoSU5RMENsJzwLBirTo/L9mF1XUO3h6zB0GxyJ6AiJvPinA6WJLeTf9g7OTGtYA2L
         HSLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=No+fP6cFy3I6WtH3+TpKx1dawXXQWU5p1Fp7ZQo/kBs=;
        b=MX3JCQkLuDTp68n8+ZmVniWhOwHfmnF5p6BS1BA3r953ZplM05FMTJz4kd68onl5gA
         3LXqtyjmpwkHydu4ZC/o8fd+xhX6NgYjEWy4P63erq65EwgTWQXkXR8OD7MouoPvbnxv
         Np9xx4KEzZcX7uDY2hRMR2WqkKsc5OZaXramA3wyjv9T9sbXoBukWrZ68VnDSuFk9biK
         pIcqBSPIgC8PeBcIJjkXQc/7rqk4ZNQVqz+rfjzj8nap56rCK0L5TlRbvbFwXowyhA/B
         IwBz9IVpUrQM5GBSxAfqIoNuSoBSW9MjeRpeOIsYAv3FuS8UPNAvXrPN0gMKBoUFyzHv
         1nmg==
X-Gm-Message-State: APzg51BfyaeVxWgcvHYDCF9MlHb3yYCZJmZ7UrN2890spILDrFQuM1qV
        ghMMGzUWPNFXB4mWcR8ogxY=
X-Google-Smtp-Source: ANB0Vda4tAFyB8G/dU7vwZL+g0gHWv0WXsBREGrp4kCyHXCfhWRQh5Ai6vHur1S5tHiL9RVNnPGekA==
X-Received: by 2002:a5d:62c2:: with SMTP id o2-v6mr14582364wrv.83.1537566194521;
        Fri, 21 Sep 2018 14:43:14 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id h18-v6sm40021536wru.42.2018.09.21.14.43.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 14:43:13 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 1/2] commit-graph write: add progress output
References: <20180904202729.13900-1-avarab@gmail.com>
        <20180907182954.2413-2-avarab@gmail.com>
        <60aae3d6-35b2-94fb-afd7-6978e935a4f7@gmail.com>
Date:   Fri, 21 Sep 2018 14:43:13 -0700
In-Reply-To: <60aae3d6-35b2-94fb-afd7-6978e935a4f7@gmail.com> (Derrick
        Stolee's message of "Fri, 21 Sep 2018 16:01:25 -0400")
Message-ID: <xmqq36u2v85q.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 9/7/2018 2:29 PM, Ævar Arnfjörð Bjarmason wrote:
>> -void write_commit_graph_reachable(const char *obj_dir, int append);
>> +void write_commit_graph_reachable(const char *obj_dir, int append,
>> +				  int report_progress);
>>   void write_commit_graph(const char *obj_dir,
>>   			struct string_list *pack_indexes,
>>   			struct string_list *commit_hex,
>> -			int append);
>> +			int append, int report_progress);
>>     int verify_commit_graph(struct repository *r, struct
>> commit_graph *g);
>>   
>
> Junio,
>
> The above prototype change seems to have created a semantic conflict
> with ds/commit-graph-tests (859fdc "commit-graph: define
> GIT_TEST_COMMIT_GRAPH") because when GIT_TEST_COMMIT_GRAPH is set, we
> call write_commit_graph_reachable() but the final parameter was
> resolved to be "1" instead of "0".

Hmph.  That's unfortunate.

Perhaps one of the topics should have yielded and waited until the
other one passes through.

As 859fdc0c ("commit-graph: define GIT_TEST_COMMIT_GRAPH",
2018-08-29) already is in 'master', the other "progress" topic
probably should be corrected to match.  The easiest and cleanest
would be to eject the ab/commit-graph-progress topic out of 'next'
and have it rerolled on top of 'master', as we are going to rewind
the tip of 'next' anyway.

While we are at it, I suspect that a saner evolution of the API into
the function would not append more parameters to the call, but would
make the "do we append?" bit into a flag word "unsigned flags" with
two bits, and such a clean-up can be done as a preliminary change.

> This causes t3420-rebase-autostash.sh to fail, as that test watches
> the full output of the rebase command, including commit runs. The
> following patch fixes the problem, but could probably be squashed into
> a merge or other commit.
>
> Thanks,
>
> -Stolee
>
> -->8--
>
> From: Derrick Stolee <dstolee@microsoft.com>
> Date: Fri, 21 Sep 2018 19:57:36 +0000
> Subject: [PATCH] commit: quietly write commit-graph in tests
>
> The GIT_TEST_COMMIT_GRAPH environment variable causes git-commit to
> write a commit-graph file on every execution. Recently, we added
> progress output when writing the commit-graph. This conflicts with
> some expected output during some tests, so avoid writing progress
> if writing a commit-graph this way.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  builtin/commit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 2a49ab4917..764664d832 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1660,7 +1660,7 @@ int cmd_commit(int argc, const char **argv,
> const char *prefix)
>                       "not exceeded, and then \"git reset HEAD\" to
> recover."));
>
>         if (git_env_bool(GIT_TEST_COMMIT_GRAPH, 0))
> - write_commit_graph_reachable(get_object_directory(), 0, 1);
> + write_commit_graph_reachable(get_object_directory(), 0, 0);
>
>         rerere(0);
>         run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
> --
> 2.19.0
