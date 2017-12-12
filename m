Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 958BB1F407
	for <e@80x24.org>; Tue, 12 Dec 2017 10:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752161AbdLLKat (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Dec 2017 05:30:49 -0500
Received: from mail-wr0-f170.google.com ([209.85.128.170]:44121 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750749AbdLLKar (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Dec 2017 05:30:47 -0500
Received: by mail-wr0-f170.google.com with SMTP id l22so20553523wrc.11
        for <git@vger.kernel.org>; Tue, 12 Dec 2017 02:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=8Hfte75NJ8jnFSzC3MQLiBXCkAJ0SEUk5h8vQDaVzaI=;
        b=ebl+mvjOAymkPuKNNI8Oav0fDekz8BTXRo4v16tq3GjQI/WQBx3Uv1pT1yrw2tmeM8
         RV3P0jVAlI9epip7zBd05MGjzudhIBGZzhx3ipBJvwDSTYt3IG2j9nZuWGxTfBshijvs
         shagAnUZPMMLQ1Mgic853k8NopnPp6/NzDnZtRh5uBWSlkNYLCbL4jcUxRXFzW5BYqWC
         HcPYbNo/FcV6nurWNXJyYfD4EB66YFnFLqDZKTdHNqZC/0YlppmjEz+aSQQlmOxOh62n
         uj6czJnca7PjiY3xsSNh4ljIPSwnaJdjJshqKuiYz1688kWMQmtnWvQkt+ET4JqAyJZr
         ESxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=8Hfte75NJ8jnFSzC3MQLiBXCkAJ0SEUk5h8vQDaVzaI=;
        b=PFaZEUuDCF9KDc7Xspm8u4xmuCy8bKeNi+Mn1Y97MPC0/hUIrYFY8WqxlH51gGEi0G
         ZCPfjz84mpJo8mIdjPMqLDzmA+o9xoKJWHss+1NM8HNU9BDzWLnSXYSUsCUSERrHiWMi
         CD9+lA/TBzac/KkcBonIhg+Qn7BQu0YTFhcXn5AUjZGi1yMT0XwAdxVT2tdZ7yL0UKsF
         Jw32TwxhWuNh0hvKaCNiknF84h9TXTVDqBhB0adNwcn2Go+pcUPNj0F26FXjLJmedlvM
         uEUskSl/VGwArEfaWw3S2Ko8HZ7GLrNGiRhFELD83gmkVjiGByRzWj5mcvUEz11dwLA5
         G1pQ==
X-Gm-Message-State: AKGB3mJySwB2m5LS1pOtVv8Zd9U1Db+KIYhKHC/YoVkwnc8Nq3ekJMXw
        htbPtgSy6cHEw9RVJmJrfEA=
X-Google-Smtp-Source: ACJfBosbjB3PWDvn9JUDbh3ZKV8zrbXn7ZhQ/SNDYjv0hzyOD5wapHJjy7Zg2u90zGhmHCY14dJNTg==
X-Received: by 10.223.166.51 with SMTP id k48mr3213251wrc.125.1513074646677;
        Tue, 12 Dec 2017 02:30:46 -0800 (PST)
Received: from laptop ([213.123.51.170])
        by smtp.gmail.com with ESMTPSA id 2sm11247280wmk.28.2017.12.12.02.30.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Dec 2017 02:30:44 -0800 (PST)
Date:   Tue, 12 Dec 2017 10:30:43 +0000
From:   Thomas Adam <thomas@xteddy.org>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Thomas Adam <thomas@xteddy.org>,
        Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Matthieu Moy <Matthieu.Moy@imag.fr>,
        Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH] git-send-email: fix get_maintainer.pl regression
Message-ID: <20171212103040.jbgkyet5rapqxi44@laptop>
References: <20171116154814.23785-1-alex.bennee@linaro.org>
 <CAPig+cTXq6jSN9f2_xyj=Jfv_cg2kUFUtA5uVkZDrRRSi2x7vg@mail.gmail.com>
 <87wp2jwe9o.fsf@linaro.org>
 <20171121205206.fvwjkkwhil4abmmk@laptop>
 <xmqq8tezyu3g.fsf@gitster.mtv.corp.google.com>
 <87mv2p89wu.fsf@linaro.org>
 <20171211172615.jfsjthkvs4itjpcn@laptop>
 <CACBZZX58KpQ7=V8GUFfxuMQq_Ar6cmmoXyPx_umUTbU19+0LCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX58KpQ7=V8GUFfxuMQq_Ar6cmmoXyPx_umUTbU19+0LCw@mail.gmail.com>
User-Agent: NeoMutt/20171013-21-a9a9c7-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, Dec 11, 2017 at 08:46:46PM +0100, Ævar Arnfjörð Bjarmason wrote:
> I.e. we'd just ship a copy of Email::Valid and Mail::Address in
> perl/Git/FromCPAN/, use a wrapper to load them, and then we wouldn't
> need to if/else this at the code level, just always use the module,
> and it would work even on core perl.

I disagree with the premise of this, Ævar.  As soon as you go down this route,
it increases maintenance to ensure we keep up to date with what's on CPAN for
a tiny edge-case which I don't believe exists.

You may as well just use App::FatPacker.

We're talking about package maintenance here -- and as I said before, there's
plenty of it around.  For those distributions which ship Git (and hence also
package git-send-email), the dependencies are already there, too.  I just
cannot see this being a problem in relying on non-core perl modules.  Every
perl program does this, and they don't go down this route of having copies of
various CPAN modules just in case.  So why should we?  We're not a special
snowflake.

-- Thomas Adam
