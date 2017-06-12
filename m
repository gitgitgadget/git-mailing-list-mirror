Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D6DF1FA7B
	for <e@80x24.org>; Mon, 12 Jun 2017 08:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752055AbdFLIK1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 04:10:27 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36057 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751959AbdFLIK0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 04:10:26 -0400
Received: by mail-pf0-f196.google.com with SMTP id y7so15711483pfd.3
        for <git@vger.kernel.org>; Mon, 12 Jun 2017 01:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :disposition-notification-to:mime-version:content-transfer-encoding;
        bh=JoxqdoGj3VQK43e0h5ZMzGKAappDbq/Uuk9vCS+JURg=;
        b=gufn+LiSJPqj6pSkZx8xCS+I3QyuXuDTy9+/ywQd5xdRdZVdM6Zj2phJnVxdo35CB5
         8zBTdK5EmKpM5XoaktFzWg3DQ5nvleWK+8CwRY+CQiQyM928YxL0x9v4hoJXLR2bg28E
         DXZ2f/mX0z5w0ePeO/23tZYffAWThFxFQqrcJHbVPIymt9O0D/SqMFyFxy8s7a55qmLa
         Zx5JFpox6iBIOtANAdfitW9IyfmF9mtN5D/bYxmP6201OhLls5gg7FbehmwmknDoZY4x
         eYTkEkqD40Hpb7XRtiDEOHpY37OANl5YZYGD1AWCQUeqW2MWUqd7SeDVpb+q33JOhjA2
         bJJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:disposition-notification-to:mime-version
         :content-transfer-encoding;
        bh=JoxqdoGj3VQK43e0h5ZMzGKAappDbq/Uuk9vCS+JURg=;
        b=CujV7zGRLKmuoAld/R5fynlDuVcNqEh8LXqJKX1Cg4JSjaYEEVT2DVQxqmYYqI+Uss
         pJvn+MlZB16VWnrHQq5T1vke7aiadwLFUkGtUwhTjAyNIGBBN3ZvNLfPc5X1seuDNKWa
         JSb/Ofhv5+IY/MFPtFKQpzqLfSWAVyOFbqbg9Wvvtd8GR45e7G3ihSFkYQFWR1xz63Q9
         WcXsodL8xl/XjQisTk2OvrEFyniQ2tBGp9raxgOpdSWEDeLWF6+Avz89KdeR97+c1wnO
         D4A7j40wkui5HzhtTwtrmD7ePRnLk/41P8bQnZAda2AxnSaQaUNWRpLeBEU0F7Wg+TcY
         GO+Q==
X-Gm-Message-State: AODbwcCFJEc5AvjISlFM8tC6A6v+zVK13hLDVEIxWkqdlr4QkpEuk72n
        IO5meuxGj+UQ+A==
X-Received: by 10.99.152.25 with SMTP id q25mr57223946pgd.93.1497255025461;
        Mon, 12 Jun 2017 01:10:25 -0700 (PDT)
Received: from unique-pc ([2405:205:8100:7f26:2f1e:ad3f:8899:445e])
        by smtp.googlemail.com with ESMTPSA id a69sm20127952pfg.91.2017.06.12.01.10.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Jun 2017 01:10:24 -0700 (PDT)
Message-ID: <1497255003.1718.1.camel@gmail.com>
Subject: Re: [PATCH] wt-status.c: Modified status message shown for a
 parent-less branch
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net
Date:   Mon, 12 Jun 2017 13:40:03 +0530
In-Reply-To: <xmqqzidg14xn.fsf@gitster.mtv.corp.google.com>
References: <20170610015236.5237-1-kaarticsivaraam91196@gmail.com>
         <xmqq7f0k4m3e.fsf@gitster.mtv.corp.google.com>
         <1497084241.8531.2.camel@gmail.com>
         <20170610102127.ftvko3m7gazavpj7@sigill.intra.peff.net>
         <xmqqzidg14xn.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 2017-06-10 at 20:02 +0900, Junio C Hamano wrote:
> Again, you said what I wanted to say in my review comment a lot
> better than I managed to say ;-)
> 
> When the current message "Initial commit" is read in the context
> together with "Changes to be committed", etc., by users of "git
> commit" who do not use the "-m message" option, it is clear that
> these are talking about the commit the user is about to make.  
> 
> The confusion factor that triggered the discussion in the thread
> that resulted in this patch exists because the output from "git
> status" uses phrases that are designed to guide the user in working
> toward creating the next commit on the branch, even though the user
> may not be thinking in terms of "what would happen when I say
> 'commit' now?"
> 
> And I do not think the potential confusion is limited to "Initial
> commit" from that point of view.  The files listed in "Changes to be
> committed" list are not files to be "committed", UNLESS the user is
> aware that s/he is asking "what would happen when I say 'commit'
> now?".  When the question is "what is the status of my working
> area?",
> that phrase in the section header is suboptimal.
> 
> Adding a bit to "struct wt_status" is a good first step to allow all
> three (i.e. in addition to "Initial commit" and "Changes to be
> committed", "Changes not staged for commit" is the other one that
> shares this potential confusion factor) to be phrased in a way that
> is more appropriate in an answer to the question "what is the status
> of my working area?", I would think.
> 
> Thanks.
> 
It seems that the current change has to be discarded altogether and
further the change required doesn't look trivial. This seems to warrant
some bit of research of the code base. As a first step I would like to
know which part of the code base creates the commit template. I guess
much can't be done without knowing how it's created.

-- 
Regards,
Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
