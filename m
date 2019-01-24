Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89B941F453
	for <e@80x24.org>; Thu, 24 Jan 2019 18:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbfAXS6F (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 13:58:05 -0500
Received: from goldenrod.birch.relay.mailchannels.net ([23.83.209.74]:41051
        "EHLO goldenrod.birch.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725913AbfAXS6E (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 24 Jan 2019 13:58:04 -0500
X-Sender-Id: dreamhost|x-authsender|novalis@novalis.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id C7B9C502960;
        Thu, 24 Jan 2019 18:58:02 +0000 (UTC)
Received: from pdx1-sub0-mail-a72.g.dreamhost.com (unknown [100.96.26.166])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 7DF27501EF1;
        Thu, 24 Jan 2019 18:58:02 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|novalis@novalis.org
Received: from pdx1-sub0-mail-a72.g.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.16.2);
        Thu, 24 Jan 2019 18:58:02 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|novalis@novalis.org
X-MailChannels-Auth-Id: dreamhost
X-Fumbling-Cooing: 5067eaee1cf3b834_1548356282668_2163026199
X-MC-Loop-Signature: 1548356282668:3592354457
X-MC-Ingress-Time: 1548356282668
Received: from pdx1-sub0-mail-a72.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a72.g.dreamhost.com (Postfix) with ESMTP id 4745281DB3;
        Thu, 24 Jan 2019 10:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=message-id
        :subject:from:to:cc:date:in-reply-to:references:content-type
        :mime-version:content-transfer-encoding; s=novalis.org; bh=mJZuF
        J1rpGxlhaPXB7kBibHr56I=; b=ChNXXCGjdCuOi2UdmPKGM5cgpbHeOoueV9yJZ
        xCi3zCAb3oUjXpPvrBVqmh5T4ucmkWyfGv4LLp99a2tV8JvP+9rV0Q9DVmaib8h/
        FcStgLQTRTQdXbjk4TI65ElepmiT+ypTDHpLf0i9GwoGKDhOh7aBjwfPn55/6OLe
        ta9e2E=
Received: from corey (unknown [38.27.161.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by pdx1-sub0-mail-a72.g.dreamhost.com (Postfix) with ESMTPSA id 963FD81DC1;
        Thu, 24 Jan 2019 10:58:01 -0800 (PST)
Message-ID: <f2a7e88a9b2f8fc014d4b945b8c9b489c6236436.camel@novalis.org>
Subject: Re: [PATCH 4/6] combine-diff: treat --shortstat like --stat
X-DH-BACKEND: pdx1-sub0-mail-a72
From:   David Turner <novalis@novalis.org>
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Date:   Thu, 24 Jan 2019 13:58:00 -0500
In-Reply-To: <20190124123450.GD11354@sigill.intra.peff.net>
References: <20190124122603.GA10415@sigill.intra.peff.net>
         <20190124123450.GD11354@sigill.intra.peff.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-VR-OUT-STATUS: OK
X-VR-OUT-SCORE: -100
X-VR-OUT-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtledriedvgdduudekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuggftfghnshhusghstghrihgsvgdpffftgfetoffjqffuvfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomhepffgrvhhiugcuvfhurhhnvghruceonhhovhgrlhhishesnhhovhgrlhhishdrohhrgheqnecukfhppeefkedrvdejrdduiedurddujeenucfrrghrrghmpehmohguvgepshhmthhppdhhvghloheptghorhgvhidpihhnvghtpeefkedrvdejrdduiedurddujedprhgvthhurhhnqdhprghthhepffgrvhhiugcuvfhurhhnvghruceonhhovhgrlhhishesnhhovhgrlhhishdrohhrgheqpdhmrghilhhfrhhomhepnhhovhgrlhhishesnhhovhgrlhhishdrohhrghdpnhhrtghpthhtohepshgsvghllhgvrhesghhoohhglhgvrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the fix here.

On Thu, 2019-01-24 at 07:34 -0500, Jeff King wrote:
> The --stat of a combined diff is defined as the first-parent stat,
> going all the way back to 965f803c32 (combine-diff: show diffstat
> with
> the first parent., 2006-04-17).
> 
> Naturally, we gave --numstat the same treatment in 74e2abe5b7 (diff
> --numstat, 2006-10-12).
> 
> But --shortstat, which is really just the final line of --stat, does
> nothing, which produces confusing results:
> 
>   $ git show --oneline --stat eab7584e37
>   eab7584e37 Merge branch 'en/show-ref-doc-fix'
> 
>    Documentation/git-show-ref.txt | 2 +-
>    1 file changed, 1 insertion(+), 1 deletion(-)
> 
>   $ git show --oneline --shortstat eab7584e37
>   eab7584e37 Merge branch 'en/show-ref-doc-fix'
> 
>   [nothing! We'd expect to see the "1 file changed..." line]
> 
> This patch teaches combine-diff to treats the two formats
> identically.
> 
> Reported-by: David Turner <novalis@novalis.org>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  combine-diff.c                                 | 1 +
>  t/t4013-diff-various.sh                        | 1 +
>  t/t4013/diff.diff-tree_--cc_--shortstat_master | 4 ++++
>  3 files changed, 6 insertions(+)
>  create mode 100644 t/t4013/diff.diff-tree_--cc_--shortstat_master
> 
> diff --git a/combine-diff.c b/combine-diff.c
> index b1d259d5a0..83ec3dfffa 100644
> --- a/combine-diff.c
> +++ b/combine-diff.c
> @@ -1325,6 +1325,7 @@ static const char *path_path(void *obj)
>   * Diff stat formats which we always compute solely against the
> first parent.
>   */
>  #define STAT_FORMAT_MASK (DIFF_FORMAT_NUMSTAT \
> +			  | DIFF_FORMAT_SHORTSTAT \
>  			  | DIFF_FORMAT_DIFFSTAT)
>  
>  /* find set of paths that every parent touches */
> diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
> index 7d985ff6b1..9ccdf08730 100755
> --- a/t/t4013-diff-various.sh
> +++ b/t/t4013-diff-various.sh
> @@ -239,6 +239,7 @@ diff-tree --cc --stat --summary master
>  # stat summary should show the diffstat and summary with the first
> parent
>  diff-tree -c --stat --summary side
>  diff-tree --cc --stat --summary side
> +diff-tree --cc --shortstat master
>  # improved by Timo's patch
>  diff-tree --cc --patch-with-stat master
>  # improved by Timo's patch
> diff --git a/t/t4013/diff.diff-tree_--cc_--shortstat_master
> b/t/t4013/diff.diff-tree_--cc_--shortstat_master
> new file mode 100644
> index 0000000000..a4ca42df2a
> --- /dev/null
> +++ b/t/t4013/diff.diff-tree_--cc_--shortstat_master
> @@ -0,0 +1,4 @@
> +$ git diff-tree --cc --shortstat master
> +59d314ad6f356dd08601a4cd5e530381da3e3c64
> + 2 files changed, 5 insertions(+)
> +$

