Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E90D21F453
	for <e@80x24.org>; Thu, 17 Jan 2019 14:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbfAQOcy (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 09:32:54 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45105 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfAQOcx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 09:32:53 -0500
Received: by mail-wr1-f65.google.com with SMTP id t6so11193931wrr.12
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 06:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=seNBeXOj5X/DaHHFj3B7UbJPeBpGnXn5pMzXtnUOjOA=;
        b=G4jtS5rc70bVdKilcGwpmDr92CERRWG28zjQAQ31YiUuzlhyWMbwhwjgmjPi63G/Qh
         tahXGNTdBe/wRMLpdWNOmDdQXaRrZ5ESBNE1cjgiJgIaw4jfPgy76JgSOpFNL6393LOA
         twXefWGy7nssVscMXwHOCH+BoGeiPl5jllw3BBPI4IC0nUMtNNorN5pBDvifb8JVELu1
         Mg3yZdgovqQh7YnGAhGPigvaKRS9pe0GKbFc5Ztjo2lIZDLVY+42l/ckyQmDt2FK2HKY
         QFgPHGJG7TlnPbgkGOm/vGi6c7U8qEkj/vnwgGnNnzIallkbMcuuQdK2+/yhbVuaeflo
         xSmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=seNBeXOj5X/DaHHFj3B7UbJPeBpGnXn5pMzXtnUOjOA=;
        b=Yq0FQYZI3Ow3PvXGzRpW7fs666Zg5SG3BGa68TzqjHSugtqPYtBVFAN7lE7xAfnTFi
         tY0Rq1uTQcFsMGIpuK3QJzmARPcCLs7UDrtJTCyaUMH4b5AvFeCFHaR01Fk1k/9EqsLr
         MOBV6RyYJY1JI/JfyTPTQlmUdbhjJbiXXqHww48Ko9ilaw+cEfT//cBcS3i9hZdajqGI
         6FgmhBzju1R9urxCK5jw47D1MXU1zHn6F5hRERByUfbcjWzWPOu8NLCm7OIOifUUGf3D
         LdLoz+gmbjMuMe8IRyALRx5ONAmtBFJAKqwazIIxebslkh+VdyRiMKV9qXm8htNSMc3l
         LMoQ==
X-Gm-Message-State: AJcUukdsab/ur19z6rg8bksspMLbgUfHqXaP5VhViInBkt+ePQX7RVAf
        LeYYPRykJNotk0Mg6oJktQ9xRR68Jgk=
X-Google-Smtp-Source: ALg8bN4GjxjlDtsKBb1IirasLPfn37DQG6qe82YVXl+zP/WQiZmVycHaLtj4tDl6y/BXZEVDinePBQ==
X-Received: by 2002:a5d:494a:: with SMTP id r10mr12648248wrs.272.1547735572048;
        Thu, 17 Jan 2019 06:32:52 -0800 (PST)
Received: from evledraar ([5.57.21.48])
        by smtp.gmail.com with ESMTPSA id t76sm41984980wme.33.2019.01.17.06.32.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 06:32:50 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 00/76] Convert diff opt parser to parse_options()
References: <20190117130615.18732-1-pclouds@gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190117130615.18732-1-pclouds@gmail.com>
Date:   Thu, 17 Jan 2019 15:32:49 +0100
Message-ID: <87munz4ani.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jan 17 2019, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> This series converts diff option parsing to using parse-options. There
> are a couple benefits of using parse-options, including "git <cmd> -h"
> output, completion and less duplicate work.
>
> This is the first half. The second one would be converting the option
> parser in revision.c.  After that, the end game is, any command can
> take a 'struct option[]' somewhere from diff/rev code, remove the
> options they are not interested, then merge with their own options and
> do parse_options() just once. There will be no separate parse phase
> for revision/diff anymore.
>
> I sent a sneak peek [1] last year and got two good comments. I take it
> people at least did not oppose to this. The most interesting parts are
> at the top and bottom. The middle is just boring conversion, usually
> one option per patch.

I'm very much for this, and have skimmed it (but not stress tested) and
it looks good to me. I have some WIP patches to --abbrev that conflict,
but which will be simpler as a result of this.
