Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 253971F6C1
	for <e@80x24.org>; Mon, 29 Aug 2016 07:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932213AbcH2HDQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 03:03:16 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:37304 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755936AbcH2HC6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 03:02:58 -0400
Received: by mail-wm0-f51.google.com with SMTP id i5so75918810wmg.0
        for <git@vger.kernel.org>; Mon, 29 Aug 2016 00:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wopITz1WD91DrFnUuZhmrob20JrvuV65IueCFu8jGAc=;
        b=CHbTv3TtioYYXFW4nupeQQyEI7+oHJ38Se+l7L4fmfWObsph007ajLiR5CTewfTlM3
         o3S0e7XxhT2JfnYyg6b+SmEtpUHyo8HKfmyLkNCiukrHvAslAU4VpywLJORSmFScXLB2
         VP4Vsp0HYAIJ7hCt4dRg9/wSum3jrYgURBf1bCoC2tIsMBmB/LTxAaNPeduiTzuzCQMk
         bHe2pxfO1X2sAg2gbM6zIA5uFmHBoNUI4az+ZqQdtHWoNN9yRtJj9/PYqLQcvcfqKjhj
         1FEQuwT0oKs8Zq4PAsaG++1UZv1cZcTSwJaifE6S21J3/BqrdCWelPj2r90+q4VRk5JX
         4q/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wopITz1WD91DrFnUuZhmrob20JrvuV65IueCFu8jGAc=;
        b=h8gHPvJbnhh03GxOmgZYYJ9WRPq1lWyHGWk42Nl6HUCrqfe0C3qMk+hx17vqdbMDfU
         dWUm6XUoUrGVr6PdMSnOcYvLLyNmT9uc7VUFRs3Dh6itdgpV5qUtH2GDv6wyjcX0oKRL
         DJgsFGpa9MPhU4q8/EDTNgJ4ckdaRW02yv+mWJgQEuu4B6g8rTnWPLMrFhW7QU7IAEqA
         R5f6uKwWmy2lcPBK/+8x0PdcnzDsPju/Z4hAWEC05LIi1d9ET9b//w1f4Rq4xPoBrJ50
         KKCyZA72qfxEJTHoLrbdA3Jm/d/a0JgY6WsfL2ddtvBxW4gHsG9K7hK6GKH0HJgwqOXX
         ndSw==
X-Gm-Message-State: AE9vXwPcOHiErPmn/mDwZFJx8JIdjnLrq9E2nw7TffWB5Od4E4V5j8ok/3fNQAc1OCq8pAVcbT0M9v5zo2/LSA==
X-Received: by 10.28.22.70 with SMTP id 67mr9224339wmw.52.1472454177196; Mon,
 29 Aug 2016 00:02:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.224.213 with HTTP; Mon, 29 Aug 2016 00:02:56 -0700 (PDT)
In-Reply-To: <20160828232757.373278-19-sandals@crustytoothpaste.net>
References: <20160828232757.373278-1-sandals@crustytoothpaste.net> <20160828232757.373278-19-sandals@crustytoothpaste.net>
From:   Paul Tan <pyokagan@gmail.com>
Date:   Mon, 29 Aug 2016 15:02:56 +0800
Message-ID: <CACRoPnQvdq3xaRF9niU-b0qLxVCvmbpv2_roxUaEaDFftt7_wQ@mail.gmail.com>
Subject: Re: [PATCH 18/20] builtin/am: convert to struct object_id
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brian,

On Mon, Aug 29, 2016 at 7:27 AM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  builtin/am.c | 138 +++++++++++++++++++++++++++++------------------------------
>  1 file changed, 69 insertions(+), 69 deletions(-)

I looked through this patch, and the conversion looks faithful and
straightforward to me. Just two minor comments:

> diff --git a/builtin/am.c b/builtin/am.c
> index 739b34dc..632d4288 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -1053,10 +1053,10 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
>         else
>                 write_state_text(state, "applying", "");
>
> -       if (!get_sha1("HEAD", curr_head)) {
> -               write_state_text(state, "abort-safety", sha1_to_hex(curr_head));
> +       if (!get_oid("HEAD", &curr_head)) {
> +               write_state_text(state, "abort-safety", oid_to_hex(&curr_head));
>                 if (!state->rebasing)
> -                       update_ref("am", "ORIG_HEAD", curr_head, NULL, 0,
> +                       update_ref("am", "ORIG_HEAD", curr_head.hash, NULL, 0,
>                                         UPDATE_REFS_DIE_ON_ERR);

I noticed that you used update_ref_oid() in other places of this
patch. Perhaps this should use update_ref_oid() as well for
consistency?

> @@ -1665,9 +1665,8 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
>   */
>  static void do_commit(const struct am_state *state)
>  {
> -       unsigned char tree[GIT_SHA1_RAWSZ], parent[GIT_SHA1_RAWSZ],
> -                     commit[GIT_SHA1_RAWSZ];
> -       unsigned char *ptr;
> +       struct object_id tree, parent, commit;
> +       struct object_id *ptr;

Ah, I just noticed that this is a very poorly named variable. Whoops.
Since we are here, should we rename this to something like "old_oid"?
Also, this should probably be a "const struct object_id *" as well, I
think.

Thanks,
Paul
