Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C15261F859
	for <e@80x24.org>; Wed, 31 Aug 2016 18:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932633AbcHaSYX (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 14:24:23 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34769 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753070AbcHaSYW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 14:24:22 -0400
Received: by mail-wm0-f67.google.com with SMTP id d196so4733036wmd.1
        for <git@vger.kernel.org>; Wed, 31 Aug 2016 11:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=YIEpsiYqqQMA1YAZ3XEYqdb8Gcbf2vF3clIs7GrEY1I=;
        b=fFMFRrJ7wRMeFz6xAc8dMgMzDNUkC2YPLCijRGYsd3e7BzjXLuR5I/KyOApeG5DluT
         DqiyD+Jew+T5ltaSHfGJd6H5fktU0oHGYmEBITjFNZDdgVGWjoFBNntnMQ5713sXGmQr
         drLEsSzb1/rShkXRD5F7moXXp3kjcJqiTW7gDAS8UE6jM+1RPZQTFsVmBgoiKGEkICcB
         PRudp6k9O8DQeIK3IGf/Ou6kp7i9YRn4jTxuZlh9pHr19oHJ8qJhyJL3u72vjrllV4sP
         jyU7NYqn+KNgZa2zrJ6vh3LToxA5V7E5J3LdQ4ZlsJe/KfqZtr+IJ4IAXXK9mSv00dYl
         Q8tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=YIEpsiYqqQMA1YAZ3XEYqdb8Gcbf2vF3clIs7GrEY1I=;
        b=WQ2AYa0S70jCQ8mZhxCufAFY4Z59d5mud8hM3xbRPpRjfLWvrBeEiSNjDV1RpcuG3O
         0iKvKtoyFKSfomaNWCjLp7hNKeJuLly1AH6iZ1p9hhi9tjn+if06s5Q6NU+6YEMh1/RB
         q9ye50W2Q4H+3Py0qbQHIIg9n7RD9IgjI7nqg5/pXOiX3taf8ZcSBotA17aDquvfjjaf
         cobu5NGSRDJDwJBS/m+Cf5Lc6QXNdxUwmcMss9SwZKvCXnhbeYlUllpugyvuBA5XfheK
         SzwkpaPAILwxqCTxd4kn7HLkYxQW1e7PesMKY0JqYWBjm/zGNVZO5wv5Iz/KBtlp0ref
         bJzw==
X-Gm-Message-State: AE9vXwMaJQ6abOASA7EIeS6o+t8sXhGALoJj308AuDwOc6wbXl6sl3loFO/cl1EsQ725Kw==
X-Received: by 10.28.113.20 with SMTP id m20mr22022681wmc.82.1472667861091;
        Wed, 31 Aug 2016 11:24:21 -0700 (PDT)
Received: from [192.168.1.26] (enu134.neoplus.adsl.tpnet.pl. [83.20.10.134])
        by smtp.googlemail.com with ESMTPSA id s6sm1076364wjm.25.2016.08.31.11.24.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Aug 2016 11:24:20 -0700 (PDT)
Subject: Re: [PATCH 11/22] sequencer: get rid of the subcommand field
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
 <258635d3aa7f70cb1b20ea722e10ad439406b31e.1472457609.git.johannes.schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <2ba846cc-0e0f-fc7a-27d1-3b8ad66ea72b@gmail.com>
Date:   Wed, 31 Aug 2016 20:24:16 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <258635d3aa7f70cb1b20ea722e10ad439406b31e.1472457609.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 29.08.2016 o 10:05, Johannes Schindelin pisze:

> The subcommands are used exactly once, at the very beginning of
> sequencer_pick_revisions(), to determine what to do. This is an
> unnecessary level of indirection: we can simply call the correct
> function to begin with. So let's do that.

Looks good.  Parsing is moved from parse_args(), now unnecessary,
to the new run_sequencer().  Which also picked up dispatch from
sequencer_pick_revisions() - that sometimes didn't pick revisions :-o.

"All problems in computer science can be solved by another level
 of indirection, except of course for the problem of too many
 indirections." -- David John Wheeler

> 
> While at it, ensure that the subcommands return an error code so that
> they do not have to die() all over the place (bad practice for library
> functions...).

This perhaps should be moved to a separate patch, but I guess
there is a reason behind "while at it".

Also subcommand functions no longer are local to sequencer.c

> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/revert.c | 36 ++++++++++++++++--------------------
>  sequencer.c      | 35 +++++++++++------------------------
>  sequencer.h      | 13 ++++---------
>  3 files changed, 31 insertions(+), 53 deletions(-)

Nice size reduction.



