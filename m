Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A23A1F453
	for <e@80x24.org>; Thu, 14 Feb 2019 18:17:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406491AbfBNSRt (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 13:17:49 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36684 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389024AbfBNSRt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 13:17:49 -0500
Received: by mail-qk1-f193.google.com with SMTP id o125so4169278qkf.3
        for <git@vger.kernel.org>; Thu, 14 Feb 2019 10:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=nus/wYlBUFfA6APM02nz76uzPusoYYC4m5SaoTGAC3g=;
        b=iyVTvEs0hfNAKRn8u8PGLjJayrN9x56d1AgF80aTCC0F0de9oIxelqlhXZRQWY3vPB
         KmochZPVSHVCSToj/5CsrgI9rS8aiKrREbDlZwL/D9CZjzDKi+0ua6KA+Zd7HcT78Kl8
         E2sJdDkgalYmslCiRc4bADEKaC92RkTskrNFhxSv/CU2yTOpIwxtjGuJtYM9KNzSiZy9
         EfaSV4AIL1K6nPyaEWIGz46PLnLYDWJCaQKpWjTB+pfUNIToyq9+2QFilSnJUjmNnYYR
         ARh1Qy7hcobLqaORK2NNigJrIHi2+2Q93Xi49+xm5wk6X6ctuxRBqfJP9YpzmJqdy+t6
         eZpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=nus/wYlBUFfA6APM02nz76uzPusoYYC4m5SaoTGAC3g=;
        b=O1H8+C1tOP/lYQhBiZj9q8YP9Lg0kDXHF4senWhfyL7BDoj+WykVufY6cVdSO3Yiv9
         HkHBa4rLHhqXVayjeXumym3WqkEcNExsHQburyjsiciKk+rek/EPFPhxMtbiP3Xp+D3R
         AMFpJ+Wzbzx2wHVKUTdV83NUTUdbT0iSC+P0r9Zp+f1e5z15asNku53E3sc1VKgN+42o
         vkkdrez7wenz0YM3oJ/UtU5sClsWrtjg6JcdhqeAurMhBQQEeZ+ChAHrhDr8i4353DA2
         3mDoIeI1sMA8g+VNnDc4tFgBmP6i1frzhdvO/4ocT/PV4Aoi87WbSfvuZPMRN9s/X5zT
         2SBw==
X-Gm-Message-State: AHQUAuYcn7cD50SOOKesQxS/I0Z7hR592WklsJqIT14lRIztvS5Bhkbj
        4tFK859UV7VgEnuWs++Naps=
X-Google-Smtp-Source: AHgI3IZd2WN0oUAA3tcHAFopxQJWdGFOtG9FrVLdktn6qjMC1N7f4E52g/EdeDdqJgjm/yDpHYFaCw==
X-Received: by 2002:a37:7883:: with SMTP id t125mr3830076qkc.201.1550168268322;
        Thu, 14 Feb 2019 10:17:48 -0800 (PST)
Received: from whubbs1.gaikai.biz ([100.42.103.5])
        by smtp.gmail.com with ESMTPSA id n21sm1535211qtl.97.2019.02.14.10.17.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 10:17:47 -0800 (PST)
Received: (nullmailer pid 15601 invoked by uid 1000);
        Thu, 14 Feb 2019 18:17:45 -0000
Date:   Thu, 14 Feb 2019 12:17:45 -0600
From:   William Hubbs <williamh@gentoo.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, chutzpah@gentoo.org, williamh@gentoo.org
Subject: Re: [PATCH v6 2/2] config: allow giving separate author and
 committer idents
Message-ID: <20190214181745.GA15584@whubbs1.dev.av1.gaikai.org>
References: <20190204184850.10040-1-williamh@gentoo.org>
 <20190205195212.25550-3-avarab@gmail.com>
 <xmqqef8mrnnj.fsf@gitster-ct.c.googlers.com>
 <87k1iekkea.fsf@evledraar.gmail.com>
 <20190206000413.GA734@whubbs1.gaikai.biz>
 <xmqqwomdqzik.fsf@gitster-ct.c.googlers.com>
 <20190213164322.GA3625@whubbs1.dev.av1.gaikai.org>
 <xmqqwom39uwz.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <xmqqwom39uwz.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 13, 2019 at 02:37:48PM -0800, Junio C Hamano wrote:
> William Hubbs <williamh@gentoo.org> writes:
>=20
> > I am writing back onn this thread because I'm not quite sure of the
> > status. v5 of the patch seemed ok, but there were some changes discussed
> > that would have created a v6. The v6 changes though were never really
> > clear. I'm not sure whether I am supposed to be doing something more or
> > whether I'm waiting for you. ;-)
> >
> > Can you write back and let me know?
>=20
> In general, unless I ask you to wait, a contributor would almost
> never be waiting for me.
>=20
> I think =C6var's v6 was not up to par, but I thought that v5 from you
> (which is in 'next') was good enough to cook in 'next'.  The topic
> will not be moving out of 'next' until the final 2.21 is released
> anyway, so if anything, I'd say the ball is in his court to update
> his version after the release, when your v5 may have a chance to be
> kicked out of 'next' and replaced _if_ there is a better version by
> then.

Thanks much for the update. I didn't realize that v5 was in next.

William

