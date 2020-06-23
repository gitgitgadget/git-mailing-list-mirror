Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098A7C433DF
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 12:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBF6820724
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 12:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Bh4jk8mD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732627AbgFWMcR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 08:32:17 -0400
Received: from mout.gmx.net ([212.227.17.21]:34199 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729611AbgFWMcR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 08:32:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592915514;
        bh=KDU8ScVuAYd7DqRcV+gclwwkBLYQjXSBBU7LPKgnzro=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Bh4jk8mDtNIg1QWTU5iy9dNGxyB6W30bAPnR2Bh9QI+zoxUbO8JXB85oV9MEC7xn4
         tk+zHqy04G898Gu8F5XtKLimbhBV+3U5uH5mkw1GG7YmQOrcntnT5unDIjxqTKKHAy
         XFBVEUiQ9sJvH71t8C37A5vPX8bS+CRfN+Y2ERvc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.227.237] ([89.1.214.61]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MdNcG-1jENL81cSe-00ZNRK; Tue, 23
 Jun 2020 14:31:54 +0200
Date:   Tue, 23 Jun 2020 14:31:53 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     phillip.wood@dunelm.org.uk
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        peff@peff.net, sandals@crustytoothpaste.net,
        Matt Rogers <mattr94@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 02/12] fmt-merge-msg: introduce a way to override the
 main branch name
In-Reply-To: <b530fe66-9cf6-ea63-e9e6-123448e2d978@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2006231357260.54@tvgsbejvaqbjf.bet>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com> <pull.656.v2.git.1592225416.gitgitgadget@gmail.com> <f4d547391537e5c3b0b4a07adb41b6aa56541fc3.1592225416.git.gitgitgadget@gmail.com> <b530fe66-9cf6-ea63-e9e6-123448e2d978@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:GNs4laHPxfSA2rjFYlKQhJTfK+mIdMPSVh7tm7vqMtF8AuQOmrs
 oGA5LQ4fLMTDfsYC5VSeKR6nmDWfadxmOwYhwQAU7EmBMymD4sKbECbs4qVrf4+AR4jsHQD
 nsn12EoLAKm97NqekLio2S0vvtAxkBe0CE1sMR1NKTW79wLnq4VrLlA9wwydlIbTgmZnEfL
 oJDoVUI2TFQpYUg3mECLw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dl+y7AgfMGQ=:q5jtejR7N+pSLlSH7eFP24
 jNp5ewncLu0aIieQu4Ce44+qQDavU/H0FpfepFAlSTk1tPkU6Z20o9w7bHTXYKvOGfRxOY6Sa
 4U8Gnnvg3SOB+If30mp3xXQBpBob15kE4Ox41aBGEZCyniFRbPjj4fl0PkIoF+fY+BwXpBlK9
 3+Fi2+p6by0MitWFBPF+mu6qvd6Le+QinS2UZqp9mJcZ0OCIhsDF6spdH5Y3eN6oXI+4Hbz7n
 aDMaRBu+IgDG3jh2QpG9GFW1qKrPkMOWddSe7JEYoMw1k1jHxrHQGdajr/B9RwuZ9U/z5Sin4
 vebBzqStseVLGfH2cK/phanN/NKYu0f0UzDI4yvDn0IbSH5MGkOGuFWoNhzYSIQ8yK3hQLDFJ
 SIXCvXN6Fjv4onZDVHCtiO5GWD5MgQ0HK60U+r9Bh5zvK8Fc2JovSBOqqAkImwTYkkhf32hBr
 ZT3zyK6nQFsHTpS5JzlzWViKQR6rMaN3SZ6jRlH38vQGd/a6QjAr1DletzWJ380UbJtClPOF+
 N+AQgiyLHrBNgQJWp+owxTshdUBjs6RGLPsWD8fSsn7rypBepyKZnYkijIwscOWf7cEoGn/l7
 ZcK2d3HuKFshatQudJT3G2bRACrhtoDFG2hn27ZCUOZQ2d6ASOCoSK7lYOhsWnRiohPu0EZ3a
 mOBoX4RjrPSuVzByMDmvqlEMqffOas/UOs4RF0zwMDrI1c3E9Wo/jwULnUrcBYorlUDqpusTf
 U0P8qF8e4iWC2YHkZM7Ct5Tb0hGKC4LgmUbIGGzsd1HXdexTpfiGo87cerSLzhRXkyHmzjc5x
 Jp4Cqa9JWczSytvZkGP85SiazJ8Anhk/rQljzjZjAp7DeVCmf5FmcuEv5JfcVtrGO0SpZUU8Z
 VT6oRoSatDChRM1jOIOh/bqVJuNxczSZHtLzPdd7kvtDJhStJLZ+hi0v78Ag/nb03FKKNnUJW
 x7QZX1A+Tmva7FEfmMeQ5A0ZfuDRoJ/xGOA1ztmIqjXESXOdM7gIVP+cBazw3jt1ZhHFO2U5o
 yE3Pmq1TWAoDb1omnfdoV2dhuLaRsnto/HsoBJBPyirh5K0A2ogbv5c3PrjP4WMoqbx1VM4IL
 W/RLdp7UBme1WqFRrmxhqNNoAKkwEZcccUokerJ9GnJ7SNct6BD4BiUh8uVtiCEveYgkOdkfl
 GsAI9k0OB1FBTMGQy/snqg68q0wN5sXmA961gOxTz3IO8LsE6BuEv7b8PFMoJM9Mt9YiGQrIc
 wO/+FyJPrsxfXuPnq
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Mon, 15 Jun 2020, Phillip Wood wrote:

