From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [RFC] t7410: 210 tests for various 'git submodule update'
 scenarios
Date: Wed, 16 Apr 2014 10:21:53 -0700
Message-ID: <20140416172153.GW21805@odin.tremily.us>
References: <1397609688-25634-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aJDJANv8BPX70wwH"
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Apr 16 19:22:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaTXE-0005Jd-Qg
	for gcvg-git-2@plane.gmane.org; Wed, 16 Apr 2014 19:22:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755350AbaDPRWB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2014 13:22:01 -0400
Received: from qmta07.westchester.pa.mail.comcast.net ([76.96.62.64]:53954
	"EHLO qmta07.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754319AbaDPRV5 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Apr 2014 13:21:57 -0400
Received: from omta19.westchester.pa.mail.comcast.net ([76.96.62.98])
	by qmta07.westchester.pa.mail.comcast.net with comcast
	id qbGP1n00227AodY57hMwQW; Wed, 16 Apr 2014 17:21:56 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta19.westchester.pa.mail.comcast.net with comcast
	id qhMu1n00J152l3L3fhMuKs; Wed, 16 Apr 2014 17:21:56 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id A3789114E2CF; Wed, 16 Apr 2014 10:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1397668913; bh=RrekoN4p/siTFVUbfmV5ujWfaTD3ziwPoDUDjXTtlo0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iHuQoAkBhnX/6g5Kjo/ABGhEAXVZ+fj+9HLC0745yc2KV7+geoEBDAyB6nH4ghPdI
	 NQE0WJ4dV+LQi+/7NgIsf3NFAMrx5fI4Bor1em9ssqrPIoBv634oXPKGIQFCGAQDn8
	 hRnvbl1wMy2X1m7gKSGR31i1ujDLrjWlAGg71hPY=
Content-Disposition: inline
In-Reply-To: <1397609688-25634-1-git-send-email-johan@herland.net>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.22 (2013-10-16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1397668916;
	bh=hlMMC+Lo6SmyG7kvBs5nBsX6qy0qwauUXldbya9eSY0=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=B7knW2JxG3vXmSg9DbTP8P1SBC5QjRlV0RiyN3jHNU22scHxTGbpNuVhdcK6AFwdJ
	 QoK+7DXyaz2i69GCRyn0ImwSzxX1aI9rjTkGnmoGfXpoKSva22uYFE5qLhG3/HW209
	 hT/PoxH38moNtIu9hb3OBfYff7G4CtxjqrWXLxEe6g832QxiAurdteNZx2sKHgHAtE
	 o+2HzztXpCkqtRji3nwQWUSWtIBnWBii/7xvmlu9U4Cc7+mzCwOD+VwQZzHRHPY44B
	 GZnNJGriRN0pCcbeMsD0i6JOzAm8ej7NhhzYx5+W2JDRLPDWMuLOKsogUOO1iIYh4t
	 H0Ma/OK7e1IIg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246351>


--aJDJANv8BPX70wwH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2014 at 02:54:48AM +0200, Johan Herland wrote:
> This is a work-in-progress to flesh out (and promote discussion about)
> the expected behaviors for all possible scenarios in which
> 'git submodule update' might be run.

This is lovely :).

> +#  - current state of submodule:
> +#     ?.?.?.1 - not yet cloned
> +#     ?.?.?.2 - cloned, detached, HEAD =3D=3D gitlink
> +#     ?.?.?.3 - cloned, detached, HEAD !=3D gitlink
> +#     ?.?.?.4 - cloned, on branch foo (exists upstream), HEAD =3D=3D git=
link
> +#     ?.?.?.5 - cloned, on branch foo (exists upstream), HEAD !=3D gitli=
nk
> +#     ?.?.?.6 - cloned, on branch bar (MISSING upstream), HEAD =3D=3D gi=
tlink
> +#     ?.?.?.7 - cloned, on branch bar (MISSING upstream), HEAD !=3D gitl=
ink

The remote branches should only matter for the initial clone and
--remote updates.  Also, only the configured submodule.<name>.branch
(your first axis) should be checked; the locally checked-out submodule
branch shouldn't matter.

> +# T2: Test with submodule.<name>.url !=3D submodule's remote.origin.url.=
 Does
> +#     "submodule update --remote" sync with submodule.<name>.url, or wit=
h the
> +#     submodule's origin? (or with the submodule's current branch's upst=
ream)?

All fetches should currently use the submodule's remote.origin.url.
submodule.<name>.url is only used for the initial clone (*.*.*.1), and
never referenced again.  This would change using my tightly-bound
submodule proposal [1], where a difference between
submodule.<name>.url and the submodule's @{upstream} URL would be
trigger a dirty-tree condition (for folks with tight-bind syncing
enabled) from which you couldn't update before resolving the
difference.

