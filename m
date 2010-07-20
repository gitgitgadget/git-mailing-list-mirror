From: Erick Mattos <erick.mattos@gmail.com>
Subject: Re: [PATCH] t/: work around one-shot variable assignment with 
	test_must_fail
Date: Tue, 20 Jul 2010 20:19:02 -0300
Message-ID: <AANLkTilY0fYxKlWLYGU4f4ZtJzsMSSnIIi0YnywKU5DU@mail.gmail.com>
References: <8HvhdiflWJtex2eC6n_6Q38YcvRRYhnh0scnq4s56M4wdwT_YlAiOw@cipher.nrlssc.navy.mil> 
	<iU5XdZGtMeaspoCqSJIp6Y--60TPVkZUrm3SdW86dsTZkNYZWqbSppLBrMXyL1rVqqYtHm94ACo@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, avarab@gmail.com, jrnieder@gmail.com,
	jaredhance@gmail.com, drafnel@gmail.com
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Jul 21 01:19:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObM60-0002cV-S7
	for gcvg-git-2@lo.gmane.org; Wed, 21 Jul 2010 01:19:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932883Ab0GTXT2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Jul 2010 19:19:28 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:54749 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932655Ab0GTXT1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Jul 2010 19:19:27 -0400
Received: by iwn7 with SMTP id 7so6156874iwn.19
        for <git@vger.kernel.org>; Tue, 20 Jul 2010 16:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=VAeMOl6zUBEAEoSiEQOwB5CqRILezcZ+94FIbpop1fE=;
        b=pH590dffcf21VM1Xp5BUfSe7eZFSgMQ/njoYSPXqFj+Vy4ETIDVj+00IDSTPoQVH+P
         MKjlJGDYZ/MxQBrtqP3Ois/HCTE4xabTL2xqkG+UyVRRiqL0DhmLHqDkZhWcnfeUaQwZ
         mNTvopmr2E7rzbtqVP7c2avGGhRspcmCk6vaA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=vI2cUwjNEOu79FmiqEaENur2lx1AcgMKoAszB896acL6t+Wg3xh3qXH5WRHtYlAv9y
         FSkvqF5UATFb06sUkL6ddCM+WvPDLrrELRk2GGVZq0t7gNOGci+iWQSPUtB4dXm0hGLB
         l/wXluU32muoZC/Wg0UrwFkuV5bDhrI1DASIs=
Received: by 10.231.147.18 with SMTP id j18mr7979682ibv.19.1279667962204; Tue, 
	20 Jul 2010 16:19:22 -0700 (PDT)
Received: by 10.231.178.36 with HTTP; Tue, 20 Jul 2010 16:19:02 -0700 (PDT)
In-Reply-To: <iU5XdZGtMeaspoCqSJIp6Y--60TPVkZUrm3SdW86dsTZkNYZWqbSppLBrMXyL1rVqqYtHm94ACo@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151374>

Hi,

2010/7/20 Brandon Casey <casey@nrlssc.navy.mil>
>
> No time to investigate, but here is an example patch and the
> results of running the affected tests. =C2=A0Looks like reflog may
> be creating a reflog when it is not supposed to.
>
> Erick, I added you to cc since you appear to be the author of the tes=
ts
> in question.

Thanks for your kindness.

> $ ./t2017-checkout-orphan.sh
> <snip>
> not ok - 8 --orphan does not make reflog when core.logAllRefUpdates =3D=
 false
> #
> # =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git checkout maste=
r &&
> # =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git config core.lo=
gAllRefUpdates false &&
> # =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git checkout --orp=
han epsilon &&
> # =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ! test -f .git/log=
s/refs/heads/epsilon &&
> # =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (
> # =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 PAGER=3D &&
> # =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 export PAGER &&
> # =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 test_must_fail git reflog show epsilon
> # =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ) &&
> # =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git commit -m Epsi=
lon &&
> # =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ! test -f .git/log=
s/refs/heads/epsilon &&
> # =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (
> # =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 PAGER=3D &&
> # =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 export PAGER &&
> # =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 test_must_fail git reflog show epsilon
> # =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )
> #
> <snip>
>
> $ ./t3200-branch.sh
> <snip>
> not ok - 32 checkout -b does not make reflog when core.logAllRefUpdat=
es =3D false
> #
> # =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git checkout maste=
r &&
> # =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git config core.lo=
gAllRefUpdates false &&
> # =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git checkout -b be=
ta &&
> # =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ! test -f .git/log=
s/refs/heads/beta &&
> # =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (
> # =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 PAGER=3D &&
> # =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 export PAGER &&
> # =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 test_must_fail git reflog show beta
> # =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )
> #
> <snip>

You have made cosmetic changes which do not do the same as the original=
=2E

