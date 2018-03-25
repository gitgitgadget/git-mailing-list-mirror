Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D25721F404
	for <e@80x24.org>; Sun, 25 Mar 2018 20:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751980AbeCYUXN (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 16:23:13 -0400
Received: from mail-lf0-f48.google.com ([209.85.215.48]:37267 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751899AbeCYUXN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 16:23:13 -0400
Received: by mail-lf0-f48.google.com with SMTP id m16-v6so21438470lfc.4
        for <git@vger.kernel.org>; Sun, 25 Mar 2018 13:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saville-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yjzXd8FAYACp9r1yXY6QqrMk/5g+vymvaOubaevQabo=;
        b=171wgP1IiCgMaQKyI+kiFLhukc3qLvKaTCqeH6jfN6veKDLVfSBbIwqvKkrHRu/Fh/
         zcy37K4Q1wpBwEtIKP2cqVAjQMOuSAmzEzN5Lqt3j+Mh97ibZozlDggij4kD3sKbYLUh
         cnKJYRmofYtk1bJXDzdg5d7tenG0kf14eunsMWyk4G2pDHsSJcplpab9g/KIYqrEl1Do
         hYM45z70htJMDUDJpCw0yY8JyIMYdInfcS2v7TcdP34x4x7F6VJ0cnWXYpHAotnR2PYS
         MLRNpiNq4IJdFedTG0MebEJlAc2jZX2Xd9TlyT+VKqrph5oc+4EnctfwfskjwNyYv8t8
         3Mqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yjzXd8FAYACp9r1yXY6QqrMk/5g+vymvaOubaevQabo=;
        b=VRrsbyiTceKS1/MZ1AMhnnSJuzD2PljR+UFxTEmCf0hZUviBLSj2q/93rPzyt9s6dI
         3GJk2jATIJqhB7FLhxgFRmjfoIWe0etpoqyhkIIstxV0nGJAI3yc7U4eGkg3nNqnPCiQ
         P+gf9l5CAWqPTkpKL7xKfCEWEt6noWB0rQPsMF8KY/+mn5BaSTynHyEwEAhG+TQqzDR3
         7lRll0LcJsSuDu+6XMvDpw74Q1pTLz3Co4qexhtGv8FP3vHY2EZ+yZZ3hniyQZdf3Bgn
         3MqCUDYvLEKGDLqpoPPRYYoCUxF6vPeIOPpS/mJjU/tpUPPGUHSVSos6mmZ3CvMdLSOT
         Q2xw==
X-Gm-Message-State: AElRT7FU76TyBtCKg2NANeBtKaT/Jp4bbB7LV2OmFNsxi6WSbFOhyE+Z
        /Pnokuqw1i/j0rZvWxw3LkMscRDMuylqKjqdid9URA==
X-Google-Smtp-Source: AG47ELs2KZ5QVC5vimNbgk71F/ZPuqFVZkY4o1r3P72kgz0vYfUnYKtJKzwvopRU7wSzWhJ6BZOuk6gRnHWf7qyrELw=
X-Received: by 2002:a19:9502:: with SMTP id x2-v6mr25738184lfd.119.1522009391416;
 Sun, 25 Mar 2018 13:23:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:9690:0:0:0:0:0 with HTTP; Sun, 25 Mar 2018 13:22:50
 -0700 (PDT)
In-Reply-To: <CA+P7+xqqLU-J5hv=yioMxMvp40hz_S9GfimjE7bp1Pj_TP-k3w@mail.gmail.com>
References: <CAKk8isqvfhiMPCdNBW5WNN4BfN1sLszekQscpy5M2Okh2YmbZg@mail.gmail.com>
 <CA+P7+xqqLU-J5hv=yioMxMvp40hz_S9GfimjE7bp1Pj_TP-k3w@mail.gmail.com>
From:   Wink Saville <wink@saville.com>
Date:   Sun, 25 Mar 2018 13:22:50 -0700
Message-ID: <CAKk8isp_oFNRNbO0fSJx5GC_QKKiojsL=TxBJu2Z54xp5NCFDA@mail.gmail.com>
Subject: Re: Should I try to fix rebase interactive preserve-merges bug
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> AFAIK this breakage of preserve-merges is a design flaw which isn't
> really fixable, which is why --recreate-merges is being added.
>
> I believe the plan is to deprecate preserve-merges once
> recreate-merges has landed.
>
> Thanks,
> Jake


Txs for the info, hopefully others will respond.