> +# D1: When submodule is already at right commit, checkout-mode currently=
 does
> +#     nothing. Should it instead detach, even when no update is needed?
> +#     Affects: 1.2.1.4, 1.2.1.6, 2.2.1.4, 2.2.1.6, 3.2.1.4, 3.2.1.6

=E2=80=9CCheckout updates always leave a detached HEAD=E2=80=9D seems easie=
r to
explain, so I'm leaning that way.

> +# D2: Should all/some of 1.3.*/1.4.* abort/error because we don't know w=
hat to
> +#     merge/rebase with (because .branch is unset)? Or is the current de=
fault
> +#     to origin/HEAD OK?
> +#     Affects: 1.3.*, 1.4.*

Maybe you mean 1.3.*, 1.4.*, and 1.5.* (merge, rebase, and !command)?
In all of these cases, we're integrating the current HEAD with the
gitlinked (*.*.1.*) or remote-tracking branch (*.*.2.*).  Since
submodule.<name>.branch defaults to master (and may be changed to HEAD
after a long transition period? [2,3]), I don't think we should
abort/error in those cases.

> +# D3: When submodule is already at right commit, merge/rebase-mode curre=
ntly
> +#     does nothing. Should it do something else (e.g. not leave submodule
> +#     detached, or checked out on the "wrong" branch (i.e. !=3D .branch)=
)?
> +#     (This discussion point is related to D1, D5 and D6)

=E2=80=9CNon-checkout updates always leave you on a branch=E2=80=9D seems e=
asier to
explain, but I think we'd want to distinguish between the local branch
and the remote submodule.<name>.branch [1].  Lacking that distinction,
I'd prefer to leave the checked-out branch unchanged.

> +# D4: When 'submodule update' performs a clone to populate a submodule, =
it
> +#     currently also creates a default branch (named after origin/HEAD) =
in
> +#     that submodule, EVEN WHEN THAT BRANCH WILL NEVER BE USED (e.g. bec=
ause
> +#     we're in checkout-mode and submodule will always be detached). Is =
this
> +#     good, or should the clone performed by 'submodule update' skip the
> +#     automatic local branch creation?
> +#     Affects: 1.2.*.1, 1.3.*.1, 1.4.*.1, 1.5.*.1,
> +#              2.2.*.1, 2.3.*.1, 2.4.*.1, 2.5.*.1,
> +#              3.2.1.1, 3.3.1.1, 3.4.1.1, 3.5.1.1

=E2=80=9CCheckout updates always leave a detached HEAD=E2=80=9D seems easie=
r to
explain, so I'm leaning that way.

> +# D5: When in merge/rebase-mode, and 'submodule update' actually ends up=
 doing
> +#     a merge/rebase, that will happen on the current branch (or detache=
d HEAD)
> +#     and NOT on the configured (or default) .branch. Is this OK? Should=
 we
> +#     abort (or at least warn) instead? (In general, .branch seems only =
to
> +#     affect the submodule's HEAD when the submodule is first cloned.)
> +#     (This discussion point is related to D3 and D6)
> +#     Affects: 1.3.1.3, 1.3.1.5, 1.3.1.7, 1.3.2.>=3D2,
> +#              1.4.1.3, 1.4.1.5, 1.4.1.7, 1.4.2.>=3D2,
> +#              2.3.1.3, 2.3.1.5, 2.3.1.7, 2.3.2.2, 2.3.2.4, 2.3.2.6,
> +#              2.4.1.3, 2.4.1.5, 2.4.1.7, 2.4.2.2, 2.4.2.4, 2.4.2.6
> +#              3.3.1.3, 3.3.1.5, 3.3.1.7
> +#              3.4.1.3, 3.4.1.5, 3.4.1.7

With the --remote option that added submodule.<name>.branch (which
eventually landed with v8 of that series [4]), I initially imagined it
as the name of the local branch [5], but transitioned to imagining it
as the name of the remote-tracking branch in v5 of that series [6].
There were no major logical changes between v5 and v8.  With the v8
version that landed in Git v1.8.2, submodule.<name>.branch was clearly
the name of the remote-tracking branch, and we gave no way to
separately configure the local branch.

