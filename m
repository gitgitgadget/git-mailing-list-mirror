Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEEAB20248
	for <e@80x24.org>; Fri, 29 Mar 2019 15:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729042AbfC2Pv5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 11:51:57 -0400
Received: from mout.gmx.net ([212.227.15.15]:35701 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728902AbfC2Pv5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 11:51:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1553874710;
        bh=iiwiwp8eFIa8IqebnM2PyPwLkaGhW0UI+2seQ3cCOZI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=QrNYYUFuUlXtKnkVbW69TO8xkEkExsSj5mS5edSu8SZXLxegyJnCwUdj2p5/mLx8e
         vwrQe0HMe4y3Wxmy4FfI8H+pelqB5KyiIAFoCgw3uQ2S/TDcY236eLHM9T6hdhS0yj
         LjVRSyPLnQcwssLB3OX1c+kDdVMBdaB62dbamjNo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Ln7wj-1gTNpw3K9t-00hPUi; Fri, 29
 Mar 2019 16:51:49 +0100
Date:   Fri, 29 Mar 2019 16:51:50 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH] sequencer: fix cleanup with --signoff and -x
In-Reply-To: <20190329110842.30604-1-phillip.wood123@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1903291651340.41@tvgsbejvaqbjf.bet>
References: <20190329110842.30604-1-phillip.wood123@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:DJdaXWPTxm1GTFhys07Z4z3o/dMkK3rzHFWiOR7kWCtPOtH+4So
 5R5XQx4jt9q0O0X8rqDUP+liFxcKDV2XNW9w4+t2oZe0nMfIuNtdeY8KXqvLT3GPehnzqS1
 ByNEqCDYMLaMhxon81SOKbBEkzBOQWiaNEfNeb4boJb8kvqLe7GXH7GoEYmChEof+IPYdv4
 GUQNgmbkPgAc+YfmjxDYA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pgTXJAHHLR8=:A+LDSMmMj9g8EyBv7j7L76
 2+v+I0EJjlTGgQyhc1+Odbe2PCbFexkr1ZXPFTJzyd8PdVlOMgl3tfKCHOSt+D8Qre2NZGI/l
 LTswmS5sEgnpeW1uZqpvtnGT07+qdsn3rns8pOXLf8gggudKyCuj5mkSarwG7EHIVhzRw+I0q
 1DK74J1NxM1q+1hpVxoB0d1ao1y0/WpNT+rid3NwU03uW5wTGE6QYHtwEqgpGGwHAozxYoehh
 iFHzKcfOiF9hoeVUikqIERCFxsIMTcawQb8FZpt6mz8qO+vlCDZj0ElNKcYsf3wJ6WqRerBM2
 Gip4QZxjAG9A4i+FHr7n4XhwD8YCrOSGhCWedD8OC5R9j6FXW43M5eOkh8Isnp1JDJieX6+XI
 QQ3B4qz/VchBxKKSOEqPmZKZXa504XH+WHkO44JF63AOcMQixulkvEDlK/KR5gWWmvI08mrbE
 MUgw8sE7Isv6QwGPFPWh2vP05/aYYfa+1kMgjdGR8e/+9BhXe9dMu0q4O4eZ00wIMwf420asQ
 yDkqnoJt58pXOq0kPDLluHPlXPTJJ1H3FwKDnzIRU3YDAm3seW9pS2fPSQhNBs/Goc7ELq2xf
 YWShoCTSvuDd1/c33ArIM4XwULQ9fZLRPanLaiXsabuQh3ySpA7lyETVg5dvNDseYGUEkwoP6
 5yt4MDZvx2oR44hDdVJZC0AMLBOL8N3Bjy/ayg62eXaxADPmGK3W1x2JxT66SiKVYxUcqTi2W
 EhYUNPRyT8dSkAl4SS9aJsaYcV0g3dA+vsdXigWcxcGtq9yTkqbDEq4LrJZ95OGlejKdt/w3E
 VljNBjGqaY5oMs5uB5lSQyyO1jiFvM0cLYzEcZl8pARvdaNagDhwEN9GPwKmkovYAA5KGnWLx
 9tjb4O/VWL4hfP7CJfeByoQWd2AfNbbwH/eu5gl72Veo9TIsy6HnK9ng/dkG7/y9xbDFRRKPQ
 j0hfPS7amfA==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Fri, 29 Mar 2019, Phillip Wood wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Before commit 356ee4659b ("sequencer: try to commit without forking 'git
> commit'", 2017-11-24) when --signoff or -x were given on the command
> line the commit message was cleaned up with --cleanup=3Dspace or
> commit.cleanup if it was set. Unfortunately this behavior was lost when
> I implemented committing without forking. Fix this and add some tests to
> catch future regressions.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---

Looks good to me!

Thank you,
Dscho

>
> This clashes with dl/merge-cleanup-scissors-fix, I've sent some
> rebased patches to Denton and he's going to send a re-roll based on
> those.
>
>  sequencer.c              | 24 +++++++++++++++++-------
>  sequencer.h              |  1 +
>  t/t3511-cherry-pick-x.sh | 20 ++++++++++++++++++++
>  3 files changed, 38 insertions(+), 7 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index 0db410d590..15457bbe71 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -172,17 +172,22 @@ static int git_sequencer_config(const char *k, con=
st char *v, void *cb)
>  		if (status)
>  			return status;
>
> -		if (!strcmp(s, "verbatim"))
> +		if (!strcmp(s, "verbatim")) {
>  			opts->default_msg_cleanup =3D COMMIT_MSG_CLEANUP_NONE;
> -		else if (!strcmp(s, "whitespace"))
> +			opts->explicit_cleanup =3D 1;
> +		} else if (!strcmp(s, "whitespace")) {
>  			opts->default_msg_cleanup =3D COMMIT_MSG_CLEANUP_SPACE;
> -		else if (!strcmp(s, "strip"))
> +			opts->explicit_cleanup =3D 1;
> +		} else if (!strcmp(s, "strip")) {
>  			opts->default_msg_cleanup =3D COMMIT_MSG_CLEANUP_ALL;
> -		else if (!strcmp(s, "scissors"))
> +			opts->explicit_cleanup =3D 1;
> +		} else if (!strcmp(s, "scissors")) {
>  			opts->default_msg_cleanup =3D COMMIT_MSG_CLEANUP_SPACE;
> -		else
> +			opts->explicit_cleanup =3D 1;
> +		} else {
>  			warning(_("invalid commit message cleanup mode '%s'"),
>  				  s);
> +		}
>
>  		free((char *)s);
>  		return status;
> @@ -1382,8 +1387,13 @@ static int try_to_commit(struct repository *r,
>  		msg =3D &commit_msg;
>  	}
>
> -	cleanup =3D (flags & CLEANUP_MSG) ? COMMIT_MSG_CLEANUP_ALL :
> -					  opts->default_msg_cleanup;
> +	if (flags & CLEANUP_MSG)
> +		cleanup =3D COMMIT_MSG_CLEANUP_ALL;
> +	else if ((opts->signoff || opts->record_origin) &&
> +		 !opts->explicit_cleanup)
> +		cleanup =3D COMMIT_MSG_CLEANUP_SPACE;
> +	else
> +		cleanup =3D opts->default_msg_cleanup;
>
>  	if (cleanup !=3D COMMIT_MSG_CLEANUP_NONE)
>  		strbuf_stripspace(msg, cleanup =3D=3D COMMIT_MSG_CLEANUP_ALL);
> diff --git a/sequencer.h b/sequencer.h
> index 4d505b3590..82bc7a48d5 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -47,6 +47,7 @@ struct replay_opts {
>
>  	char *gpg_sign;
>  	enum commit_msg_cleanup_mode default_msg_cleanup;
> +	int explicit_cleanup;
>
>  	/* Merge strategy */
>  	char *strategy;
> diff --git a/t/t3511-cherry-pick-x.sh b/t/t3511-cherry-pick-x.sh
> index 9888bf34b9..84a587daf3 100755
> --- a/t/t3511-cherry-pick-x.sh
> +++ b/t/t3511-cherry-pick-x.sh
> @@ -298,4 +298,24 @@ test_expect_success 'cherry-pick preserves commit m=
essage' '
>  	test_cmp expect actual
>  '
>
> +test_expect_success 'cherry-pick -x cleans commit message' '
> +	pristine_detach initial &&
> +	git cherry-pick -x mesg-unclean &&
> +	git log -1 --pretty=3Dformat:%B >actual &&
> +	printf "%s\n(cherry picked from commit %s)\n" \
> +		"$mesg_unclean" $(git rev-parse mesg-unclean) |
> +			git stripspace >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'cherry-pick -x respects commit.cleanup' '
> +	pristine_detach initial &&
> +	git -c commit.cleanup=3Dstrip cherry-pick -x mesg-unclean &&
> +	git log -1 --pretty=3Dformat:%B >actual &&
> +	printf "%s\n(cherry picked from commit %s)\n" \
> +		"$mesg_unclean" $(git rev-parse mesg-unclean) |
> +			git stripspace -s >expect &&
> +	test_cmp expect actual
> +'
> +
>  test_done
> --
> 2.21.0
>
>
