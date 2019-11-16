Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EB1D1F4B5
	for <e@80x24.org>; Sat, 16 Nov 2019 05:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbfKPFpJ (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Nov 2019 00:45:09 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41638 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725308AbfKPFpJ (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 16 Nov 2019 00:45:09 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6ACE160FFC;
        Sat, 16 Nov 2019 05:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1573883107;
        bh=rV8JFDuqMHz+E2bctnP4EbdozltJTADxuPi4I5VmeMI=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=wEobfovlPfvZHjMbum/5bGMXoj4LkqaPPtzHRM6FMlvhysYbHVce8cP9x1gf/CgCG
         fM3ziR4JAh4IFdTX5F5Z+3KbwEZ9C8+/fIB2AbZ8G5THinKfpY3VDQZO4oyJv4yDGd
         d6tscspR1TVfCqInB9nWY5QwtUHWv1fuF9XI0uN93K63/ZvbVtfq3vJc9rxCRFwU2k
         swiDzrShA18ZhH3CF1/o2zyqIfOBBjatP/T8cYkOSksN+/RVnANe9YJjZkqTdBvAUV
         5wkjx2RGaA1vqYcPt/zcsV4H1/hK+YRWry035oFKv77KshRadCmDieqtSmMr8DkkUl
         Wiv9UgCtWQlYc9qfI2Ohjr2D0mi6Yd08x+m99mAIg8UaZZmheG0aWz1ZBv3IErKLJ4
         gwBBREJN29lQO5YwYYwtbJqZoGLMZHTLwSmdQA14ALw7bsey4QoSsWSWav+nIjgzPu
         Ibm2qpGLx5TJhCliAb9CTbKSFVKgU2yisUgcusqkg8RkBXyRXOL
Date:   Sat, 16 Nov 2019 05:45:01 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [RFC] Hook management via 'git hooks' command
Message-ID: <20191116054501.GA6538@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
References: <20191116011125.GG22855@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
In-Reply-To: <20191116011125.GG22855@google.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-2-amd64)
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-11-16 at 01:11:25, Emily Shaffer wrote:
> Here's my suggestion.
>=20
>  - Let configs handle the hook list and ordering, via 'hook.{hookname}' w=
hich
>    can be specified more than once.
>    - global config: hook.update =3D /path/to/firsthook
>      user config: hook.update =3D /path/to/secondhook
>      worktree config: hook.update =3D -/path/to/firsthook #eliminate the =
firsthook
>       call
>    - global config: hook.update =3D /path/to/firsthook
>      repo config: hook.update =3D /path/to/secondhook
>      repo config: hook.update =3D ^/path/to/firsthook #move firsthook exe=
cution
>        after secondhook for this project

I'd like to hear more about how we handle multiple hooks that are
repo-specific and don't live in the PATH.  This is a common situation
for existing tools that handle multiple hooks, and it's one I think we
should support.

Perhaps we add a "git hook execute" subcommand that executes scripts
=66rom the hook directory.

>  - Let users decide whether they want to check core.hookDir in addition t=
o their
>    config, instead of their config, or not at all, via a config
>    'hook.runHookDir' "hookdir-first", "hookdir-only", "config-only", etc.
>  - Let users ask to be notified if running a hook from .git/hooks via a c=
onfig
>    'hook.warnHookDir'. (Mentioning .git/hooks rather than core.hookDir is
>    intentional here.) Alternatively, ask for 'hook.warn' with values "hoo=
kdir",
>    "all" depending on how trusting the user feels.
>    - If we want to phase out .git/hooks, we can make this notification op=
t-out
>      instead of opt-in, someday.
>    - between runHookDir and warnHookDir, users are able to phase out
>      .git/hooks scripts at their own pace.
>  - Abstract most of this via a 'git hooks' command.
>    - 'git hooks add <hookname> [--<scope>] <path>' to append another hook;
>      let the scope setting match 'git config'.
>    - 'git hooks show [<hookname>]' to indicate which hooks will be run, e=
ither
>      on a specific event or for all events, and in which order, as well a=
s each
>      hook's config origin
>    - 'git hooks edit <hookname>' to modify the hook order, or choose not =
to run
>      a hook locally
>    - By managing it through a command, we can reorder the contents of con=
fig
>      files if it makes sense to do so.
>  - Add a hook library.
>    - Optionally specify all hook events via enum, so we aren't string-typ=
ing
>      calls to find_hook() anymore.
>    - Resolve configs into a list of hooks to run by concatenating them to=
gether
>      in config precedence order.
>      - Also allow configs formatted like "-<path>" to remove an
>        earlier-configured invocation of that hook, or "^<path>" to move t=
he
>        earlier-configured invocation to this point in the execution order
>    - Move the find_hook() implementation to here, to account for the mult=
ihook
>      ordering

I think this addresses most of the concerns that I had about ordering.
It is still a little suboptimal that we're relying on the ordering of
the config file, since it makes things equivalent to numbered files in
=2Ed directories hard.

Possibly as an alternative to the ^ syntax, we could make the hook value
be of the form "key program", where key is a sort key (e.g., a number)
and program is the program to run.  We pick normal config file ordering
if the keys are identical.  Then if the system config wants to have a
hook that always runs at the end, it can do so easily.

In addition, we should be sure that attempting to remove a hook which
doesn't exist isn't an error, since a user might want to set their
~/.gitconfig file to always unset a global hook that may or may not
exist.

We also need to address exit codes with multiple hooks and whether we
fail fast or not.  My series may provide some valuable options here, or
we may choose to go with a single, simpler approach.  Whatever we do, we
should document the behavior clearly.

Overall, though, I think this approach has a lot of potential and I feel
positive about it.  Thanks for bringing this up again in a productive
and helpful way.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl3PjN0ACgkQv1NdgR9S
9oufGRAAwf+75WOgBmAYJTxXxl5b6pXkispA3+M3sL2QrnEcRav4henuo+d7uybx
sxnY6WtmrsAIk8pQMM0BCVIsehMgoKIiED5pYiip6wEtccC3u6/K1K+55zuCykwj
1rQlEU+7J6FVhXjq7fUMDqWSE4DmdnyJ+MduZxMf+t54Hs9fg538gmWVtmO3ukmN
98aGwirHQgT6SjYPEfppxGtpmynEVr5O2McFqju6DoWMycOaBU9nTDoc0aJfciXw
OF649N0fomcq3oJjBr+B2Wyr7SlljtHVSvOI1tgdeIpKvPaAy8R237a2aWW6HeWi
z1FUCdGbmJb9X2YbGs7qWZ6dn9cVnuAf7lMClaxs/dNVywMpHak0ZNlTmSjmt3TD
TUaxEl6J/IQt/grb+2u4q3UB4B3aKesJ1Y33xzpfzwoSAVwRChRbP2wo4qvEJ1hm
Vi6mB/Tquv2enCXQ+BGSM31ksDrp1kpEsUU/hfZpeyUvrA/ZiC39GZcv21SaqMId
6obLfVJ68vH6FysnTyBuLIPNZRPSEB9obWbm91u9nN1BBaeYvDCjibQ0u2sEItiH
JJDuazaqrT4pk4jj8HVYqFu/MpiHk981JaVqgK+Deu9h77gntoQ05W74r27W+RyY
XyBIIphXTuQxjy0KXPjX/zCA+IOrgESc2TewOiB5df0bfQhGNI0=
=mo2g
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
