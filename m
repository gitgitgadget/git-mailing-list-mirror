Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDCF920954
	for <e@80x24.org>; Thu, 30 Nov 2017 09:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751443AbdK3Jh5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Nov 2017 04:37:57 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40861 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750877AbdK3Jhz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Nov 2017 04:37:55 -0500
Received: by mail-wm0-f68.google.com with SMTP id v19so11136787wmh.5
        for <git@vger.kernel.org>; Thu, 30 Nov 2017 01:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=V0v5m50UCfRS3C4xXlpPClxRR/g0WkNKi/tugUTsvGY=;
        b=GF+18AszHq1/3jKZgjdYa5PMgGqT+WrxmNd46vBiaHvtEV98OtxLcKjcdaABxxEL0t
         LN9Xram7puxflBWH/a6wbyJzn0EfDixMdLDmqfK3bFd3KgBNZu+Kh6VI5fEKpCaIe5lF
         SspWLaCjusV/ZIeBI2WCeFYAAet9QmjMgIeIJmDwu7C8G1GJ/67/yjC72b3Yg0+V4a/P
         01dZKe6VqWVddPXcTiABnN6BPzm5t4hwvg/6XuOWVHfewclBV+UfCGCCYHHR4dRSpXqW
         wvFdRmGJWnqmwW0QRDcKvZm70GUjmMuf4IInCDLi5OTPZ/OvPiHHFqQqgqIS5JU9eT0e
         A+1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=V0v5m50UCfRS3C4xXlpPClxRR/g0WkNKi/tugUTsvGY=;
        b=K/19nmXu9Erz33bKF/9qs7AjHU02Wov3SpY1DcGOJNJaJY65zeVz6Ms0qL0FueIEM1
         nF2hrMZclh6hHtr8Jf0YpMLRU/IbgMuHyrKJRX/u4R0+gzTV7ZzVvX68H9FoDlERWQ1F
         VJBHJGFdgHY9QWmimxCoWdYaJFvpK1FxGpxzq8OtPu7mfxvDVC5+nATt+UUtY+qEDzad
         NOJAYBAtalIJgNf3pp3tKShtssmbIrSoEQD1Xg1r6fIZLhUvDB/3PjDYkkGD98A9h3/3
         Js7egMk7WiBhwsOl49jY7aTkIhQJa5YRXUeA4TAv6qbaAZXu7A0q11tHKlczJzVLxdam
         7pww==
X-Gm-Message-State: AJaThX5BZisj/abS2cpS6px7ahMy4dNvIs40HZYgVFnLMES3FaHlG5Hi
        k6v0CMv9WOmStIZnsoG3gOFM7ght
X-Google-Smtp-Source: AGs4zMZJAVAbuKw3GCkqgV7v4SojFDjtLcGA+e5zQu8Ej19ss4teEWIVj/xxayT8dfrFUQEIvPvgOQ==
X-Received: by 10.80.161.134 with SMTP id 6mr11922331edk.197.1512034673508;
        Thu, 30 Nov 2017 01:37:53 -0800 (PST)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id w13sm3122982eda.63.2017.11.30.01.37.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Nov 2017 01:37:51 -0800 (PST)
Received: from avar by evledraar with local (Exim 4.89)
        (envelope-from <avarab@gmail.com>)
        id 1eKLHg-0003Mn-EP; Thu, 30 Nov 2017 10:37:32 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Alex Riesen <alexander.riesen@cetitec.com>,
        Brandon Casey <drafnel@gmail.com>, Petr Baudis <pasky@ucw.cz>,
        Gerrit Pape <pape@smarden.org>,
        "martin f . krafft" <madduck@madduck.net>, Eric Wong <e@80x24.org>
Subject: Re: [PATCH] Makefile: replace perl/Makefile.PL with simple make rules
References: <20171129153436.24471-1-avarab@gmail.com> <20171129195430.10069-1-avarab@gmail.com> <20171130021137.GG15098@aiede.mtv.corp.google.com>
User-agent: Debian GNU/Linux 9.2 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <20171130021137.GG15098@aiede.mtv.corp.google.com>
Date:   Thu, 30 Nov 2017 10:37:21 +0100
Message-ID: <87fu8wumy6.fsf@evledraar.booking.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 30 2017, Jonathan Nieder jotted:

