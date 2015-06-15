From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Documentation on git-checkout --ours/--theirs improved
Date: Mon, 15 Jun 2015 13:10:52 -0700
Message-ID: <xmqq381s91gz.fsf@gitster.dls.corp.google.com>
References: <xmqqwpzafe88.fsf@gitster.dls.corp.google.com>
	<1434372447-51230-1-git-send-email-simon.eu@gmail.com>
	<1434372447-51230-3-git-send-email-simon.eu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Simon A. Eugster" <simon.eu@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 15 22:11:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4aii-0001XN-KM
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jun 2015 22:11:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754005AbbFOUKz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Jun 2015 16:10:55 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:33070 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479AbbFOUKy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2015 16:10:54 -0400
Received: by igbos3 with SMTP id os3so28022744igb.0
        for <git@vger.kernel.org>; Mon, 15 Jun 2015 13:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=EpgT1aGLYaKj8hTDynZwhw25Vucb8WONG07BNQVkIJY=;
        b=b+YnvrkkbTnQzQoFv4XwITKMPY84/mHwuMtrOjJqPPAwj11Vgt7ONjGYJ0pkbjFTQW
         RpCdpVTH4gH91kNAsiroHnWPbr7ELm4Z/IMP3Q6tryyuFv97vMYqtBtSXdxtGB41Ykeg
         K8GCOYfpWZtsy8GRI177g4PmfyaMsy599OUDzgQGY1y5fKBj9rfSRSrikzcDabyb3QM4
         X/JPjnCfTSRokzQkT4g34H+lFEqoHpQ0UCxgNAweSbMbinc6CrBSXnLbGrgp6EbmI20H
         hW4fEMnD32tEs/VssfRlpML6o9SIEnwAz8MeF/xOTsuOC80FPC8jX19Chw9pbnWucpyI
         Oh+g==
X-Received: by 10.42.163.137 with SMTP id c9mr31633734icy.51.1434399053958;
        Mon, 15 Jun 2015 13:10:53 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:16f:c4ab:c37f:75f8])
        by mx.google.com with ESMTPSA id o19sm8294711igs.18.2015.06.15.13.10.52
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 15 Jun 2015 13:10:53 -0700 (PDT)
In-Reply-To: <1434372447-51230-3-git-send-email-simon.eu@gmail.com> (Simon
	A. Eugster's message of "Mon, 15 Jun 2015 14:47:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271720>

"Simon A. Eugster" <simon.eu@gmail.com> writes:

> ---

- Lack of explanation as to why this is a good thing.
- Lack of sign-off.

Why is there still 1/2, if its effect is wholly annulled by a
subsequent step 2/2?

>  Documentation/git-checkout.txt | 39 ++++++++++++++++++++++++++++++++=
+++----
>  1 file changed, 35 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/git-checkout.txt b/Documentation/git-check=
out.txt
> index 5c3ef86..ec0be28 100644
> --- a/Documentation/git-checkout.txt
> +++ b/Documentation/git-checkout.txt
> @@ -116,10 +116,41 @@ entries; instead, unmerged entries are ignored.
>  --theirs::
>  	When checking out paths from the index, check out stage #2
>  	('ours', HEAD) or #3 ('theirs', MERGE_HEAD) for unmerged paths.
> -+
> -After a `git pull --rebase`, for example, 'ours' points to the remot=
e
> -version and 'theirs' points to the local version. See linkgit:git-me=
rge[1]
> -for details about stages #2 and #3.
> +	See linkgit:git-merge[1] for details about stages #2 and #3.
> ++
> +Note that during `git rebase` and `git pull --rebase`, 'theirs' chec=
ks out
> +the local version, and 'ours' the remote version or the history that=
 is rebased
> +against.
> ++
> +The reason ours/theirs appear to be swapped during a rebase is that =
we
> +define the remote history as the canonical history, on top of which =
our
> +private commits are applied on, as opposed to normal merging where t=
he
> +local history is the canonical one.

"We define" sounds a bit strange to me.

It is not "we" who define so.  Those who use "rebase" because they
employ a shared central repository workflow are the ones that treat
the history of their "remote repository" (which is their shared
central repository) as the canonical one.


	Note that during `git rebase` and `git pull --rebase`,
	'ours' and 'theirs' may appear swapped; `--ours` gives the
	version from the branch the changes are rebased onto, while
	`--theirs` gives the version from the branch that holds your
	work that is being rebased.

	This is because `rebase` is used in a workflow that treats
	the history at the remote as the shared canonical one, and
	treat the work done on the branch you are rebasing as the
	third-party work to be integrated, and while you are
	rebasing, you are temporarily assuming the role of the
	keeper of the canonical history.  As the keeper of the
	canonical history, you would view the history from the
	remote as `ours`, while what you did on your side branch as
	`theirs`.



> +During merging, we assume the role of the canonical history=E2=80=99=
s keeper,
> +which, in case of a rebase, is the remote history, and our private c=
ommits
> +look to the keeper as =E2=80=9Ctheir=E2=80=9D commits which need to =
be integrated on top
> +of =E2=80=9Cour=E2=80=9D work.
> ++
> +Normal merging:
> +------------
> +local ---------abC                  <-- canonical history
> +                 | git checkout --ours
> +                 v
> +MERGE ---------abC
> +                 ^
> +                 | git checkout --theirs
> +origin/master ---Xyz
> +------------
> +Rebasing:
> +------------
> +local -----------Abc
> +                 | git checkout --theirs
> +                 v
> +REBASE --------xyZ
> +                 ^
> +                 | git checkout --ours
> +origin/master -xyZ                    <-- canonical history
> +------------

I can see that an arrow with "canonical history" points at different
things between the two pictures, but other than that, I am not sure
what these are trying to illustrate.  Especially between abc and
xyz, why does the former choose abc while the latter choooses xyz?
Are these pictures meant to show what happens when the user says
"checkout --ours" during a conflicted integration (whether it is a
merge or a rebase)?

Thanks.

> =20
>  -b <new_branch>::
>  	Create a new branch named <new_branch> and start it at
