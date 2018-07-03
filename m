Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B613D1F6AC
	for <e@80x24.org>; Tue,  3 Jul 2018 20:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752768AbeGCUs0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 16:48:26 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36734 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752466AbeGCUsZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 16:48:25 -0400
Received: by mail-wr0-f193.google.com with SMTP id f16-v6so3227161wrm.3
        for <git@vger.kernel.org>; Tue, 03 Jul 2018 13:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=FoXZv0OtSxkIeMFNThw2ENjMYl3/YevDgDe4hkFH4H0=;
        b=RTGn0dKC+XRQhrdOKv00Xe+Zzj+ZFXm1hrot7WxkYiY/HnwU0qXjxGRTmzlznikiDv
         hMRgvEdKZ5d7wp9JZsAxpghgXVsmWqnfri43BzpTnziabaKFgSvhsaB3O4veufzeRMJ2
         2JiOunlyNyPglyAP3Wd9X6+79oU1K4OHYVMtwV7jRvleUU9p9RZDv/dRI9UNqclZtnZx
         yNpisvUHf7qlrTs9HlvHBBHld4SIl+bZc4G0juvpMRJIu1BeWqRL5kW2gBW1dpseSEFZ
         ZoHgrzAzdXvTQO+W/rGuDB5A8ovhhAtk/NhlXlQeG3fczGzW7fa/woPG4mUAXK+2aMQx
         0a8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=FoXZv0OtSxkIeMFNThw2ENjMYl3/YevDgDe4hkFH4H0=;
        b=GgQ5HFHwekfN+sz84JKjpCbpjlP/KWE6kFVkGxgTeDN3Y6S9SrXDrwmuM3vhO3At6m
         TOqmbC4YZOOyekcZqE8cN7Bmmewr9EVHYoNoncqxpRNWB8ALaGdrxSWjIEtuA7bAFZs4
         in/p1vHKrQ+dTwW4ZhRwHD1FwvQI1iiaiPkIZ+YV4bo4D0nTyIbP2Dk3GSUSJTaavHPL
         bU70pkC2L39DKJ9bXipakt+/TlHsoZA3LSm/WX0sYw7vqy/n0PHbCdA4yv3D17wojFuD
         x53wOc8kZGPoAn4d6NRpg3MctFCR7RcW+nITFexhA7PnuCH5AVxMkzoMc1WIzURQ7SPr
         u0BA==
X-Gm-Message-State: APt69E3oSnuX34FdbdrYbl7IdABNJenITQyUHuXRxj9A4mJUU72o+dhE
        GC9sqeVlTcdYbEBqH3X63tnPu6kD
X-Google-Smtp-Source: AAOMgpeeuo7hfOosBDEjebMdMC8Hv8MvDHqhOcxqXU23D3yVEaf7YXZqMObz+zoidvsqn+P2PAfDug==
X-Received: by 2002:a5d:6250:: with SMTP id m16-v6mr3759151wrv.179.1530650904286;
        Tue, 03 Jul 2018 13:48:24 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id v15-v6sm1535137wmc.16.2018.07.03.13.48.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 13:48:23 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        avarab@gmail.com
Subject: Re: [PATCH v2 0/2] teach --only-matching to 'git-grep(1)'
References: <cover.1529961706.git.me@ttaylorr.com>
        <cover.1530562110.git.me@ttaylorr.com>
        <20180703143729.GB23556@sigill.intra.peff.net>
Date:   Tue, 03 Jul 2018 13:48:23 -0700
In-Reply-To: <20180703143729.GB23556@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 3 Jul 2018 10:37:29 -0400")
Message-ID: <xmqq1sckoxk8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Jul 02, 2018 at 03:08:54PM -0500, Taylor Blau wrote:
>
>> Attached is the second re-roll of my series to teach 'git grep
>> --only-matching'. Since last time, not much has changed. The change I
>> did include is summarized below, and an inter-diff is attached as
>> always.
>> 
>>   - Initialize both match_color and line_color to NULL, thereby
>>     silencing a compiler warning where match_color was given to
>>     opt->output_color uninitialized [1].
>
> This iteration looks fine to me. I think we'd ideally do
> s/grep/& --column/ in the commit message of the second patch, but that's
> not worth re-rolling.

I'm OK doing this myself while queuing:

- $ git grep -no -e git -- README.md | grep ":27"
+ $ git grep -n --only-matching --column -e git -- README.md | grep ":27"

but the lack of changes to Documentation/git-grep.txt makes the
topic worth rerolling anyway (I needed to look up what "-no" means
there, and then found there was no such option in the manpage ;-).

