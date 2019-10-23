Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C87AA1F4C3
	for <e@80x24.org>; Wed, 23 Oct 2019 16:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407050AbfJWQKR (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Oct 2019 12:10:17 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36512 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404582AbfJWQKQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Oct 2019 12:10:16 -0400
Received: by mail-ed1-f66.google.com with SMTP id h2so16206904edn.3
        for <git@vger.kernel.org>; Wed, 23 Oct 2019 09:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=RhEC+EZQqSyuThrDwmj0eNSaBsD+zHEsRh4HNDtFcRs=;
        b=aeIrl0ruNueRg60t+MDMvyOQM7ENI59aPVBQJCQlAQje4+mNTKcsVqhsIyphnSR7ed
         CLKKawu2j1D2C78OoIrPbfrJRIgv8C/DDsaPk6FTao+I4UPYeuXbR/72AzQeWlDINL2y
         qx/ZMwq1WBWwfTREYpgCaz8VC1Ew2TlaoI1/KrDgVc0nZdNHJxoT6MZ2dLVu/0oqm04f
         E+GcuQzgbgdAeMyPlDflryinY6rUSDaGe1xkKzOD+QeD6AlOp0OtDYoeqWF0Im95n4bF
         tEWmY1nyJD7DWbYRR21hxMJ2c590+2y8n0pqSiLzI3A6xkD4rFgJd0xDEiUtLTa4pn0h
         /aZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=RhEC+EZQqSyuThrDwmj0eNSaBsD+zHEsRh4HNDtFcRs=;
        b=bLV1QhRV2WF0igyFDYGpJAbIFaP+tfeMt2J+l+Lk0gFxddvFfGynCWf1AD3EIdkVUp
         fIeizPSVx7dZmCOfjiZSEYwVmCrNt3Ug+SVTSPHQ6JSBOrDPPKMQQzxAqCtKprVoiai4
         qNbiO6t9EF4411e2hVGpg0cdJ9yzcxBuV1216xUH5WhMk0pj4vdFhZOD/+Bg/6O5E52x
         dmdIBawZ6voND2uMGcU5R8DN9Q8eSIbneD+BoemcRfltRkhpPBhSLpftxDKjb6x1AC1w
         9V2f8mv+1ogxw5c8LKvHCCtuwsb2Xg3z8cMcu2szhVGn9qFMenlEHGP/v8+E2cxq0jqf
         sD5Q==
X-Gm-Message-State: APjAAAV+qGOjtr7PYDoK+qhCTGOMRXlGhjMotAu6ts3IeQ5MbbjuNGpl
        A41L0mKky/63lGYxv/1vb36c4NoriNqwASUdovFa6guY4Zk=
X-Google-Smtp-Source: APXvYqzWdzj3Jdp+eOaHMxFohm+RdbH/N6FZFBfrg/e7EfRRO5UJDARQP9qRR2gnZDIaezffIp9ok77wFib4lbllhrk=
X-Received: by 2002:a17:906:70d2:: with SMTP id g18mr22514129ejk.18.1571847014597;
 Wed, 23 Oct 2019 09:10:14 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 23 Oct 2019 18:10:03 +0200
Message-ID: <CAP8UFD1T3mwZna7YXn=povc1wma48BxkSppkrW4k0EV2ODixPA@mail.gmail.com>
Subject: Draft of Git Rev News edition 56
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Gabriel Alcaras <gabriel.alcaras@telecom-paristech.fr>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Elijah Newren <newren@gmail.com>,
        Garima Singh <garimasigit@gmail.com>,
        Pierre Tardy <tardyp@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Wong <e@80x24.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone!

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-56.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/399

You can also reply to this email.

In general all kinds of contribution, for example proofreading,
suggestions for articles or links, help on the issues in GitHub, and
so on, are very much appreciated.

I tried to cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Gabriel and me plan to publish this edition on Saturday
October 26th. Yeah this is a bit unusual as we usually try to publish
on Wednesdays, sorry about that!

Thanks,
Christian.
