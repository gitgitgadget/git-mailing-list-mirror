Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D36491F404
	for <e@80x24.org>; Thu, 23 Aug 2018 21:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbeHXBUS (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 21:20:18 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:39777 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727485AbeHXBUS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 21:20:18 -0400
Received: by mail-wm0-f49.google.com with SMTP id q8-v6so7299782wmq.4
        for <git@vger.kernel.org>; Thu, 23 Aug 2018 14:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=4aZx+77fsBms/MVxH3srJ1K9B0saNb7hUQDGg8M1dnA=;
        b=nT2PwdozbcTj5qoKsXlxbTFZqSZ2tjFYHHraVa/VMzi3DbQxXuQM0e3UTcb6vCFDwk
         I+L5CEzbIWgdUIRalEXveCpT8N/NxDwftTjo/PQv0zDDuRznLRMg58vPEyTOV2WA2o8w
         iQBcxBb8iz++vRrz/5UIxc0XUrraiNPj1JL20TxfzjSrCz2Qff37lys5AzM78xhCtL6e
         +BevxTvABg1WWxdJrr598zOmtyILF4IppQQP2Q0B8UN45lGdf0lzZ1er90nywBPoevyY
         GQJdYor/1W9V6QxTeQvhsGp8ECYyhmWKvi9MURg0bP4BIAAlqZrZqVM08/9MWaIAUIVS
         92ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=4aZx+77fsBms/MVxH3srJ1K9B0saNb7hUQDGg8M1dnA=;
        b=Um7dI+E5PtIfuobJadaA1og9Aadqlg+2YaCuw9IvjUp4uWQEbzwM4aO2c3hf4bD3uv
         vDJz2iRrhnw0XG8mCFjRYRFWan3Y6g48+FFfcM1Y52Tu/vGytxv+WUY5+ipjN+AGGAJD
         odPEv+XQVpSRCVTi3Y36l+ma968t2Mbx0Vx6p/Jx+HnZsxFtlC35VWc0l2d/OG3rWcKa
         dgVKvOvdxeyNiueho7+M7IWATPyDlyBFVpAQX6kCka1uITjkT+FFeWSR/GMn43twqtKg
         dHLdzQlNj7QqBfKqZjZ5e/QubV9hV4QNn3zF4Ug81QiFyLpEYz3lV/2Lu7fC5w+1JYer
         4K9A==
X-Gm-Message-State: APzg51CYRGaaPVQDmzjagHwiB9851Iz4Kdt1EMKmPT1auman0eVZqBJ6
        xZWRYpGf6sZu2D4lyi2UKec=
X-Google-Smtp-Source: ANB0VdZ2jkRWIAfPV062waDkqjcnPC/RezY17B2B5VuMnh0Il6+7Kr51WBCFe8sNucJ8QTpx/zSmjw==
X-Received: by 2002:a1c:8f50:: with SMTP id r77-v6mr6612223wmd.44.1535060917766;
        Thu, 23 Aug 2018 14:48:37 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id c15-v6sm3734328wmb.2.2018.08.23.14.48.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Aug 2018 14:48:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kyle Meyer <kyle@kyleam.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] range-diff: update stale summary of --no-dual-color
References: <20180823023955.12980-1-kyle@kyleam.com>
        <nycvar.QRO.7.76.6.1808232254260.73@tvgsbejvaqbjf.bet>
        <xmqq1saoixxs.fsf@gitster-ct.c.googlers.com>
        <87pny8wz6z.fsf@kyleam.com>
Date:   Thu, 23 Aug 2018 14:48:36 -0700
In-Reply-To: <87pny8wz6z.fsf@kyleam.com> (Kyle Meyer's message of "Thu, 23 Aug
        2018 17:27:48 -0400")
Message-ID: <xmqqsh34hhzf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kyle Meyer <kyle@kyleam.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> [...]
>
>>>> -			    N_("color both diff and diff-between-diffs")),
>>>> +			    N_("restrict coloring to outer diff markers")),
>>>
>>> How about "use simple diff colors" instead?
>
> That's certainly better than the one above, and I also prefer it to
> "color only based on the diff-between-diffs" in v2.
>
>> I am wondering if it makes sense to remove the option altogether.
>> I've been trying to view the comparison of the same ranges in both
>> styles for the past few days, and I never found a reason to choose
>> "no dual color" option myself.
>
> But I like this suggestion even better.

That wasn't even a suggestion.  I just did not see the point of the
optional behaviour myself, and was soliciting concrete examples
where the --no-dual mode would help.

