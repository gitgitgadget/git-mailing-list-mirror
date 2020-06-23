Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48EF9C433E0
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 19:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19DC52082F
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 19:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="ajw+MGbw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387535AbgFWTSR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 15:18:17 -0400
Received: from mout.gmx.net ([212.227.15.18]:47945 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733308AbgFWTSR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 15:18:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592939879;
        bh=EFMdPujJokvSQPkRDFKa5Kg7ipgnDeRbJ0cN+TI99as=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ajw+MGbw+Mi2KhTJVym8vX0dIIxQ1Tovm3b9k1qBFEiM47eCKIvDm3moBbKMOMc1m
         jt3zhdb+Knbzohf0T1d4fStvtIFfdpNwA16WFR9z+umheIWJXHHddz20x/+JyY3CQX
         +Z7sZnzRmXBlvhF43ehKyfDWWT/EA2HoZ3mNavCw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.227.237] ([89.1.212.7]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mof9P-1j43Lj3MYz-00p6GD; Tue, 23
 Jun 2020 21:17:58 +0200
Date:   Tue, 23 Jun 2020 21:17:57 +0200 (CEST)
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
Subject: Re: [PATCH v2 04/12] git_main_branch_name(): optionally report the
 full ref name
In-Reply-To: <e8ed76e8-bdd5-ae58-56ea-0513a21ac5d6@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2006232116210.54@tvgsbejvaqbjf.bet>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com> <pull.656.v2.git.1592225416.gitgitgadget@gmail.com> <ca1c63c3e012edde26b4f0c67175ca53f4d29e08.1592225416.git.gitgitgadget@gmail.com> <e8ed76e8-bdd5-ae58-56ea-0513a21ac5d6@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:h5h8vAIwh6jASzB96vdR/TUnHY4upmK8YaSadk7EdFF9LYLatbM
 d17x6nVqB6N5bCQLleyS0r9g+q0CxCPTZ5ezAIl705gCOm+Z/FAB3Ypr8/PdsmCDcZegf8p
 NjC2aFBeYm4VQYZwAcjC/wX+nM2wIue0piS/P7u+3hxazfllTM4P/85S6v0r3LcJZca55EP
 pz6R3aEjPdlVbLFcya1+w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+uDnpv9c+t0=:OoVsAhQ7W3MamryxOK9glq
 5ecqXbeW8mmA1Zh6RbM10F1J9+bwwSJerDsn1/ts1s8/gXHMSdvhd/dRsZV7ZZIdRmrPY7Yye
 4lqWyTmwCjwsc1TB0WFpCuAREK1yln6DSV9AKj0TPwiefeuPZFJ+rezBUjui8IAK9xW5VUI6g
 cTl8pGN1EvtuHvPv+Y9UgXSTSVLR6wvNYFpkDNiiN9vxun4wCxm6yvhqAdPc/+tpEZOX5R85+
 ca5JyXEb90YseUcAOpiDZRarIUKIBAwZT5hEQ01nOJjjA2DsS5SKZAV8Y1QTBKbXi098CczyM
 7vqJRoF+El0GhaTfANoRn4vL7tinyq/VCYiNpqZbvMghc5U0yBytdyTM2vML5FgJxB1cUEx8h
 OhGrLz2AqTRjLLNLk4MMC/zvhHyhpNcq9rdrJ7KNbzTcNQWz/mRUZ08F8ofmwaObedw+oynib
 61n25Z0IGbyrzZppLMhv3xFFlrMOn2cUIeFxg5cJrSzrtrBm53zkZBfNXz3pQUHPibARMsarh
 lZFxNeAzNPj6K79N+39YEtu3tZKJ+BEUSYSKzFrYJDEeXey8lMJvA2CESxpBdOnuIgJRp7i75
 gS92dnEo2zXkJqcEzA+TNan9qGs2YtQ7iIyz5HKi3GdVc0F7/oBi4M58d29H+JwnwagRISyIK
 J7YobNhP1sK5Sl/CXQNym/MGBTSrAS2vAZTVmdP7RnDXIXuEoQGHoQDOcjSeNqXfFBA2iyvQG
 7tk6w8klbOL1ckOtAdGS79glc/riSPvXzJK123F9VG5wcgwG6S2KD4F4YlN7ctzcCIz1S+gvr
 XqZav31hNvsbnPSD5W4nui07CIH9wyiDBI+6GVF0EObhmJ6HG01vOyxZxfqz4OEw8nXQLnSob
 5tz9ivozfbuSVlXn6E2G5ged6VdxU5qVyw7H1uZHvn4ibULOcA4nxlxlUoVFgj0s45LUngdHL
 oWuasHo1LYZgXYn8d7GjcMDmR37leZLqJ84IBpn84jDl1qyyXc0DCB+KOiA1uZ9N9KsTQl+g9
 /doEtlmr8y1qZRoEX7+dlGQXXpKIhft8AntO1bdSyxCU/NslFXCs0SA298ViTQDkSrgy2Y87o
 Inj4JZBp7E+gTVUtHCHa7iRz1cWVHKGfe6ntjlG+wkm10Owcinabb0HoziL5cvAuZPcM/ZkY8
 pZ5CdKzNId4xrAr6272ZXmR+0NamI9Px7bUxpSTB3MUiT2Abl4tomgUDM1B0lP9RFDX/t3csc
 13DmMW/WSeIpGJPEw0rR0g0JfbsMwd+HZG8ZtZw==
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
> > We are about to introduce the first caller of that function (`git
> > fast-export`) that wants a full ref name instead of the short branch
> > name.
> >
> > To make this change easier to review, let's refactor the function
> > accordingly without mixing in the actual first call using the new flag=
.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >   fmt-merge-msg.c    |  2 +-
> >   refs.c             | 12 ++++++++----
> >   refs.h             |  8 ++++++--
> >   send-pack.c        |  2 +-
> >   transport-helper.c |  2 +-
> >   5 files changed, 17 insertions(+), 9 deletions(-)
> >
> > diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
> > index 43f4f829242..03dba905643 100644
> > --- a/fmt-merge-msg.c
> > +++ b/fmt-merge-msg.c
> > @@ -451,7 +451,7 @@ static void fmt_merge_msg_title(struct strbuf *out=
,
> >    		strbuf_addf(out, " of %s", srcs.items[i].string);
> >    }
> >   -	main_branch =3D git_main_branch_name();
> > +	main_branch =3D git_main_branch_name(0);
> >    if (!strcmp(main_branch, current_branch))
> >    	strbuf_addch(out, '\n');
> >   	else
> > diff --git a/refs.c b/refs.c
> > index f1854cffa2f..7da3ac178c4 100644
> > --- a/refs.c
> > +++ b/refs.c
> > @@ -560,8 +560,9 @@ void expand_ref_prefix(struct argv_array *prefixes=
,
> > const char *prefix)
> >   		argv_array_pushf(prefixes, *p, len, prefix);
> >   }
> >
> > -char *repo_main_branch_name(struct repository *r)
> > +char *repo_main_branch_name(struct repository *r, int flags)
> >   {
> > +	int full_name =3D flags & MAIN_BRANCH_FULL_NAME;
> >    const char *config_key =3D "core.mainbranch";
> >    const char *config_display_key =3D "core.mainBranch";
> >    const char *fall_back =3D "master";
> > @@ -570,7 +571,10 @@ char *repo_main_branch_name(struct repository *r)
> >    if (repo_config_get_string(r, config_key, &name) < 0)
> >     die(_("could not retrieve `%s`"), config_display_key);
> >   -	ret =3D name ? name : xstrdup(fall_back);
> > +	if (full_name)
> > +		ret =3D xstrfmt("refs/heads/%s", name ? name : fall_back);
> > +	else
> > +		ret =3D name ? name : xstrdup(fall_back);
>
> This looks good, we always check the name before returning it and free n=
ame if
> we're returning refs/heads/<name>
>
> >    if (check_refname_format(ret, REFNAME_ALLOW_ONELEVEL))
> >   		die(_("invalid branch name: %s =3D %s"),
> > @@ -582,9 +586,9 @@ char *repo_main_branch_name(struct repository *r)
> >   	return ret;
> >   }
> >
> > -char *git_main_branch_name(void)
> > +char *git_main_branch_name(int flags)
> >   {
> > -	return repo_main_branch_name(the_repository);
> > +	return repo_main_branch_name(the_repository, flags);
> >   }
> >
> >   /*
> > diff --git a/refs.h b/refs.h
> > index a207ef01348..96472f9a9f5 100644
> > --- a/refs.h
> > +++ b/refs.h
> > @@ -157,9 +157,13 @@ int dwim_log(const char *str, int len, struct obj=
ect_id
> > *oid, char **ref);
> >   /*
> >    * Retrieves the name of the main (or: primary) branch of the given
> >    * repository.
> > + *
> > + * The result is an allocated string. Unless the flags ask for a shor=
t
> > name, it
> > + * will be prefixed with "refs/heads/".
> >    */
>
> nit pick: the flag is defined to give the fullname, to get the short nam=
e you
> just pass 0.

I decided to drop the flag and always return the name, not the full ref.
It makes the code _slightly_ less efficient, but easier to follow.

Ciao,
Dscho

>
> Best Wishes
>
> Phillip
>
> > -char *git_main_branch_name(void);
> > -char *repo_main_branch_name(struct repository *r);
> > +#define MAIN_BRANCH_FULL_NAME (1<<0)
> > +char *git_main_branch_name(int flags);
> > +char *repo_main_branch_name(struct repository *r, int flags);
> >
> >   /*
> >    * A ref_transaction represents a collection of reference updates th=
at
> > diff --git a/send-pack.c b/send-pack.c
> > index 2532864c812..898720511d0 100644
> > --- a/send-pack.c
> > +++ b/send-pack.c
> > @@ -405,7 +405,7 @@ int send_pack(struct send_pack_args *args,
> >    }
> >
> >   	if (!remote_refs) {
> > -		char *branch_name =3D git_main_branch_name();
> > +		char *branch_name =3D git_main_branch_name(0);
> >
> >     fprintf(stderr, "No refs in common and none specified; doing nothi=
ng.\n"
> >   			"Perhaps you should specify a branch such as '%s'.\n",
> > diff --git a/transport-helper.c b/transport-helper.c
> > index 8c8f40e322d..7a54e5b2fb2 100644
> > --- a/transport-helper.c
> > +++ b/transport-helper.c
> > @@ -1044,7 +1044,7 @@ static int push_refs(struct transport *transport=
,
> >    }
> >
> >   	if (!remote_refs) {
> > -		char *branch_name =3D git_main_branch_name();
> > +		char *branch_name =3D git_main_branch_name(0);
> >
> >     fprintf(stderr,
> >      _("No refs in common and none specified; doing nothing.\n"
> >
>
