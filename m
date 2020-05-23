Return-Path: <SRS0=yx/J=7F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2574AC433DF
	for <git@archiver.kernel.org>; Sat, 23 May 2020 14:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE76220727
	for <git@archiver.kernel.org>; Sat, 23 May 2020 14:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="TrmTbc7O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387834AbgEWORG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 May 2020 10:17:06 -0400
Received: from mout.gmx.net ([212.227.17.22]:39321 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387799AbgEWORF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 May 2020 10:17:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1590243416;
        bh=RnaobU4ey9U5IHjtkocwbl+jK+bfXr9KReCFWEaGK58=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=TrmTbc7OeDeZB/gJFdT3mweHVudj3jJsCE6hQqHb5qz7fcS2vR5ToKQHbkNUvviZo
         ppA0KiJ265Y15mp6eSh3ApDcQB/VRoMjL85kVw2OSZWdYkJKwrzqiUW/7p1gsaOhjc
         Kyqb51FSq62BhLiUbbN49Rqp/FKqccmgD7cmKvPk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.211.123] ([89.1.214.131]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MwQXN-1imjqn1zr3-00sLjv; Sat, 23
 May 2020 16:16:56 +0200
Date:   Sat, 23 May 2020 08:59:31 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v3 0/5] cleanup ra/rebase-i-more-options
In-Reply-To: <20200521101455.63484-1-phillip.wood123@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2005230857120.56@tvgsbejvaqbjf.bet>
References: <20200407141125.30872-1-phillip.wood123@gmail.com> <20200521101455.63484-1-phillip.wood123@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:m7UKe0TWOBmGYF8gB442g3pJIj7TMiUBtwYMuMSHt+x52ziq9ZT
 p13DJfNIAvcqYK9HlGDXfoUxkZDhYfG6E5+0J4mYmmEmK9KKRPxcNYpjrALMWxKRSpvDAIk
 xbg27Iw/NB9xk+Jo6ChI8tjAX+dCCRHOqCoveXx49ECV1H6DC7JJa49U17/UqoM0sG4sdTr
 g+OixgQidhTkWKm0P4viQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ol2ImenvZ2Q=:WdVBCcpI3OAm7AOBJxpIPn
 kR8lOJSF8ssN6e19tChKCkMxqXs8w2mifGNzIWDSIo3mB9foZekE+gCBKvpN8IfE89JXemTNw
 BuakwowHqUJYab1fV3ZR755clm9le/NA3bSFXYU9aNHpJxHqWby+BtglM1jhozdSKF9YUrtIO
 fbYg3lcSed35u5fjlQnh+zEbCdxOE7SNZdcXZm4YeSi6Vob5zTgp1YctCkxlHZEH8Jur0532U
 27Mgpri3XT2Nvx15nFH0f+j82DWMw3L9iL6OtgFezN2JDn1pY0Hhnw/xjs2lDYiuJYXSg1nYB
 ibWIlPT/dfrUXQdW/jCx2+NLkRKk3L6fIT7BJ6KjH9thpn9YYWykLDTFtAW/FC1n2Pei8U/yE
 IEF+BDt0H8nxQ26LwBV9zGtq8OcfkQsAeVVS14lxnPRr8gYNAcq1lOpoVnO70fGIkl2PXf0EB
 9waP2lfBfUX2hoSqNrEDXmql4zoPbiFHyePwDC5rflenV/AvVWIbdLMn2hHIe3Z+ltQkV1dxV
 KsmMT6rcx/7+SdSfOENtYfeGgL4AXbx+Pr/f5gTPi1hzaB605TRIjKrXFtsu2aCkgk4zkhvhg
 bXi8CrJD8SLwh2U3vykoKL68wZkhtVsPr1okI62I3DCbNW/RBmovYgVYX8DOX/eZQw3TwXBiB
 CL1P8XrKwZRDy9f5zlRlwUa+tDEVhAqGS+g+6tc8FPA1x1aIqE/aSq/Qk6Psa1fqbAGc6BORB
 SX9WnKzhq8jz55qomnLupYbFuFa0gmEAdRV6+T9q2rAwf/kRdNQu1qiulZOaOpBQfrxP7Qo7Z
 YNz+KjNzepV0079ba++brSBSRLwhvva8UlcZwo3hg56H2+O/vCnrdb36BmMwl45WyPg8Sgpfl
 0xmG7f96NudwKF0q9J54K0OyAYjQH9/XB6jbZdBQ9E0KKkcAJA/mkWZJoaZYv+eSrcO/fU3mu
 hOPmdw5VVKdHg9veM0xzW0YLyx8c6DTmIQtoQrPjpeVJbyBjyVQ6+WGygkGS8gfxBTH/5rdK3
 x06x9fN5MW4jfMCedQFgxvD5Qv2p4ne9xbY4OKtcYCwV8W4tjgBn5qYodhCIh4WtzC1UiFUoC
 FfDqb0zXegELr2ggkAx7mIvMpsIhL2wCc6zZgtUSZrnMPr+a+P2DktERlOhC5BtABCfUkkSaS
 8nh3IFiufG39vPTjdFsSPmrMxoX45t1FMwsRUV3h62fQpno1OHgGRrbvtXGYscPtA52mnBguc
 39KjjuAwvgBFmybUP
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Thu, 21 May 2020, Phillip Wood wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Thanks for the feedback on v2, I've updated the documentation as
> suggested by Elijah and made the style fixes suggested by Alban but
> I've not changed read_author_script() for the reasons explained in
> https://lore.kernel.org/git/c6a2711a-96c1-d7ac-9678-20c581408ef5@gmail.c=
om
>
> These patches are based on 9fadedd637 ("Merge branch
> 'ds/default-pack-use-sparse-to-true'", 2020-03-29)

Thank you for working on these patches! TBH what I was looking to most in
that GSoC project was the ability to combine `--interactive` with Sverre's
`--whitespace=3Dfix` option, but it never came even close to that. So I ha=
d
planned to help this patch series as much as I can.

Turns out that I do not really have any time to help this patch series,
therefore I am very happy to see Danh and Elijah jump in and review the
patch series, and that makes me think that between the three of you, it is
in good hands now.

Thanks,
Dscho

>
> Phillip Wood (2):
>   rebase -i: support --committer-date-is-author-date
>   rebase -i: support --ignore-date
>
> Rohit Ashiwal (3):
>   rebase -i: add --ignore-whitespace flag
>   sequencer: rename amend_author to author_to_free
>   rebase: add --reset-author-date
>
>  Documentation/git-rebase.txt           |  33 +++-
>  builtin/rebase.c                       |  46 ++++--
>  sequencer.c                            | 111 ++++++++++++-
>  sequencer.h                            |   2 +
>  t/t3422-rebase-incompatible-options.sh |   2 -
>  t/t3436-rebase-more-options.sh         | 209 +++++++++++++++++++++++++
>  6 files changed, 379 insertions(+), 24 deletions(-)
>  create mode 100755 t/t3436-rebase-more-options.sh
>
> Range-diff against v2:
> 1:  5ef315240a ! 1:  df8c4ed2e9 rebase -i: add --ignore-whitespace flag
>     @@ Documentation/git-rebase.txt: your branch contains commits which =
were dropped, t
>       with `--keep-base` in order to drop those commits from your branch=
.
>
>       --ignore-whitespace::
>     -+	Behaves differently depending on which backend is selected.
>     ++	Ignore whitespace differences when trying to reconcile
>     ++differences. Currently, each backend implements an approximation o=
f
>     ++this behavior:
>      ++
>      +apply backend: When applying a patch, ignore changes in whitespace=
 in
>     -+context lines.
>     ++context lines. Unfortunately, this means that if the "old" lines b=
eing
>     ++replaced by the patch differ only in whitespace from the existing
>     ++file, you will get a merge conflict instead of a successful patch
>     ++application.
>      ++
>      +merge backend: Treat lines with only whitespace changes as unchang=
ed
>     -+when merging.
>     ++when merging. Unfortunately, this means that any patch hunks that =
were
>     ++intended to modify whitespace and nothing else will be dropped, ev=
en
>     ++if the other side had no changes that conflicted.
>      +
>       --whitespace=3D<option>::
>      -	These flags are passed to the 'git apply' program
> 2:  55eb3a7efc ! 2:  df44a0bde6 rebase -i: support --committer-date-is-a=
uthor-date
>     @@ Commit message
>          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>
>       ## Documentation/git-rebase.txt ##
>     -@@ Documentation/git-rebase.txt: when merging.
>     +@@ Documentation/git-rebase.txt: if the other side had no changes t=
hat conflicted.
>       See also INCOMPATIBLE OPTIONS below.
>
>       --committer-date-is-author-date::
>     @@ sequencer.c: static int run_git_commit(struct repository *r,
>
>       	if (!(flags & VERIFY_MSG))
>      @@ sequencer.c: static int try_to_commit(struct repository *r,
>     -
>     - 	if (parse_head(r, &current_head))
>     - 		return -1;
>     --
>     - 	if (flags & AMEND_MSG) {
>     - 		const char *exclude_gpgsig[] =3D { "gpgsig", "gpgsig-sha256", NU=
LL };
>     - 		const char *out_enc =3D get_commit_output_encoding();
>     -@@ sequencer.c: static int try_to_commit(struct repository *r,
>       		commit_list_insert(current_head, &parents);
>       	}
>
> 3:  19352fdc22 =3D 3:  fa3d4856b4 sequencer: rename amend_author to auth=
or_to_free
> 4:  5e971abb74 ! 4:  96657233d4 rebase -i: support --ignore-date
>     @@ sequencer.c: static const char *author_date_from_env_array(const =
struct argv_arr
>      +		error(_("malformed ident line '%s'"), author);
>      +		return NULL;
>      +	}
>     ++
>      +	len =3D ident.mail_end - ident.name_begin + 1;
>     -+
>      +	strbuf_addf(&new_author, "%.*s ", len, ident.name_begin);
>      +	datestamp(&new_author);
>      +	return strbuf_detach(&new_author, NULL);
>     @@ sequencer.c: static int try_to_commit(struct repository *r,
>      +		free(author_to_free);
>      +		author_to_free =3D (char *)author;
>      +	}
>     ++
>       	if (commit_tree_extended(msg->buf, msg->len, &tree, parents,
>       				 oid, author, opts->gpg_sign, extra)) {
>       		res =3D error(_("failed to write commit object"));
> 5:  43a097c583 =3D 5:  828155baba rebase: add --reset-author-date
>
> --
> 2.26.2
>
