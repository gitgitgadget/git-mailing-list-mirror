Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 202B6200B9
	for <e@80x24.org>; Sun,  6 May 2018 23:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751884AbeEFXZc (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 19:25:32 -0400
Received: from mail-wr0-f176.google.com ([209.85.128.176]:38880 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751625AbeEFXZb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 May 2018 19:25:31 -0400
Received: by mail-wr0-f176.google.com with SMTP id 94-v6so25187241wrf.5
        for <git@vger.kernel.org>; Sun, 06 May 2018 16:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rWmwvJ+ZTQSDt9fJovqXagUNg4N1/gIl2ePKRRIv5kM=;
        b=QrogYIYEKoR8AtnbjRyt/wmjwFS5ukjBQWzqWU4CyjVhETE4NczAlD/KRrNpswPIVv
         7WE8qHlTL+gPZH7Sy98OcUBXwbwJoNmSSzjCyi0cxEEF3SkXCPd+f1XSt0hHF6wGHCPp
         2EdbAO/8swb3iiOuB7+8HweXAyGQiLHPPjbOjnVwM0v/g+vm4TA4bbITsN4TCXWh00iA
         KT6L6g7VdqAvlFqMo/kopVHwsfzJcNVUrqzS4dsnapvOul+mOPa6083z/0Kr+2XLv35t
         WRrdGTBKcaNare6EREoaYfhlF9ge+kyNgDs1RkFEUeLq4DVpSgoHTGBPacrV5w14qOvU
         /ZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rWmwvJ+ZTQSDt9fJovqXagUNg4N1/gIl2ePKRRIv5kM=;
        b=Zyg8eZClPEt4DgOslpNEZRS7nw5ZIsEBZ2HEQ0RXC0usJZY8Rd0XleusBpChtgK5aM
         sW1uM+P7Q2w4+Ei9qncmctnA+l4XrdbSc/Pglte9iP/T++ZYD9FU6V8fUzeuI/Jyn2mm
         5upsUCd1MkS3f9Ya1M3ysWnRV8BWOIalpz5JXyi6KX1RA8yLudwPa8d5wEaj1JaHadw8
         QuLX7sMjteKGsBevTvdzlegFGnQLeVLyw7oVVX2Nyq1R9wZYjecKMBEPFe0L1Km7PdyU
         QLirXjUGpKx41mTWlw3j52jppv49S1MXnchuLIN+pIQYTsFkv2q6YeY+fB/qC2DQpL1Y
         0xRA==
X-Gm-Message-State: ALQs6tB6cKXTN49FYp5EyyMquBN1iY645l6/V8q+OFrbH4ld0QKJhyGj
        c+VLJpCMSDrXIicV4KjXENBNBA==
X-Google-Smtp-Source: AB8JxZpRcJhzEZsRN2kg3wpgSAC7uMNeKGOBYSWZXDoHrcv3ZSOVXbb0oswth1tPBeUXww4EDq/fnQ==
X-Received: by 2002:adf:b0c1:: with SMTP id j1-v6mr25685277wra.3.1525649130002;
        Sun, 06 May 2018 16:25:30 -0700 (PDT)
Received: from localhost.localdomain (x4db290cc.dyn.telefonica.de. [77.178.144.204])
        by smtp.gmail.com with ESMTPSA id q2-v6sm22536585wrm.26.2018.05.06.16.25.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 06 May 2018 16:25:29 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Shulhan <ms@kilabit.info>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Martin =?UTF-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [bug] Multiline value should error if the next line is section
Date:   Mon,  7 May 2018 01:25:14 +0200
Message-Id: <20180506232514.3065-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.17.0.563.g5f538d38fa
In-Reply-To: <20180507060322.66b121bd@kilabit.info>
References: <20180507020348.31b473b4@kilabit.info> <CAN0heSooYuGkxP9u0Uuwu_TCEOd_pj20L05=bwwHynPOapej6g@mail.gmail.com> <20180507060322.66b121bd@kilabit.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On Sun, 6 May 2018 22:03:10 +0200
> Martin Ågren <martin.agren@gmail.com> wrote:
> > On 6 May 2018 at 21:03, Shulhan <ms@kilabit.info> wrote:
> > > [alias]
> > >         tree = --no-pager log --graph \
> > >                 -n 20 \
> > > [user]
> > >         name = Shulhan
> > >
> > > (2) Run `git config -f git.config -l`
> > >
> > > The command print the following output,
> > >
> > > alias.tree=--no-pager log --graph -n 20 [user]
> > > alias.name=Shulhan  
> > 
> > Small mistake, big consequences. :-)
> > 
> > This behavior looks correct to me, though. It seems very hard to me to
> > second-guess what the user meant. For example, what if that third line
> > contained a "="? Like:
> > 
> > [alias]
> >         huh = !dd \
> >               bs=1024 ...
> > 
> > Should Git guess that the backslash on the second line was a mistake?
> > Or maybe not, because alias.bs = "1024 ..." would be a useless alias?
> 
> The context of multiline next value that I reported before was
> about section, not variable.
> 
> > 
> > I think such guessing would be theoretically possible, but especially
> > if Git guesses wrong, that could be very frustrating to fight against.
> > 
> 
> I'm not familiar with git config parser, obviously :), but checking
> the start of next multiline value that start with '[' maybe not
> impossible. Git should not guessed, but report error at the
> offending line: either user forgot to enclosed the variable with
> double quote or they missplace the backslash.

But it's not an error; as far as the config file syntax is concerned,
it's perfectly valid, even if it's not what you intended.  Reporting it
as error would be just guessing. 

