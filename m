Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CF6420248
	for <e@80x24.org>; Tue, 12 Mar 2019 22:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfCLWgO (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 18:36:14 -0400
Received: from mout.gmx.net ([212.227.15.18]:45135 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726384AbfCLWgN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 18:36:13 -0400
Received: from [192.168.0.129] ([37.201.195.16]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M8m7Q-1hBVW903wK-00CAAB; Tue, 12
 Mar 2019 23:36:01 +0100
Date:   Tue, 12 Mar 2019 23:35:44 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Thomas Gummerer <t.gummerer@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Matthew Kraai <mkraai@its.jnj.com>
Subject: Re: [PATCH v2] stash: pass pathspec as pointer
In-Reply-To: <20190311221624.GC16414@hank.intra.tgummerer.com>
Message-ID: <nycvar.QRO.7.76.6.1903122323460.41@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.1902191127420.41@tvgsbejvaqbjf.bet> <20190225231631.30507-1-t.gummerer@gmail.com> <20190225231631.30507-19-t.gummerer@gmail.com> <20190307191836.GB29221@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1903081630040.41@tvgsbejvaqbjf.bet>
 <20190309182610.GD31533@hank.intra.tgummerer.com> <xmqqimwqmbba.fsf@gitster-ct.c.googlers.com> <xmqqd0mxkgvy.fsf@gitster-ct.c.googlers.com> <20190311214244.GB16414@hank.intra.tgummerer.com> <20190311221624.GC16414@hank.intra.tgummerer.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:pJZ2VS5SLM4YMcrZaoqTXbpNe3DKPQ1+YkSXIAX2WzrVheJGmjH
 n1brfonrY8wwO9dZKI+Hk3MYjlykZoxebvN98/BA4q0VvEZxlCRyv6XAA6+bWICnryOsJYT
 RFsSzgHXD27L3Ml52O391qQVlOsRcPCI5iGlKsmNlTO+UjXNwrgLAxHPVNpxGJEu+AEarqV
 P387QvvCYvWIqPMQZT3mw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:i9m0pOXAE/8=:DfGUHxlA0AYmWc5RouK0L5
 sLGNNwNETrxYgTC/YuAw7eU51PW4lcMhyZGrPp2011BE5gnmT+Kz9gmJSbpFoEY/aoYUcHoye
 9nDaiDiJnRFT4OJJ7oMgwYXbxDz2Eg6+xfAUWDXHWdiIcJO+Wm9IFRkKgjXTH2y8owBRxR0Y8
 okAm3WLgY7L67/AGFn6qo+rUmtpAdlfRApS6frRs1YsJNESrh6rYFUZerTHzREGV2zMr36k/I
 X7Sc/+xvs6g1lF+dVrLqCz2TuIPkRqWvVFL0UQFChr2aJs+VgkzngNVFI68rTp/A3ucAg6Kbv
 l4yVRD4iv4+UOQg0wy+tMn9LIOXD1FVplcoc4eU77OzJgMVY6qU4NLNS/TxIIsS6z/tgsbukE
 VK8FyrR10ctw9St+/vS7HiKGn9VhO5Nl36YFMgMhktIAuOG1KPMIrkji9N+zyFooKsBoU552U
 TTnReXaRXqUIlhrE2WZBFzG1P7VA0gM1IF0ielfPJYyol3+LgOsOScmnQRjNw9C4oxE1giyBQ
 Ch6BE2RXT4wFe+oFFHAtJNF1DxXM5kIdGyyiLgcVCiQrFhnScVAB+eLFkPPzfhLemPVMgaSBT
 TP5WoJrOlJsJzrm6CRtRAAO5TK2zigftoP9hrz7fu9Y9QC75yWtQM7JnEgB71yiErbSJjAz4/
 +StEZdbDqBYGsv7X3VRUTAVmtawB4lDx5e9/vJxCXV5gEF32AwaoFkxp1ucKc4pzmxqcag5bA
 kk4o7j6rvZZr97nIkaENc8G0bKN30R16zx0sQCiuT7nNuJVrTQf/rP617YYg0kiL+5nYURFdd
 6V1fId1mcPKLsbgzDru0TMq6KKZBOqq9yqSD6ugklyzrwf65b+NSFfWTDglUNA+jpWe9MFHXz
 +/rVv8VmH3tgADM5wVkYs8Y9LC+F24wDQRdKlJntZZV/DvUUlmjfKre1o1n05cBlwKhAIxmwn
 eDTqbdl25ew==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Thomas,

On Mon, 11 Mar 2019, Thomas Gummerer wrote:

> Passing the pathspec by value is potentially confusing, as the copy is
> only a shallow copy, so save the overhead of the copy, and pass the
> pathspec struct as a pointer.

Not only confusing, but also wasteful ;-)

> In addition use copy_pathspec to copy the pathspec into
> rev.prune_data, so the copy is a proper deep copy, and owned by the
> revision API, as that's what the API expects.

Good.

> [...]
> diff --git a/builtin/stash.c b/builtin/stash.c
> index 2f29d037c8..e0528d4cc8 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -826,11 +826,11 @@ static int store_stash(int argc, const char **argv, const char *prefix)
>  }
>  
>  static void add_pathspecs(struct argv_array *args,
> -			  struct pathspec ps) {
> +			  const struct pathspec *ps) {

I see that you added the `const` keyword. While it does not hurt, I would
probably not have bothered...

> [...]
> @@ -1042,6 +1049,7 @@ static int stash_working_tree(struct stash_info *info, struct pathspec ps)
>  	struct index_state istate = { NULL };
>  
>  	init_revisions(&rev, NULL);
> +	copy_pathspec(&rev.prune_data, ps);

This moved here... because...

>  
>  	set_alternate_index_output(stash_index_path.buf);
>  	if (reset_tree(&info->i_tree, 0, 0)) {

... this `if` block could jump to...


> @@ -1050,7 +1058,6 @@ static int stash_working_tree(struct stash_info *info, struct pathspec ps)
>  	}
>  	set_alternate_index_output(NULL);
>  
> -	rev.prune_data = ps;
>  	rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
>  	rev.diffopt.format_callback = add_diff_to_buf;
>  	rev.diffopt.format_callback_data = &diff_output;
> @@ -1089,12 +1096,13 @@ static int stash_working_tree(struct stash_info *info, struct pathspec ps)

... this point (the `done:` label is *just* one line further up, and this
is a static diff, so we cannot just increase the context when we need to
see more, unlike, say, GitHub PRs) and...

>  	discard_index(&istate);
>  	UNLEAK(rev);
>  	object_array_clear(&rev.pending);
> +	clear_pathspec(&rev.prune_data);

... we add this call here.

However, we would not have needed to move the initialization of
`rev.prune_data`, I don't think, because `init_revision()` zeros the
entire struct, including `prune_data`, which would have made
`clear_pathspec()` safe to call, too.

Both of my comments need no action, and the rest of the patch looks good
to me.

Thank you for going through this!
Dscho
