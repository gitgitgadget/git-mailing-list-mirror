Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AC0F1F516
	for <e@80x24.org>; Thu, 21 Jun 2018 10:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932883AbeFUKih (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 06:38:37 -0400
Received: from mout.gmx.net ([212.227.17.22]:55209 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932303AbeFUKig (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 06:38:36 -0400
Received: from [192.168.0.129] ([37.201.195.106]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MVZuV-1fhMSW0nFP-00YwFH; Thu, 21
 Jun 2018 12:38:31 +0200
Date:   Thu, 21 Jun 2018 12:38:41 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Alban Gruin <alban.gruin@gmail.com>
cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        phillip.wood@dunelm.org.uk, Elijah Newren <newren@gmail.com>
Subject: Re: [GSoC][PATCH v2 3/3] rebase -i: rewrite checkout_onto() in C
In-Reply-To: <20180619154421.14999-4-alban.gruin@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1806211236350.11870@tvgsbejvaqbjf.bet>
References: <20180618131844.13408-1-alban.gruin@gmail.com> <20180619154421.14999-1-alban.gruin@gmail.com> <20180619154421.14999-4-alban.gruin@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Yf0dU43py07UZeagAeEvmGLxzoWiwULic9VDuZo9NKiQCdZE5pi
 acXCYs02kYfY0UoWhq3zI6rtO6HlbReysjeqS3nw2qda6EtAwNJw1ysEvTaKSwJML+aUfup
 OF0n4Gzd9UbfPba2cDdLk16pJcEyXnDfnk84HjIgjuw+iXy8cXoX7uGMU+pt2TzPQWJycv+
 eETjv2BXv2L1vrZQ5gqnw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4+4IbGLEofo=:QsnBm6L2VIneYa184JYp/A
 d9vp0yXb5bnYavf2KZR80LrB3pt+3dSN47MxClH46V6MCDRlKTrsFzsydUErRCsBMkQ9BHc8i
 6qHfGNte+vDxPW0gp1BXTq4efpW8VDkA3Qt0snlDPpD9pOFqXx8PFEBa4lDTfz7BoLNjKEccB
 /XqHQydHzaIcwbhnSDJuDry1A1otAmLb3agpseMbdT2nmUKZkH4rFV8C8hyKernqakISE6axx
 eFXTl0/UQlVOyTY6sJyjNJHJPqmbdibuh25HrfnLOAx3/RqHgCs9f3H56MnebG3qXw8QlZwe4
 Ip5ry7p7UySpeRWTU07UDen9iiym5vzJN/Iaj8Q8IGhV5LDzAvTM4845mtm71+o8mwZDT5UtJ
 16+1OTA2mSD0GRtq1mwo2SqFL+ispUZmv8dt6Y1AoQRtxOLUovh4OmUjepg8p0RPwm25AphOm
 ujmS83+IrL0EIA8znucj+m9W8PjZeJKFNz/tBj3R54rLZnR+YafcxhqV0HyxSNDz01y90gsqg
 xtWNZSPvE7ZjWRoVScUKo1nvUlNxQ0hWi+cJNy2vLDl/NuxlImiHVqGMZbBeqo7e3K/rW8nEI
 Vh1YkobkTrhnGqvHKXU5wsf72MEE81glShZlu/B14vm1rxuU68fxI1R+ekit+YmP235t1ecI3
 +MHlAN1JqXCIlErEOPRVtfO7IKfqM+tytlhOjbBKONZYFKu8GeaWmTeqnT/Anmk62R0PoRWGb
 TJZDVXso/CymZjmS3vHdxRocVwJaJETYaDkdoEPN5pAMod4GZsRcuDKvm48LC9r1bk6E0hz6W
 3rzLrjm
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban,

On Tue, 19 Jun 2018, Alban Gruin wrote:

> diff --git a/sequencer.c b/sequencer.c
> index a7a73e3ef..9165bf96c 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -3161,6 +3161,25 @@ int checkout_base_commit(struct replay_opts *opts, const char *commit,
>  	return 0;
>  }
>  
> +int checkout_onto(struct replay_opts *opts,
> +		  const char *onto_name, const char *onto,
> +		  const char *orig_head, unsigned verbose)
> +{
> +	struct object_id oid;
> +	const char *action = reflog_message(opts, "start", "checkout %s", onto_name);
> +
> +	if (get_oid(orig_head, &oid))
> +		return error(_("%s: not a valid OID"), orig_head);
> +
> +	if (run_git_checkout(opts, onto, verbose, action)) {

Ah, so this is the reason for the split.

If you send a new iteration of this patch series, could you do me a favor
and add a paragraph to the commit message of 2/3, saying something like
this: "The function `run_git_checkout()` will be used on its own in the
next commit, therefore the code is not folded into
`checkout_base_commit()`? That way, I do not have to burden my working
memory with this bit of information ;-)

Thanks,
Dscho
