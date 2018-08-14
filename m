Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 189911F404
	for <e@80x24.org>; Tue, 14 Aug 2018 15:18:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732063AbeHNSGX (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 14:06:23 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:52867 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730759AbeHNSGX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 14:06:23 -0400
Received: by mail-wm0-f45.google.com with SMTP id o11-v6so12614294wmh.2
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 08:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=vWbhc8r1k6nlolykwENB64SZJDlV+0ljhknAGfl+31E=;
        b=XLQOTT/J+9LmSs58ywvaK9CU1qXTJoaQq3/bghpso6IesxLjI/xykl389BU/PSYYhC
         nWNp1JX4eBSXGSMPIlSogR+Z5ZKIuxMCXNKP8hvr5HU2T1jKIp4g84jzwV+R885QLXaE
         ufmoCH/6yCsojhzg2IlrhjUMK5+gdC09/VRhboUT/Y1LLw3HfnzG8tVy/gbdJBJhpg6W
         C29q61qdz4O4NL742agoU6w1YERqv9V3FkURtdnOpjuhB172XT7nqoHwZIB8+4RKoZlk
         tDMoRzXb3CgrLvzFitAebh+LE169zuuERtAWVePO1ESFxtej7ZINa31pTkZHVNyPXVBV
         XCXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=vWbhc8r1k6nlolykwENB64SZJDlV+0ljhknAGfl+31E=;
        b=GqwX61126TrQYbdiitdWClyNV/XmP/dBuL6QZ2UnqXxs9woXivLqSbMAJeIsGVja+t
         XOxQjA2LquRJuHRT7kNWuhCoJjXPjZ2dzjGaFMifwXTyvRnlfCp+siADyUvf7SgjeG4g
         odtBZxpNWlmWEtb0UUymBTjXctb7i+BGdmx97jLyE2LLceHoneQkioOKdH45h/HXvanL
         gTNxhwYdW+swkC3417gmoRcEzejeOER04mL16ZQ2bBdsZoWNbngDgAJ0w932aY1bIA2l
         qcB9Eq1TMsM2Fzi2qvFqJ0k2XrIstUOqTkDvjt04lW+IrVWMFLnyh2ELMSlrnuwmUAwJ
         TqjA==
X-Gm-Message-State: AOUpUlGo4GTnQyioJwFV8Oc/eSvjlWNUGR9C3pGisXoZd7v2J0H6daRT
        qfbGG1NjOT3YmX6x8eykh/k=
X-Google-Smtp-Source: AA+uWPzquUpEAlt7y42VPsf23hMYG1p/ZDIX2C37sjktD8reu9o45Yib84Z7Z4lwVRiOCqQlY0grRQ==
X-Received: by 2002:a1c:908b:: with SMTP id s133-v6mr11437260wmd.69.1534259927141;
        Tue, 14 Aug 2018 08:18:47 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id b2-v6sm14930490wmh.3.2018.08.14.08.18.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 08:18:46 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Thomas Rast via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH v6 11/21] range-diff: add tests
References: <pull.1.v5.git.gitgitgadget@gmail.com>
        <pull.1.v6.git.gitgitgadget@gmail.com>
        <1477c58e4c0c9e1d5836ffcb9bcb7360b1a5df0d.1534159977.git.gitgitgadget@gmail.com>
        <20180813183504.GD13316@hank.intra.tgummerer.com>
        <nycvar.QRO.7.76.6.1808141652460.71@tvgsbejvaqbjf.bet>
Date:   Tue, 14 Aug 2018 08:18:45 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1808141652460.71@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 14 Aug 2018 16:53:51 +0200 (DST)")
Message-ID: <xmqqr2j10yei.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hmm. I hoped that my commit message was enough to indicate that while he
> is the author, I assembled this. Maybe I should move him to the footer, as
> an Original-Authored-By:?
>
> Junio?

I think the log message gives a clear enough statement to credit the
original author.  Sign-off is not about credit, but is about making
sure we know the provenance of the contribution we would use in our
codebase, so it would be nice to have, but lifting code from another
project (i.e. TRast's tbdiff) that is appropriately licensed (GPLv2)
verbatim is something you can do with your own sign-off, without the
original author's sign-off, so I think what we have is good.
