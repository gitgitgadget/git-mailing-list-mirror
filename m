Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98A841F462
	for <e@80x24.org>; Wed,  5 Jun 2019 08:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfFEICq (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jun 2019 04:02:46 -0400
Received: from mout.gmx.net ([212.227.15.15]:60457 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726693AbfFEICf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jun 2019 04:02:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559721749;
        bh=FoSbmVCkJds+z01OEzrxtzbAmVpbL4jL8CaKQGVts28=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=cBYNUGqtlN7XX+IsC62aT2tOC8/Ow5eCdK566VjL+VTAx3yCwiuCG9qaB8XBMWMZ/
         /LClQAHDTjm3QjvDlZ61i7t61DrQZJNYoILvEdRnxNQrv4PoIwlCZtJtfl0fQ87s8W
         aUDtakkljTyZI42tWGEN3z0JaZ5yyBxwXb8YsMXI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M5QJD-1hX3IW2uDF-001OzZ; Wed, 05
 Jun 2019 10:02:29 +0200
Date:   Wed, 5 Jun 2019 10:02:13 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Denton Liu <liu.denton@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] config: learn the "onbranch:" includeIf condition
In-Reply-To: <nycvar.QRO.7.76.6.1905312214331.1775@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.1906050953050.1775@tvgsbejvaqbjf.bet>
References: <7b60e58ba554768fd915e4f5c00a97737707ed42.1559263024.git.liu.denton@gmail.com> <3573995264441c50ea9529b3ee926d1ed3ec4ac8.1559330905.git.liu.denton@gmail.com> <nycvar.QRO.7.76.6.1905312214331.1775@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:+lYbc+XlTw+pjuh65BAIdMBIoIX/clv6Hw9e0Em9y4H96yoUGil
 Q0UmWnBR+T2vDx8uy6LczKp4eZZXi1YXWFEkolIkv/4KBc5STXKgtssdXVOTD6IktBj7iBo
 HU+SDgmI44eiYReLm1E3IZ8FQvVjXMdO1lFwmv7/IuQWZ8O6WYupfNZLNnc95zrO6zkL2Yd
 88Hh9pozel/nP4RRsaorA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DsU5xp6WRDQ=:uwpIu5E/PsXv4384v/iPpv
 n9/YXwBRcvrA3XAtX2mFvUG62/aPNPqRvROlUho2p4dby55H3gH9aJ/6PsFFpmm0L+SQcZQ69
 3+P41yVAN24pPUCgPYxrDxcUSri/2AISmlpqERApFKZ15mRj1HiE2KDPo8Unt3rfbMArV/Gsu
 ambxAQIWiEVjzJeljtYCdmOVSseHBO6bGKXz9+PPY42NUuD5VrVl/gMjic43cLpxO8tuRtd5R
 BS9/pClBBESzcVfc28N0a+dIqDjvBE8RyM7JZ36yNkEXkkwj3sDoibhbiTWdxnThzH9eGfel+
 MJoDF3SpTwLhQ0d0qn+avGZjM+8zN4wzcTMRtItbXqCxEmMvp9Vah/niD+6aRPr+s4KH+wAXv
 qPkksOOKIB2QTm/QHNXpMmjCLfZBxwzpjPvwgYQ+gl53aFaM29LLX5Y3Mct9oSsY9RRwQfmu5
 Q7tlWiURdT1wYassQmG4/Fr6T8ROabMfMtrLi0rGIbbHmEk7GAkz2OHVuLTkbYKlXcVk9A/2o
 OjUt6zIRS31Gxp0D0yWpnoc6W+/lANNMg7XEk2uWfVJWC9GeIVRNo7pB1rGNQvLJPaJtKA/UD
 UsA4JEZUU95ktFrTmZwyxOI+m93ma0pXYuakS4/195anoIqhH7BC+Yov0LgzNS5kP+4kRWUhp
 gnnRniaLqivWppIDTTdoGPpFx7VIMOnT22B0xyoeBGLSs7uS+9t2b/IU7u3xvOdPudmd+xiJk
 5Px3dusiuw1NQTcpR3sAAYSLEIjQxKS0sMbLN0K6kw5JVzl+4e9Odd4j/y4qprvlU5GJq98lh
 m2XftlmQyujyyj2rJELEy3tKwHT2nDFdZ4pLSxoAAwfvv9LBEMKuXoycxjNuiKCK7soVkCq4I
 NI5IPxeU0zhthmne4AQjbkhOnpvHqDTv2uKxGqLERb9LJido2Z9sJzA6cQxAVU9omCYU9K5UQ
 phgy+fADyECz8l6CGzAg+MkLy/SnE2ogOJmENcaD4yWvD5CxObBFj
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Denton,

On Fri, 31 May 2019, Johannes Schindelin wrote:

> On Fri, 31 May 2019, Denton Liu wrote:
>
> > Currently, if a user wishes to have individual settings per branch,
> > they are required to manually keep track of the settings in their head
> > and manually set the options on the command-line or change the config
> > at each branch.
> >
> > Teach config the "onbranch:" includeIf condition so that it can
> > conditionally include configuration files if the branch that is
> > checked out in the current worktree matches the pattern given.
>
> This looks good to me.

... actually...

> > diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
> > index 579a86b7f8..05c7def1f2 100755
> > --- a/t/t1305-config-include.sh
> > +++ b/t/t1305-config-include.sh
> > @@ -309,6 +309,39 @@ test_expect_success SYMLINKS 'conditional include=
, gitdir matching symlink, icas
> >  	)
> >  '
> >
> > +test_expect_success 'conditional include, onbranch' '
> > +	(
> > +		cd bar &&

This `bar` is a side effect of an earlier test case. To be precise, of
this test case:

test_expect_success SYMLINKS 'conditional include, gitdir matching symlink=
' '
	ln -s foo bar &&
	(
		cd bar &&
		echo "[includeIf \"gitdir:bar/\"]path=3Dbar7" >>.git/config
&&
		echo "[test]seven=3D7" >.git/bar7 &&
		echo 7 >expect &&
		git config test.seven >actual &&
		test_cmp expect actual
	)
'

As you can see, this test case is marked with the `SYMLINKS` prerequisite,
and hence can be skipped.

I got a crazy idea, though: how about `cd foo` instead of `cd bar`? It
should still work, as `bar` is just a symbolic link (unless that test case
has been skipped, in which case `bar` does not even exist) to `foo`.

And while this still relies on a side effect of an earlier test case
('conditional include, both unanchored', to be precise), at least that
test case cannot be skipped because of a missing prerequisite.

The same `s/cd bar/cd foo` applies to the second test case in this patch,
too, of course.

Thanks,
Dscho

> > +		echo "[includeIf \"onbranch:foo-branch\"]path=3Dbar9" >>.git/config=
 &&
> > +		echo "[test]nine=3D9" >.git/bar9 &&
> > +		git checkout -b master &&
> > +		test_must_fail git config test.nine &&
> > +		git checkout -b foo-branch &&
> > +		echo 9 >expect &&
> > +		git config test.nine >actual &&
> > +		test_cmp expect actual
> > +	)
> > +'
> > +
> > +test_expect_success 'conditional include, onbranch, wildcard' '
> > +	(
> > +		cd bar &&
> > +		echo "[includeIf \"onbranch:?oo-*/**\"]path=3Dbar10" >>.git/config =
&&
> > +		echo "[test]ten=3D10" >.git/bar10 &&
> > +		git checkout -b not-foo-branch/a &&
> > +		test_must_fail git config test.ten &&
> > +
> > +		echo 10 >expect &&
> > +		git checkout -b foo-branch/a/b/c &&
> > +		git config test.ten >actual &&
> > +		test_cmp expect actual &&
> > +
> > +		git checkout -b moo-bar/a &&
> > +		git config test.ten >actual &&
> > +		test_cmp expect actual
> > +	)
> > +'
> > +
> >  test_expect_success 'include cycles are detected' '
> >  	cat >.gitconfig <<-\EOF &&
> >  	[test]value =3D gitconfig
> > --
> > 2.22.0.rc1.169.g49223abbf8
> >
> >
>
>
