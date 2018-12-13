Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCACC20A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 19:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbeLMT3e (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 14:29:34 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39895 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbeLMT3e (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 14:29:34 -0500
Received: by mail-qt1-f195.google.com with SMTP id n21so3491763qtl.6
        for <git@vger.kernel.org>; Thu, 13 Dec 2018 11:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=wTPZl6tNF/JT7nEmgMOvAPsqRMbvH2HIl4636Rel9YI=;
        b=H/YCNo+aBzq3VTqqsw/WMaeHuKqrk+HFhoR9I/e1U9qtiv5anK0O+bPf2QVNaZCoVb
         0jGhU8VvVJRD7ptpcup55Nvd6gMUgxAt6X0dxVh5XaB8LKecobtHIj92pguqi8iB/M/T
         7Z3QIhTMD0AcmzQ46nIQic5U875KiaOVkefP34JZhlvQFTmlEhoavMrDnzjx8JPwhPfY
         nJAvTzQivgw0IW7N8SYATV3YYZdMd3f1BBsigY+Gef3RSaVrpoISuwKVhSn820X3/sNK
         1Oq67qqzJ1JBc+m8xoiA35U8U0Pm9P+GvP/edgQjYoE3GvEEGmC4Y3LvP6mPLJ4JRlxh
         yhGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=wTPZl6tNF/JT7nEmgMOvAPsqRMbvH2HIl4636Rel9YI=;
        b=PO4B6hUt/8db9UGaAp3Id5b86RJC3UiUsRZPcUF9GoHlRyLdC/4pET9fl72CPfrZS8
         yxGdvGQnJMywBqFZNSSkoNqoCxx5ucn6J4TN2l+sFMnJBmdg4DQiv4Y/RzWfcjwH/Xwn
         /8SBQ4ZezJdos1yxYQqqphx3jQnv89P6dq1WU9ZCX+AR1W7G1ItscVk03kW9Ec248mVu
         +B9CF8auQQFM8QgBpD53+7nvk5SMi8p19n5wk9d8TNe5UCG8LIEQy0ob5Y/yjWfrtLSr
         6SCReQ+kmlDqpMpbpcKOtJCkwoo/jZwp5tens6TiBIp6u9reb6l1qFuyuKVxMqisiVCi
         GavA==
X-Gm-Message-State: AA+aEWaz9V4OotjoieX1yjdLSNGZaTZMHAfJvTEoEy2udbfP8MTAmyuN
        V1kxzynv7w16xf7E4F1Aohg=
X-Google-Smtp-Source: AFSGD/Xo/2aJ7vSUmLmYqb9zvJPgmbq6WYYAp8orizEjdAi4Vdah3x7ruMAZFuMT/ipvy6/Ll+BINw==
X-Received: by 2002:a0c:c138:: with SMTP id f53mr28134qvh.225.1544729372950;
        Thu, 13 Dec 2018 11:29:32 -0800 (PST)
Received: from whubbs1.gaikai.biz ([100.42.103.5])
        by smtp.gmail.com with ESMTPSA id w52sm1949858qtc.51.2018.12.13.11.29.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Dec 2018 11:29:32 -0800 (PST)
Received: (nullmailer pid 21213 invoked by uid 1000);
        Thu, 13 Dec 2018 19:29:30 -0000
Date:   Thu, 13 Dec 2018 13:29:30 -0600
From:   William Hubbs <williamh@gentoo.org>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, chutzpah@gentoo.org
Subject: Re: enhancement: support for author.email and author.name in "git
 config"
Message-ID: <20181213192930.GA21006@whubbs1.gaikai.biz>
References: <20181206181739.GB30045@whubbs1.gaikai.biz>
 <CAN0heSp2g0A82YYvMw-RaERESXFtj3TgPKA3RysC07Lf=tHBcg@mail.gmail.com>
 <20181206191737.GA31091@whubbs1.gaikai.biz>
 <nycvar.QRO.7.76.6.1812062318570.41@tvgsbejvaqbjf.bet>
 <20181207222147.GA22590@whubbs1.gaikai.biz>
 <20181207224428.GE73340@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20181207224428.GE73340@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On Fri, Dec 07, 2018 at 02:44:28PM -0800, Jonathan Nieder wrote:
> William Hubbs wrote:
> > On Thu, Dec 06, 2018 at 11:20:07PM +0100, Johannes Schindelin wrote:
>=20
> >> There *is* a way to get what you want that is super easy and will
> >> definitely work: if you sit down and do it ;-)
> >>
> >> Please let us know if you need any additional information before you c=
an
> >> start.
> >
> > Which branch should I work off of in the repo?
>=20
> "master".
>=20
> Also, please make sure the documentation (e.g. in
> Documentation/config/user.txt) describes when a user would want to set
> this option.

Is the git team on an irc channel somewhere, or should I start sending
patches that I know are incomplete to the list?

I would like to work with someone on this since I'm not that familiar
with the git sources. :-)

Thanks,

William

