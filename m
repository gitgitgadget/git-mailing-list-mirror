Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A225F1F404
	for <e@80x24.org>; Wed, 14 Feb 2018 23:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031929AbeBNXEE (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 18:04:04 -0500
Received: from mail-pg0-f42.google.com ([74.125.83.42]:42470 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031852AbeBNXED (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 18:04:03 -0500
Received: by mail-pg0-f42.google.com with SMTP id y8so2751108pgr.9
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 15:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=jX30lOZkXYHEyV3+Wlzx79VHebULIu4jI+FZZr9bbsA=;
        b=lRXQ6YTo2+FDBXH7tL6x0FGxrE++WvFoTVvctq5tRFEPnHsBZuWono9ph64FSNxe1x
         CMv7KL6MRH3G3ikTAv4s/CTVEZUNNT8ssFZcp4YRMppjrv/CnFbbY8v1iQXG+9nn42I+
         16mckIn3F1P1S+9YdlRflE4sJigaCNQP4c+4vXW88PUCca7lb5I50jZCissm88tWnhRf
         vEdb6jl6CNFzGrfS4JnKTbPDqpPwM2uIxDXO82u+9NB7qD9yywIn9VxMJe+q5H/bSwCq
         p7MhGkyYZceAwpYeJKOkkENO7i4VunQA7dEWdS/96FslJg3bUmvEDK9DFyhv9xXaWruV
         sQNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jX30lOZkXYHEyV3+Wlzx79VHebULIu4jI+FZZr9bbsA=;
        b=i4EyarYQHA40zoCfutecIbiNmc9lGe9q7e4mvBA4RZt8OEm9RUgke7cdY0k0vI9rNr
         KKajbmOECHWNWoO6wnh/findiegzHV6iCJhljhrdIRnN9gYmb8CYeCFu50RENVTGDF40
         UVN/LmVu6lZ8ivjnXoLPxyCafxghUJNv1y/nZPccAJ8RUG0fp9Qf45G0uCUD+FS3FjK3
         y4YOWqF34ygSchn2pfNpLpFTDl9gctag6OYIReo7UaLvD8Mpgi+9WXuOVqVtNa+KU9w2
         wUqXFXKLcrBxrexwTeK+YnsAjYI8PGo08wJu5fLAGRK+DRnInblMfzQ9O5sQCMdjCnWi
         GdQQ==
X-Gm-Message-State: APf1xPCiuRbS/abKoYmadzpV976JF8tQp6RYGOW1T55tMXigUfDVYSxp
        qYxHjwhAYpfKhZdVb5p5wo4=
X-Google-Smtp-Source: AH8x2256FhLnP9taPDDxnU7d317OUIl5XNE0jNuOcbLFLR4rDu1LEuRBHfzoAF5y/BVN4/zXp78chA==
X-Received: by 10.99.113.7 with SMTP id m7mr474208pgc.403.1518649442844;
        Wed, 14 Feb 2018 15:04:02 -0800 (PST)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id p4sm33880544pgn.81.2018.02.14.15.04.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Feb 2018 15:04:02 -0800 (PST)
Date:   Wed, 14 Feb 2018 15:03:59 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>, Petr Baudis <pasky@ucw.cz>,
        Benoit Bourbie <bbourbie@splunk.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jari Aalto <jari.aalto@cante.net>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
        Marcus Griep <marcus@griep.us>
Subject: Re: [PATCH 4/8] perl: update our ancient copy of Error.pm
Message-ID: <20180214230359.GD136185@aiede.svl.corp.google.com>
References: <20180214222146.10655-1-avarab@gmail.com>
 <20180214222146.10655-5-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180214222146.10655-5-avarab@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason wrote:

> The Error.pm shipped with Git as a fallback if there was no Error.pm
> on the system was released in April 2006, there's been dozens of
> releases since then, the latest at August 7, 2017, let's update to
> that.

Comma splices:
 s/, there's/. There's/
 s/, let's/. Let's/

The one piece of information I was curious about that this (quite clear,
thank you) commit message is missing is what changed in the intervening
time.  Is this just about keeping up with upstream to make it easy to
keep up later, or has upstream made any useful changes?  E.g. did any
API or behaviors get better?

Related: do we have to worry about in-tree users taking advantage of
improved API and packagers forgetting to add a dependency on the new
version?  Do we declare the minimal required Error.pm version somewhere
(e.g. in the INSTALL file)?

[...]
>  perl/Git/FromCPAN/.gitattributes |   1 +
>  perl/Git/FromCPAN/Error.pm       | 296 +++++++++++++++++++++++++++++++++------
>  2 files changed, 256 insertions(+), 41 deletions(-)
>  create mode 100644 perl/Git/FromCPAN/.gitattributes

Most of the added lines are documentation, so this diffstat doesn't look
half-bad.

Thanks for writing it.

Jonathan
