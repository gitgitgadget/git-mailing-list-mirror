Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 855D420286
	for <e@80x24.org>; Tue, 12 Sep 2017 11:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751454AbdILLqA (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Sep 2017 07:46:00 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34674 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751289AbdILLp4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2017 07:45:56 -0400
Received: by mail-wr0-f196.google.com with SMTP id k20so5929658wre.1
        for <git@vger.kernel.org>; Tue, 12 Sep 2017 04:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vUOHmnhCp+wiCqhH7wPUn4R+IXNzK0YPlpSwyVZ/kNA=;
        b=SlhH3dY8KXIwSwvE1K5yeoz/fCPRiHEZK+j7JKioxrEYXRMpCOpes/NAI3EGGWu2oX
         aq61/SDLcFXDL4Djge9n+kWwoMdABwWH7GuHjd2XzEy9bqafokeGYDRfmbIaVSQKWtdy
         MMEnVseUKLGBzaZC+TcCtC6BW1IScklh9k3adrjKjcBOraZnnnkGInNbVWRf6ncK2IhL
         3HZcW+MERt3Q7JNZFnp/1rzQIfFx3m03qePfwlNmN+1dtprWW41tEIff2yGogAsdkF5A
         jRIsSfSXispSJdodhH8/P+R1Sw9pk95EGmlH0E6lDkgkfl5joR79staXqUawUk714tdE
         FGbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vUOHmnhCp+wiCqhH7wPUn4R+IXNzK0YPlpSwyVZ/kNA=;
        b=cEasLZZaUXdvQlpVuQiseeYQPTsVMQ7AvPLvOZjZP7bouKJgtLLBzqTailJBpgB/2N
         Vi8HKbqC5ywtRKQBtYLBOm7sk6bNIduaNohdquH0K6wqTFhJ89HWbgnzGWAJ/f+npDpD
         KCKsY5WtQ67kKfKQz2vJxnnm9M0n8RiYdsGqAuEaLcA2PBU8MxvwhA5jlqLVqGg3FSu2
         wWJab/sp4K/R5DAO2Jmb0RYn9PXKyjIGC30nAGUQx82zn4/Jc1IH+bkxfn0hSt3xFBaK
         YQH4gEa5rLeQQQBapzkI9Y+CS4ZkOW/ZoaZ+n+d3EQ6WsfoDpsFlJF0Y8c+8bpX1ciL+
         XRGw==
X-Gm-Message-State: AHPjjUgwA9X6RJFLSm3H4/7IsJX7dJpIu52TzC7g/G0RT+UfprIcUFHb
        0TnhrDMxg3r8Sg==
X-Google-Smtp-Source: ADKCNb4tKyVnBtcp6G2CeJhVM841xnvTtG2UVF4ws/8lp8bwUhaKkDWnVKQYDfwHx1CZrut6Aem7pg==
X-Received: by 10.223.184.161 with SMTP id i30mr12315719wrf.147.1505216754706;
        Tue, 12 Sep 2017 04:45:54 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id z132sm7405381wmb.4.2017.09.12.04.45.53
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Sep 2017 04:45:53 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v1 2/2] travis-ci: skip a branch build if equal tag is present
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20170911145241.18571-1-szeder.dev@gmail.com>
Date:   Tue, 12 Sep 2017 13:45:53 +0200
Cc:     gitster@pobox.com, git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <3B175D35-5B1C-43CD-A7E9-85693335B10A@gmail.com>
References: <20170911145241.18571-1-szeder.dev@gmail.com>
To:     =?utf-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 11 Sep 2017, at 16:52, SZEDER G=C3=A1bor <szeder.dev@gmail.com> =
wrote:
>=20
>> If we push a branch and a tag pointing to the HEAD of this branch,
>=20
> s/the HEAD of//, perhaps?
> There is no such thing as "HEAD" (all capital!) of a branch, is it?

Agreed, maybe:
"If we push a branch and a tag pointing to the tip of this branch..."

Would that be OK for you?


>> then Travis CI would run the build twice. This wastes resources and
>=20
> Nit: s/run the build/build and test the same tree/, to further stress
> that the two builds are redundant.

OK, will fix.


>> slows the testing.
>>=20
>> Add a function to detect this situation and skip the build the branch
>=20
> s/skip the build/skip building/ ?

OK, will fix.


>> if appropriate. Invoke this function on every build.
>>=20
>> Helped-by: Junio C Hamano <gitster@pobox.com>
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> ---
>> ci/lib-travisci.sh | 23 +++++++++++++++++++++++
>> 1 file changed, 23 insertions(+)
>>=20
>> diff --git a/ci/lib-travisci.sh b/ci/lib-travisci.sh
>> index 44d6ba2dd2..9c4ae9bdd0 100755
>> --- a/ci/lib-travisci.sh
>> +++ b/ci/lib-travisci.sh
>> @@ -1,5 +1,28 @@
>> # Library of functions shared by all CI scripts
>>=20
>> +skip_branch_tip_with_tag () {
>> +	# Sometimes, a branch is pushed at the same time the tag that =
points
>> +	# at the same commit as the tip of the branch is pushed, and =
building
>> +	# both at the same time is a waste.
>> +	#
>> +	# Travis gives a tagname e.g. v2.14.0 in $TRAVIS_BRANCH when
>> +	# the build is triggered by a push to a tag.  Let's see if
>> +	# $TRAVIS_BRANCH is exactly at a tag, and if so, if it is
>> +	# different from $TRAVIS_BRANCH.  That way, we can tell if
>> +	# we are building the tip of a branch that is tagged and
>> +	# we can skip the build because we won't be skipping a build
>> +	# of a tag.
>> +
>> +	if TAG=3D$(git describe --exact-match "$TRAVIS_BRANCH" =
2>/dev/null) &&
>> +		$TAG !=3D $TRAVIS_BRANCH
>=20
> This must be
>=20
>    [ $TAG !=3D $TRAVIS_BRANCH ]
>=20
> otherwise the shell will rightfully complain:
>=20
>  $ TRAVIS_BRANCH=3Dv2.14.0 ./ci/lib-travisci.sh=20
>  ./ci/lib-travisci.sh: line 17: v2.14.0: command not found
>=20
> Furthermore, I would prefer quotes around $TAG and $TRAVIS_BRANCH.  If
> either one of those two variables were empty (or contain multiple
> words) at that point, the shell would complain.  Now, I don't think
> that either can end up being empty, so quotes are not necessary, but
> having quotes around them would save future readers from spending
> brain cycles on this unnecessarily.

Agreed. I will fix both things!


Thanks for the review,
Lars=
