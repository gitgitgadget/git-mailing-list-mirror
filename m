Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30F651F404
	for <e@80x24.org>; Wed, 28 Feb 2018 02:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751706AbeB1CMr (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 21:12:47 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:37090 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751628AbeB1CMq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 21:12:46 -0500
Received: by mail-wr0-f196.google.com with SMTP id z12so761233wrg.4
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 18:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7NDw9QQE+9kdKTSn0+yWdIwrRMjP+UJ+0avHEscCxew=;
        b=ihExOB5Ek5o+ntMKpIbP7XRvlMSrFsj9As5oEcuQuqLwAcSt8oBHfXYO3vTLMktOy/
         0YI/qmRBHga+dNQqZbe7Q81CrplTmHKTW2bME7pFh1iFYV/nGNQIfkuG6KfiT380T+e8
         Xiv/gvmZk5SxnXaNGKAZMPuyC1D2A8IBg4PEs9E7/3a4bsL9YpiUqd9PwYnLvw3s2JvU
         6Xy2bsZzri8P0BHJTdHxrai378ivuXaUl2kSOwbT0m4vvvETcIlzO0wYyouCUe7aD9TZ
         TV85t3QRlA9j2o4Cad/2TDKb6+uD/ri4kUfjt5pU3n2eKVxx9Mq5vCUeJQIhksnXP9GG
         Fs1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7NDw9QQE+9kdKTSn0+yWdIwrRMjP+UJ+0avHEscCxew=;
        b=qDRfqgT9Rj19saVUQcDo/YCx2aU9U514o/z3PHP09xJx8QKPHcv84Ch+RC5psLjqPV
         O1LzlaFYeWO9FgPLuiGvzZPFnpvy/+ahOxsx5NqpVoKZTa8uGI1wDUvH/OH4963cpOth
         vvOK3foITcokQVhIuyDeAjLL1ERwtA7/olGtHwgfBQUHMGTn0KfvW5A1fb3IeeFi9G4P
         vgJDSkhdRLEePPb5pelPnXGNfnvmupTrdOO/OSoWYOIC95x/DVDDCXr4s7itDYEf5QKX
         vsXrX9smVyIoDg+I+IsfW0uE4Lh0NyKsBW32D2nSd6Rshm2DjyOKF72URfvRqSYvbU0J
         w/fQ==
X-Gm-Message-State: APf1xPB+XukQL2Zr+jS+qHIBb+hrCi+/zuzxy1zqZzx+pijSGoCAI74y
        2bqtETfIY7b6k2ncOHqDAGFNUmZGhDk=
X-Google-Smtp-Source: AH8x225wgvTIaYvgORhGVJvtr2Mr1s7eQIdHpcG7y9JEvCZsVdjalAL/Ii/Q6XwmSHxnoyTiVIEY+Q==
X-Received: by 10.223.187.72 with SMTP id x8mr13666136wrg.217.1519783965511;
        Tue, 27 Feb 2018 18:12:45 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id v9sm316506wre.8.2018.02.27.18.12.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Feb 2018 18:12:44 -0800 (PST)
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution (Road
 Clear)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git mailing list <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
References: <87y3jtqdyg.fsf@javad.com>
 <bbe64321-4d3a-d3fe-8bb9-58b600fabf35@gmail.com>
 <nycvar.QRO.7.76.6.1802270051470.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <CA+P7+xq8UUcLWomUi=PS_hTKfJd3dMAxMmhioDS1bixwcmKAqw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1802271718090.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <4d7f3406-b206-cc22-87df-85700d6a03d9@gmail.com>
 <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com>
 <nycvar.QRO.7.76.6.1802272330290.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <3b562b51-2f1a-48f6-d6b4-8e0fbddd3a40@gmail.com>
Date:   Wed, 28 Feb 2018 03:12:40 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1802272330290.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

On 28/02/2018 00:27, Johannes Schindelin wrote:
> 
> thank you for making this a lot more understandable to this thick
> developer.

Hehe, no problem, it primarily served fighting my own thickness ;)

> > Finally, we drop temporary commits, and record rebased commits A3' 
> > and B3' as our "rebased" merge commit parents instead (merge commit 
> > M' keeps its same tree/snapshot state, just gets parents replaced):
> >
> > (5) ---X1---o---o---o---o---o---X2
> >        |\                       |\
> >        | A1---A2---A3---U1      | A1'--A2'--A3'
> >        |             \          |             \
> >        |              M         |              M'
> >        |             /          |             /
> >        \-B1---B2---B3---U2      \-B1'--B2'--B3'
> 
> ...
> 
> In my example, where I dropped A1' specifically so that that embarrasingly
> incorrect change to the README would not be seen by the world, though, the
> evil merge would be truly evil: it would show said change to the world.
> The exact opposite of what I wanted.

Yeah, I`m afraid that`s what my testing produced as well :( Back to 
the drawing board...

> It would have been nice to have such a simple solution ;-)

Eh, the worst thing is the feeling I have, like it`s just around the 
corner, but we`re somehow missing it :P

> So the most obvious way to try to fix this design would be to recreate the
> original merge first, even with merge conflicts, and then trying to use the
> diff between that and the actual original merge commit.

For simplicity sake, this is something I would like to avoid (if 
possible), and also for the reasons you mentioned yourself:

> Now, would this work?
> 
> I doubt it, for at least two reasons:
> 
> - if there are merge conflicts between A3/B3 and between A3'/B3', those
>   merge conflicts will very likely look very different, and the conflicts
>   when reverting R will contain those nested conflicts: utterly confusing.
>   And those conflicts will look even more confusing if a patch (such as
>   A1') was dropped during an interactive rebase.
> 
> - One of the promises was that the new way would also handle merge
>   strategies other than recursive. What would happen, for example, if M
>   was generated using `-s ours` (read: dropping the B* patches' changes)
>   and if B1 had been cherry-picked into the history between X1..X2?
> 
>   Reverting R would obviously revert those B1 changes, even if B1' would
>   obviously not even be part of the rebased history!
> 
> ...
> 
> But maybe I missed something obvious, and the design can still be fixed
> somehow?

Would additional step as suggested in [1] (using R1 and R2 to "catch" 
interactive rebase additions/amendments/drops, on top of U1' and 
U2'), make more sense (or provide an additional clue, at least)?

It`s late here, and I`m really rushing it now, so please forgive me if 
it`s a stupid one... :$

Regards, Buga

[1] https://public-inbox.org/git/8829c395-fb84-2db0-9288-f7b28fa0d0d1@gmail.com/
