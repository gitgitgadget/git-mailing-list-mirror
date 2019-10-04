Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 009D41F4BD
	for <e@80x24.org>; Fri,  4 Oct 2019 14:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388376AbfJDO1l (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Oct 2019 10:27:41 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42750 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388149AbfJDO1k (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Oct 2019 10:27:40 -0400
Received: by mail-lf1-f66.google.com with SMTP id c195so4624502lfg.9
        for <git@vger.kernel.org>; Fri, 04 Oct 2019 07:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=v8rUWXbkn9sfjTQZQi5ZKyXXnvzt3TPm9esI0uvsHk4=;
        b=eoKEf786A2NtbllDPHx3C+IYxPnDTael39oPDW0Y4B5JxLb/3eSwMjctFudpAJnqdY
         a30HY6Vz5KoWBidXXoKpQ/U0hRH/RqsyIkrUm37xxBynAOvfi63o52+o2YD10GD/jCz7
         NcBhDwa1rNrAzzqN8Piv4/1BrG523XEw0THArnruf2PjDkK0ujwCDk0NGbXJvLuAZH5U
         WRmnUm2yOlngSDp2sAy5jcGVXeEW4wCZrC2jb+1f7rwcKr7dUYTbWjQu2juEPqdJ/K9Y
         2Ar56Iv+53mvtEjUKc37JZmkfFUQL2Z9UqozyT8zh7OpGM2nwfv/FkdE92FSrBaKFCfY
         9wXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=v8rUWXbkn9sfjTQZQi5ZKyXXnvzt3TPm9esI0uvsHk4=;
        b=PMOJkX5+vU8Avmspl8VsfjbdSPoTeWCZ26rZ7YUfCzVgFdPY+HArmaPUBiDTNgNtrf
         uDjhlg+ydj1F5HtgYyaN6JwbfF0DkEjvUCGWwTlsyHeNci8EstO3IAuahKJCrlr9a827
         zo8IQmF/DH8kd2H/0+XkPrm1OeI6789GCF9ltxX/RU5mzqb3Gb3ouuGVSs9U/4xHyA8P
         DEwg2QdAMIYN0+15AeFyqklisM0dP2nwM6kuADKbo9VKqz8qTgGXH43/Bjbh+2k3yF9c
         GNfACTaB0Cb2KSoma4aYVLXXl8PN+MpB2GmCc2OAYB3JL1Uu1+dhOrnXCGF87iPBHIVI
         bOZQ==
X-Gm-Message-State: APjAAAVN/sfNr4cNJxekKw6a1MWKso4xKbtVeCxLvMhxUAU3F997ZulA
        JcJciPHyy0QVmEa7R3tZVws=
X-Google-Smtp-Source: APXvYqy0FHYkpneKNc7/3RB7AHrqQmZSOmTAdEKDGQxB6ORC2HFQCNE0qA/K6o0gGmIcBpur7PwKLA==
X-Received: by 2002:ac2:483a:: with SMTP id 26mr9054869lft.188.1570199257611;
        Fri, 04 Oct 2019 07:27:37 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id z20sm1525045ljk.63.2019.10.04.07.27.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Oct 2019 07:27:36 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Derrick Stolee <stolee@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        "peff\@peff.net" <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "gitster\@pobox.com" <gitster@pobox.com>, garimasigit@gmail.com
Subject: Re: [DISCUSSION] Growing the Git community
References: <71fba9e7-6314-6ef9-9959-6ae06843d17a@gmail.com>
        <20190920143614.GB20698@genre.crustytoothpaste.net>
Date:   Fri, 04 Oct 2019 16:27:36 +0200
In-Reply-To: <20190920143614.GB20698@genre.crustytoothpaste.net> (brian
        m. carlson's message of "Fri, 20 Sep 2019 14:36:17 +0000")
Message-ID: <86muegoaav.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I think GitGitGadget is a useful tool which I haven't really had the
> time to learn how to use.  I appreciate that many people prefer a
> patch-based workflow, and that using a patch-based workflow and a
> mailing list provides the project independence and avoids favoring any
> hosting platform or tool, which I agree with.
>
> I think also that many folks find a pull request-based workflow to be
> easier and more familiar and supporting this a bit better may lower the
> barrier to entry, so I'm in favor of bridges that make contributing
> easier, even if one still needs to subscribe to the list to get
> feedback.       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ^^^^^^^^

Actually you can get feedback without having to subscribe to git mailing
list; and I am not talking here about GitGitGadget gathering response
like GitHub Issues <-> mail bridge.  You can get your feedback via
public-inbox.org, and respond to feedback via public-inboc.org mail to
[Usenet] news interface, reading and replying via NNTP (or replying via
email from thread read via NNTP):
  nntp://news.public-inbox.org/inbox.comp.version-control.git

Unfortunately it looks like newsreaders are dying category of
applications.  KDE's KNode got discontinued in 2015, XPN (X Python
Newsreader) last release had in 2009, MicroPlanet Gravity in 2010; there
is still Pan, Gnus for GNU Emacs; some e-mail clients also have support
for Usenet, like Mozilla Thunderbird (and SeaMonkey), Sylpheed and Claws
Mail.

This technique might not be described in our documentation...

Best,
--=20
Jakub Nar=C4=99bski
