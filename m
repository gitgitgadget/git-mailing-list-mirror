Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90AE01F453
	for <e@80x24.org>; Thu, 17 Jan 2019 19:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbfAQTuZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 14:50:25 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40045 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728832AbfAQTuZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 14:50:25 -0500
Received: by mail-ed1-f65.google.com with SMTP id g22so9321002edr.7
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 11:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fWK/EdBDPAcNzwyS3jaoHOroDeDb/Ukl5KbQyB6GZ/Q=;
        b=TBenrHhOOQEDfJDl/r1ATbcFkQ1EO0IkUvOA6CIGoHfBUHeVCvf++J/IvR4hx/CHcr
         9IilljZx1hdt/ptuu/L3xv674zachomPOxcxMVIbBBJ6NFmL2CTv2gl+DT1JLIOWtV8h
         /O+qAyf4p0TXddeMkKcKz/G7tZgKlIwSMQLH2AMDVL1SttWXRV7rp5db01FCGaP4PPI6
         nvV+CLgT0DGGKC5cw4XsnwcMayFvV95FrU7frtjlM3RKBNjuFaDT4wxM9qxXriaAuO+B
         PYOjZG8KWzKrvZZ5EtxI44jK4phdkaS6VFu2rd+oRqgg7vC8qV2v9a5tkyXO1n0902Bq
         Ee1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fWK/EdBDPAcNzwyS3jaoHOroDeDb/Ukl5KbQyB6GZ/Q=;
        b=nVoySk3ru2JI7SVIv/bbKCqssBTT+Opo9CZArQICiC9ZgNQ61eKsw95Rz5EFhqvP5c
         9SXlRk37ESI6n8b+d0bQqcT+YEnJAdyHuyFg+AJTlg6nX3rouHYFBpneMl6tZ5tEF8CK
         9aBMMgUS3KWbjKFe7ybIFiEqDemMJb08ApALB1YDhplJd09XLa27zSbM1y2J45lBcIlW
         1E8Dh+S2RK87/mOJUNd8GxfdStR3g/fOyo/On5JMMPet5u9+FMlWGBU+EK3sL0wre0Tg
         iUnHKa/NoIK0YQnhnXQuAtd1P2ftqrRFBtjNNQJDfKcbaNCdY0iG/mqh8fFGeoxoBRiK
         kYzg==
X-Gm-Message-State: AJcUukdOBQAqO+Ay9BtC3veTNPDX05zNkEJikgihCTmIZyovN+8TMwn3
        U59g5RKcr/N9ZKpSa3Es+82GtJMgg+47+zlqUEAl7A==
X-Google-Smtp-Source: ALg8bN7d7RZlLGe+RH0Xr3w4YlzJLRe446Vaa7qY3QOHR59XAy+6iK5odasaWmzGUQOKPgpPpp+CGnHA2WLbCr9T9H0=
X-Received: by 2002:a50:acc3:: with SMTP id x61mr12824137edc.76.1547754623200;
 Thu, 17 Jan 2019 11:50:23 -0800 (PST)
MIME-Version: 1.0
References: <20190117130615.18732-1-pclouds@gmail.com> <87munz4ani.fsf@evledraar.gmail.com>
In-Reply-To: <87munz4ani.fsf@evledraar.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 17 Jan 2019 11:50:11 -0800
Message-ID: <CAGZ79kZqt+SgHVrhQjPrkcVD8dJcux-yeE6g9o=De6RLWNbydw@mail.gmail.com>
Subject: Re: [PATCH 00/76] Convert diff opt parser to parse_options()
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 17, 2019 at 6:33 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:

> > I sent a sneak peek [1] last year and got two good comments. I take it
> > people at least did not oppose to this. The most interesting parts are
> > at the top and bottom. The middle is just boring conversion, usually
> > one option per patch.
>
> I'm very much for this, and have skimmed it (but not stress tested) and
> it looks good to me. I have some WIP patches to --abbrev that conflict,
> but which will be simpler as a result of this.

I like the series a lot.
