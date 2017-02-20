Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3C3A201A9
	for <e@80x24.org>; Mon, 20 Feb 2017 20:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751454AbdBTUbM (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Feb 2017 15:31:12 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:36184 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751240AbdBTUbL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2017 15:31:11 -0500
Received: by mail-wm0-f42.google.com with SMTP id c85so90701446wmi.1
        for <git@vger.kernel.org>; Mon, 20 Feb 2017 12:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gal-ro.20150623.gappssmtp.com; s=20150623;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=9oPgi+7UDxwEphZRP3iw5RaV2LrI1n7vz4nJoy3k05I=;
        b=gZdNmz8GUdNCilVgsJchSB66Z1E3t7lu/sfBNdP7ER3SRcRI1OK1zRTj5vgA18Y4uX
         vmuCtDbN8CMJzy4AGeaCrcP/7vTRlrDgZciwQRscnmUx7drZKNmYDXfMgyhI7wgRmpeQ
         pdCP81WD6yGsv4YhGhVy+rLkUSM/em/PqlsiBvhOSU4yBzab974sVafj/aidwwd080WC
         q55LREfPDjFjtOj2RfQ2Y6qezhVKeLRvaGNlPGWlucA6dN59+RcckUiYqTk4gVqX+4Si
         6pWZLrnZ+N30GNe2mBZB/QKqeDDCBRM5ltrbLeve+CATLXBaZ48Y0YJ7nBDog4XdYB34
         puKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=9oPgi+7UDxwEphZRP3iw5RaV2LrI1n7vz4nJoy3k05I=;
        b=ecDyR8OYOXodo9aAzb0+k32MbygSmZr4mb8yZT+TOzKWq40KToT67Vyvm7k/h1geep
         GBbcsM8+H65bq1xL8wv0mTrw0LEMRWRD4yXoSL6FZg8bdPQdkwjNYqquWN/5xn+l3Lf2
         IZ9uN9w1+c/pwYyP6LzWTczzijVH7rjE5MULUns6Ovy0Qo8xRPvbitBBzRgOs1U0+4Uq
         wpgLUcFR/7auwrfXDP0S+fRq0y1hd6y2+IIF8GTMpf5icsP309ZzGEIAUj9qZBj4fDKv
         924uHHHZcg6W0bso+/kHreEdUhvXPwpVv/hffc7N/OC3yX6fA91Rgh80sUesb6qLHXSE
         cYEg==
X-Gm-Message-State: AMke39mqMZBH505JmopTvOJI8r6B8MpVepI/EJzYbwS7BbNLKesLFijbrIJh2N9O7ekE3rTm1qGLkso23ofYjw==
X-Received: by 10.28.186.197 with SMTP id k188mr21036936wmf.25.1487622669073;
 Mon, 20 Feb 2017 12:31:09 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.226.6 with HTTP; Mon, 20 Feb 2017 12:31:08 -0800 (PST)
X-Originating-IP: [77.178.206.182]
In-Reply-To: <CABEd3j8m5D=bBbUD+uzvE9c8AwdBEM79Np7Pnin-RLL=Hjq06A@mail.gmail.com>
References: <CAMX8fZWe2HO78ySonHX0adtPUxVPbj5_vo-NUGrjwpb7gPdGrQ@mail.gmail.com>
 <d4991e4b-cbc4-da14-381a-88704e457a19@gmx.net> <3ff5ce3c-285f-cb9a-d1d4-46323524dab7@kdbg.org>
 <CAMX8fZVkBU6M8fkUcRr69V97_NTSOGGmPB1U-ObhmVv3i6wQhg@mail.gmail.com>
 <477d3533-d453-9499-e06e-72f45488d421@kdbg.org> <CAMX8fZW2y+iPRfSbXVcHufbM+CsqgekS_0WnCEJ++=njy_TvKg@mail.gmail.com>
 <CAP8UFD3ngMvVy2XLzYNn9OFbS+zQpWTW=pravpHhA-0PcDVhfg@mail.gmail.com>
 <CAMX8fZVeAEJ5tfCO_4Pebnq=rysaJ2xDMjH-9pjmPeF4FziLFw@mail.gmail.com>
 <d7bb866d-4a50-f75e-ff4c-bcdd54f75459@kdbg.org> <CAMX8fZWRgeK5XjSrFYzZea8YgT9Mqm0XJBxQGt1eqdWZU+DEnA@mail.gmail.com>
 <CA+P7+xrch9WDo6OgU3vUEpXqAETZ07mkf76dC9nJctm0LTFQHQ@mail.gmail.com>
 <CABEd3j8sgDd8DXW8+2Q7pjANPTr-Ws1Xs1ap875mkxFOfnenYw@mail.gmail.com>
 <58d25138-de2e-6995-444f-79c3ac0bbad2@gmail.com> <CABEd3j8m5D=bBbUD+uzvE9c8AwdBEM79Np7Pnin-RLL=Hjq06A@mail.gmail.com>
From:   Alex Hoffman <spec@gal.ro>
Date:   Mon, 20 Feb 2017 21:31:08 +0100
X-Google-Sender-Auth: WQBWQCGEOOPIv_jx0DTSsviGX0w
Message-ID: <CAMX8fZUNHmouUsgEY3+0CmTaEp+y5b1-Cp8Nk3OttTc30v0R5A@mail.gmail.com>
Subject: Re: Git bisect does not find commit introducing the bug
To:     Oleg Taranenko <olegtaranenko@gmail.com>
Cc:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Christian Couder <christian.couder@gmail.com>,
        Stephan Beyer <s-beyer@gmx.net>, git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I see two different problems each with a different assumption (see the
definition of "bisectable" in the email of Junio C Hamano):

1. (Current) Assume the entire history graph is bisectable. DO: Search
where in the entire graph the first 'trait'/transition occurs.
2. (New) Assume only the graph between one good commit and one bad
commit is bisectable. DO: Search where the first transition occurs in
the graph between these two commits.

It seems that the real world needs a solution also for the second
problem (example if the good commit is the FIRST good commit of a
feature or if the good commit is not the first good commit, but you
definitely know, that it broke first somewhere in between the good and
bad commit).

I find the way to go as Oleg proposed is gittish enough (with a new
parameter --strategy). Beside I would underline that also the second
problem is a bisect problem, just for another graph, thus it makes
perfect sense to extend 'git bisect' for this.

Does that look reasonably?
