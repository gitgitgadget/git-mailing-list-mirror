Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F935C4346E
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 01:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF0BC20874
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 01:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgIYB7O (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Sep 2020 21:59:14 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37810 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726704AbgIYB7O (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 24 Sep 2020 21:59:14 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 959A560457;
        Fri, 25 Sep 2020 01:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1600999123;
        bh=l//Bh2MtSBDJLTNjDMTqlmLgLTxE8dRCFAmM4Qm+AwU=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=pjjlrpx/h98T2jSYXkOw3eyEjBZJyz7mVbWqTQARPgGIxiV/mBi8glEa8Sa3BosVY
         YOwBsKY+7I19SePmT+tszCyCQGZ407PCS/J9NxuuCvSpvA96JAjmA4M27HbDYTep6n
         kDh8JajoAij5efw4EGcg0WXME7X+0StIfSxJBdyf/V+moUwl5nA2Mcn7aYGeEaupR3
         4nXMZ9aFnbdZNgMmL8l5vMoPjg4HqtFG0NhB3RzJxSHz01W+6g3EBEjEYJT5dCWEDt
         jakNvgJnpPIJfxT0EKTK80Xgb9nAxZnOK97MDrc6iEYq5ofSYZeVduKQklSz12EQs6
         bx9UFiPSdV0+VX31pNgTYG17dcH88KG47MQA4patQmiQ21bYbjRrGck01VJMsM/u6Z
         TH/GDQckrtUNue0amqpfLvVrkAzp13PHkJbenPw6HssWDe0b5xRjdot5U8u7bxlH8t
         lqO/BY5vWGAmfpw3+WqA6oA30y/3EQGuW7SA9MDWeFntcMA+enY
Date:   Fri, 25 Sep 2020 01:58:39 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     The Sharp Ninja <ninja@thesharp.ninja>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Feature suggestion: Features Sets and Feature Dependencies Sets
Message-ID: <20200925015839.GB1392312@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        The Sharp Ninja <ninja@thesharp.ninja>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <DM6PR12MB32446D3BE708BF5158CA0444D5380@DM6PR12MB3244.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5I6of5zJg18YgZEa"
Content-Disposition: inline
In-Reply-To: <DM6PR12MB32446D3BE708BF5158CA0444D5380@DM6PR12MB3244.namprd12.prod.outlook.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--5I6of5zJg18YgZEa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-09-23 at 12:34:24, The Sharp Ninja wrote:
> # Proposal for Feature Sets and Feature Dependency Sets
>=20
> I believe a very useful feature for Git would be the addition of
> Feature Sets and Feature Dependency Sets.
>=20
> ## Feature and Feature Set
>=20
> A Feature is a defined domain of functionality, such as a specific
> service of an API.  Features can be managed as a subset of the
> repository, allowing for segmenting a repository into working groups
> that have their own set of permissions for the pool of users with
> access to the repository.  As an example, User A may not have
> permissions to merge within the repository, but within Feature A he is
> allowed to do so.  This would streamline integrating new users into
> large repositories and teams.

Git doesn't natively provide any functionality for restricting access to
a repository more than by read-only or read-write permissions.  This is
intentional.

Restricting merging to a set of files or even a directory causes
problems detecting what files those are in the context of renames and
copies.  Plus, should Git consider the paths as they were in the merge
base, or one of the heads?  If one of the heads, which one?  Currently,
merges are symmetric except for the order of parents in the commit
object, and this would break that property.

This does seems like functionality you could add on using your CI
system, a pre-receive hook, or features of your hosting platform.  For
example, your CI system could run a check that the user is operating
only within their domain, and reject the operation otherwise.

At $DAYJOB, we do this by requiring reviews by certain teams for certain
files.  If I want to merge code with approval only from my team, I must
restrict myself to files my team owns.  If I touch other teams' files, I
must seek their approval.  Without the relevant approvals, I cannot
merge or deploy any code.  All of this is built on top of Git and Git
knows nothing about it.

In addition, your proposal is very specific to your workflow where teams
must touch only their code.  In other organizations, such as mine, teams
may touch any code with approval.  There's no reason to think that one
or the other approach is better or should be more privileged in Git
itself, especially when both approaches can be effectively built on top.

> ## Changes to Workflow
>=20
> Once a user has cloned a repository, he may chose to scope his work to
> the Feature Set.  All Fetch/Pull/Push operations are limited to the
> Feature Set.

Because a blob can be shared across paths and is only stored once, it's
not possible to determine efficiently whether a blob is accessible only
under a certain path.  As outlined in gitnamespaces(7), trying to
restrict access to only a subset of a repository can't be done securely,
because attackers can make deltas against other objects.

So this approach would be both inefficient and insecure.

> ## Feature Dependency Sets
>=20
> Artifacts that are not part of a Feature, but directly affect the
> Feature can be added to a Feature Dependencies Set.  When scoping
> actions to the Feature, artifacts related to the Feature by way of
> inclusion in a Feature Dependency Set are also included in the
> activities.  If a commit includes changes to items in the Feature
> Dependency Set then creating a pull request will generate two PRs, the
> first a normal PR with normal permissions that includes only the
> changes in the Features Dependency Set, to be adjudicated via the
> normal workflow, and the second PR scoped to both the changes in the
> Feature Set and Feature Dependency Set in the Feature's user-level
> branch.

Git has no concept of pull requests.  Those are a feature typically
built on top of hosting platforms like GitHub, GitLab, or Bitbucket.
Some projects, such as Linux, don't use pull requests at all.
--=20
brian m. carlson: Houston, Texas, US

--5I6of5zJg18YgZEa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX21OzgAKCRB8DEliiIei
gc7PAQD62nZ9g95SyaztYWE2wdqTZGXjbmgj45wlcDf2TvJBfAD+Mw/klvx28Pnb
Aw4Y8rIM9Y/rwr23f6YqWaXtv/fqkAU=
=T7Es
-----END PGP SIGNATURE-----

--5I6of5zJg18YgZEa--
