Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E63071F42D
	for <e@80x24.org>; Sat,  2 Jun 2018 12:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751355AbeFBMjd (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Jun 2018 08:39:33 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:43563 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750831AbeFBMjc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Jun 2018 08:39:32 -0400
Received: by mail-wr0-f195.google.com with SMTP id d2-v6so23252301wrm.10
        for <git@vger.kernel.org>; Sat, 02 Jun 2018 05:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Avgi8WHTELa+/WDrwp52yTdAWrg4aHSlCJzWsNa53Vg=;
        b=BuaghzyUZy7zRcDDWkBnWnDgyt042ERv15n3DwNPAx97OxKOo6i7Ifb4Bi2u3b3J19
         aBRol1/WOdIs2c9IOzecri4+f0HhysKQOCTc6EhuuiqtS6/sS06LOi/u/Ujt2nDtLZq9
         VssxMb6gLfBaNgg+IGsNQBkP5b4i2i+aRZY64YbK8TKCieyJs8rwOSTtkoBuXOt3W9XO
         nNPsXUs/N1gZGPbJlJ8ZeAuXzlhWMhVkWa2xcOGYDHNiyYHtAvwrFy45XAUr0ykQ6lV9
         P7/VFmtnSxFBUD/LTPRVnfVPi/UwmNSRTC+jwJ5xGBNEebA957eQFNtCXNmEfhknltnC
         MQjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=Avgi8WHTELa+/WDrwp52yTdAWrg4aHSlCJzWsNa53Vg=;
        b=GncECwaW0Gc5BXX1LfM9EcylP7e/X1mm9N61PJ2iwXrqYdG+4ULAz09Hqt9i/th2CA
         ugp0Eh5H8EqDVoZfEM+99DHWnsEfdeR8MhZNLWucGACzY3WYoDmLKlSsYQIZtrZAIS1Y
         MvsAx5wsGduO0yHBuYUwHBci1hHGBnH/ppFh6oO0ycdZQvLBTRLK97ftf1UtMsY57Wde
         HSXsZbli4YSA2Jdf49uQX0CEsFQq1LOwv/aC3YAxJIqntw7Oy47/XiWlcMrvvv/6jZ2b
         /cOhAXI/m4fdrtGNjLlMlcCd38+CnyJcZsy1ZT4SHg4z8HI41Vis7ALHEYNXd/hdzlt+
         dhvg==
X-Gm-Message-State: ALKqPwen/mwH7uZ2tgsmvV10T8kEpW7Mof8BpK/xK1CrzudAsUGjQ71e
        sjBfsBmQmgNOo/taZ92Ge4ZUH1AC
X-Google-Smtp-Source: ADUXVKI/d/J1oXbxFj6ZYKU6mIPLWW9nArdxGZVROGQxM0W59j3/1Z07CUvzrk6GuDNC7Q7YDRKT5w==
X-Received: by 2002:adf:f7cf:: with SMTP id a15-v6mr11073059wrq.108.1527943170808;
        Sat, 02 Jun 2018 05:39:30 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (abri204.neoplus.adsl.tpnet.pl. [83.8.102.204])
        by smtp.gmail.com with ESMTPSA id c53-v6sm39832744wrg.12.2018.06.02.05.39.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 02 Jun 2018 05:39:29 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "gitster\@pobox.com" <gitster@pobox.com>,
        "stolee\@gmail.com" <stolee@gmail.com>,
        "avarab\@gmail.com" <avarab@gmail.com>,
        "marten.agren\@gmail.com" <marten.agren@gmail.com>,
        "peff\@peff.net" <peff@peff.net>
Subject: Re: [PATCH v3 15/20] commit-graph: test for corrupted octopus edge
References: <20180511211504.79877-1-dstolee@microsoft.com>
        <20180524162504.158394-1-dstolee@microsoft.com>
        <20180524162504.158394-16-dstolee@microsoft.com>
Date:   Sat, 02 Jun 2018 14:39:26 +0200
In-Reply-To: <20180524162504.158394-16-dstolee@microsoft.com> (Derrick
        Stolee's message of "Thu, 24 May 2018 16:25:59 +0000")
Message-ID: <86tvqltla9.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

> The commit-graph file has an extra chunk to store the parent int-ids for
> parents beyond the first parent for octopus merges. Our test repo has a
> single octopus merge that we can manipulate to demonstrate the 'verify'
> subcommand detects incorrect values in that chunk.

If I understand it correctly the above means that our _reading_ code
checks for validity (which then 'git commit-graph verify' uses), just
there were not any tests for that.

>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  t/t5318-commit-graph.sh | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index 58adb8246d..240aef6add 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -248,6 +248,7 @@ test_expect_success 'git commit-graph verify' '
>  '
>  
>  NUM_COMMITS=9
> +NUM_OCTOPUS_EDGES=2
>  HASH_LEN=20
>  GRAPH_BYTE_VERSION=4
>  GRAPH_BYTE_HASH=5
> @@ -274,6 +275,10 @@ GRAPH_BYTE_COMMIT_EXTRA_PARENT=`expr $GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN + 4`
>  GRAPH_BYTE_COMMIT_WRONG_PARENT=`expr $GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN + 3`
>  GRAPH_BYTE_COMMIT_GENERATION=`expr $GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN + 8`
>  GRAPH_BYTE_COMMIT_DATE=`expr $GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN + 12`
> +GRAPH_COMMIT_DATA_WIDTH=`expr $HASH_LEN + 16`
> +GRAPH_OCTOPUS_DATA_OFFSET=`expr $GRAPH_COMMIT_DATA_OFFSET + \
> +				$GRAPH_COMMIT_DATA_WIDTH \* $NUM_COMMITS`
> +GRAPH_BYTE_OCTOPUS=`expr $GRAPH_OCTOPUS_DATA_OFFSET + 4`
>  
>  # usage: corrupt_graph_and_verify <position> <data> <string>
>  # Manipulates the commit-graph file at the position
> @@ -378,4 +383,9 @@ test_expect_success 'detect incorrect commit date' '
>  		"commit date"
>  '
>  
> +test_expect_success 'detect incorrect parent for octopus merge' '
> +	corrupt_graph_and_verify $GRAPH_BYTE_OCTOPUS "\01" \
> +		"invalid parent"
> +'

So we change the int-id to non-existing commit, and check that
commit-graph code checks for that.

What about the case when there are octopus merges, but no EDGE chunk
(which I think we can emulate by changing / corrupting number of
chunks)?

What about the case where int-id of edge in EDGE chunk is correct, that
is points to a valid commit, but does not agree with what is in the
object database (what parents octopus merge has in reality)?

Do we detect the situation where the second parent value in the commit
data stores an array position within a Large Edge chunk, but we do not
reach a value with the most-significant bit on when reaching the end of
Large Edge chunk?

> +
>  test_done
