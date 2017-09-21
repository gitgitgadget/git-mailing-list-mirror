Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1848920A26
	for <e@80x24.org>; Thu, 21 Sep 2017 22:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751847AbdIUW0s (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Sep 2017 18:26:48 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:37991 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751728AbdIUW0r (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2017 18:26:47 -0400
Received: by mail-wr0-f194.google.com with SMTP id p37so3804840wrb.5
        for <git@vger.kernel.org>; Thu, 21 Sep 2017 15:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=FudH9HdFk9XNA2hOLsNnznuR2s0xs8LGSL36+ybqE8Q=;
        b=UvX+nkyA/5ln6W1WFwGB7/qccHcn+CkZRfLgzyaFENbjLmvDdq2AaVGufVrVcyD3Jv
         0u3/5dILDmKlaLRhXY4sb6VM3A3H+xyjPE/ZPGIbSuS6i7IdXPFUnhQkkKlIcONYrbWK
         hb/7Iwbd3t5Sw7ByLZ1ZkqP8IuJFdvbihe6TkkLD5N+aD9R6CUbqfbCa0s46BF1eRunU
         LwvnnmEHLOKjZzn0HbgftupP1PRx0KwXzyQ5H2wqCjqUO+JG3qWdjPJFsKWa9E8iXZLe
         z44RyrWHETerHaG3hhGzb3BBv9tZ33OjJPOX5xvMLLSQLOVPsvID7w4n20jeDgJdQeyI
         iiFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=FudH9HdFk9XNA2hOLsNnznuR2s0xs8LGSL36+ybqE8Q=;
        b=aTsItpPqvLR91T6yo5ICiZGvHVcDr0noGNdmSWdA05Iw+vCkR3rGrmEqpbJdlCegTf
         GCW51hcSvax3ECJ+gNDqe+kK13O9MfRaecJsRIWU5FxmH6V26T6lYzKzj642W31Tx2y2
         ZLY4iasfD+fufdKPWWYwFKIPdSAP+9VIRzD8rN6iCU2AB0JBR917Y2a+hNttfIPzKfAo
         Wxa1FFVFhy5ffryTnLruhxwutjJtEtyVJ0jYuz60iKl4hVVYHLKP4IE5OxcbDh1ajuTQ
         uktzw42y8aDUcEg/HgxVKE3IQBTztEgPSUOn7OcvvqcaI28zpLaOJ5C164pkpp6I+GJk
         YK0Q==
X-Gm-Message-State: AHPjjUgPmez2vedGlNJAqE5PCKESCnHjF/M0jfaH452SJJmF4vSgoFY7
        s3VWWHhtB+rrukqPPvBFyP0=
X-Google-Smtp-Source: AOwi7QDdNCrXkYH34DoJLd+bDbv3M0bKmWH5aCfBd9iGfWtjt/V9YxX5YRLMb1MR4O46SAusMNqffw==
X-Received: by 10.223.186.6 with SMTP id o6mr2837156wrg.263.1506032806658;
        Thu, 21 Sep 2017 15:26:46 -0700 (PDT)
Received: from rempc0mfw8m.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id q188sm2170088wmb.43.2017.09.21.15.26.45
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 Sep 2017 15:26:45 -0700 (PDT)
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v1] travis-ci: fix "skip_branch_tip_with_tag()" string comparison
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20170921212848.GJ27425@aiede.mtv.corp.google.com>
Date:   Fri, 22 Sep 2017 00:26:44 +0200
Cc:     git@vger.kernel.org, szeder.dev@gmail.com, gitster@pobox.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <4FC081C4-355E-4E62-8CD8-89C299485182@gmail.com>
References: <20170921204830.66831-1-larsxschneider@gmail.com> <20170921212848.GJ27425@aiede.mtv.corp.google.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 21 Sep 2017, at 23:28, Jonathan Nieder <jrnieder@gmail.com> wrote:
>=20
> larsxschneider@gmail.com wrote:
>=20
>> 09f5e97 ("travis-ci: skip a branch build if equal tag is present",
>> 2017-09-17) introduced the "skip_branch_tip_with_tag" function with
>> a broken string comparison. Fix it!
>>=20
>> Reported-by: SZEDER G=E1bor <szeder.dev@gmail.com>
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> ---
>=20
> Thanks for the fix.
>=20
> 09f5e97 appears to be for the ls/travis-scriptify branch, which is
> already part of "next" (if it weren't, I'd suggest just squashing your
> patch into that commit).
>=20
>> --- a/ci/lib-travisci.sh
>> +++ b/ci/lib-travisci.sh
>> @@ -14,7 +14,7 @@ skip_branch_tip_with_tag () {
>> 	# of a tag.
>>=20
>> 	if TAG=3D$(git describe --exact-match "$TRAVIS_BRANCH" =
2>/dev/null) &&
>> -		$TAG !=3D $TRAVIS_BRANCH
>> +		[ "$TAG" !=3D "$TRAVIS_BRANCH" ]
>=20
> Git style is to use 'test' instead of '[' for this.  See
> =
https://public-inbox.org/git/2f3cdc85-f051-c0ae-b9db-fd13cac78aed@gmail.co=
m/
> for more on that subject.

Oh, you're right!


> Could you squash in the following?

@Junio: Can you squash it when you apply the patch?

Thank you,
Lars


>=20
> Thanks,
> Jonathan
>=20
> diff --git i/ci/lib-travisci.sh w/ci/lib-travisci.sh
> index c3b46f4a7d..b3ed0a0dda 100755
> --- i/ci/lib-travisci.sh
> +++ w/ci/lib-travisci.sh
> @@ -14,7 +14,7 @@ skip_branch_tip_with_tag () {
> 	# of a tag.
>=20
> 	if TAG=3D$(git describe --exact-match "$TRAVIS_BRANCH" =
2>/dev/null) &&
> -		[ "$TAG" !=3D "$TRAVIS_BRANCH" ]
> +		test "$TAG" !=3D "$TRAVIS_BRANCH"
> 	then
> 		echo "Tip of $TRAVIS_BRANCH is exactly at $TAG"
> 		exit 0

