Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 941C820401
	for <e@80x24.org>; Tue, 27 Jun 2017 18:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753341AbdF0SzS (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 14:55:18 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:35653 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752311AbdF0SzQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 14:55:16 -0400
Received: by mail-wm0-f46.google.com with SMTP id w126so32960527wme.0
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 11:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=m48/WbzcpcpBI9wfrwHFxQX1+bjPxbK2R6dEs+JOgXQ=;
        b=eBNJTUteTUZj+rLq50p2X39AfvPXPEYkmbUDIILx+D45D2dn8FQFrNx/lgL6TgGYFQ
         fX3Svy+QivWlz7PD4tknYWnOq0Lhk1XKPvADPCiNHHrgIz+Bp1Kn2p+0w3m8krAoVgQG
         ii/k8Srt7gYSiiJXBeG1oXMoojSmonqqO8T798PBa+2cv7fP5ZSBtYQ6sdUMAmo02QzY
         CV2/ALrE3IgGc8+z/dv1abFqGunFbceQtMRDyqkoOON1sjzmKPIhJksbtn+VgJuJPzZ3
         s4wDODNIRnyjmA7UkRlhcGwfs508/25WuxqQ600zwZ2kliq4mqo3Pn3TKgyh5RPVy/4h
         43SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=m48/WbzcpcpBI9wfrwHFxQX1+bjPxbK2R6dEs+JOgXQ=;
        b=lEfr3R0vQfI1lNdFAtHnTvU1xrQ7PCI5D+An5B+GczMOHYrqnVoUpsibGYSVWI8vpB
         31WnkAEiJtyhx4nuBtCnnDiOzwd4DMxFwzzTCjJhadJPCxZ2CJ4p8DTEDjP9AP1d8muX
         f96u8aGE9aCa+tH2S6wyJcjylf4MV1hjSrR3U3hcIroPFqffJg2u0SYVR9veiQOhQ/5v
         VwFOBbT2MA18K28cxkjaUtglEsoekS+wROwxWsYYrC4Xg63KrqjGk4sMorqWl38NlTWo
         0GNuo8X/3PrUuhpXkakYk2YRj40uaYTMDaz1rHtTfYsAAGDE6kpexGB8JDkFsbp9KiiS
         IcvA==
X-Gm-Message-State: AKS2vOzZglAaSaaf4z4YZOaRm1yqbG71Pg4xevYFm1uCJwisg6Q7L7y+
        QtY/2R1MUWlvrg==
X-Received: by 10.80.139.151 with SMTP id m23mr4844947edm.140.1498589715350;
        Tue, 27 Jun 2017 11:55:15 -0700 (PDT)
Received: from snth (g74110.upc-g.chello.nl. [80.57.74.110])
        by smtp.gmail.com with ESMTPSA id d36sm1442990edb.63.2017.06.27.11.55.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Jun 2017 11:55:14 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1dPvdp-0006bb-FL; Tue, 27 Jun 2017 20:55:13 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Kebe <michael.kebe@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Marc Stevens <marc@marc-stevens.nl>
Subject: Re: Compile Error v2.13.2 on Solaris SPARC
References: <CAKKM46tHq13XiW5C8sux3=PZ1VHSu_npG8ExfWwcPD7rkZkyRQ@mail.gmail.com> <87fuem7aw2.fsf@gmail.com> <CAKKM46vr2Y_Zs+EJX-nxw7XH0nbpmTyubR1jibYoiieNCDns4Q@mail.gmail.com> <CAKKM46sBVyTMGNwU6E9s7gq8wiBfAxrKzBFVgU=zfwj+YdAjcQ@mail.gmail.com> <20170627162808.p7sj3jpwum7n3hq2@oracle.com> <xmqq1sq52uwj.fsf@gitster.mtv.corp.google.com> <20170627182942.gpug4xaek2vba7uh@oracle.com>
User-agent: Debian GNU/Linux 8.8 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <20170627182942.gpug4xaek2vba7uh@oracle.com>
Date:   Tue, 27 Jun 2017 20:55:13 +0200
Message-ID: <87shiljm5q.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 27 2017, Liam R. Howlett jotted:

> This compressed logic is causing a lot of issues.  Could we just rewrite
> it as a whole lot of #if/#else, statements to avoid running across the
> issue where the precompiler does not short-circuit the checks?  Would
> this cause any other issues?

Again, this is hopefully addressed by my
20170627121718.12078-2-avarab@gmail.com ([PATCH 1/3] sha1dc: update from
my PR #36).

> A third option is to compile a small test and just -DSHA1DC_BIGENDIAN in
> the Makefile.

This would be ideal, but so far the only facility we have for that is
the configure script, which there have been objections to making a hard
dep in the past, thus we have various bits done via macros that would be
better done via built-time compiling & testing a C program.

My memory of such discussions is hazy though, did people fundimentally
object to the idea, or was it just an objection to autoconf in
particular, I don't know.

If it was just autoconf maybe someone more clever at Makefile magic than
me could come up with a way to compile a test program that would then
define a flag that would be passed to the rest of the programs, and set
up dependencies in such a way that it was done before anything else, I
don't know if that's easy/possible with make.
