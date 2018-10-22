Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F92D1F453
	for <e@80x24.org>; Mon, 22 Oct 2018 09:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbeJVRu0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Oct 2018 13:50:26 -0400
Received: from mout.gmx.net ([212.227.15.18]:39723 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728062AbeJVRu0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Oct 2018 13:50:26 -0400
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lz4KW-1fasNC2ONE-014DBh; Mon, 22
 Oct 2018 11:32:38 +0200
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lz4KW-1fasNC2ONE-014DBh; Mon, 22
 Oct 2018 11:32:38 +0200
Date:   Mon, 22 Oct 2018 11:32:41 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Rajesh Madamanchi <rmadamanchi@gmail.com>
Subject: Re: [PATCH] receive: denyCurrentBranch=updateinstead should not
 blindly update
In-Reply-To: <xmqqpnw61qkg.fsf_-_@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1810221132190.4546@tvgsbejvaqbjf.bet>
References: <CANahLXm7O6scvLdaL6bm14d5oGM5Zp+S-rpQDo554ssagRFNoQ@mail.gmail.com>        <xmqqsh124wqb.fsf@gitster-ct.c.googlers.com>        <xmqq4ldi38u7.fsf@gitster-ct.c.googlers.com> <xmqqpnw61qkg.fsf_-_@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:gmtWGo9i5rNiwv5Gk74/jxQEYb50efykr52z6vpwPxfdiUQPKSx
 Hh0QVJJnwhU0Xn5NxfK4PiJLDxzDtLI1kCnnM6BwQd2ngmDTFf07g/sd9iRhbKQdVA2ifHj
 bIvXjGeuqw40cy+vGXCyYQVuMSFElyUMrWFKOiHXudArigyDvcZ7+wgbkz1AUEG5wmFRQJh
 w7xjLpcET/P3T5P6kZrZw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mykFBaY0lag=:32c9phHG1O/pQcNXliJXa8
 5JyGf/XjQnjsl88CicA0/9QzoU5ANMiFmbN9zT0rzFXmluWCELP9rk3/ibXCuKL5K/SwhekPc
 Gul56CRKmwVWsGT4F186XxYBzv2HEJf1ga2fUdabBmZRlNi3FVqFCkB1inXO1AnqfJqxS5/bR
 3CvYS4e78QMrLeml2vXEk6hdV/pB6DUtWOShypVF1u9ZmzjJH88oKYbVbqcPQICXKPyM9764E
 G1rvfN/0BsbuDqO2pE7cNFwdzv1O/9MIHi5sbkYGKjOeLZZvlx72VllYX2WPdo+DLIYO9weEx
 0D3nVgOBBhHPiLOWqw/OBeGTN/8qYykCqZpqmE472ogvNSJWuEIbt6WycZXy1+V1jfmN2Tk8f
 S4KULv2JV7rScfPoH+MfM4LVCnLHP4Z9XJApnep7JvsqaY4gn0pEYIHxdawh4PLbPEoU0m7IQ
 vzNU3YKM7/eS3ev/Wht2+R1ytRViW4nnH+rBahLai7EOJSMVV6cqt163diJfXxOw0LHh76ng5
 FHJ5zkSaXbfmF0dFOyBduA8kyoBVpBtd65kTK5nydMLTDGPLIFrDgwt94S5lDNyMipdTCnr3/
 45Vq/YwA6YHFpUhr/f407K6McQUirL4FzHZ5uP4f+idxfE2Dl6NJHoCqILagVY20MiHnvzL9j
 YJnOB+up0NZvTe6UX/fLLshHO34o+lyZunI4X25sV5gFF+olxxOTRveW0EiYaTlSQDNMS+Tbx
 aj1SAvIiP4c6D7LBExUcA8Vj+RymYWycONYTBObrfIrKi12DLh3q8p6L0aAOB+naKvWK3Y7O+
 oXslHCHDH/rPkBGKZK8vJrT47mfawdUVxT9I2bHWCPrjUsggvs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 19 Oct 2018, Junio C Hamano wrote:

> The handling of receive.denyCurrentBranch=updateInstead was added to
> a switch statement that handles other values of the variable, but
> all the other case arms only checked a condition to reject the
> attempted push, or let later logic in the same function to still
> intervene, so that a push that does not fast-forward (which is
> checked after the switch statement in question) is still rejected.
> 
> But the handling of updateInstead incorrectly took immediate effect,
> without giving other checks a chance to intervene.
> 
> Instead of calling update_worktree() that causes the side effect
> immediately, just note the fact that we will need to call the
> funciton later, and first give other checks chance to reject the
> request.  After the update-hook gets a chance to reject the push
> (which happens as the last step in a series of checks), call
> update_worktree() when we earlier detected the need to.

Nicely explained, and the patch looks good to me, too.

Thanks,
Dscho

> 
> Reported-by: Rajesh Madamanchi
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/receive-pack.c | 12 +++++++++---
>  t/t5516-fetch-push.sh  |  8 +++++++-
>  2 files changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 95740f4f0e..79ee320948 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -1026,6 +1026,7 @@ static const char *update(struct command *cmd, struct shallow_info *si)
>  	const char *ret;
>  	struct object_id *old_oid = &cmd->old_oid;
>  	struct object_id *new_oid = &cmd->new_oid;
> +	int do_update_worktree = 0;
>  
>  	/* only refs/... are allowed */
>  	if (!starts_with(name, "refs/") || check_refname_format(name + 5, 0)) {
> @@ -1051,9 +1052,8 @@ static const char *update(struct command *cmd, struct shallow_info *si)
>  				refuse_unconfigured_deny();
>  			return "branch is currently checked out";
>  		case DENY_UPDATE_INSTEAD:
> -			ret = update_worktree(new_oid->hash);
> -			if (ret)
> -				return ret;
> +			/* pass -- let other checks intervene first */
> +			do_update_worktree = 1;
>  			break;
>  		}
>  	}
> @@ -1118,6 +1118,12 @@ static const char *update(struct command *cmd, struct shallow_info *si)
>  		return "hook declined";
>  	}
>  
> +	if (do_update_worktree) {
> +		ret = update_worktree(new_oid->hash);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	if (is_null_oid(new_oid)) {
>  		struct strbuf err = STRBUF_INIT;
>  		if (!parse_object(the_repository, old_oid)) {
> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> index 7a8f56db53..7316365a24 100755
> --- a/t/t5516-fetch-push.sh
> +++ b/t/t5516-fetch-push.sh
> @@ -1577,7 +1577,13 @@ test_expect_success 'receive.denyCurrentBranch = updateInstead' '
>  		test $(git -C .. rev-parse master) = $(git rev-parse HEAD) &&
>  		git diff --quiet &&
>  		git diff --cached --quiet
> -	)
> +	) &&
> +
> +	# (6) updateInstead intervened by fast-forward check
> +	test_must_fail git push void master^:master &&
> +	test $(git -C void rev-parse HEAD) = $(git rev-parse master) &&
> +	git -C void diff --quiet &&
> +	git -C void diff --cached --quiet
>  '
>  
>  test_expect_success 'updateInstead with push-to-checkout hook' '
> -- 
> 2.19.1-450-ga4b8ab5363
> 
> 
