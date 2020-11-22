Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB5BC56202
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 09:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E6E72075A
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 09:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="liZ36Dyh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbgKWJV6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 04:21:58 -0500
Received: from mout.gmx.net ([212.227.17.21]:53587 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726716AbgKWJV6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 04:21:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606123312;
        bh=YqALqC8gglEeAj9alpmOFh7BaYgbIQpFQzBRBZDJHLk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=liZ36DyhkmJAcm7KNro6Bc6c4vR7QAw0/i1IUFXTJDzv3TJ8s2DlB8RQ63qpTyal+
         7fErLaK1Zf3D77N4HqA2PIJ/9YA2vU+UxaLEozcxTSdgnFfl95em+OdMRkC0N/TC3B
         2IYizaWTbTdWpwJtbjj+XSsZyeEFcYy6Z1yAWoJY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.22.105] ([89.1.213.133]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MTRMi-1koiDz3i7Y-00Tmzf; Mon, 23
 Nov 2020 10:21:51 +0100
Date:   Sun, 22 Nov 2020 20:00:28 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Peter Hadlaw <hadlawp@gmail.com>, git@vger.kernel.org
Subject: Re: Re* Keeping the original init.defaultBranch config value
In-Reply-To: <xmqqd00a36wc.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2011221958240.56@tvgsbejvaqbjf.bet>
References: <CABrPy+GrSB87mFm5tXsXkC+OKg6NBxUJA5b0NYsa18a8EbcrNw@mail.gmail.com> <xmqqd00a36wc.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:yzw5Xwsh8zncrWgronSNTv79nQBKFCDyfJKBAzhiBw9oivf/c78
 kciTEbIiFOZPmK4cKx95yGEGShojBQjn3N/SP9MtUvdY+s7Ru05hUrGR54tQplWPkolsj/i
 KC2mqo5uqWmAKEA60/M1uVudnBFjvHtFUguA3DEVfjS7I0EDpNki3CLIOPeLGIfQo+NE8Ky
 TT49sOWhp9fT1YQRmP8Iw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wSxzBnn9E28=:VwSs5cKHCgFW78AGOd7YlX
 G167++/cILvNFTgWnV81ngmvj6u1Q0woonrPfpSA35dev9BzmY4/h+JGX6GG6xVr0EbhLcd8G
 vbQEr7wfOgjqWG7kuvGnqWNR7zK5af30rouDWAaBDP3U3eslBQKIsHqLtZyKNnSSKG7sj6LZe
 9xCICPNqt7B6LD1++QY/UrogNHZkkzPfD/+Mn3jAnvt9584Mw9c3viSSylNXn3sgC6Znx24uF
 uouCbR2uxHuWlCVtyV6E5V1ooP1WNDHEfXvkh9/cIBRjHl/L4VnzYKv4qJh0/X4agqS9ES6f5
 XIOGUwj0NHk73gAsix3ZnTZJcJR1sxLqekLPOINNcPMWSy+da0QnJY74SWfpFlcuGusxmrfc0
 PEqKD5WhwvEU0KmQxh6kEgHcmYkgZ1lRwkX92e4iA1GxL7xxhBInyY6kQiHFi3F1EKAb9IaHN
 QvJLOOv7+x7fIc7ZjME3rZs0csEhdyECL+n2MgqTJ9vt5rIfqcBwM+Bgaze2t5I12PxSJcNCH
 OTP6S8dqYEAufvsaUFVkUe0W4T/lwadLHEPYqu2VwY71ob9Yr/hQsLXGc1h/M1j1K/tHH4VmH
 jDe40NUrBGgo7+hUiNBSfkism7CKGQGDw0y4pp70Qpx7GGnjoToR0YKlMPkn94DkjnWtihdWs
 JW4pMOmDX5BKqpDGVI11hWaSLRpwv69qo33JGZr5vEvWkiz4yxrrNBjwwXZcIYN40EWJ/1abC
 8WUhCxpbJsTMxSoVxwQVqXJJJmTqL7MX2EHsgSYXK3O4oXGzG7N2hzriH8KZpKTolDYrtioo3
 dHGrrD3O/FsTCQsxnrTgJoC7EmYYAtcD1AMXgK+9cQCWskToU5SoC/4JZuVptwkfDudHao+sb
 OgTDX067IEsiemYJCC/kS/LXIWYiybOHVU6CRFXfQ=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 18 Nov 2020, Junio C Hamano wrote:

> --- >8 ------ >8 ------ >8 --- cut here --- >8 ------ >8 ---
> Subject: "init" doc: mention the configurability more clearly
>
> Update the description for the '--initial-branch' option to mention
> that the historical default has been `master` and it can be
> configured to use any name.  When actual transition happens to
> another fixed name, say 'main', the description would further be
> updated to mention like:
>
> 	... fall back to the default name 'main', but it can be
> 	customized with the `init.defaultBranch` configuration
> 	variable.  Note that the default name historically was
> 	'master'.
>
> in order to help people who wonder why more mature projects or
> documentation tend not to say 'main'.
>
> While we are at it, stop referring to "HEAD file", which was a
> remnant from 2005 that talks too much about implementation detail.
> The most important fact is that the current branch is set to an
> unborn branch and not detached HEAD.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---

Just to make sure to mention it: I transmogrified this patch into
https://lore.kernel.org/git/1518387eaa95098707878459bc74bd5ef2179386.16060=
87406.git.gitgitgadget@gmail.com/

Thanks,
Dscho

>  Documentation/git-init.txt | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git i/Documentation/git-init.txt w/Documentation/git-init.txt
> index 59ecda6c17..62c7552a12 100644
> --- i/Documentation/git-init.txt
> +++ w/Documentation/git-init.txt
> @@ -20,8 +20,9 @@ DESCRIPTION
>
>  This command creates an empty Git repository - basically a `.git`
>  directory with subdirectories for `objects`, `refs/heads`,
> -`refs/tags`, and template files.  An initial `HEAD` file that
> -references the HEAD of the master branch is also created.
> +`refs/tags`, and template files.  An unborn branch (see the
> +`--initial-branch` option below for its name) is made to the current
> +branch.
>
>  If the `$GIT_DIR` environment variable is set then it specifies a path
>  to use instead of `./.git` for the base of the repository.
> @@ -73,8 +74,10 @@ If this is reinitialization, the repository will be m=
oved to the specified path.
>  -b <branch-name>::
>  --initial-branch=3D<branch-name>::
>
> -Use the specified name for the initial branch in the newly created repo=
sitory.
> -If not specified, fall back to the default name: `master`.
> +Use the specified name for the initial branch in the newly created
> +repository.  If not specified, fall back to the default name
> +'master', but it can be customized with the `init.defaultBranch`
> +configuration variable.
>
>  --shared[=3D(false|true|umask|group|all|world|everybody|0xxx)]::
>
> o
>
