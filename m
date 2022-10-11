Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FE8C433F5
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 18:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiJKSl5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Oct 2022 14:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiJKSlz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2022 14:41:55 -0400
Received: from box.elsiehupp.com (box.elsiehupp.com [104.131.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBAF87CB48
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 11:41:54 -0700 (PDT)
Received: from authenticated-user (box.elsiehupp.com [104.131.30.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by box.elsiehupp.com (Postfix) with ESMTPSA id B895DFC346;
        Tue, 11 Oct 2022 14:41:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=elsiehupp.com;
        s=mail; t=1665513713;
        bh=AhfymJ8oOnTA5hl3T/ccMrhAIZySXMS7W7zbjeAbDk4=;
        h=From:Subject:Date:References:To:In-Reply-To:From;
        b=gx54BgA1+2ht/dq3ujRYCcsO6NlRkjUi+ETtaQZ9ehR6G/IUmMp0dsBiEBJkYBR3K
         wyK04LahJZlXYwshZy7aH1y6rvWx3OSUO5x7MTfNLLo78y6HIobruU9pRMmqpEfRWJ
         MdY68Q7CPrg3WxFmkTgQxsYSuhgWkCoc5OT6t7tWRPc1tCRxKHH60l2kGy6S+cd4gA
         gu1D6m7sXVmBbCsMxVpTfqdmYKEjLGEWpIZP9Fi98Ce111NFgpnFSG2MOhO76uT9OK
         JENtuF9aZa33vo4AEqhwL/m4hvjfrPj5S36TkDoAvw8Z0gR7nkpbkDDQWm749F+wJJ
         huhNZdJImQZZQ==
From:   Elsie Hupp <git@elsiehupp.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: Multiple --global config workspaces?
Date:   Tue, 11 Oct 2022 14:41:53 -0400
References: <C4E3A512-2E2C-4EA5-9F2E-3662BCF0F165@elsiehupp.com>
 <xmqqwn96x61t.fsf@gitster.g> <Y0Vr/4IeA236nxzF@coredump.intra.peff.net>
 <03B277AB-DE33-443D-AC9C-FAB7A2F93AB3@elsiehupp.com>
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        reto@labrat.space, philipoakley@iee.email, git@vger.kernel.org
In-Reply-To: <03B277AB-DE33-443D-AC9C-FAB7A2F93AB3@elsiehupp.com>
Message-Id: <909C9446-F04D-4037-B12D-C97A68EC5AB3@elsiehupp.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I just opened an issue on the =E2=80=9CGit Book=E2=80=9D repository =
suggesting the addition of a section discussing [includeIf], if anyone =
here would like to comment there:

https://github.com/progit/progit2/issues/1801

> On Oct 11, 2022, at 12:55 PM, Elsie Hupp <git@elsiehupp.com> wrote:
>=20
> Hi Junio, Reto, Jeff, Philip, et al,
>=20
> Cool, thanks!
>=20
> I was using the =E2=80=9CGit Book=E2=80=9D documentation, not the =
manpage, since (a) the =E2=80=9CGit Book=E2=80=9D is more user-friendly, =
and (b) it=E2=80=99s higher on the DuckDuckGo results for =E2=80=9Cgit =
config", i.e.:
>=20
> https://www.git-scm.com/book/en/v2/Customizing-Git-Git-Configuration
>=20
> Even then, I don=E2=80=99t see includeIf in the first two web-based =
versions of the manpage for the DuckDuckGo query "man git-config":
>=20
> https://linux.die.net/man/1/git-config
> https://manpages.org/git-config
>=20
> Though includeIf does appear in the manpage on my local system, as =
well as in the web-based Arch manpage (which is the fifth result):
>=20
> https://man.archlinux.org/man/git-config.1
>=20
> And includeIf does appear in the official documentation (which is the =
first DuckDuckGo result for "man git-config=E2=80=9D=E2=80=94I much =
prefer web mirrors to using man in the terminal):
>=20
> https://git-scm.com/docs/git-config#_conditional_includes
>=20
> So in summary it seems like a big part the issue I had is that the =
documentation for conditional includes has somewhat lacking SEO, i.e. if =
someone is familiar with the --global config keywords and googles that, =
they are unlikely to find the section for conditional includes. And, =
additionally, conditional includes are a new enough feature that they =
don=E2=80=99t appear in the higher-ranking web-based manpages, neither =
of which display the version of Git they pertain to. (Maybe someone =
could poke them about this, but I=E2=80=99m not sure the best way of =
doing so.)
>=20
> As an aside, looking through the full documentation I see that I can =
also do:
>=20
> [includeIf "hasconfig:remote.*.url:https://github.com/**=E2=80=9D] =
path =3D ./Repositories/github/.gitconfig
> [includeIf "hasconfig:remote.*.url:https://gitlab.com/**=E2=80=9D] =
path =3D  ./Repositories/gitlab/.gitconfig
>=20
> And, conveniently, [includeIf "gitdir:github/=E2=80=9C] also expands =
to [includeIf =E2=80=9Cgitdir:**/github/=E2=80=9C], so I don=E2=80=99t =
have to specify [includeIf "gitdir:~/Repositories/github/=E2=80=9C]. =
(I=E2=80=99m not sure how to represent the trailing slash in bash =
syntax, but it helps, too!)
>=20
> Something more consistent with my initial use case might be a =
hypothetical feature like the following (apologies for dubious syntax):
>=20
> [user "gitdir:github/"]
> 	email =3D "elsiehupp.github@example.com"
>=20
> Or something like:
>=20
> if "gitdir:gitlab/" email =3D "elsiehupp.gitlab@example.com=E2=80=9D
>=20
> In other words, part of the discoverability issue is that I wasn=E2=80=99=
t looking for a conditional _include_ so much as a conditional statement =
more generally.
>=20
> I also tried:
>=20
> [include] path =3D $GIT_COMMON_DIR/../.gitconfig
>=20
> =E2=80=A6only to discover that $GIT_COMMON_DIR is not set =
automatically. Is there some way of automatically describing a path =
relative to any given cloned Git repository?
>=20
> And I tried the following to no avail (despite both paths resolving =
when using cat):
>=20
> [includeIf "gitdir:github/"] path =3D ./**/github/.gitconfig
>=20
> [includeIf "gitdir:github/"] path =3D ./*/github/.gitconfig
>=20
> So it would be nice if in addition to being able to use bash wildcards =
in [includeIf =E2=80=9Cgitdir=E2=80=9D] one could use bash wildcards in =
inclusion paths, as well.
>=20
> I guess for the time being what I=E2=80=99ll stick with is this:
>=20
> [includeIf "gitdir:github/"] path =3D ./Repositories/github/.gitconfig
> [includeIf "gitdir:gitlab/"] path =3D ./Repositories/gitlab/.gitconfig
>=20
> Best,
> Elsie Hupp

