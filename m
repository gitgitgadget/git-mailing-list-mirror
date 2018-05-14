Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E61491F406
	for <e@80x24.org>; Mon, 14 May 2018 14:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753974AbeENOxZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 10:53:25 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:38707 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753369AbeENOxY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 10:53:24 -0400
Received: by mail-oi0-f66.google.com with SMTP id k17-v6so10943466oih.5
        for <git@vger.kernel.org>; Mon, 14 May 2018 07:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=I1rhoV5nSwAm7D3M6o8V8Us2BVK/20/shKrHit7fQe4=;
        b=uoqpT+FaLye/EvqP+6FH3w9ghVwrmd//BhnzKVh7DYM68OFjdYyrPgePbMs53WybGp
         LrBh4eAGPr3Zr/wnmscgSxxQwE8doTpqgt11UimD0RJLchtbcTUYNLOmA8mk2ZyrO7t3
         9tuCmZ2LbxUx3wCVwwzW6cdJazdmA/TOkYlrlsln/MX4ERrmjjDHjraXE/H0pRwFqWhP
         DdrRmaeLG0c3eykwJltvHobAuw4kyTLxMr7P6YEERpZwCgELt5MTBMAd+OyDf3ll2hWY
         cP02JzumOo1ZHcY7X9+e1v0whKJTE36K3VIOXCPRReLujldTu3HhAN9wsznak6dNexAE
         hyxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=I1rhoV5nSwAm7D3M6o8V8Us2BVK/20/shKrHit7fQe4=;
        b=n8gyQS5k9Fs70zqTMnOWGixsYjfR7MYJ0ZDPSJ7Id04TJ8iuIvSObyYtpHntnYq2Xh
         TujDT2r/5XAdkqK7CryXf/i61JQl9v1sApKA7uHfLNZZsaS5y/UwnnSjsMILPpx3uVw0
         X+9Jp6eU1ewPe9nqSgiD82QSw4CxJHYHbrjKE/0Dh1ZnYKe42F7CLIRc+jUlx/RyFmnc
         oY8wfzm6hNvOZhzZeq53hqGSUopjXapSgO75SM7p9ysFjVMyR8cTCvcNfqx8yo+iXvxC
         Hmei1hS3z6rYZ9Disv7QdqXCRDRDdV88Ss/Il8+moHxOfOdOgv2Rm22WSdLpJ208KUBM
         rnJw==
X-Gm-Message-State: ALKqPwfzxN8MFV1Dr1at8nLwqT+qSnfEkis3LSaBybJ8ePOM/YlmKRak
        OWG0lYTdG1OMMWNvMEVYpm7qJrlAfpgx9q3BwN0=
X-Google-Smtp-Source: AB8JxZovyPGfIBxMfitND/YLENgcLxX+DCneD+YudyB+MJMY2YmoNTSgyjW8SbOl9tN5ZWtpfCoaz/LIQCMQ/aRj9ug=
X-Received: by 2002:aca:51ce:: with SMTP id f197-v6mr7049331oib.32.1526309604078;
 Mon, 14 May 2018 07:53:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.178.133 with HTTP; Mon, 14 May 2018 07:52:53 -0700 (PDT)
In-Reply-To: <20180513210233.GA18892@alpha>
References: <1526178214-30956-1-git-send-email-danniercl@gmail.com> <20180513210233.GA18892@alpha>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 14 May 2018 16:52:53 +0200
Message-ID: <CACsJy8B2TVr1g+k+eSQ=pBEO3WN4_LtgLo9gpur8X7Z9GOFL_A@mail.gmail.com>
Subject: Re: [PATCH 1/3] checkout.c: add strict usage of -- before file_path
To:     Kevin Daudt <me@ikke.info>
Cc:     Dannier Castro L <danniercl@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <Matthieu.Moy@imag.fr>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 13, 2018 at 11:02 PM, Kevin Daudt <me@ikke.info> wrote:
> One data point indicating this is giving issues is that today on IRC a
> user was confused why `git checkout pt` did not show any message and did
> not checkout a remote branch called 'pt' as they expected. It turned out
> they also had a local file/dir called 'pt', which caused git to checkout
> that file/dir rather than creating a local branch based on the remote
> branch.

Now this is something we should fix. When an argument can be
interpreted in more than one way Git should reject it, but I think
this ambiguation logic does not take dwim (i.e. create a new branch
beased on remote) into account.
-- 
Duy
