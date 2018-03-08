Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29AB71F404
	for <e@80x24.org>; Thu,  8 Mar 2018 23:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751067AbeCHXbY (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Mar 2018 18:31:24 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36651 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750824AbeCHXbX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Mar 2018 18:31:23 -0500
Received: by mail-wm0-f67.google.com with SMTP id 188so857204wme.1
        for <git@vger.kernel.org>; Thu, 08 Mar 2018 15:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PzedQEKSH4ZbWyARHHS4ZPNPtYMCDtIwoSJz+bWg2Gc=;
        b=aycDCIVFhaXq4pUDRXa44dNCkHbqhGx5Q7RqyHHx1rI0wKpXjz3e08c1F80I8lh3O9
         Hn7rjnzlq0MbTDG0OCfs9nSYnsSpyC2k/sJjbbzjA+OzSYWuDYGXrzp1EvxAlArWtenM
         K4bWgSV4cwxyID5wrhJbMUFOuadOeK4YSR5cwy/4xtYShLwr27UvaHGmx+Op8sgCLDMA
         cd6elCRrCKs+fSqFPZ/ZXKj6WT8P8FyAZrbIpWYErNHJIqV6ZezEKa4Ckd8v/KoowTY3
         yJXJLFwdWxtsatOSEzFVIDPzYzN/llJlfVuOmzWPRbqwqlAMH1NMiV8/CZX9aEIcG6Qo
         SfVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PzedQEKSH4ZbWyARHHS4ZPNPtYMCDtIwoSJz+bWg2Gc=;
        b=nsUsQeRJd4jylfz1+z0mlRSWYgfubZLAQmSA1ya/CsLEkC+RuNTIciWt/NvWM30vUF
         vMMbhJCNEJ4N1qIhEEc5Q8T2/xTEmoRxg2X1jMmKrkoJRwimiEEsvhz8+1V6MBTvrBFW
         PCJVEiUEZZ979wI5UyfZuBlSW3Hnjm8M/INo0oNpmm9UunOwPPzdggn+vZQqw1REGan/
         OjukxjmTqYWtYe6D0H57lcbNCSx6pFAVo8ebaAntTDnQwDVfa8DRelSu8sNAy8xW7pfU
         RGkDenjEgxLeKb7VDzpzQOPwkneEG/NC0QILLyfrP2I2IPH2AWlmahLNx5qLqaK0HmIa
         A6gw==
X-Gm-Message-State: AElRT7FoEixzQ+B/tl52zP/pqsF87jtfKlOa68nyFGNUUs2XsH17Lyfx
        xBNfiA7LdqncpqcLS+rHRNg=
X-Google-Smtp-Source: AG47ELsaaVsHFux8y/2PPtaQTdL1PGeEJhYwExaTsmlW1373heMBwop5shzEzHxb9XMRTmTKZAJVPg==
X-Received: by 10.28.29.209 with SMTP id d200mr402663wmd.149.1520551881849;
        Thu, 08 Mar 2018 15:31:21 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id b99sm34170858wrd.75.2018.03.08.15.31.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Mar 2018 15:31:21 -0800 (PST)
Subject: Re: [RFC v2] Rebasing merges: a jorney to the ultimate solution (Road
 Clear)
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Sergey Organov <sorganov@gmail.com>
Cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <87y3jtqdyg.fsf@javad.com> <87r2oxe3o1.fsf@javad.com>
 <nycvar.QRO.7.76.6.1803070742580.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <87vae8yq15.fsf@javad.com>
 <nycvar.QRO.7.76.6.1803071450511.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <a0cc88d2-bfed-ce7b-1b3f-3c447d2b32da@gmail.com>
 <4918cc79-79ba-5dd2-ea84-dc47db47d835@gmail.com>
 <b11785bd-5c96-43c1-95d8-b28eccfd13c8@gmail.com>
Message-ID: <d29d3c0e-6473-0461-c8ea-02975ce4de14@gmail.com>
Date:   Fri, 9 Mar 2018 00:31:11 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <b11785bd-5c96-43c1-95d8-b28eccfd13c8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/03/2018 20:58, Igor Djordjevic wrote:
> 
> > Phillip's method is essentially merging the new tips into the original
> > merge, pretending that the new tips were not rebased but merged into
> > upstream.
> 
> [...]
> 
> Here`s a starting point, two commits A and B, merged into M:
> 
> (3) ---A
>         \
>          M
>         /
>     ---B
> 
> 
> According the "patch theory"[1] (which might not be too popular 
> around here, but should serve the purpose for what I`m trying to 
> explain), each merge commit can be "transformed" to two non-merge 
> commits, one on top of each of the merge parents, where new commit 
> brings its original merge parent commit tree to the state of the 
> merge commit tree:
> 
> (4) ---A---U1
> 
> 
> 
>     ---B---U2
> 
> 
> Now, we have two new commits, U1 and U2, each having the same tree as 
> previous merge commit M, but representing changes in regards to 
> specific parents - and this is essentially what Sergey`s original 
> approach was using (whether he knew it, or not).
> 
> When it comes to rebasing, it`s pretty simple, too. As this:
> 
> (5) ---X1---o---o---o---o---o---X2 (master)
>        |\
>        | A1---A2---A3
>        |             \
>        |              M
>        |             /
>        \-B1---B2---B3
> 
> ... actually equals this:
> 
> (6) ---X1---o---o---o---o---o---X2 (master)
>        |\
>        | A1---A2---A3---U1
>        |
>        |
>        |
>        \-B1---B2---B3---U2
> 
> ... where trees of M, U1 and U2 are same, and we can use the regular 
> rebase semantics and rebase it to this:
> 
> (7) ---X1---o---o---o---o---o---X2 (master)
>                                 |\
>                                 | A1'--A2'--A3'--U1'
>                                 |
>                                 |
>                                 |
>                                 \-B1'--B2'--B3'--U2'
> 
> ... which is essentially this again:
> 
> (8) ---X1---o---o---o---o---o---X2 (master)
>                                 |\
>                                 | A1'--A2'--A3'
>                                 |            \
>                                 |             M'
>                                 |            /
>                                 \-B1'--B2'--B3'
> 