> Hi,
>
> Ævar Arnfjörð Bjarmason wrote:
>
>> Replace the perl/Makefile.PL and the fallback perl/Makefile used under
>> NO_PERL_MAKEMAKER=NoThanks with a much simpler implementation heavily
>> inspired by how the i18n infrastructure's build process works[1].
>
> Yay!  This looks exciting.
>
> One quick comment:
>
> [...]
>>  * We don't build the Git(3) Git::I18N(3) etc. man pages from the
>>    embedded perldoc. I suspect nobody really cares, these are mostly
>>    internal APIs, and if someone's developing against them they likely
>>    know enough to issue a "perldoc" against the installed file to get
>>    the same result.
>>
>>    But this is a change in how Git is installed now on e.g. CentOS &
>>    Debian which carry these manpages. They could be added (via
>>    pod2man) if anyone really cares.
>>
>>    I doubt they will. The reason these were built in the first place
>>    was as a side-effect of how ExtUtils::MakeMaker works.
>
> Debian cares (see
> https://www.debian.org/doc/packaging-manuals/perl-policy/ch-module_packages.html
> for details).
>
> I'll try applying this patch and seeing what happens some time this
> week.

It just says you have to install the manpages in such-and-such a place,
but I don't have any. There, policy issue fixed :)

More seriously, it seems to me that the only reason we have these
manpages in the first place is because of emergent effects. *Maybe* I'm
wrong about someone using Git.pm as an external API, is that the case?

I was assuming this was more of a case where we were manifying the
equivalent of Documentation/technical/api-*.txt and shipping them as
user docs just because that's what EU::MM will do by default, and nobody
thought to stop it.

But sure, if we still want these I can just provide them, here's the
relevant generated perl.mak section:

	POD2MAN_EXE = $(PERLRUN) "-MExtUtils::Command::MM" -e pod2man "--"
	POD2MAN = $(POD2MAN_EXE)
	manifypods : pure_all config  \
		Git.pm \
		Git/I18N.pm \
		Git/SVN/Editor.pm \
		Git/SVN/Fetcher.pm \
		Git/SVN/Memoize/YAML.pm \
		Git/SVN/Prompt.pm \
		Git/SVN/Ra.pm \
		Git/SVN/Utils.pm
		$(NOECHO) $(POD2MAN) --section=$(MAN3EXT) --perm_rw=$(PERM_RW) -u \
		  Git.pm $(INST_MAN3DIR)/Git.$(MAN3EXT) \
		  Git/I18N.pm $(INST_MAN3DIR)/Git::I18N.$(MAN3EXT) \
		  Git/SVN/Editor.pm $(INST_MAN3DIR)/Git::SVN::Editor.$(MAN3EXT) \
		  Git/SVN/Fetcher.pm $(INST_MAN3DIR)/Git::SVN::Fetcher.$(MAN3EXT) \
		  Git/SVN/Memoize/YAML.pm $(INST_MAN3DIR)/Git::SVN::Memoize::YAML.$(MAN3EXT) \
		  Git/SVN/Prompt.pm $(INST_MAN3DIR)/Git::SVN::Prompt.$(MAN3EXT) \
		  Git/SVN/Ra.pm $(INST_MAN3DIR)/Git::SVN::Ra.$(MAN3EXT) \
		  Git/SVN/Utils.pm $(INST_MAN3DIR)/Git::SVN::Utils.$(MAN3EXT)

I.e. we'd just need to create the mandir, then call pod2man.

However, even then we should consider what I've noted above and decide
which modules we really want to be shipping docs for, e.g. Git::I18n is
never going to be used by anyone external, nor is the Git::SVN stuff.

I think the only thing we're talking about shipping manpages for is
*maybe* just Git.pm itself, no?

I don't really care, so if others want to ship them all I'll just hack
it up. This just seemed like a bug to fix while I was at it.
