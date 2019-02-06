Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,URIBL_DBL_SPAM,URIBL_RED shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AB681F453
	for <e@80x24.org>; Wed,  6 Feb 2019 08:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbfBFI7A (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 03:59:00 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38854 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728499AbfBFI7A (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 03:59:00 -0500
Received: by mail-wm1-f65.google.com with SMTP id m22so1721432wml.3
        for <git@vger.kernel.org>; Wed, 06 Feb 2019 00:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=jb2R7l9c36Q8eNkIHL2PTq0DV26bTFyLquI7/wxU/dU=;
        b=HYEkqJ2tHBa3CG+qqA1MhLlsV2uAm+LeqgJpvGddJGqQpWDXhRTh6o9G6ltvdnn7ql
         yqex1wWzKfojWb/9KNAUzd/6tanM1I2CqFvolVhNrNNBjYRS2XwAMtsYyCNyzERy0PHg
         E14ve4M0eiuej+fBc8slUGS+HpAB30ko+aNerEQP5futniv+GA4hJ6Nbk6dBWBw8O/1Z
         JjFZgn714vJ6vQtsRRJEfi4loIujfp1ZerDBGVz2HTq8d5EJoCS7LEboYHjY8Xcw/UVB
         SSvwo9IHgyfQMkCnmpcLnONI3vyPfGGuGFvJy6o3ZdKo6tE4GfnGK/TZn27JTVYf66fe
         vF2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=jb2R7l9c36Q8eNkIHL2PTq0DV26bTFyLquI7/wxU/dU=;
        b=Yo2cgSHq4Ax4Mvcg5NOi5YpRrDl+7D1/Jx4bhyDol1weO64tKcUCpfQVE6AE9E5Z4Z
         LUuxe9FhjcInFU1KajAYSTanpQVbu1l1Rk32wJh5YdyfQb3kmRZfOzvrHy8544gYqm9+
         u9HTFqFqoBu1WWhKEZjZFNCGzjdp8O38eSakx3CNz4JLVChzTZSGHAqmcXI66UaRu9/7
         cv1NnEEuytaqQewlboG/SRSxlhEw8vD1CTSUpaUT6EfXdRA1I583+iR0190tZ17u7MlD
         Eq74AenEDLwNLlycPVuu8/cKpZ1pq5JQrHz85vUlS5Xv0LYbpAvkqFWSn1sAa4vCTj1u
         ZOEw==
X-Gm-Message-State: AHQUAuaXP4dI15bdCSXV8Y3c3LkJbmuYvhkM3u+NJF1q1CwPfHU6LVvI
        CyixWnbFDJJFQWq8fUivgvU=
X-Google-Smtp-Source: AHgI3IaRExQcLn4IiYGylrMEgE/rwODSIASbldg8QqoLA2xjHd6O5HZOOPmUPQHhtiR/4KtY/c0raQ==
X-Received: by 2002:a1c:9855:: with SMTP id a82mr2115882wme.20.1549443537959;
        Wed, 06 Feb 2019 00:58:57 -0800 (PST)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id a15sm6913830wrx.58.2019.02.06.00.58.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 00:58:57 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     William Hubbs <williamh@gentoo.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        chutzpah@gentoo.org
Subject: Re: [PATCH v6 2/2] config: allow giving separate author and committer idents
References: <20190204184850.10040-1-williamh@gentoo.org> <20190205195212.25550-3-avarab@gmail.com> <xmqqef8mrnnj.fsf@gitster-ct.c.googlers.com> <87k1iekkea.fsf@evledraar.gmail.com> <20190206000413.GA734@whubbs1.gaikai.biz>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190206000413.GA734@whubbs1.gaikai.biz>
Date:   Wed, 06 Feb 2019 09:58:56 +0100
Message-ID: <87imxxl2cv.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 06 2019, William Hubbs wrote:

> On Tue, Feb 05, 2019 at 10:14:37PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>>
>> On Tue, Feb 05 2019, Junio C Hamano wrote:
>>
>> > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>> >
>> >> +static int set_ident_internal(const char *var, const char *value,
>> >> +			    struct strbuf *sb, const int flag)
>> >> +{
>> >> +	if (!value)
>> >> +		return config_error_nonbool(var);
>> >> +	strbuf_reset(sb);
>> >> +	strbuf_addstr(sb, value);
>> >> +	author_ident_explicitly_given |=3D flag;
>> >> +	ident_config_given |=3D flag;
>> >> +	return 0;
>> >> +}
>> >> +
>> >> +static int set_ident(const char *var, const char *value)
>> >> +{
>> >> +	if (!strcmp(var, "author.name"))
>> >> +		return set_ident_internal(var, value, &git_author_name,
>> >> +					  IDENT_NAME_GIVEN);
>> >> +	else if (!strcmp(var, "author.email"))
>> >> +		return set_ident_internal(var, value, &git_author_email,
>> >> +					  IDENT_MAIL_GIVEN);
>> >> +	else if (!strcmp(var, "committer.name"))
>> >> +		return set_ident_internal(var, value, &git_committer_name,
>> >> +					  IDENT_NAME_GIVEN);
>> >> +	else if (!strcmp(var, "committer.email"))
>> >> +		return set_ident_internal(var, value, &git_committer_email,
>> >> +					  IDENT_MAIL_GIVEN);
>> >> +	else if (!strcmp(var, "user.name"))
>> >> +		return set_ident_internal(var, value, &git_default_name,
>> >> +					  IDENT_NAME_GIVEN);
>> >> +	else if (!strcmp(var, "user.email"))
>> >> +		return set_ident_internal(var, value, &git_default_email,
>> >> +					  IDENT_MAIL_GIVEN);
>> >> +	return 0;
>> >> +}
>> >
>> > In the v5 patch from William, author_ident_explicitly_given and
>> > committer_ident_explicitly_given were set separately depending on
>> > what variable was given (e.g. user.name marked both, author.name
>> > marked only author but not committer_ident_explicitly_given).  In
>> > the original before the addition of this feature with v6, giving
>> > user.name would have set both, as we can see below.
>> >
>> > Is this change intended?
>> >
>> > Or did you find that committer_ident_explicitly_given is no longer
>> > useful and the variable is not used anymore?
>>
>> No, that's a mistake of mine when porting this over, but also clearly a
>> blindspot in our tests since they all pass with this.
>>
>> I haven't dug (don't have time right now) to check what the effect of
>> that is. William?
>
> I attempted to save your patches to apply them, but didn't have any luck

On top of current master you can do e.g.:

    vm git (master $=3D) $ wget -q -O- https://public-inbox.org/git/2019020=
5195212.25550-2-avarab@gmail.com/raw | git am
    Applying: ident: test how GIT_* and user.{name,email} interact
    vm git (master $>) $ wget -q -O- https://public-inbox.org/git/201902051=
95212.25550-3-avarab@gmail.com/raw | git am
    Applying: config: allow giving separate author and committer idents

I also push these to https://github.com/avar/git.git although not always
in a timely manner...