Having explained all this, I realized this is the same "essentially 
merging the new tips into the original pretending that the new tips 
were not rebased but merged into upstream" as Phillip`s one, just 
that we have additional temporary commits U1 and U2 (as per mentioned 
"patch theory") :)

Merging U1' and U2' with M as a base can initially be presented like 
this as well (what Phillip`s approach would yield):

	git merge-recursive U1 -- M U1'
	tree="$(git write-tree)"
	git merge-recursive U2 -- $tree U2'
	tree="$(git write-tree)"
	
..., where we know U1 = U2 = M (in regards to trees), so this is the 
same as:

	git merge-recursive M -- M U1'
	tree="$(git write-tree)"
	git merge-recursive M -- $tree U2'
	tree="$(git write-tree)"

..., which can be further simplified, being the same as:

	git merge-recursive M -- U1' U2'
	tree="$(git write-tree)"

... which is exactly what Sergey`s (updated) approach suggests, 
merging U1' and U2' with M as merge-base (and shown inside that 
sample implementation script I provided[1]) :)

With all this said, I think it`s safe to say these two approaches are 
exactly the same, just Sergey`s being simplified (thus harder to 
initially understand), and the only actual question is whether we 
value U1' and U2' enough, as possible "something suspicious happened" 
indicators, to use them, or not.

I would think yes, but I would be open for more samples of where do 
they become useful for reporting "suspicious activity", too.

Regards, Buga

[1] https://public-inbox.org/git/b11785bd-5c96-43c1-95d8-b28eccfd13c8@gmail.com/
