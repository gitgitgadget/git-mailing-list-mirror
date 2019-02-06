Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,URIBL_DBL_SPAM,URIBL_RED shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B01081F453
	for <e@80x24.org>; Wed,  6 Feb 2019 00:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbfBFAEQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Feb 2019 19:04:16 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38862 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbfBFAEQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Feb 2019 19:04:16 -0500
Received: by mail-ot1-f66.google.com with SMTP id e12so9058064otl.5
        for <git@vger.kernel.org>; Tue, 05 Feb 2019 16:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=k5LLOXG+tOxSR/pYgqOFu9/tjGjNlAVBV94QPhKL1bs=;
        b=bChdE5EqpkHILn34EridP/yNffBKZiEX5t8MqMGG0/wPiNClKAG+wUqWUwjyOE2sPF
         kGp1sZVrq8ZuFc7iQSBBLiW65AxxitIQptkwK5++K+k4ckPxEZmltb1w4HrtNxfhezYZ
         WXskYL93n6kXY3+3jhCmyZtXm+H8tQseK9ulVmoNr0pZaHBODf+6DyV8vXj0Lr90wxmC
         NJBYCHRKE6uwQ8xZH1fGzhBo8eIaPNKKSi8yl+HKTFf6Z8bHBFoZGkTFJhq21dUWLW45
         0uKodOYxrRmNentMhnXn5aoNZp1FIVBmHf4tvz1MKTJokYGLLtwMry2gSvsYROyBWIg5
         Cwrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=k5LLOXG+tOxSR/pYgqOFu9/tjGjNlAVBV94QPhKL1bs=;
        b=r1W56MVC0O9pHvcahiwcBtYMH28TTzuMEb4chxa4CcaaIlV+a0EJh7gZETfVM5LjZG
         aHkW5m+B1S47UhgHBUujp7vDjp9/ynHVVHiQ+N+nCz3+fyfZ7gB7Wo4421VcFTIIz5N7
         WYRMRbisVcAc4ft7M9Zu0DHCWVH2LCIQEj14TRnSy7tghQTeZDvtq1qEUQUGzb/fdIoK
         Ww56C9rBlqPBXwFj59sTMaPZ/yaqdM/3AzYYb6S0fJzemIpq1V9n8C7paTwz/05+uFY5
         TmbbT248xJMWfomD+I2jACCbVAwaY1HRyIs4gEed86RlBASZmcrvzIiq9uL6Gb1/sNu/
         6yWA==
X-Gm-Message-State: AHQUAuYJ6Cur4ci1Lvi/OIGSgDRsVUW1qAVRQguqgYh474V9CDDNB2pT
        K60zClpiBCSQnh14ybNV5Qc=
X-Google-Smtp-Source: AHgI3IaRL22Q0X5+Fa9mdOtwiWnj60YjVBRdWIh5uN8gF6HiBK3vU3Qte0llqKiNRR/Lq0JplQQbZg==
X-Received: by 2002:a9d:6050:: with SMTP id v16mr4069796otj.42.1549411455313;
        Tue, 05 Feb 2019 16:04:15 -0800 (PST)
Received: from whubbs1.gaikai.biz ([100.42.103.5])
        by smtp.gmail.com with ESMTPSA id q26sm9041386otf.73.2019.02.05.16.04.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Feb 2019 16:04:14 -0800 (PST)
Received: (nullmailer pid 759 invoked by uid 1000);
        Wed, 06 Feb 2019 00:04:13 -0000
Date:   Tue, 5 Feb 2019 18:04:13 -0600
From:   William Hubbs <williamh@gentoo.org>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        chutzpah@gentoo.org, williamh@gentoo.org
Subject: Re: [PATCH v6 2/2] config: allow giving separate author and
 committer idents
Message-ID: <20190206000413.GA734@whubbs1.gaikai.biz>
References: <20190204184850.10040-1-williamh@gentoo.org>
 <20190205195212.25550-3-avarab@gmail.com>
 <xmqqef8mrnnj.fsf@gitster-ct.c.googlers.com>
 <87k1iekkea.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <87k1iekkea.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 05, 2019 at 10:14:37PM +0100, =C6var Arnfj=F6r=F0 Bjarmason wro=
te:
>=20
> On Tue, Feb 05 2019, Junio C Hamano wrote:
>=20
> > =C6var Arnfj=F6r=F0 Bjarmason  <avarab@gmail.com> writes:
> >
> >> +static int set_ident_internal(const char *var, const char *value,
> >> +			    struct strbuf *sb, const int flag)
> >> +{
> >> +	if (!value)
> >> +		return config_error_nonbool(var);
> >> +	strbuf_reset(sb);
> >> +	strbuf_addstr(sb, value);
> >> +	author_ident_explicitly_given |=3D flag;
> >> +	ident_config_given |=3D flag;
> >> +	return 0;
> >> +}
> >> +
> >> +static int set_ident(const char *var, const char *value)
> >> +{
> >> +	if (!strcmp(var, "author.name"))
> >> +		return set_ident_internal(var, value, &git_author_name,
> >> +					  IDENT_NAME_GIVEN);
> >> +	else if (!strcmp(var, "author.email"))
> >> +		return set_ident_internal(var, value, &git_author_email,
> >> +					  IDENT_MAIL_GIVEN);
> >> +	else if (!strcmp(var, "committer.name"))
> >> +		return set_ident_internal(var, value, &git_committer_name,
> >> +					  IDENT_NAME_GIVEN);
> >> +	else if (!strcmp(var, "committer.email"))
> >> +		return set_ident_internal(var, value, &git_committer_email,
> >> +					  IDENT_MAIL_GIVEN);
> >> +	else if (!strcmp(var, "user.name"))
> >> +		return set_ident_internal(var, value, &git_default_name,
> >> +					  IDENT_NAME_GIVEN);
> >> +	else if (!strcmp(var, "user.email"))
> >> +		return set_ident_internal(var, value, &git_default_email,
> >> +					  IDENT_MAIL_GIVEN);
> >> +	return 0;
> >> +}
> >
> > In the v5 patch from William, author_ident_explicitly_given and
> > committer_ident_explicitly_given were set separately depending on
> > what variable was given (e.g. user.name marked both, author.name
> > marked only author but not committer_ident_explicitly_given).  In
> > the original before the addition of this feature with v6, giving
> > user.name would have set both, as we can see below.
> >
> > Is this change intended?
> >
> > Or did you find that committer_ident_explicitly_given is no longer
> > useful and the variable is not used anymore?
>=20
> No, that's a mistake of mine when porting this over, but also clearly a
> blindspot in our tests since they all pass with this.
>=20
> I haven't dug (don't have time right now) to check what the effect of
> that is. William?

I attempted to save your patches to apply them, but didn't have any luck

Also, according to Junio's report, my patch is already merged to next,
so if you give me your patch based on that, I'll take a look, but it may
be a day or so.

William
