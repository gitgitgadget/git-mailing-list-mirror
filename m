Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB90EC433F5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 12:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFACA615E2
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 12:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235356AbhKPMQZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 07:16:25 -0500
Received: from mout.gmx.net ([212.227.17.22]:52699 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234468AbhKPMQE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 07:16:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637064785;
        bh=NaM70XaJvz1wvZQQNBn3NOR9LiH/gEi997/nEInY97s=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=HQXnZixClHGo3TIJUYyBEROa+xoHAprSziOo0+EMir68FCOuP9rEJOdixex56tTk9
         xWizkLGGseH1Gz46XlVMp16s/tycKeyxPgLe1s64CJjI1zAr3+3SrDbSWLgVltFG20
         emVNTwoNsmBpBI/FsiO3glLdywnxnBjLju9Ri2uM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.27.166.205] ([89.1.213.220]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MsHru-1mWwv50WHi-00thOU; Tue, 16
 Nov 2021 13:13:05 +0100
Date:   Tue, 16 Nov 2021 13:13:03 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] name-rev: prefer shorter names over following merges
In-Reply-To: <pull.1119.git.git.1636762454792.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2111161227090.21127@tvgsbejvaqbjf.bet>
References: <pull.1119.git.git.1636762454792.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:4uFU56+rWfnKaKpdUZTssnYVt//zNtZIPGN9Amz1ZMtD37fgijC
 zAe07Fz5e6ZChZj+3IUr8zZvWOi96dL8OCIlDLVW2c4qCoK7kSa/fzyF/5WaCouPbaZRUDj
 +RX5ui2ZDsjg3FTHTAyKL564UBn1jugKRyMmGNXJaMpIG/TednsFWCpw39DeXFVB3/ouomf
 xyf/hz6N9uJePDi17CkIw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:k6Ryz7lDNIQ=:Qihgwr1X0S4yEP8kZ+v6lm
 diaJq3wCD3V7QzcGPExnaVfKS19fcA2Kyd61nEWXW81Miqytvfx57+01R1YcrkflkBQnGf5HQ
 smkiHOxd8DkJ7Dl5afSZN/E8jjTGNowZM2+mzAO4Y6Ate66613uM0Xv7+GCXsSMolGIADJ5zj
 uAfU7LBYTjsP2XUS5gPuFtUYCNWAR+70JVyov0MD+kaRYW71BdWLjXoYVu442XVD6jK8IS0ow
 RYrnPiPjojHVQ7v4eUR/oGLqSP0A56Mlv+b5IyxMsvFy9GPaTwtBAIMgFGRDsvwe6U9NWWS42
 Fqtt7eTM4YwHhwMnddciwOXeFFAFFbvsAhQmo6Xj0WTbRb7p5+4/bDNrbR6mR1xZRSJe5SVzv
 s8EPXTshVvxfpTXUi2oA0FChbOnpAvKF898hllidtNz1LbtabNHwVts39+8tS1zhX1dYz8wpX
 Y/JZeXb3db0mKs9RUaW8V3qwKHPrmgYLxKdfRpBg04UkaehxTL+7cJZaVEBFPiqSkxyjxqY9T
 v/Z4V5N297SNpHBXiYOWP8M6V6CGh/daar2bFsVR1hoxo8GvsdaTADUoC9zCNvg1Ra063lxps
 m9+iJgZiTrZrkL80DBzsRzH7I3ZXwo269YH5RdjKrC0RO6Axtw1C3X8VLJB1+9qmlOoj+xRbU
 tHFksR5rrTbr86nCh4jHxbFbX8CxXBfM4MyoB2kxeRxRidAqVTl6xvL5lyVsfl8Ee6jVCVaPc
 4WPYvTsJIbLCUmcRqEDP4Hn4/tSuWY0ZJU/qL4O1RLXRCRByP4UqptYeVo0/PQYg6EicKmNOk
 hq6Y5kPdAxf8ZhLwnBzsReISz0LXGo7xsstMgVsrRw8PeyyEkCuyQFIxkX1bkb3OyIlMRvqhr
 H27qKfo5afOEW59m67yVC2WsFuSHaJuAFX858hX6+Q+5+420PUFBR5GtwudKhqZBJ0EbS9TK7
 p62wMEgxIZzSqerxvA3cKQNx5Unl1ceYf9A498yoiN9Cn9bwcvg15wDBh9rZflS1IC6jjz/Jj
 IrOLHhLfdsz138BsuLmKEvejHkjVS4n7rWcglK7s/4tbe4vgZ9M66n0yFIH/pPlY9pbO2qzMU
 630+9ttHqe0XDw=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Sat, 13 Nov 2021, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
