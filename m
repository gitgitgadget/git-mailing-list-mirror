Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7253E1FA7B
	for <e@80x24.org>; Mon, 19 Jun 2017 13:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751711AbdFSNYz (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 09:24:55 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:35292 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750782AbdFSNYy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 09:24:54 -0400
Received: by mail-pg0-f50.google.com with SMTP id 132so14459893pgb.2
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 06:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :disposition-notification-to:mime-version:content-transfer-encoding;
        bh=ldt3tvr7U9YlBBwdvAyq7v1JEMED26/1JOnMhFH0HrM=;
        b=sq7FEdQ8J09bQk6I4nuHvrS7cltJY/tGxBQxXZr+Ze1iR/00YM4Z9b8uUU8b9JG8gR
         6bUBAxsAOiZxwol/ktGJ7K3ThpunInbqbq5+5Js/K+J3yC8dtorg9p3vvWuuEVG3cWXM
         9ryd6gIy0WUM1DgERGwcgvOAErJSPCdSRFu5gRGgW3MbpaX4hJk09cTixgsRIiOjFF3y
         lyn8Dk7YkwQ7gkE5XihfIFzfl/8wlr5r8LkkX+eyiukmvR2cZhbBPkOgSVSRaBlXabYl
         aCmyIXyXBErefVOqiqROEge8k5jv2dwgXgjN/CG56ihzGLz+Eptu2SE91zv0CsOj/n+S
         MSMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:disposition-notification-to:mime-version
         :content-transfer-encoding;
        bh=ldt3tvr7U9YlBBwdvAyq7v1JEMED26/1JOnMhFH0HrM=;
        b=Kdw8Wu/6dps7OVLcv32r7+hZtumdtoUom/xqPG10bLBcX01tDrbx072oy7t0pu2eQH
         SpRPcXKmK5wdmrIVEB7xpff2Vosu8Mz1mKuoV0iM/ltTRXICAEyMeunT65pkquSoqxyi
         HGpW8Qw1WZOXDOrZOSFnQbnMmY3piJPuxZr3NEeccVSjT8+dBaL0Ci4lBmU7ptUdgeVj
         kktyHKPnaJULtTRakHP+UML0XMIFQKhm78fPp7gQDmoe2Haz8YczftDJrXq8LfoGHxrv
         J+4PLL+Rhykn5pasLwJh2GYTyKe4JXHoaqN1Lq4lncnTzSZq/1geSrgGGWE/JENJessD
         BECw==
X-Gm-Message-State: AKS2vOxgXfr6Bhlvf6fi1WsCOmbik+0ngFiBUqZtAuNpKPShFtp6itWs
        O0lUTuzf/LQxDgXE5/I=
X-Received: by 10.99.174.67 with SMTP id e3mr25612042pgp.119.1497878683147;
        Mon, 19 Jun 2017 06:24:43 -0700 (PDT)
Received: from unique-pc ([182.73.79.179])
        by smtp.googlemail.com with ESMTPSA id x5sm21064130pfi.103.2017.06.19.06.24.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Jun 2017 06:24:42 -0700 (PDT)
Message-ID: <1497878658.1909.3.camel@gmail.com>
Subject: Re: [PATCH/ALMOST FINAL] Contextually notify user about an initial
 commit
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Jeff King <peff@peff.net>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     gitster@pobox.com, git@vger.kernel.org,
        sandals@crustytoothpaste.net
Date:   Mon, 19 Jun 2017 18:54:18 +0530
In-Reply-To: <20170619091050.kymih3f345kexaf7@sigill.intra.peff.net>
References: <1497771338.1689.4.camel@gmail.com>
         <20170618075301.6431-1-kaarticsivaraam91196@gmail.com>
         <87shix8zik.fsf@gmail.com>
         <20170619091050.kymih3f345kexaf7@sigill.intra.peff.net>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 2017-06-19 at 05:10 -0400, Jeff King wrote:
> On Sun, Jun 18, 2017 at 10:34:59AM +0200, Ævar Arnfjörð Bjarmason
> wrote:
> 
> > Why not simply "No commits yet", saying "on the branch" is
> > needlessy
> > duplicating information in the context of the status output in
> > which
> > this is printed, i.e. now you have:
> > 
> >     $ ~/g/git/git-status
> >     On branch master
> > 
> >     No commits yet on the branch
> > 
> >     nothing to commit (create/copy files and use "git add" to
> > track)
> > Since we've already pointed out that the user is on a branch.
> 
> I thought one of the points was to disambiguate the case of "no
> commits
> yet in the repository" and "no commits yet on the branch". If we
> don't
> care about making that distinction (or think that the mention of the
> branch is enough to make it clear), then succinct is fine. I don't
> have
> a strong opinion either way.
> 
I had the same thought in the beginning but the sample output seemed to
make me think "The terse message was fine". I am unopinionated, too.
I'll stay with "No commits yet" for now until someone suggests to
change it due to confusion about whether it's a "No commits yet on the
branch" or it's a "No commits yet on this repository".

--
Regards,
Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
