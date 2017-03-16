Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EE4C20323
	for <e@80x24.org>; Thu, 16 Mar 2017 22:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754426AbdCPW7n (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 18:59:43 -0400
Received: from mout.gmx.net ([212.227.17.20]:50319 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752582AbdCPW7m (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 18:59:42 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LwW8p-1c9Lio0t4h-018OFL; Thu, 16
 Mar 2017 23:59:37 +0100
Date:   Thu, 16 Mar 2017 23:59:35 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org
Subject: Re: sequencer "edit" command always issues a warning
In-Reply-To: <20170316131534.4vpbub3vmde7maua@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1703162358520.3767@virtualbox>
References: <20170316131534.4vpbub3vmde7maua@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:tju5ZHVDXbTp5P7YW9TOZQeMn84R9Nq7J8JFlvYXFgK1mwmfVT0
 59iSALg03UWOuOUYZZfbdf4mIEhq7mrwYjNjw60uqJtwlrFId5TBSwwGA7d4N6UdItJX2zx
 fzEGMtgFgD/b3BbJZO+3t0//eFjqkSKc91+rt67g3kr2riEaC2lcjvDwu1MHOaU0n6dqy0c
 mb1BUwjKRZQlwuLud/PxA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:32ZEgClytFU=:eG7jgJ4mw6qfCJUgg5rsw7
 Dww4QIlF8gb5cqpMT9/Q0+KZCa78mPGpxyu4UiqDQm92TQjzQz9jA2C5DtEpuSujMw5nrQ463
 7xH7fHA3Ri9rFnKOGA0ndd10KQ6J3Yr3xqsyZ/NiQrVAF/7zWax9i0jVTtMAJ710qQDFc6jtG
 3rcWzhSpTRKkdRQYW/snhUyLkDPnw8hvkUZ6ooQQqr8Xwl3Oyl3uD5YKd/MpX6cWDai0exCRp
 z5NZFPmK4G0PKBt3Y9nxpHVM1hmhrnrsZlIorUVIcGk4zXgRQTdhPPJ80XKcEy3/2KkOWqr2c
 qxIKtycRY97DiAyWwfYdlnb6WrH1iEuAgnwHkVYOBnMuvIYdSSb7qIImOcw+24/PeM3Yj0i2e
 8U1k4HKVBHADPj1pdpvtmdtsFht7WGah+YJ6FAg7YKLOEPpuJ+Diib6P+947G+KKJjPT8Yyrn
 TssZJmA6B2DAcEaHUchTGmmiUnW5CgJ5A8sRfsSMIIQ8GaRYsSGQSKFtls54MK+zO75M6wO/n
 zZl3dcb0p/52TnJRx/AXAbRDAon7M/mM2e3u9nAew1Jkw/ZKO/CtnRfUOt0iFLwnFDhVyh9M1
 e4Tq7tiCZfrvgdQ7CQZuCJJbnl/cA/unk1H/JAaVDS5CON38IH97plMQ0zfaHy371Af2CMOHL
 zd73dXAD6V0X2+y8+wW3XuqNpFC3m4+xjqtf4hzpzzBZNDgWYHclRINCWdFMbxunEN1kMULuD
 SabYlbR5z7vi3z5bq7mllaY02k6sdybusvVXTC6YKwkHAiEQndB4kIQmyoS+EPCSEIj4CPlu0
 +h61BXq+gFY8eLi1uUi2WyuMXXliA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Thu, 16 Mar 2017, Jeff King wrote:

> I was rebasing with the new built-in sequencer code today, and I was
> surprised to see the use of warning() here:
> 
>   $ git rebase -i
>   [set one commit to 'edit']
>   warning: stopped at 6ce6b914a... odb_pack_keep(): stop generating keepfile name
>   You can amend the commit now, with
>     [...more instructions...]
> 
> It alarmed me for a minute until I realized that no, this is nothing to
> be alarmed about, but just git doing exactly what I told it to do.
> 
> The original just wrote:
> 
>   Stopped at 6ce6b914a... odb_pack_keep(): stop generating keepfile name
> 
> It would be easy to switch back:
> 
> diff --git a/sequencer.c b/sequencer.c
> index 1f729b053..8183a83c1 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1997,7 +1997,8 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
>  			if (item->command == TODO_EDIT) {
>  				struct commit *commit = item->commit;
>  				if (!res)
> -					warning(_("stopped at %s... %.*s"),
> +					fprintf(stderr,
> +						_("Stopped at %s...  %.*s"),
>  						short_commit_name(commit),
>  						item->arg_len, item->arg);
>  				return error_with_patch(commit,
> 
> and that would match most of the other messages that the command issues,
> which use a bare fprintf() and start with a capital letter. But I'm not
> sure if there was some reason to treat this one differently.

I do not recall why I chose warning(); probably just an oversight on my
part. Your patch looks good.

Ciao,
Dscho
