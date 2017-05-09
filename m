Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2B951FC44
	for <e@80x24.org>; Tue,  9 May 2017 02:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751423AbdEIC6I (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 22:58:08 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35545 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751243AbdEIC6H (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 22:58:07 -0400
Received: by mail-pg0-f67.google.com with SMTP id i63so13130718pgd.2
        for <git@vger.kernel.org>; Mon, 08 May 2017 19:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=BRLj2npnQns9Vf99kuxsBAAQguy8+n/RC2SPcnZP6lo=;
        b=UrorZ+xjwUCvWRh+4PvMWDsHRrWvOd2xaR+kxAzv/RR1sEsSDwe0HCWJNi1BoRSDA5
         uTDa8ZzxJe1EvTezBivmHh5AX2/XMAJRdeZicyR8kV5siumhTUGFrIt8WId0mliMZwT0
         556YWOrqAZ9WFhEPKEnLE3PYJcZRWr70ylngsWJZAuRLX+ebVKCLnO5vPeqXjI3yCofQ
         1UhMA6kmdIIsPk1uo02lpMwOtdHGCrDKDFwGoAjPyY9i2L/e/W+QI3SVehIMNH3ROGrr
         vBJlisPJunbQm+YYR/qRS7g8yTLxNDWIy0wNmqZwYNBLcX3fZd0KtxACm39xIsdq6vXF
         UOvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=BRLj2npnQns9Vf99kuxsBAAQguy8+n/RC2SPcnZP6lo=;
        b=I/VgInoui8Y0xVEqY+QfNbxXAK0ngpd6TS6Cnrk6GOboA/otM5HTq0R8OkkE3PBXZ6
         hDNA4TYvinFAJHrZNADq8mgFTZG9W97O2WFar3SoJQfLxtp9zUApH9RyB5suEDvGjWLt
         Cjtm8tDmJ7p/0UGu8/BPYfORuixAdiPbgI1e/LuCw6CYAocp3PD1VXgb7vdGyvxIuVtl
         DDSjHf4XOr8hFqdS0SEWMlffR7RM8J+BSYYmPw70ROUzTqq3q+AVyzHyltQUOssjQPQW
         GYiK5p6rbYd8d8M2CnynN70G5V/7ApTHk+Bmle+J+OLOAv/KCvTd1PlCLKYYduUjRh4x
         owpA==
X-Gm-Message-State: AN3rC/7aS2vJo7iBoqI5H3KdvL5XBlyGH1awYhke2RuixaHUVF4vfAtX
        fYx0XdAvhatlFQ==
X-Received: by 10.98.8.143 with SMTP id 15mr36235464pfi.268.1494298686728;
        Mon, 08 May 2017 19:58:06 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:2823:d4da:fd9a:464a])
        by smtp.gmail.com with ESMTPSA id m125sm26626418pfc.3.2017.05.08.19.58.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 08 May 2017 19:58:06 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     "'Stefan Beller'" <sbeller@google.com>,
        "'Ciro Santilli'" <ciro.santilli@gmail.com>, <git@vger.kernel.org>
Subject: Re: Add an option to automatically submodule update on checkout
References: <CAFXrp_do8Jn-k18_FSRNeHQrWNydwdj2y3y5gw+XoZPGAzPL-w@mail.gmail.com>
        <001b01d2c809$62ac8520$28058f60$@nexbridge.com>
        <CAGZ79kaES-3ftadorYnx2wMDc-q7qsG376E1zy-C67Ldt2BO5g@mail.gmail.com>
        <002201d2c81a$9ff76060$dfe62120$@nexbridge.com>
Date:   Tue, 09 May 2017 11:58:05 +0900
In-Reply-To: <002201d2c81a$9ff76060$dfe62120$@nexbridge.com> (Randall
        S. Becker's message of "Mon, 8 May 2017 12:46:17 -0400")
Message-ID: <xmqqtw4u4tz6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Randall S. Becker" <rsbecker@nexbridge.com> writes:

> I have to admit that I just assumed it would have to work that way
> this would not be particularly useful. However, in thinking about
> it, we might want to limit the depth of how far -b <name> takes
> effect. If the super module brings in submodules entirely within
> control of the development group, having -b <name> apply down to
> leaf submodules makes sense (in some policies). However, if some
> submodules span out to, say, gnulib, that might not make
> particular sense.

I do not see a strong reason to avoid your own branches in "other
people's project" like this.

The submodule's upstream may be a project you have no control over,
but the repository you have locally is under your total control and
you can use any branch names to suit the need of your project as the
whole (i.e. the superproject and submodules bound to it).

The fact that local branch names are under your control and for your
own use is true even when you are not using submodules, by the way.

