From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/7] t5528-push-default.sh: add helper functions
Date: Mon, 23 Apr 2012 08:36:51 -0700
Message-ID: <xmqqipgqlass.fsf@junio.mtv.corp.google.com>
References: <1334933944-13446-1-git-send-email-Matthieu.Moy@imag.fr>
	<1335170284-30768-1-git-send-email-Matthieu.Moy@imag.fr>
	<1335170284-30768-4-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Apr 23 17:37:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMLJy-0001gD-5F
	for gcvg-git-2@plane.gmane.org; Mon, 23 Apr 2012 17:36:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752613Ab2DWPgx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Apr 2012 11:36:53 -0400
Received: from mail-vx0-f202.google.com ([209.85.220.202]:38212 "EHLO
	mail-vx0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752311Ab2DWPgw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2012 11:36:52 -0400
Received: by vcbfk26 with SMTP id fk26so1347040vcb.1
        for <git@vger.kernel.org>; Mon, 23 Apr 2012 08:36:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=kZON09MvUyNi57qQJobVo2BO8RgAzOphjXmf6dE3VoE=;
        b=LcxyQLrNBohxLOlUEkpcAtM80fZxJbStakCaZRqQACLeagI1e3AWRYvm062hNlTcgy
         3czLpxLQzo8Ghw27FNIIdIl6WEj7MGI6fuyInv9Jy0RTMDqkbJVB2TFmI1wSBaWwq6+n
         knBOsVeaGchdSdaqYLdt8I7Yu0DQ11KCNec3QUR3Z7R9bVs8wq/eorP4DQ4jafs4CdqG
         MJyNIq3O453+P31G6SnYvN+itf2jevywC0CVM7t2n2U83Pih3zkqX0DgiaoY1NsGi3jt
         Lvuq2gxdsgFCalTZXMZKh+1IQcvAfXxVy8QcMiuAJTLcQpepsN6bmXdarYCugK2SReZ7
         HaWw==
Received: by 10.236.180.33 with SMTP id i21mr20144920yhm.1.1335195412023;
        Mon, 23 Apr 2012 08:36:52 -0700 (PDT)
Received: by 10.236.180.33 with SMTP id i21mr20144896yhm.1.1335195411899;
        Mon, 23 Apr 2012 08:36:51 -0700 (PDT)
Received: from wpzn4.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id k54si15221596yhh.5.2012.04.23.08.36.51
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Mon, 23 Apr 2012 08:36:51 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by wpzn4.hot.corp.google.com (Postfix) with ESMTP id ADECB1E004D;
	Mon, 23 Apr 2012 08:36:51 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 597E5E120A; Mon, 23 Apr 2012 08:36:51 -0700 (PDT)
In-Reply-To: <1335170284-30768-4-git-send-email-Matthieu.Moy@imag.fr>
	(Matthieu Moy's message of "Mon, 23 Apr 2012 10:38:00 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQlTDp4oKExxIToz4mjbEb3QHOhCZQX/iObrzKw9hAyj+eedjeXW8FVLAOeXSRHXWzwIm0LnksHlN5X6WMddyXVHKZ5xTpbpQ+44IJ5/nuVGzFKrrIRzj03j2pQUpKyfrYunFKPEFrlBrzX1qcRdcIJ729k7mCBYKnCF/AhIUCJRZtKUkpI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196132>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
>  t/t5528-push-default.sh |   45 ++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 38 insertions(+), 7 deletions(-)

The use of helpers makes the body of the test easier to follow.

> diff --git a/t/t5528-push-default.sh b/t/t5528-push-default.sh
> index c334c51..da7d3d8 100755
> --- a/t/t5528-push-default.sh
> +++ b/t/t5528-push-default.sh
> @@ -13,16 +13,47 @@ test_expect_success 'setup bare remotes' '
>  	git push parent2 HEAD
>  '
>  
> +# $1 = local revision
> +# $2 = remote revision (tested to be equal to the local one)
> +check_pushed_commit () {
> +	git log -1 --format='%h %s' >expect &&
> +	git --git-dir=repo1 log -1 --format='%h %s' "$2" >actual &&
> +	test_cmp expect actual
> +}

Hmph.  How is $1 used in the above to make it compare between local and
remote?  Does the first one need to have "$1" before " >expect"?

> +# $1 = push.default value
> +# $2 = expected target branch for the push
> +test_push_success () {
> +	git -c push.default="$1" push &&
> +	check_pushed_commit HEAD "$2"
> +}
> +
> +# $1 = push.default value
> +# other arguments = target branches that should not be touched
> +test_push_failure () {
> +	push_default=$1 &&
> +	shift &&
> +	if test $# -gt 0
> +	then
> +		# branch may not exist
> +		test_might_fail git --git-dir=repo1 \
> +			log --no-walk --format='%h %s' "$@" >expect
> +	fi &&
> +	test_must_fail git -c push.default="$1" &&

What subcommand does this run with one-shot override configuration?  Do
we need " push" before " &&"?

> +	if test $# -gt 0
> +	then
> +		test_might_fail git --git-dir=repo1 \
> +			log -1 --format='%h %s' "$@" >actual
> +	fi &&
> +	test_cmp expect actual
> +}

This allows us to look at not just the failure of the push operation,
but also inspects the resulting repository to make sure things that must
stay intact do, which is very nice.  The callers can even pass "--all"
to it, instead of enumerating the branches, which would be very useful
when testing a single-branch modes like `current` and `upstream`.

>  test_expect_success '"upstream" pushes to configured upstream' '
>  	git checkout master &&
>  	test_config branch.master.remote parent1 &&
>  	test_config branch.master.merge refs/heads/foo &&
> -	test_config push.default upstream &&
>  	test_commit two &&
> -	git push &&
> -	echo two >expect &&
> -	git --git-dir=repo1 log -1 --format=%s foo >actual &&
> -	test_cmp expect actual
> +	test_push_success upstream foo
>  '
>
>  test_expect_success '"upstream" does not push on unconfigured remote' '
> @@ -30,7 +61,7 @@ test_expect_success '"upstream" does not push on unconfigured remote' '
>  	test_unconfig branch.master.remote &&
>  	test_config push.default upstream &&
>  	test_commit three &&
> -	test_must_fail git push
> +	test_push_failure upstream master
>  '

... and we can use --all not master here, right?

>  test_expect_success '"upstream" does not push on unconfigured branch' '
> @@ -39,7 +70,7 @@ test_expect_success '"upstream" does not push on unconfigured branch' '
>  	test_unconfig branch.master.merge &&
>  	test_config push.default upstream
>  	test_commit four &&
> -	test_must_fail git push
> +	test_push_failure upstream master
>  '

Same here.

Thanks.
