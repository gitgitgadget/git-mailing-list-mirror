Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09334C433F5
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 20:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347279AbiCUUhj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 16:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239953AbiCUUhi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 16:37:38 -0400
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786BD54BD7
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 13:35:54 -0700 (PDT)
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:c2d2:c7d2:a4cd:bda7])
        (Authenticated sender: jn.avila@free.fr)
        by smtp5-g21.free.fr (Postfix) with ESMTPSA id 0B4C85FFAD;
        Mon, 21 Mar 2022 21:35:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1647894953;
        bh=PZoY98Jrw1DNZ/WutzrKs4ade0IK2c+oVGgNt0hr9As=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BvE1lMCKao9bGYcfCtk2YtQGQ+/j+SMO6auXcudk6HMeQx/LvGY9AouWeOwKwhhSu
         Nx/+JXlFRg1E380wGMi1eCNpD2K63y64cBjlKd9F7QlL4OhwdE0v+VfqcJg8MIzWM+
         dpLIkZ2CVtgISFzG/hj7Z6ekwYU6hq2YWv9xPlIkovMXmUT2NVz6OTte5BJv6VzA1V
         VFqGPdFI2qWOZh5eZQFF2DsYeJrwtwVK10WZONkkN8OHDDLUj5NN4AVVYU4QhEsJ8q
         s9J1VA0YUlYET7lNrlocq5NEVKoLKIeBa1DSY9r3DVUdk1l7d27jb5GNV6sKs2IcAI
         m4nMERu1bI0CQ==
From:   =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To:     Johannes Sixt <j6t@kdbg.org>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        =?ISO-8859-1?Q?Jean=2DNo=EBl?= Avila via GitGitGadget 
        <gitgitgadget@gmail.com>
Subject: Re: [PATCH 0/7] More i18n fixes
Date:   Mon, 21 Mar 2022 21:35:49 +0100
Message-ID: <3656471.kQq0lBPeGt@cayenne>
In-Reply-To: <220321.86ils79z0c.gmgdl@evledraar.gmail.com>
References: <pull.1181.git.1647813291.gitgitgadget@gmail.com> <e44b6ccf-21a2-72c6-4d40-dc0004895255@kdbg.org> <220321.86ils79z0c.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Monday, 21 March 2022 14:59:24 CET =C6var Arnfj=F6r=F0 Bjarmason wrote:
>=20
> On Mon, Mar 21 2022, Johannes Sixt wrote:
>=20
> > Am 20.03.22 um 22:54 schrieb Jean-No=EBl Avila via GitGitGadget:
> >> This is another i18n PR (and hopefully the last for a while).
> >>=20
> >> As usual, the intent is kept the same: curbing the number of strings to
> >> translate, remove constant, error prone parts out of the way, trying i=
n some
> >> sense to "put a precedent" so that the template strings can be reused =
later.
> >
> > I feel that many of the example conversions look like sentence lego
> > because there remains only one English word, e.g., "'%s' failed". The
> > converted code does not leave a hint for the translators what the %s
> > will be. Is it a command, a function name, somehting else? Even if the
> > hint was provided, different translations may be required depending on
> > the substituted entity. Did you investigate the existing translations
> > whether all of them can be converted to the new scheme?
> >
> >> This series has also a RFC status: can "bad argument" messages be merg=
ed
> >> with unrecognized argument?
> >
> > The cases that patch 7/7 transforms look like they need not keep
> > "unrecognized argument", but can be converted to "bad argument".
> >
> > Disclaimer: neither am I a translator nor a user of a translated Git.
>=20
> Just to add to this:
>=20
>  - Careful use of sentence lego is OK, but e.g. in my native language a
>    command-line option would use a male noun article, whereas commands
>    would be feminine.
>=20
>    (I still haven't submitted an Icelandic translation, but this applies
>    in general).
>=20
>    As a result string like "'%s' failed" can be *workable*, i.e. you can
>    translate it assuming you'll get any arbitrary string, but the
>    translation will often be rather tortured.
>=20
>    So it's much preferred (and this also goes to Johannes's comment) to
>    instead do e.g.:
>=20
>        "failed to run the '%s' command"
>        "failed to use the '%s' argument"
>=20
>    Or whatever, and e.g. for:
> =09
> 	-		return strbuf_addf_ret(err, -1, _("%%(objecttype) does not take argum=
ents"));
> 	+		return strbuf_addf_ret(err, -1, _("%s does not take arguments"), "%(o=
bjecttype)");
>=20
>    Instead say "the '%s' format does not...", i.e. disambiguate with
>    "format".
>=20
>  - While perfect shouldn't be the enemy of the good, it would be most
>    welcome to improve some of the warts revealed by these messages,
>    notably that e.g. the "failed to run X command" don't report
>    errno. E.g. this in git.c is a good template (except for the "\n" we
>    should ideally get rid of):
>=20
>        _("failed to run command '%s': %s\n")

OK.=20

>=20
>  - On that topic, it would be really useful to see if we can unify some
>    of these with *existing* po/git.pot messaging, I don't know if that's
>    part of your workflow, but in some cases I've seen we can either
>    tweak wording slightly to match an existing message, or could further
>    unify some existing similar messages.
>=20

That's part of the workflow, although not hand-made, but greped. There are =
two types of factorizations:
* strings where introducing a placeholder creates duplicates
* strings that basically mean the same, but expressed differently (require =
human parsing)

>  - Even if we say "failed to run git-apply" or whatever now we should
>    really be adding quotes to these as we convert them. In some cases
>    the changes that (good):
> =09
> 	-		die(_("git-http-push failed"));
> 	+		die(_("'%s' failed"), "git-http-push");
>=20
>    But not in others (bad):
> =09
> 	-		res =3D error(_("Bad bisect_write argument: %s"), state);
> 	+		res =3D error(_("bad %s argument: %s"), "bisect_write", state);
>=20
>    I.e. that should be 'bad '%s' argument. And also on the "unify" point
>    above, e.g. grep.c has this:
>=20
>        grep.c: die("bad %s argument: %s", opt, arg);
>=20
>    So we could covert that one to "bad '%s' argument: '%s"" while we're
>    at it...
>=20
> - In some cases there's ucase to lcase conversions, like Bad->bad above
>   (good), but others are missed, e.g. (also missing quotes as noted
>   above):
>=20
> 	-		die(_("Server does not support --shallow-since"));
> 	+		die(_("Server does not support %s"), "--shallow-since");
>=20
>  - On quotes, let's consistently use '' quotes, and not e.g.g:
> =09
> 	-		die(_("`scalar list` does not take arguments"));
> 	+		die(_("%s does not take arguments"), "`scalar list`");
>=20
>=20

OK for disambiguation, lowercasing and quoting all placeholders.
BTW, disambiguation may have the side effect of revealing where the type of=
 placeholders may not be matching the types of replaced variables.


Will reroll.

Thanks.



