Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1F281F453
	for <e@80x24.org>; Tue, 22 Jan 2019 20:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbfAVUjl (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 15:39:41 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52929 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfAVUjl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 15:39:41 -0500
Received: by mail-wm1-f66.google.com with SMTP id m1so15557066wml.2
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 12:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=EQ9UTYBIwjtKeSLPBdlOS31NaFEUb3+gW7ZWfnre5U8=;
        b=aEy+nJQiUPnvsiA3uNNNWi/GhvczxX33OXo9bl2FdwasaFeAVATTf8pOtyMvhrvEst
         m7XEhRaIMkNTYg1SDiovWbld9C9QabbkrHEWhEH+a54BjphazzJce3J+c2V4y1QOOG8w
         HH48CHOQ/byH5OY10yenuJYtl1zDvroBufNz3UpIDZ48/9+BDzFL39n2Om4z8lHS+lcn
         r8TmCmWAyQn2Ybt3A8dkJcAjuRI63eii6+hpqzsWPoA22RgUSkdue69kokOa4R6KOEl/
         xJ8Gp9GJaj/wJQkmbsoCLZ1sIjH/LfnsTF1iM7v0yjKMEF7y0sZXH2T0phRLRV0iub2W
         BYfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=EQ9UTYBIwjtKeSLPBdlOS31NaFEUb3+gW7ZWfnre5U8=;
        b=IvIE05fFmRoTGPZ1cwJp3H34xwWqe/geNpdWU2nBm78rjI3qTrk2m74wGGxciY/VBx
         oXsvLf/EedkWDm4J3IgPOaO+NdP/yu1SkFAsMCFkiOT/jcu71VIzW+9tcw2pvc21Dwly
         iWe6kV+3rSoEwbNEnKqqAnc/n1wRRQszuhAeuKU/hyOl4o6hOZrYpOduE/pUrnfkHjem
         JRu+ls2mXX2gIvcYYUDsuc5X4FW4kxU46mFemoE2RbzZ/qvLZCcj6IVNYZ7fEPPznHRm
         5BdIz0HW8PnPc8eIM8q1VHc6mDASTIiwCYtGyFYDX/H2xRQPrLgH03wneyg/4ky825GZ
         YlGw==
X-Gm-Message-State: AJcUukfWkeVpednMXw6n0JO/TeJpxn6COxxlt2w5o2Anjr4AGcfe+PIS
        HTBKCFxqPp6Hsc09z6vIOAY=
X-Google-Smtp-Source: ALg8bN6qD4ZPWGnNlSahs+kcPVMGpuvZTaGWOYAt8FrE1ER6/EAPWa4gFMecJR2GWxpf2SsXUTaf9A==
X-Received: by 2002:a1c:b14:: with SMTP id 20mr10896wml.103.1548189579032;
        Tue, 22 Jan 2019 12:39:39 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id o5sm37928632wrw.46.2019.01.22.12.39.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 12:39:38 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        Pratik Karki <predatoramigo@gmail.com>,
        Phillip Wood <phillip.wood@talktalk.net>
Subject: Re: [PATCH v4 5/8] git-rebase, sequencer: extend --quiet option for the interactive machinery
References: <20181122044841.20993-1-newren@gmail.com>
        <20181211161139.31686-1-newren@gmail.com>
        <20181211161139.31686-6-newren@gmail.com>
        <nycvar.QRO.7.76.6.1901211709090.41@tvgsbejvaqbjf.bet>
        <CABPp-BFrgjW-c8NKGYKs1VaH--Oc8yUu0enQMSp1pQVUwBOBwA@mail.gmail.com>
Date:   Tue, 22 Jan 2019 12:39:38 -0800
In-Reply-To: <CABPp-BFrgjW-c8NKGYKs1VaH--Oc8yUu0enQMSp1pQVUwBOBwA@mail.gmail.com>
        (Elijah Newren's message of "Mon, 21 Jan 2019 09:50:25 -0800")
Message-ID: <xmqqy37ce8ad.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Also, I have a fuzzy memory of discussing a very similar case with
> some rebase-oriented option and its on-disk representation, where the
> concern was more about users upgrading git versions during an
> incomplete rebase rather than power users looking at internal file
> contents.  And I think either Phillip or Junio made some statement
> about considering these internal details and that they felt the worry
> about upgrade mid-rebase was overly worrying.  But I can't find the
> emails right now, and it's been so long (at least half a year) that I
> might be imagining things.

I do recall saying that mid-rebase upgrade is probably not worth
getting worried about.
