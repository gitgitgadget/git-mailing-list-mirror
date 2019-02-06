Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,URIBL_DBL_SPAM,URIBL_RED shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E85571F453
	for <e@80x24.org>; Wed,  6 Feb 2019 01:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbfBFBFr (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Feb 2019 20:05:47 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34770 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfBFBFr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Feb 2019 20:05:47 -0500
Received: by mail-ot1-f66.google.com with SMTP id t5so9315705otk.1
        for <git@vger.kernel.org>; Tue, 05 Feb 2019 17:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=L6xAO+GHOU2tAJ500VZrA4Yurp4qRoON6xUWo7GC27E=;
        b=PNrWEzFD2q6P0zuK4eSF6Bw+vqqVJ92l3H6yCefi67RkATuYPUR7nnMNxLRcCcM7b8
         VUpUy6roKBGlO0jQ1PsD/El1QiJSW6Lbws5xH5gUk2jM2FpQJepYlPg7eyPBeTHtutPE
         Z2lwK6Y0NPhD64pujdewD7CNscxbcH4usf0t+XvD5FeONd+B8ArdzTJEJWTjPpx6wkAv
         z8HvxWbTsdp2NJ+Qf5ZO6sftlRx7h1/YLSv65n0dpCmM/PSODGjUiYC5xw7szVnYyrlJ
         kJayGzgyQcn1UAGe9xSpk+8U30A2pxgBy4qLl54+FDwvcGIJECfBIarEIxYZ+YrcQfsP
         sS2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=L6xAO+GHOU2tAJ500VZrA4Yurp4qRoON6xUWo7GC27E=;
        b=H/QIAzuGrIsp9CIKtAlp5vk7DT+1k8wOFRjUj5RvgUm+KAAvTCL7Asg3M03iirWqjw
         XpCy4qIV0858oHWJfsnX2fiRCbre8GtUQMgibIQcMWR4LoI4xa+/MFOGLCVpgmYXD2jd
         wJQzj1gwHb5fRZiKpsYokAdfzAPBgw9eiuPHKqt1to4+nuIK/hXMtu8y2+nfQtVoj6RY
         JBxVTHcElQh5Bj1CWB6CIe01mqoQOdnXfgSL1u7ScEW49DhyQl9JIz6ZjF+dYIi3e3y3
         cBuYPTmx71bHiKL+hBrFQjfwvoFZ/si81y3oIqvZQLOvGSMgtHBrjBCoBl8GMDIWbvWK
         lSxQ==
X-Gm-Message-State: AHQUAuZUJx6Z9HFXXzSWQN6ztloPY3XIxsin22jW6M4BHA3DIYzXzP3n
        iJvyDvXFYojmRlRCAIYvm/z7oW9J
X-Google-Smtp-Source: AHgI3IZooRKQdWBs3Ae1ZPDx90QyNpk1UQnu7cBXISJKcB1zR70J+Sz4qnwFROgtTNlhGjpqBaiVxQ==
X-Received: by 2002:a05:6808:103:: with SMTP id b3mr445107oie.274.1549415145910;
        Tue, 05 Feb 2019 17:05:45 -0800 (PST)
Received: from whubbs1.gaikai.biz ([100.42.103.5])
        by smtp.gmail.com with ESMTPSA id j23sm10078332oih.22.2019.02.05.17.05.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Feb 2019 17:05:45 -0800 (PST)
Received: (nullmailer pid 1053 invoked by uid 1000);
        Wed, 06 Feb 2019 01:05:43 -0000
Date:   Tue, 5 Feb 2019 19:05:43 -0600
From:   William Hubbs <williamh@gentoo.org>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        chutzpah@gentoo.org, williamh@gentoo.org
Subject: Re: [PATCH v6 2/2] config: allow giving separate author and
 committer idents
Message-ID: <20190206010543.GA1035@whubbs1.gaikai.biz>
References: <20190204184850.10040-1-williamh@gentoo.org>
 <20190205195212.25550-3-avarab@gmail.com>
 <xmqqef8mrnnj.fsf@gitster-ct.c.googlers.com>
 <87k1iekkea.fsf@evledraar.gmail.com>
 <20190206000413.GA734@whubbs1.gaikai.biz>
 <20190206001558.GB734@whubbs1.gaikai.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190206001558.GB734@whubbs1.gaikai.biz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 05, 2019 at 06:15:58PM -0600, William Hubbs wrote:
> On Tue, Feb 05, 2019 at 06:04:13PM -0600, William Hubbs wrote:
> > On Tue, Feb 05, 2019 at 10:14:37PM +0100, =C6var Arnfj=F6r=F0 Bjarmason=
 wrote:
> > >=20
> > > On Tue, Feb 05 2019, Junio C Hamano wrote:
> > >=20
> > > > =C6var Arnfj=F6r=F0 Bjarmason  <avarab@gmail.com> writes:
> > > >
> > > >> +static int set_ident_internal(const char *var, const char *value,
> > > >> +			    struct strbuf *sb, const int flag)
> > > >> +{
> > > >> +	if (!value)
> > > >> +		return config_error_nonbool(var);
> > > >> +	strbuf_reset(sb);
> > > >> +	strbuf_addstr(sb, value);
> > > >> +	author_ident_explicitly_given |=3D flag;
> > > >> +	ident_config_given |=3D flag;
> > > >> +	return 0;
> > > >> +}
> > > >> +
> > > >> +static int set_ident(const char *var, const char *value)
> > > >> +{
> > > >> +	if (!strcmp(var, "author.name"))
> > > >> +		return set_ident_internal(var, value, &git_author_name,
> > > >> +					  IDENT_NAME_GIVEN);
> > > >> +	else if (!strcmp(var, "author.email"))
> > > >> +		return set_ident_internal(var, value, &git_author_email,
> > > >> +					  IDENT_MAIL_GIVEN);
> > > >> +	else if (!strcmp(var, "committer.name"))
> > > >> +		return set_ident_internal(var, value, &git_committer_name,
> > > >> +					  IDENT_NAME_GIVEN);
> > > >> +	else if (!strcmp(var, "committer.email"))
> > > >> +		return set_ident_internal(var, value, &git_committer_email,
> > > >> +					  IDENT_MAIL_GIVEN);
> > > >> +	else if (!strcmp(var, "user.name"))
> > > >> +		return set_ident_internal(var, value, &git_default_name,
> > > >> +					  IDENT_NAME_GIVEN);
> > > >> +	else if (!strcmp(var, "user.email"))
> > > >> +		return set_ident_internal(var, value, &git_default_email,
> > > >> +					  IDENT_MAIL_GIVEN);
> > > >> +	return 0;
> > > >> +}
> > > >
> > > > In the v5 patch from William, author_ident_explicitly_given and
> > > > committer_ident_explicitly_given were set separately depending on
> > > > what variable was given (e.g. user.name marked both, author.name
> > > > marked only author but not committer_ident_explicitly_given).  In
> > > > the original before the addition of this feature with v6, giving
> > > > user.name would have set both, as we can see below.
> > > >
> > > > Is this change intended?
> > > >
> > > > Or did you find that committer_ident_explicitly_given is no longer
> > > > useful and the variable is not used anymore?
> > >=20
> > > No, that's a mistake of mine when porting this over, but also clearly=
 a
> > > blindspot in our tests since they all pass with this.
> > >=20
> > > I haven't dug (don't have time right now) to check what the effect of
> > > that is. William?
> >=20
> > I attempted to save your patches to apply them, but didn't have any luck
>=20
> More info here. I use mutt and when I tagged the patches and saved them
> to a mailbox, they went to a mailldir type folder, and "git am" didn't
> seem to like that, but I'll try again.

I tried one more time, saving the patches to individual files, and they
still would not apply.

Thanks,

William