> On 15/06/2020 13:50, Johannes Schindelin via GitGitGadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > There is a growing number of projects and companies desiring to change
> > the main branch name of their repositories (see e.g.
> > https://twitter.com/mislav/status/1270388510684598272 for background o=
n
> > this).
>
> I think this is a good way of phrasing the rationale for the change

As I am replacing this patch in v3 with a version that simply drops the
special handling of the `master` branch, I moved that rationale into the
patch introducing support for `git init --initial-branch=3D<name>`.

> > However, there are a couple of hard-coded spots in Git's source code
> > that make this endeavor harder than necessary. For example, when
> > formatting the commit message for merge commits, Git appends "into
> > <branch-name>" unless the current branch is the `master` branch.
> >
> > Clearly, this is not what one wants when already having gone through a=
ll
> > the steps to manually rename the main branch
>
> This didn't quite scan for me maybe s/already having/one has already/ ?

Thank you! If I had not dropped that part of the commit message, I would
have taken your suggested fix.

> > (and taking care of all the
> > fall-out such as re-targeting existing Pull Requests).
> >
> > Let's introduce a way to override Git's hard-coded default:
> > `core.mainBranch`.
> >
> > We will start supporting this config option in the `git fmt-merge-msg`
> > command and successively adjust all other places where the main branch
> > name is hard-coded.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >   Documentation/config/core.txt |  5 +++++
> >   fmt-merge-msg.c               |  6 ++++--
> >   refs.c                        | 27 +++++++++++++++++++++++++++
> >   refs.h                        |  7 +++++++
> >   t/t6200-fmt-merge-msg.sh      |  7 +++++++
> >   5 files changed, 50 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/config/core.txt b/Documentation/config/core=
.txt
> > index 74619a9c03b..32bb5368ebb 100644
> > --- a/Documentation/config/core.txt
> > +++ b/Documentation/config/core.txt
> > @@ -626,3 +626,8 @@ core.abbrev::
> >    in your repository, which hopefully is enough for
> >    abbreviated object names to stay unique for some time.
> >    The minimum length is 4.
> > +
> > +core.mainBranch::
> > +	The name of the main (or: primary) branch in the current repository.
> > +	For historical reasons, `master` is used as the fall-back for this
> > +	setting.
> > diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
> > index 72d32bd73b1..43f4f829242 100644
> > --- a/fmt-merge-msg.c
> > +++ b/fmt-merge-msg.c
> > @@ -407,7 +407,7 @@ static void fmt_merge_msg_title(struct strbuf *out=
,
> >   				const char *current_branch)
> >   {
> >   	int i =3D 0;
> > -	char *sep =3D "";
> > +	char *sep =3D "", *main_branch;
> >
> >    strbuf_addstr(out, "Merge ");
> >    for (i =3D 0; i < srcs.nr; i++) {
> > @@ -451,10 +451,12 @@ static void fmt_merge_msg_title(struct strbuf *o=
ut,
> >    		strbuf_addf(out, " of %s", srcs.items[i].string);
> >    }
> >   -	if (!strcmp("master", current_branch))
> > +	main_branch =3D git_main_branch_name();
> > +	if (!strcmp(main_branch, current_branch))
> >    	strbuf_addch(out, '\n');
> >    else
> >   		strbuf_addf(out, " into %s\n", current_branch);
> > +	free(main_branch);
> >   }
> >
> >   static void fmt_tag_signature(struct strbuf *tagbuf,
> > diff --git a/refs.c b/refs.c
> > index 224ff66c7bb..f1854cffa2f 100644
> > --- a/refs.c
> > +++ b/refs.c
> > @@ -560,6 +560,33 @@ void expand_ref_prefix(struct argv_array *prefixe=
s,
> > const char *prefix)
> >   		argv_array_pushf(prefixes, *p, len, prefix);
> >   }
> >
> > +char *repo_main_branch_name(struct repository *r)
> > +{
> > +	const char *config_key =3D "core.mainbranch";
> > +	const char *config_display_key =3D "core.mainBranch";
> > +	const char *fall_back =3D "master";
> > +	char *name =3D NULL, *ret;
> > +
> > +	if (repo_config_get_string(r, config_key, &name) < 0)
> > +		die(_("could not retrieve `%s`"), config_display_key);
> > +
> > +	ret =3D name ? name : xstrdup(fall_back);
> > +
> > +	if (check_refname_format(ret, REFNAME_ALLOW_ONELEVEL))
> > +		die(_("invalid branch name: %s =3D %s"),
> > +		    config_display_key, name);
> > +
> > +	if (name !=3D ret)
> > +		free(name);
>
> I'm struggling to come up with a scenario where name !=3D NULL && name !=
=3D ret
> here, however once we get to patch 4 that scenario definitely does exist=
.

Right.

But as I am dropping the concept of `core.mainBranch` from v3, this won't
apply anymore.

>
> > +
> > +	return ret;
> > +}
> > +
> > +char *git_main_branch_name(void)
> > +{
> > +	return repo_main_branch_name(the_repository);
> > +}
> > +
> >   /*
> >    * *string and *len will only be substituted, and *string returned (=
for
> >    * later free()ing) if the string passed in is a magic short-hand fo=
rm
> > diff --git a/refs.h b/refs.h
> > index a92d2c74c83..a207ef01348 100644
> > --- a/refs.h
> > +++ b/refs.h
> > @@ -154,6 +154,13 @@ int repo_dwim_log(struct repository *r, const cha=
r
> > *str, int len, struct object_
> >   int dwim_ref(const char *str, int len, struct object_id *oid, char *=
*ref);
> >   int dwim_log(const char *str, int len, struct object_id *oid, char *=
*ref);
> >
> > +/*
> > + * Retrieves the name of the main (or: primary) branch of the given
>
> nit pick, I'm confused by the ':'

Right, v3 won't have that peculiar construct.

Thank you for your review!
Dscho

>
> Best Wishes
>
> Phillip
>
> > + * repository.
> > + */
> > +char *git_main_branch_name(void);
> > +char *repo_main_branch_name(struct repository *r);
> > +
> >   /*
> >    * A ref_transaction represents a collection of reference updates th=
at
> >    * should succeed or fail together.
> > diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
> > index e4c2a6eca43..7a873f4a05c 100755
> > --- a/t/t6200-fmt-merge-msg.sh
> > +++ b/t/t6200-fmt-merge-msg.sh
> > @@ -158,6 +158,13 @@ test_expect_success 'setup FETCH_HEAD' '
> >   	git fetch . left
> >   '
> >
> > +test_expect_success 'with overridden default branch name' '
> > +	test_when_finished "git switch master" &&
> > +	git switch -c default &&
> > +	git -c core.mainBranch=3Ddefault fmt-merge-msg <.git/FETCH_HEAD >act=
ual
> > &&
> > +	! grep "into default" actual
> > +'
> > +
> >   test_expect_success 'merge.log=3D3 limits shortlog length' '
> >    cat >expected <<-EOF &&
> >    Merge branch ${apos}left${apos}
> >
>
>
