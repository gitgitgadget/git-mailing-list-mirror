Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D026BC433DB
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 01:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A130A64E42
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 01:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbhCSB27 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Mar 2021 21:28:59 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:44036 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232131AbhCSB2s (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 18 Mar 2021 21:28:48 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C5A8360457;
        Fri, 19 Mar 2021 01:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1616117297;
        bh=GeN/ooJTA8JtP54utjEf6OGRSHJNKy5LRt+JZjv9LwM=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=ux679t+KOpq86W33BPEQaz2YVzRMj2IGe121/qLwF+HkMwkW4C+8sirNiJ/TLw+8Z
         jozgF3gpvv1AQoU5pmuZiQfoxEY1DRkdVyIqNRV1yKqHFF/9+pMA/G069dm5efym0V
         kzLlI0Y28PaVuImE784ckZpvajVM+L950+URSt6sIzx2XeTOOhYQ5k3g75oIXblFj1
         iyrcGwuLqpaIxJrpMNVrEwTMZA5bUlp3wh5VWnpCH7qur1oPTEaVx+24rbGVz677wy
         jvccna5RhgSalX4rL7osAmBuCBBt+cFvuY903DKeLg80d/9lKqiu17Um0faMPzy3Xx
         ck6ZH2NFFkcEHIZUpI5L4e1jEKhytO2zpPHdJtLKnCX2TD18rxldn8MmPLaswDsfny
         UV+5VtsKrOCoChxSicsvJ9qvGncGzMm2UmYNMPxJ/B+aMQplu2jiitxpGPcxE+U+Bw
         /jm77BuIabEcGdBzMrBUoUcpDQfbfOhc2xCCNo6PegqkpPA8hfC
Date:   Fri, 19 Mar 2021 01:28:10 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Albert Cui via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Albert Cui <albertqcui@gmail.com>
Subject: Re: [PATCH] hooks: propose repository owner configured hooks
Message-ID: <YFP+KuUn99vftBIC@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Albert Cui via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Albert Cui <albertqcui@gmail.com>
References: <pull.908.git.1616105016055.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5WCbRzyuZ/wOjtRI"
Content-Disposition: inline
In-Reply-To: <pull.908.git.1616105016055.gitgitgadget@gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--5WCbRzyuZ/wOjtRI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-03-18 at 22:03:35, Albert Cui via GitGitGadget wrote:
> +User Goals / Critical User Journeys
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +* As a repository owner / project maintainer,
> +
> +    ** I want to enforce code style so I require developers to use a
> +    standardized linter.

This sounds like you're proposing pre-commit hooks for this purpose.
Let me quote you this passage from the FAQ that I wrote that explains my
position perfectly:

  [S]ome advanced users find `pre-commit` hooks to be an impediment to
  workflows that use temporary commits to stage work in progress or that cr=
eate
  fixup commits, so it's better to push these kinds of checks to the server
  anyway.

It also outlines that pre-commit hooks are not an effective control and
for effective implementation, this must live on the server.

I can never imagine myself wanting to use a pre-commit hook for these
reasons.  It would interrupt my typical workflow which uses many, many
fixup and squash commits and near constant rebases.

Similarly, a pre-push hook prevents me from pushing up in-progress code
to a remote so my colleagues and other interested parties can follow my
progress, contribute design feedback, and, if I need to be out of the
office for a while, pick up my work and continue it.

> +    ** I want to prevent leaks / share code widely so I check that devel=
opers
> +    are uploading code to the right place.

This is also not an effective control.  Any user can bypass this
trivially, so there's little point in shipping a hook that does this.

> +    ** I want this to just work for all the developers in my repository,=
 without
> +    needing to support them through configuration.

Unfortunately, in most cases, what hooks are to be used and whether they
should be used is a developer choice, and developers should be able to
use or not use hooks much the same way as they choose an editor.  Thus, a
proposal that a project maintainer should specify a set of hooks to be
used on a developer machine is much like that maintainer proposing that
a developer use a specific editor.

While there are situations where that's done, in general, it's not a
best practice to do so, so I'm generally negative on the idea of
automatically deploying hooks to developer machines.  I think doing so
is a fundamental mistake in the developer process in most circumstances.
Certainly there are exceptions, but I think they are so few that the
burden of running a script is very minor in comparison.

> +Design Principles
> +~~~~~~~~~~~~~~~~~
> +
> +* *Make it easy:* Developers just want to get their work done. Introduci=
ng
> +friction is bad, especially when it prevents development from even start=
ing e.g.
> +workspace set up.

I think this assumes that developers need these hooks to be productive,
and I'm not in agreement with that assumption.  For the reasons I've
outlined above, I think that's a misunderstanding about best practices
and how codebases should be structured.

> +* *Treat hooks as software, not configuration:* We take seriously the
> +responsibility that comes with causing arbitrary code to run on a user's
> +machine. Such code needs to come from a reputable source, be automatical=
ly
> +updated, and run with user consent.

I don't think we can securely automatically update hooks from a remote
source.  That sounds like a terrible idea from a security perspective.

If users really want this, they can add a post-checkout hook to do so.

> +Feature Requirements

> +* Users must explicitly approve hook execution at least once (yes/no)
> +
> +    ** This could happen during setup or at execution time
> +
> +    ** When a hook command changes, a user should re-approve execution (=
note:
> +    implementation should not interfere with requirement listed in =E2=
=80=9CFast
> +    Follows")
> +
> +    * Users do not need to run setup scripts to install hooks --- the se=
tup flow
> +    happens automatically at clone time

This sounds like you're proposing automatically installing hooks, which
would of course be a security vulnerability.  If that's not what you're
proposing, then perhaps you'll want to rephrase this point.

> +* Automation is able to continue to use clone and other commands
> +non-interactively
> +
> +* Works across Windows/Linux/macOS

Git supports other platforms as well.

> +Implementation Exploration: Check "magic" branch for configs at fetch ti=
me
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~
> +
> +Example workflow
> +^^^^^^^^^^^^^^^^
> +
> +* Perform fetch as normal
> +
> +* After fetch is complete, Git checks for a "magic" config branch (e.g.
> ++origin/refs/recommended-config+) which contains information about confi=
g lines
> +an end-user may want (including hooks).

As I explain further below, shipping config is a security problem.

> +* As part of the fetch subcommand, Git prompts users to install the conf=
igs
> +contained there.

I don't want to be prompted to install hooks, because I never want to
use hooks from a repository like this.

Moreover, how could a user possibly make an educated decision?  They
can't actually see the hooks at this point because no checkout has
occurred, so the user must make a leap of faith based on the purported
reputation of the repository owner.

In similar situations, such as piping curl to bash, the recommendation
is always to download the script manually, inspect it for any problems
or vulnerabilities, and only then execute it.  This proposal doesn't
allow that.

> +    ** User responses to that prompt could be "sticky" - e.g. a user cou=
ld reply
> +    "no (this time)", "no (never)", "yes (this time)", or "yes (always)".
> +    Always/never indicate that the user trusts the remote this config is=
 coming
> +    from, and should not apply to configs fetched from other remotes.

"Yes (always)" is almost certainly a security problem.

> +Future Work
> +~~~~~~~~~~~
> +
> +* Extending this to allow repository owners to specify specific configur=
ations
> +in general e.g. this repository should use partial-clone with these para=
meters.

I don't think any sort of automatic configuration is going to be secure.
Git has had numerous vulnerabilities with the .gitmodules file and it is
highly restricted in its contents.  So I'm pretty much completely
opposed to this since I think it's likely to result in Git becoming a
CVE magnet.

Even if the entire rest of the project disagreed with me and adopted
this, the config would need to be restricted to an allowlist, not a
denylist, because we have good and sufficient evidence that the latter
is not secure.  Even things as simple as changing diff colors can cause
a security problem (e.g., hiding malicious code in a code review), so
I'm having trouble imagining how we could come up with more than a tiny
set of options that could be legitimately shipped securely, at which
point the extra maintenance and development burden becomes excessive.

> +* A way to perform general set up of a code base e.g. installing depende=
ncies,
> +any first-build related tasks

There are already a variety of proposals for this, such as
https://github.com/github/scripts-to-rule-them-all.  I don't believe Git
needs to be in the business of doing this, and all of my concerns about
security are appropriate here as well.

In general, I have grave concerns about this proposal.  It makes
assumptions that users should or will want to use the repository owner's
hooks, which I disagree with.  I think prompting users to install hooks
will encourage them to be much more likely to do so, especially for less
skilled users, which is likely to lead to social engineering attacks.
And overall, this proposal sounds like it does not give enough
consideration to the giant security risks it introduces.  I don't think
this proposal as it stands should be accepted, and I am having a hard
time thinking of any similar proposal I could support.

I appreciate that this proposal does make things slightly easier for a
subset of users and environments, but I think picking a standard set of
scripts for those users and environments and letting users execute them
if and when they want is only slightly more difficult and much more
secure.  I've used that approach at work and it works great, so I feel
confident it can work in most other environments as well.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--5WCbRzyuZ/wOjtRI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYFP+KgAKCRB8DEliiIei
gSOVAP9ndzs/jI7jyQHj0g8hdO4N5gi7TLo5nM1qSIjDlmYSoAEAiiePO78iNyyX
4saMiXu4WJO/WtEvbqyDakCAXU2OCwM=
=h0wf
-----END PGP SIGNATURE-----

--5WCbRzyuZ/wOjtRI--