>
> --->8---
> From: Brandon Casey <drafnel@gmail.com>
>
> See e2007832552ccea9befed9003580c494f09e666e
> ---
> =C2=A0t/t2017-checkout-orphan.sh | =C2=A0 36 ++++++++++++++++++++++++=
++++++------
> =C2=A0t/t3200-branch.sh =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=
=A06 +++++-
> =C2=A0t/t3301-notes.sh =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=
=A06 +++++-
> =C2=A03 files changed, 40 insertions(+), 8 deletions(-)
>
> diff --git a/t/t2017-checkout-orphan.sh b/t/t2017-checkout-orphan.sh
> index be88d4b..81cb393 100755
> --- a/t/t2017-checkout-orphan.sh
> +++ b/t/t2017-checkout-orphan.sh
> @@ -69,7 +69,11 @@ test_expect_success '--orphan makes reflog by defa=
ult' '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git config --unset core.logAllRefUpdates &=
&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git checkout --orphan delta &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0! test -f .git/logs/refs/heads/delta &&
> - =C2=A0 =C2=A0 =C2=A0 test_must_fail PAGER=3D git reflog show delta =
&&
> + =C2=A0 =C2=A0 =C2=A0 (
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PAGER=3D &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 export PAGER &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test_must_fail git=
 reflog show delta
> + =C2=A0 =C2=A0 =C2=A0 ) &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git commit -m Delta &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test -f .git/logs/refs/heads/delta &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0PAGER=3D git reflog show delta
> @@ -80,17 +84,29 @@ test_expect_success '--orphan does not make reflo=
g when core.logAllRefUpdates =3D
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git config core.logAllRefUpdates false &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git checkout --orphan epsilon &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0! test -f .git/logs/refs/heads/epsilon &&
> - =C2=A0 =C2=A0 =C2=A0 test_must_fail PAGER=3D git reflog show epsilo=
n &&
> + =C2=A0 =C2=A0 =C2=A0 (
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PAGER=3D &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 export PAGER &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test_must_fail git=
 reflog show epsilon
> + =C2=A0 =C2=A0 =C2=A0 ) &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git commit -m Epsilon &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0! test -f .git/logs/refs/heads/epsilon &&
> - =C2=A0 =C2=A0 =C2=A0 test_must_fail PAGER=3D git reflog show epsilo=
n
> + =C2=A0 =C2=A0 =C2=A0 (
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PAGER=3D &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 export PAGER &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test_must_fail git=
 reflog show epsilon
> + =C2=A0 =C2=A0 =C2=A0 )
> =C2=A0'
>
> =C2=A0test_expect_success '--orphan with -l makes reflog when core.lo=
gAllRefUpdates =3D false' '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git checkout master &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git checkout -l --orphan zeta &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test -f .git/logs/refs/heads/zeta &&
> - =C2=A0 =C2=A0 =C2=A0 test_must_fail PAGER=3D git reflog show zeta &=
&
> + =C2=A0 =C2=A0 =C2=A0 (
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PAGER=3D &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 export PAGER &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test_must_fail git=
 reflog show zeta
> + =C2=A0 =C2=A0 =C2=A0 ) &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git commit -m Zeta &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0PAGER=3D git reflog show zeta
> =C2=A0'
> @@ -99,10 +115,18 @@ test_expect_success 'giving up --orphan not comm=
itted when -l and core.logAllRef
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git checkout master &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git checkout -l --orphan eta &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test -f .git/logs/refs/heads/eta &&
> - =C2=A0 =C2=A0 =C2=A0 test_must_fail PAGER=3D git reflog show eta &&
> + =C2=A0 =C2=A0 =C2=A0 (
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PAGER=3D &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 export PAGER &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test_must_fail git=
 reflog show eta
> + =C2=A0 =C2=A0 =C2=A0 ) &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git checkout master &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0! test -f .git/logs/refs/heads/eta &&
> - =C2=A0 =C2=A0 =C2=A0 test_must_fail PAGER=3D git reflog show eta
> + =C2=A0 =C2=A0 =C2=A0 (
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PAGER=3D &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 export PAGER &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test_must_fail git=
 reflog show eta
> + =C2=A0 =C2=A0 =C2=A0 )
> =C2=A0'
>
> =C2=A0test_expect_success '--orphan is rejected with an existing name=
' '
> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index 859b99a..bf7747d 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -237,7 +237,11 @@ test_expect_success 'checkout -b does not make r=
eflog when core.logAllRefUpdates
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git config core.logAllRefUpdates false &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git checkout -b beta &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0! test -f .git/logs/refs/heads/beta &&
> - =C2=A0 =C2=A0 =C2=A0 test_must_fail PAGER=3D git reflog show beta
> + =C2=A0 =C2=A0 =C2=A0 (
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PAGER=3D &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 export PAGER &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test_must_fail git=
 reflog show beta
> + =C2=A0 =C2=A0 =C2=A0 )
> =C2=A0'
>
> =C2=A0test_expect_success 'checkout -b with -l makes reflog when core=
=2ElogAllRefUpdates =3D false' '
> diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
> index 2d67a40..1d82f79 100755
> --- a/t/t3301-notes.sh
> +++ b/t/t3301-notes.sh
> @@ -693,7 +693,11 @@ test_expect_success 'create note from non-existi=
ng note with "git notes add -c"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git add a10 &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_tick &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git commit -m 10th &&
> - =C2=A0 =C2=A0 =C2=A0 test_must_fail MSG=3D"yet another note" git no=
tes add -c deadbeef &&
> + =C2=A0 =C2=A0 =C2=A0 (
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MSG=3D"yet another=
 note" &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 export MSG &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test_must_fail git=
 notes add -c deadbeef
> + =C2=A0 =C2=A0 =C2=A0 ) &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_must_fail git notes list HEAD
> =C2=A0'
>
> --
> 1.6.6.2
>

I don't like this proposed patch because I don't see an improvement
when:
* you change a line to three;
* the original line is clear enough;
* the resulting lines improves nothing;
* it is for cosmetic purposes only inside a script;
* and it uses more resources, even if little more as by creating a
  subshell environment, to do the same.

Best regards
