Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BF7F1F404
	for <e@80x24.org>; Sat,  7 Apr 2018 16:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751735AbeDGQz6 (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Apr 2018 12:55:58 -0400
Received: from mail-lf0-f46.google.com ([209.85.215.46]:43606 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751499AbeDGQz5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Apr 2018 12:55:57 -0400
Received: by mail-lf0-f46.google.com with SMTP id v207-v6so4551038lfa.10
        for <git@vger.kernel.org>; Sat, 07 Apr 2018 09:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=X2g6CVi/8W+n5j8fnqnUhK9OwIHMbaPEPG5GViuyHv0=;
        b=TVypJLaCI8dQWTB+Gw/ZjplXmB9J1JzwTwjXEGUqQjhIxDwNCVmDWscbn/ab5hit6k
         mtliCxNtiAsTTT8jwasPu5PygbxwrXWT50RnzHkeIEupBVAZ268zTH1ZZgvOlxhfK5wX
         0+Mr0YmnTSS+Lf/hhf3ZPqjDmEW8td9MUpCCzHDCSvp+CL04qRm8gcUpqka+dGEpYOvK
         Q4S+IvaRYRYpj0/KP+Dpc3kurxhVE9hBBC6o44LN60W2IrV4BpRMbAHLm1mZugXSC5N6
         /SGUSCsPK3EPYHywTh1m1SzlHkXPpPFD7/j3ljf1ytHXrT1Qx+GWR8mBNR6hLE3SmfvT
         dL9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=X2g6CVi/8W+n5j8fnqnUhK9OwIHMbaPEPG5GViuyHv0=;
        b=NkEGnI0YRIK9PpRuUT8vkFRaI7nmJAnjvlI+QdBzvs2MQ++Qa1do52bV2ruPrV64vp
         A+1NCmHfM//ezqPxczhqpaDi/Y9cjm3e+tCKvHb6xVL7xUzSG0jZ4fm02Up0xpckpGib
         Y4nOZeSyUk8sGTqcgTZ9zXcpwOt1RMbM1r02qOjLlcoeQW5+M6Rss4MwQ1v5G9X7zLaR
         7nCy1oF3fFM2ZmjrTgpuHNN2mPyRaz9G4en7MoYWfydxe71nOpyUUfoWdfj0USFFaY/d
         RV8JOrsZKBNZnH+lRw0KuYzI43U5MC0TkT3h2fisPtyfI1oGRRDzVKPhPufr2ss+EuvD
         KnRQ==
X-Gm-Message-State: ALQs6tAFbnet7zILUhje+xCX3w8QJY4y5v+kYcpL27unVgb7YjlsLR0e
        Jx7tHqH9M+NL7TRSueWdT50=
X-Google-Smtp-Source: AIpwx480AMKRLz2gDsuh3meJLlpzcptKgtpup/Alf2T/6iwsCEqD+u/STjAdkPM5MtmVG+a84Emd+w==
X-Received: by 2002:a19:d911:: with SMTP id q17-v6mr7808277lfg.99.1523120155490;
        Sat, 07 Apr 2018 09:55:55 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (ega165.neoplus.adsl.tpnet.pl. [83.21.64.165])
        by smtp.gmail.com with ESMTPSA id s12sm2177762ljj.49.2018.04.07.09.55.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 07 Apr 2018 09:55:54 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/6] Compute and consume generation numbers
References: <20180403165143.80661-1-dstolee@microsoft.com>
Date:   Sat, 07 Apr 2018 18:55:48 +0200
In-Reply-To: <20180403165143.80661-1-dstolee@microsoft.com> (Derrick Stolee's
        message of "Tue, 3 Apr 2018 12:51:37 -0400")
Message-ID: <867epjez1n.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Derrick Stolee <dstolee@microsoft.com> writes:

> This is the first of several "small" patches that follow the serialized
> Git commit graph patch (ds/commit-graph).
>
> As described in Documentation/technical/commit-graph.txt, the generation
> number of a commit is one more than the maximum generation number among
> its parents (trivially, a commit with no parents has generation number
> one).
>
> This series makes the computation of generation numbers part of the
> commit-graph write process.
>
> Finally, generation numbers are used [...].
>
> This does not have a significant performance benefit in repositories
> of normal size, but in the Windows repository, some merge-base
> calculations improve from 3.1s to 2.9s. A modest speedup, but provides
> an actual consumer of generation numbers as a starting point.
>
> A more substantial refactoring of revision.c is required before making
> 'git log --graph' use generation numbers effectively.

I have started working on Jupyter Notebook on Google Colaboratory to
find out how much speedup we can get using generation numbers (level
negative-cut filter), FELINE index (negative-cut filter) and min-post
intervals in some spanning tree (positive-cut filter, if I understand it
correctly the base of GRAIL method) in commit graphs.

Currently I am at the stage of reproducing results in FELINE paper:
"Reachability Queries in Very Large Graphs: A Fast Refined Online Search
Approach" by Ren=C3=AA R. Veloso, Lo=C3=AFc Cerf, Wagner Meira Jr and Moham=
med
J. Zaki (2014).  This paper is available in the PDF form at
https://openproceedings.org/EDBT/2014/paper_166.pdf

The Jupyter Notebook (which runs on Google cloud, but can be also run
locally) uses Python kernel, NetworkX librabry for graph manipulation,
and matplotlib (via NetworkX) for display.

Available at:
https://colab.research.google.com/drive/1V-U7_slu5Z3s5iEEMFKhLXtaxSu5xyzg
https://drive.google.com/file/d/1V-U7_slu5Z3s5iEEMFKhLXtaxSu5xyzg/view?usp=
=3Dsharing

I hope that could be of help, or at least interesting
--
Jakub Nar=C4=99bski