Recently, we decided that local branches might be important after all
[7], which lead to the partially landed v5 of my local-branch-creation
series [8], now partially reverted with d851ffb (Revert "submodule:
explicit local branch creation in module_clone", 2014-04-02).  Like v4
of that series [9], I considered the landed-and-now-reverted v5 to be
a stop-gap until we got better local-branch handling.

Anyhow, that's why submodule.<name>.branch is only important when we
interact with the remote repository (during clones and --remote
updates).  We've never landed a patch that explicitly addresses what
the local branch should be.

> +# D6: The meaning of submodule.<name>.branch is initially confusing, as =
it does
> +#     not really concern the submodule's local branch (except as a namin=
g hint
> +#     when the submodule is first cloned). Instead, submodule.<name>.bra=
nch is
> +#     really about which branch in the _upstream_ submodule

Which is how gitmodules(5) explains it:

  submodule.<name>.branch
    A remote branch name for tracking updates=E2=80=A6

> +#     submodule.<name>.url, or by the submodule's remote.origin.url?)
> +#     want to integrate with.

The submodule's remote.origin.url for everything except the initial
clone (*.*.*.1).  See my response to T2.

> =E2=80=A6                               This is probably the more useful =
setting, and it
> +#     becomes obviously correct after (re-)reading gitmodules(5) and
> +#     git-config(1). However, from just reading the "update" section in
> +#     git-submodule(1) (or not even that), things are not so clear-cut. =
Would
> +#     submodule.<name>.upstream (or .remote-branch, or similar) be a bet=
ter
> +#     name for this?

Are the docs from 23d25e4 (submodule: explicit local branch creation
in module_clone, 2014-01-26; now reverted with d851ffb, Revert
"submodule: explicit local branch creation in module_clone",
2014-04-02) clearer?  Maybe we can salvage some of those docs even
though we've reverted the actual code changes?

> +# D7: What to do when .branch refers to a branch that is missing from up=
stream?
> +#     Currently, when trying to clone, the clone fails (which causes 'git
> +#     submodule update --remote' to fail), but leaves the submodule in an
> +#     uninitialized state (there is a .git, but the work tree is missing=
).
> +#     This is probably not the behavior we want...
> +#     Affects: pre, 3.2.2.1, 3.3.2.1, 3.4.2.1, 3.5.2.1

I think we should remove the submodule's .git file after the failed clone.

Cheers,
Trevor

[1]: http://thread.gmane.org/gmane.comp.version-control.git/240336
[2]: http://thread.gmane.org/gmane.comp.version-control.git/245283
[3]: http://thread.gmane.org/gmane.comp.version-control.git/245357
[4]: http://thread.gmane.org/gmane.comp.version-control.git/211830
[5]: http://article.gmane.org/gmane.comp.version-control.git/210730
[6]: http://article.gmane.org/gmane.comp.version-control.git/210764
[7]: http://thread.gmane.org/gmane.comp.version-control.git/239799
[8]: http://thread.gmane.org/gmane.comp.version-control.git/241112
[9]: http://article.gmane.org/gmane.comp.version-control.git/240498

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--aJDJANv8BPX70wwH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTTrwsAAoJEKKfehoaNkbtRQQP/3SIyLcww0hukz1bqm6XOXjJ
HbIgE/P2rpZ5V2hDsWChM9I33IIVvT8n2yTGIJPB4mfJmSaoJncO1E8eajGTcnAF
73i3bjNfMTaj48uTs900RZTjRBTGICy9UHyNIpmyIaY8fgQxYJ9sm31bf4rUgKTJ
BWPJZYg32OOQqffV4avrqPvtUR/nYZSOS81mkLTydOGD6iPyOfYcSsYM/Pftoagj
2WAGySoThLHsax+e83yqEfLFHNlcI3wLMfnc38O42ff6YyPF3MJla44G0ItYNmCy
17hlie6HP0UXFQVIpA+j2Zeehv4mnRnM2Wf6/DOXiFIDeDRjOnIxGfcf8rNUVUs1
geas2E7RoeEdLvjoRD9/guMIw8oUn2UtibNNZwXzmTKI+joZXRLs/AJIVoQ/WpFy
n6h7wQIbqhEA/i6LCYFhpu4ISo2slYuq9Zj6VYMd/Ah9/8nEkBmVtK9BffLLUbjv
Kk8kFb+4wlERiCsXAZnGEccLB3pXatmst5RtQfGL5E8MzTGAAxym3BokS5029ETd
8pfKkzBQnWxOWW1Er6VSgGi9rLJcRBIdO6reWl4x/fzmUkr6LAf3uJVQvJqOcNwr
IVmuDWDRugZKcCwOb3vp2o9Zbdz0PYhFYwPJlyadKqjdnZvy+1oWzZVBU16TSlvQ
JGpiYW53ER0ClMfVhOyW
=T28g
-----END PGP SIGNATURE-----

--aJDJANv8BPX70wwH--
