Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D5F820C11
	for <e@80x24.org>; Thu, 30 Nov 2017 21:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750995AbdK3U75 (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Nov 2017 15:59:57 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:44187 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750842AbdK3U74 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Nov 2017 15:59:56 -0500
Received: by mail-it0-f68.google.com with SMTP id b5so63728itc.3
        for <git@vger.kernel.org>; Thu, 30 Nov 2017 12:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=yDAZUPjYSN5iswOtUEaVCGpIUkUwLeS8uyPn6wnqyCY=;
        b=NFNDjaKT1IzA6u7evQfQapfFD+d1N9m5L9G0teHvgwcemsjutUU+P7sXAROzsOhchG
         s8cCLoMgKeBWUruyhdT68FTp34cjGQywxrBVoR77gv8kr0uWWQqWpydfDD13A8gafzHb
         31DqYUvVu9aEF7JvewvWk7K6n0khqGKL8IbqM+IzXuXQOjqJd3F05aiAxq9dRuLfFtZi
         WH4LNRPc+SmSouCPVHnX6qjk5z75MUQ+j1HcRIwjJ7U6TLwpybnqQ5bRkqmrxcjsnhDg
         jMk+8pnqo1UOyS/WTPMfq/cYPZGOrcEHy3H2hCiM5q8hmBXcbrTY26R6fFQxQfWwj0du
         ItJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=yDAZUPjYSN5iswOtUEaVCGpIUkUwLeS8uyPn6wnqyCY=;
        b=MgI+25R5YNrPWODP+6g8SMs2lWtPPWFUdpyb1t8UZZYvHU3d+IkSTsIfu5CXPVQ0bj
         ibfLTVR3SHt1jgY6NXM5Kkhb0iN+GDl6c1N+sFO6d0jUmmWeGMCtqV84CGO0ZaNHo4V+
         GwTlPQopyNxR1hZCbys+CqIur3cotjXNag07V9Ro49unRy0LKc23yn/QlL1hGkYzc3hA
         S1n9EYIRZtJfu7g1unk+7tcf+phjxj/9yajc8Ty9kmoMgqPgiG3fwv3bMyyQAT+UrACy
         RvEdh9u0xkxWeX93eCSDE/gKq8n05gdLaaLnpPIjCqCk3OiTFIXjhSeHcA0NalY0rZSH
         OqMQ==
X-Gm-Message-State: AJaThX61QgPq0U8YZy/5c2Fqaa0BapKdVYmnkKr53mJGvA3F0QxqCb51
        Z+CvwsQakpT2EQ65VamxRoU=
X-Google-Smtp-Source: AGs4zMZmkIny2Hft/F0psdhCNMNJG56cIKQ9aojHfRvEpAILziFscz0QSHQOaJj0LJkYWbGvfOdEJw==
X-Received: by 10.36.222.68 with SMTP id d65mr5321018itg.67.1512075595714;
        Thu, 30 Nov 2017 12:59:55 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id m31sm2660896iti.3.2017.11.30.12.59.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Nov 2017 12:59:55 -0800 (PST)
Date:   Thu, 30 Nov 2017 12:59:52 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Alex Riesen <alexander.riesen@cetitec.com>,
        Brandon Casey <drafnel@gmail.com>, Petr Baudis <pasky@ucw.cz>,
        Gerrit Pape <pape@smarden.org>,
        "martin f . krafft" <madduck@madduck.net>, Eric Wong <e@80x24.org>
Subject: Re: [PATCH] Makefile: replace perl/Makefile.PL with simple make rules
Message-ID: <20171130205952.GB20640@aiede.mtv.corp.google.com>
References: <20171129153436.24471-1-avarab@gmail.com>
 <20171129195430.10069-1-avarab@gmail.com>
 <20171130021137.GG15098@aiede.mtv.corp.google.com>
 <87fu8wumy6.fsf@evledraar.booking.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87fu8wumy6.fsf@evledraar.booking.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason wrote:
> On Thu, Nov 30 2017, Jonathan Nieder jotted:
>> Ævar Arnfjörð Bjarmason wrote:

>>>  * We don't build the Git(3) Git::I18N(3) etc. man pages from the
>>>    embedded perldoc. I suspect nobody really cares, these are mostly
>>>    internal APIs, and if someone's developing against them they likely
>>>    know enough to issue a "perldoc" against the installed file to get
>>>    the same result.
[...]
>> Debian cares (see
>> https://www.debian.org/doc/packaging-manuals/perl-policy/ch-module_packages.html
>> for details).
[...]
> It just says you have to install the manpages in such-and-such a place,
> but I don't have any. There, policy issue fixed :)
>
> More seriously, it seems to me that the only reason we have these
> manpages in the first place is because of emergent effects. *Maybe* I'm
> wrong about someone using Git.pm as an external API, is that the case?

Yeah, people really do use Git.pm as an external API.

Unlike e.g. something on CPAN, its API stability guarantees are not
great, so I am not saying I recommend it, but people have been using
it that way.

If we want to prevent this, then we should not be installing it in the
public perl module path.  Or we should at least add a note to the
manpages we ship :) to recommend not using it.

Thanks,
Jonathan
