Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 973AD1F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 22:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751558AbdB0WwZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 17:52:25 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35484 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751338AbdB0WwX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 17:52:23 -0500
Received: by mail-pf0-f195.google.com with SMTP id y23so1330025pfk.2
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 14:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=LZU9t0EVf+hdqKzPxGMqAkqgKKKqsCbYx3JOWy2BKaM=;
        b=sYdFSX1GJ6qfp43PNSM4SK09fSSPpH8KKPuX88eZN6mB4EHtlff/hqFN6EmGXEOVUd
         CCtsiU9Br9jvKJdP53YqeRS8UZZxG/BIoDdmfkjwSPmvNd+4IQpnHaj194cLjHH6iKt0
         X4sPxVZYTT1NWRgXJmgJV/WPDYjuBMjTq61biUG1zxSE/rw98UrcQ/pUc6bsPygS0gtB
         63Cnu6smj8KzaNP0mPUslFSuFeEl0qkIYwXkJXJzfsaQahzGCXQi7eTifyd72FpDPuom
         SrOz9T2+6MQMmMWO2hTa30w5mouh4tatW2K1ZfaX8bphBVq/P+AeW+9pM0IuKsIrd9fJ
         zC4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=LZU9t0EVf+hdqKzPxGMqAkqgKKKqsCbYx3JOWy2BKaM=;
        b=eGqOJWIU54brUYzBhiQZveonxkB3gcYd9W/xgC23QjXQmO/01u33DHCtSR/+F5uTvp
         KyS3svh2Mnor1ed7KBzaKbBjTxKN74E89zvf1kpvN1pAVT0Iq2CJp/Il0JWAEURpNUgy
         F6mQV1yEMq7YG6qBvQMVmamYsd8m0vkNrZUoFwZpMm9XoSi/tKEKmHzGjUnzx3BVmloD
         lGga7EvwQG99ewP96KAqZ7ppjWcwaMOIsJ6VdeXHHTa/9FSQ+Npgl8rx7JgQicpzcoDY
         622xC/MtXl1mMVWlRlLveWb82fVpp+uswdPW3PXgCtytREPPOYk1CSgvH3oQ3MjMwVYO
         MWow==
X-Gm-Message-State: AMke39mRifWGuO/ffolpUqC13evuMK5aY21TXSmX1FuZfhSGELR0N0C2OjEmAK5i++PTbw==
X-Received: by 10.84.143.1 with SMTP id 1mr27043164ply.81.1488235897005;
        Mon, 27 Feb 2017 14:51:37 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:c953:ec42:862e:1e81])
        by smtp.gmail.com with ESMTPSA id q23sm10882812pfg.63.2017.02.27.14.51.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 27 Feb 2017 14:51:36 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/6] Specify explicitly where we parse timestamps
References: <cover.1488231002.git.johannes.schindelin@gmx.de>
        <12b60c14dad15e3252e314771b3fe369305bbfc5.1488231002.git.johannes.schindelin@gmx.de>
        <xmqqwpcbmfai.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 27 Feb 2017 14:51:35 -0800
In-Reply-To: <xmqqwpcbmfai.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 27 Feb 2017 14:37:09 -0800")
Message-ID: <xmqqh93fmemg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> -	unsigned long number = strtoul(date, &end, 10);
>> +	time_t number = parse_timestamp(date, &end, 10);
>
> This hunk does not belong to this step.  Everybody else in this step

obviously I meant "the left half of this hunk" ;-)

> still receives parse_timestamp()'s return value in ulong, not time_t.
> I presume that that will happen in the final step 6/6 (which could
> be a huge patch that exceeds 100k?)
