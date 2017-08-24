Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B7CC20285
	for <e@80x24.org>; Thu, 24 Aug 2017 14:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753146AbdHXONz (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Aug 2017 10:13:55 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37129 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753111AbdHXONx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2017 10:13:53 -0400
Received: by mail-wm0-f65.google.com with SMTP id v186so2933379wmf.4
        for <git@vger.kernel.org>; Thu, 24 Aug 2017 07:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=oH4xZwrqFqiJaUesxnyTv8MIaGZE3840zEz1hbKpPKg=;
        b=NHALWHDvFQVzVsS+JOEPn8Cuunls7nuPxifziN/IKb3I8EOuTZ9E3Y9RhySZyc5BPa
         xHkcvoF542v+Z6DmNN3HXvu/DPokeEpeJ7kquQDYYCAuBUjclzDrW4sSycFatk/DJT/h
         LZLzgZl/ftLnWAJn+bTI92RFBMih0ji5lymG+KIe/2zaFYhgrHFO64vZCYKsZJye3Llz
         JxXDiZEySC2v2LPAkG6JaEs8aD0krgT41Rc9qiDX52JRkTw55gyCUzaqw4jnwMSandB6
         /S8vLuNsTXiPoB/PkEv/skBi/6bdwXjfRHaqC85iD9nTP7g4T4Ory71L8NSppalBF10w
         /14A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=oH4xZwrqFqiJaUesxnyTv8MIaGZE3840zEz1hbKpPKg=;
        b=lzv965JnrYXd2UZXbqQop8gIuq9M6z65WlfuxYIeT2YQ0FiXhYN1UFUTxnCyOEPgoY
         JMd/YO87LRx9xb297LnHylDfXN+uJ5QokgO6vYk3aLgvKUgrTWv0au+eZq/nW3naVjLN
         7an8ilvprdcqF0MG6dZ76ZvAWMB8xoKyW4RLW+w3OeVocQuPBDpEt7Ycdc2vP1MrLkQJ
         Gflq1CpI9u4fzoWgGfirJWIFPnVAj1/l3QpfIyltWTfnQaw7MJ9eSCxMEmrAOEplAil1
         bVpBSMAzerrJN/XlZShiTGzC9IbvogeWxlWlQogWWD6mvjkInrY7cygkjYggQM2MoPeL
         zULg==
X-Gm-Message-State: AHYfb5hsD9Ptabv1Faev0IfU5jZtLWHm9LFT3JRiS2R/KsP9vMqFgaKs
        jXgLdRWTzV1MOWbM
X-Received: by 10.28.99.7 with SMTP id x7mr128332wmb.59.1503584032510;
        Thu, 24 Aug 2017 07:13:52 -0700 (PDT)
Received: from mimir ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id s86sm5923514wma.10.2017.08.24.07.13.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Aug 2017 07:13:50 -0700 (PDT)
Date:   Thu, 24 Aug 2017 15:13:48 +0100
From:   Richard Maw <richard.maw@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v4 12/16] files-backend: make reflog iterator go through
 per-worktree reflog
Message-ID: <20170824141348.GC2021@mimir>
References: <20170823123704.16518-1-pclouds@gmail.com>
 <20170823123704.16518-13-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170823123704.16518-13-pclouds@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 23, 2017 at 07:37:00PM +0700, Nguyễn Thái Ngọc Duy wrote:
> refs/bisect is unfortunately per-worktree, so we need to look in
> per-worktree logs/refs/bisect in addition to per-repo logs/refs. The
> current iterator only goes through per-repo logs/refs.
> 
> Use merge iterator to walk two ref stores at the same time and pick
> per-worktree refs from the right iterator.
> 
> PS. Note the unsorted order of for_each_reflog in the test. This is
> supposed to be OK, for now. If we enforce order on for_each_reflog()
> then some more work will be required.
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  refs/files-backend.c          | 59 +++++++++++++++++++++++++++++++++----------
>  t/t1407-worktree-ref-store.sh | 30 ++++++++++++++++++++++
>  2 files changed, 75 insertions(+), 14 deletions(-)
> 
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 5cca55510b..d4d22882ef 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -2055,23 +2046,63 @@ static struct ref_iterator_vtable files_reflog_iterator_vtable = {
<snip>
> +static struct ref_iterator *files_reflog_iterator_begin(struct ref_store *ref_store)
> +{
> +	struct files_ref_store *refs =
> +		files_downcast(ref_store, REF_STORE_READ,
> +			       "reflog_iterator_begin");
> +
> +	if (!strcmp(refs->gitdir, refs->gitcommondir)) {
> +		return reflog_iterator_begin(ref_store, refs->gitcommondir);
> +	} else {
> +		return merge_ref_iterator_begin(
> +			reflog_iterator_begin(ref_store, refs->gitdir),
> +			reflog_iterator_begin(ref_store, refs->gitcommondir),
> +			reflog_iterator_select, refs);
> +	}
> +}
> +
>  /*
>   * If update is a direct update of head_ref (the reference pointed to
>   * by HEAD), then add an extra REF_LOG_ONLY update for HEAD.

Whilst trying to use ref backends to implement ref namespaces
one of the issues I had was that namespaced bisect refs weren't being found.

This turned out to be for the same reason their reflogs weren't found,
that by only iterating through the commondir refs it was missing the gitdir ones
and that it only worked normally because of a special case in loose_fill_ref_dir


        /*
         * Manually add refs/bisect, which, being per-worktree, might
         * not appear in the directory listing for refs/ in the main
         * repo.
         */
        if (!strcmp(dirname, "refs/")) {
                int pos = search_ref_dir(dir, "refs/bisect/", 12);

                if (pos < 0) {
                        struct ref_entry *child_entry = create_dir_entry(
                                        dir->cache, "refs/bisect/", 12, 1);
                        add_entry_to_dir(dir, child_entry);
                }
        }

If files_ref_iterator_begin was made to use a merged or overlay ref iterator too
then this special case could be removed and bisecting in a namespaced workspace
would work.

I've yet to work out whether namespaced bisect refs makes sense,
but that's a problem for the next time I have time to work on it :).
