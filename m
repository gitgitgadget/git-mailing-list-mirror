Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0ABCA1F404
	for <e@80x24.org>; Tue, 13 Mar 2018 22:14:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751595AbeCMWOf (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 18:14:35 -0400
Received: from mail-wr0-f176.google.com ([209.85.128.176]:40912 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751255AbeCMWOe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 18:14:34 -0400
Received: by mail-wr0-f176.google.com with SMTP id m4so2468932wrb.7
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 15:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=JG40UphIBnkM2bgDqBkWNduEfPSgN7+FgDt6npPIXxQ=;
        b=VxCpqswWge3bAAhOFk6vfU6SjoFi80vhyoZ3X8IE9uinbl46+ERYAxYyhulGK5CxlY
         DERpbc37qODamsNubvDjpRitKcDXPdR7P+pztKmo77OcN8J6xEFvxg+BwcRizA5rJJL/
         zuVQkD1s2Y8HFwLNkbVvFYDQhA1OdACwHPsISzEDuxTS0kCA15dTG8cJxtF3tAIHqX6d
         Lh2GMBzalzSvEUwtMjIhpyRk08MHLBC20aNTRI1z0YGr2wBGlKSECGuPmZreL1gHhwJ5
         7Jt8m6JFQjRpn8Vfj73aI7qX+6uqHwZ50KzibZr1p1D9lwd9htWhdgbO6AhF2BZ8ZoRd
         jbig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=JG40UphIBnkM2bgDqBkWNduEfPSgN7+FgDt6npPIXxQ=;
        b=iX/BbjkcsHf0NQKZ3yisv3mVIKHgVWxAnCqwsVvX4dwH5hZX87tF6DAgTUJj2JQ7bI
         KjxAO7axprTjhm+4xg0HzvEEU7sApb4KLHvaVGR6SWAEnIbpLpmjPy0OzzNqvi9KlIBC
         UV3CC3DCjs70nsx8TH3o2HXxVNnsORj+8/jCjxPTvIZY/CrARAyOty82Hgh34/1NKhW8
         1czMVB2tGTK6temmQK8+/9WwjX9Z1gNurdd34BKvas52bsbDYCBXPCKBrvSpxcE/pUki
         mQglPEilyht/zV3e9j8TwC0ollN5g+3EN9xrTUSxq3trqGUzHmwFkNrt8ifxGKbTIb81
         dWQA==
X-Gm-Message-State: AElRT7HT0dOxVhQ3O2Fr2WVYPxX8BJh4tAmvrnbLhhx6H60qNMMeDC2y
        yeB/ta49GbNkMg22ljxXuIY=
X-Google-Smtp-Source: AG47ELt3xcutMfhK7NPHOoIf3JAcQ25/ZOPHs9Zz7bYuldPnATWRRaFZZohOfB8tX/TC88sV2z++7A==
X-Received: by 10.223.195.206 with SMTP id d14mr1966962wrg.0.1520979273060;
        Tue, 13 Mar 2018 15:14:33 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id h38sm839546wrh.61.2018.03.13.15.14.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Mar 2018 15:14:32 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Alexandre Julliard <julliard@winehq.org>,
        Dorab Patel <dorabpatel@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        David =?utf-8?Q?K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [PATCH v2] git{,-blame}.el: remove old bitrotting Emacs code
References: <xmqq7eqmxysm.fsf@gitster-ct.c.googlers.com>
        <20180310123058.31211-1-avarab@gmail.com>
        <CAN0heSp9UMd=t2ssCa7Ln2Gtm2b=EKzyQbDEJGG4Lm5YboF8xg@mail.gmail.com>
        <xmqqbmfr3jke.fsf@gitster-ct.c.googlers.com>
        <20180310184545.16950-1-avarab@gmail.com>
        <87woyfq02x.fsf@evledraar.gmail.com>
Date:   Tue, 13 Mar 2018 15:14:32 -0700
In-Reply-To: <87woyfq02x.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Tue, 13 Mar 2018 19:53:10 +0100")
Message-ID: <xmqqfu531v3r.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> I sent a v3 a few days ago which addressed this, it's at
> 20180310184545.16950-1-avarab@gmail.com

Thanks, I did look at that version but did not act on it immediately
and then forgot about it.

Queued.
