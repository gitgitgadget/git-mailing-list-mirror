Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 947CB201CF
	for <e@80x24.org>; Wed, 17 May 2017 06:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753243AbdEQGrY (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 02:47:24 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:36698 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753223AbdEQGrX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2017 02:47:23 -0400
Received: by mail-io0-f169.google.com with SMTP id o12so3656134iod.3
        for <git@vger.kernel.org>; Tue, 16 May 2017 23:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Gg8wmQixe5Ypj6W0aI4rEaDRicVCIL3ZmiHfp4WyDxQ=;
        b=nWvDrt6jFxRIqY2GH8JIt3uMvnK/fxj5G9JT0fXftJH5ai4wuFjrJovU2UMUVdgasS
         m5O+1zP0i/XKKfI04rdq0fqZzhkSb4j1NTmKfs5sfBqy/fE8GjGmB7mrxQJfJzDCNpRY
         L0V4c2WMYxHlER2KSAL9c+VUDa/eTIbpsn3/k1KAZ9ZeEf+NXOv3+m2YGQ4pRy4nKOuS
         xYQGBzUkPY8v1wAEVnkITtfXVt5dMfE6174yhyxQsq19hOAgrPj9BZT+2zP8Tibdn7F7
         BhWGKy8kzj9RFdedhVARwjylc83IWZLmcCDg+R20/IADe5ram6cWK/hvQYqbdEEa3Y4l
         Cwkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Gg8wmQixe5Ypj6W0aI4rEaDRicVCIL3ZmiHfp4WyDxQ=;
        b=gHl7fF2JSrkJlXC0eIj/r9Ytm3W7R1kQbWkjUA8n2J7oSBJJncD2wLyhNdIZBjz8hz
         vxWH9bLVS/grMwK5HBpsbSWB6b8SaIAAAGDhW4/6B2Mhx6r00JVBM6Q/w1a6E4FfOsim
         BEHMsXkvSb9GEpc1N75/o08tBQsdZiO2G4U0TK2cX9SN/cGgCvsCTXXljpAE+VrVEoYu
         c2pisG6DbzBQwziG3Lb1CBKElci+10w23AlvVpop3/m/BzrxhyaXqe3KkWLBkcm8w8xP
         7FY+FGkD0+ND4fqKnVwu8+qbDJYAlhLvhwpGhhn4n6R+wZ8OBEwc4Yj2AFdOBeYJ4TWH
         mDtw==
X-Gm-Message-State: AODbwcDHe6KHSWXB2+TIC7JC6m1awKKYFFzyyIxtA3ToF98nLkRcsO0R
        o9xN/wsNQGgv8CRbjw26DQHaqe7879nAuyg=
X-Received: by 10.107.201.131 with SMTP id z125mr1587389iof.160.1495003642331;
 Tue, 16 May 2017 23:47:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Tue, 16 May 2017 23:47:01 -0700 (PDT)
In-Reply-To: <xmqq7f1gyzep.fsf@gitster.mtv.corp.google.com>
References: <20170516175906.hdwn4x5md7dj7fo3@kitenet.net> <20170516203712.15921-1-avarab@gmail.com>
 <xmqq7f1gyzep.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Wed, 17 May 2017 08:47:01 +0200
Message-ID: <CACBZZX4Jppr7ht7m444EjW4CDYX5CMvnxtStH4bF=A19TYKcZg@mail.gmail.com>
Subject: Re: [PATCH] tests: add an optional test to test git-annex
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Joey Hess <id@joeyh.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 17, 2017 at 4:45 AM, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Add an optional test to test git-annex. It's guarded by a new
>> EXTERNAL_TESTS environment variable. Running this test takes me 10
>> minutes.

[Re-arranged your mail because it worked better with my reply]

> I do not mind at all to place the simple reproduction recipe Joey
> posted as a new test in our test suite, though.  That kind of test
> that catches changes to externally visible behaviour surely belongs
> to our test suite.

This is not a replacement for having an isolated test for the issue
Joey noted. We should have a separate patch for that, but I did not
have time/interest in writing that up. This change is orthagonal to
that.

> Well, it is one thing to place git-annex under CI to make sure its
> latest and greatest works together well with our latest and greatest
> (and it may be something we want to see happen), but driving its
> tests from our testsuite sounds like a tail wagging the dog, at
> least to me.

To me this is just a question of:

* Is it the case that git-annex tests for a lot of edge cases we don't
test for: Yes, probably. As evidenced by them spotting this
regression, and not us.

* We can (and should) add a test for the specific breakage we caused
in 2.13.0, but that's no replacement for other things annex may be
covering & we may be missing which'll catch future breakages.

* It's a pretty established practice to test a library (git) along
with its consumers (e.g. annex) before a major release.

* This allows us to do that at minimal cost. I think it makes sense to
add this and integration tests for other similar utilities if they're
similarly easy to integrate.