>
> name-rev has a MERGE_TRAVERSAL_WEIGHT to say that traversing a second or
> later parent of a merge should be 65535 times more expensive than a
> first-parent traversal, as per ac076c29ae8d (name-rev: Fix non-shortest
> description, 2007-08-27).  The point of this weight is to prefer names
> like
>
>     v2.32.0~1471^2
>
> over names like
>
>     v2.32.0~43^2~15^2~11^2~20^2~31^2
>
> which are two equally valid names in git.git for the same commit.  Note
> that the first follows 1472 parent traversals compared to a mere 125 for
> the second.  Weighting all traversals equally would clearly prefer the
> second name since it has fewer parent traversals, but humans aren't
> going to be traversing commits and they tend to have an easier time
> digesting names with fewer segments.  The fact that the former only has
> two segments (~1471, ^2) makes it much simpler than the latter which has
> six segments (~43, ^2, ~15, etc.).  Since name-rev is meant to "find
> symbolic names suitable for human digestion", we prefer fewer segments.
>
> However, the particular rule implemented in name-rev would actually
> prefer
>
>     v2.33.0-rc0~11^2~1
>
> over
>
>     v2.33.0-rc0~20^2
>
> because both have precisely one second parent traversal, and it gives
> the tie breaker to shortest number of total parent traversals.  Fewer
> segments is more important for human consumption than number of hops, so
> we'd rather see the latter which has one fewer segment.
>
> Include the generation in is_better_name() and use a new
> effective_distance() calculation so that we prefer fewer segments in
> the printed name over fewer total parent traversals performed to get the
> answer.

Thank you. As you most likely figured out, that magic weight was
introduced by me, in ac076c29ae8 (name-rev: Fix non-shortest description,
2007-08-27). And indeed the motivation was to keep the name as short as
possible.

Technically, your solution does not fix the problem fully, as we still do
not determine the _shortest possible_ name. Having said that, I think your
patch improves the situation dramatically, so: ACK!

Thanks,
Dscho

>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>     name-rev: prefer shorter names over following merges
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-11=
19%2Fnewren%2Fprefer-shorter-names-in-name-rev-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1119/=
newren/prefer-shorter-names-in-name-rev-v1
> Pull-Request: https://github.com/git/git/pull/1119
>
>  builtin/name-rev.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/name-rev.c b/builtin/name-rev.c
> index b221d300147..27f60153a6c 100644
> --- a/builtin/name-rev.c
> +++ b/builtin/name-rev.c
> @@ -44,11 +44,20 @@ static struct rev_name *get_commit_rev_name(const st=
ruct commit *commit)
>  	return is_valid_rev_name(name) ? name : NULL;
>  }
>
> +static int effective_distance(int distance, int generation)
> +{
> +	return distance + (generation > 0 ? MERGE_TRAVERSAL_WEIGHT : 0);
> +}
> +
>  static int is_better_name(struct rev_name *name,
>  			  timestamp_t taggerdate,
> +			  int generation,
>  			  int distance,
>  			  int from_tag)
>  {
> +	int name_distance =3D effective_distance(name->distance, name->generat=
ion);
> +	int new_distance =3D effective_distance(distance, generation);
> +
>  	/*
>  	 * When comparing names based on tags, prefer names
>  	 * based on the older tag, even if it is farther away.
> @@ -56,7 +65,7 @@ static int is_better_name(struct rev_name *name,
>  	if (from_tag && name->from_tag)
>  		return (name->taggerdate > taggerdate ||
>  			(name->taggerdate =3D=3D taggerdate &&
> -			 name->distance > distance));
> +			 name_distance > new_distance));
>
>  	/*
>  	 * We know that at least one of them is a non-tag at this point.
> @@ -69,8 +78,8 @@ static int is_better_name(struct rev_name *name,
>  	 * We are now looking at two non-tags.  Tiebreak to favor
>  	 * shorter hops.
>  	 */
> -	if (name->distance !=3D distance)
> -		return name->distance > distance;
> +	if (name_distance !=3D new_distance)
> +		return name_distance > new_distance;
>
>  	/* ... or tiebreak to favor older date */
>  	if (name->taggerdate !=3D taggerdate)
> @@ -88,7 +97,7 @@ static struct rev_name *create_or_update_name(struct c=
ommit *commit,
>  	struct rev_name *name =3D commit_rev_name_at(&rev_names, commit);
>
>  	if (is_valid_rev_name(name)) {
> -		if (!is_better_name(name, taggerdate, distance, from_tag))
> +		if (!is_better_name(name, taggerdate, generation, distance, from_tag)=
)
>  			return NULL;
>
>  		/*
>
> base-commit: 9d530dc0024503ab4218fe6c4395b8a0aa245478
> --
> gitgitgadget
>
