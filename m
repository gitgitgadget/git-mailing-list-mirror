Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57D0F1F404
	for <e@80x24.org>; Wed, 28 Mar 2018 17:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753071AbeC1RrB (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 13:47:01 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:43108 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753054AbeC1RrA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 13:47:00 -0400
Received: by mail-pf0-f175.google.com with SMTP id j2so1285855pff.10
        for <git@vger.kernel.org>; Wed, 28 Mar 2018 10:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ReTylJ/T0PN7pdwP9KIpFXXraVfsiKY3F2Dr6Zzyr/Y=;
        b=H7Twp+p/WPoIE8Zp8ZRaUYubnuEpKu2p9EByyXFIGKQd2teHYHAexNubldHDu/+gsa
         rd6ClcLAjkcaK/mFdHpv3umPEukJbjHyxqll1SzKXWQ+EJia00ywmJi5K7AqqT3E9boW
         vtDTFZmk91x39l7uJsLoI5Yz7iwW3BD6TfOuiy87EWUgoYyhxGQgx3Cek+eGow8t3PxB
         8dK0Ekb4379yQIO1fe69tgIDQxRGhSpr1ghnyzg/64s1/KywLEBVFBxzzdNGu3787wjn
         sLF5PJZCCHfj8tDTdz/g5pn+g822ZWVuNYTNlrJKzo3aXRa4DLTmhPGZsocv+d+Uy6Ke
         3hFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ReTylJ/T0PN7pdwP9KIpFXXraVfsiKY3F2Dr6Zzyr/Y=;
        b=QvPfogCpBaRqAXzuaYvPQsla4Ni/naDWaVwkUe1cMQSxdPSBNlBEOOJae9sqy029wB
         BuN3nFSnmdXxWP/LzyhmdpIn5HS5+qbHy1SzIC6KbvcIYNZH6jwO/cY7D3FFQqEui30/
         07ZfzsKFNmyC5OWlTKXwBd6e2ir4FLlLkKkBDVBNpwZxfZWxHaNRxrYisBqRqY34KMp0
         H8EoNIK7HzHagHDcEudiBPAJUKn0JLpEwyevXcHrYVMmoI3IcLztQcXY9Sz+GAVkO1Sd
         z5Zz4eYrgsgeKkpQmw9KJPSp6iEwpryjCSBT9wCR+T0QKNLF+TXmsiMjwzHgMKF68Y99
         c1MA==
X-Gm-Message-State: AElRT7GfKujMKtqpzEkH06lGvWpyt2qOmjy2HJCpQC3CoiVLvW0fGpjT
        pYD7M+Yl5GuVtJadKgocsQQHWQ==
X-Google-Smtp-Source: AIpwx4+WbydSdI8QW0sk+A5KkwpI+vBrh8KXmBX5yGeVMTpOVDQkJeVkkaxpzrSLDNYS4bQZP6MhWg==
X-Received: by 10.99.164.18 with SMTP id c18mr3190761pgf.85.1522259219459;
        Wed, 28 Mar 2018 10:46:59 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id e125sm7992687pgc.76.2018.03.28.10.46.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Mar 2018 10:46:58 -0700 (PDT)
Date:   Wed, 28 Mar 2018 10:46:57 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, bmwill@google.com, git@vger.kernel.org,
        hvoigt@hvoigt.net, seanwbehan@riseup.net
Subject: Re: [PATCH 5/6] submodule: fixup nested submodules after moving the
 submodule
Message-Id: <20180328104657.2396071270905628fd2fdca3@google.com>
In-Reply-To: <20180328172449.27012-6-sbeller@google.com>
References: <CAGZ79kaQYjepND8EdgB73meBsShOc5aBporiK2Bo40fqcar0gg@mail.gmail.com>
        <20180328172449.27012-1-sbeller@google.com>
        <20180328172449.27012-6-sbeller@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 28 Mar 2018 10:24:48 -0700
Stefan Beller <sbeller@google.com> wrote:

> +static void connect_wt_gitdir_in_nested(const char *sub_worktree,
> +					const char *sub_gitdir)
> +{
> +	int i;
> +	struct repository subrepo;
> +	struct strbuf sub_wt = STRBUF_INIT;
> +	struct strbuf sub_gd = STRBUF_INIT;
> +
> +	const struct submodule *sub;
> +
> +	if (repo_init(&subrepo, sub_gitdir, sub_worktree))
> +		return;

If repo_init() fails, is it because the working tree doesn't exist on
disk, so we don't need to perform any connections on submodules? I think
a comment should be added to describe this.

> +
> +	if (repo_read_index(&subrepo) < 0)
> +		die("index file corrupt in repo %s", subrepo.gitdir);
> +
> +	for (i = 0; i < subrepo.index->cache_nr; i++) {
> +		const struct cache_entry *ce = subrepo.index->cache[i];
> +
> +		if (!S_ISGITLINK(ce->ce_mode))
> +			continue;
> +
> +		while (i + 1 < subrepo.index->cache_nr &&
> +		       !strcmp(ce->name, subrepo.index->cache[i + 1]->name))
> +			/*
> +			 * Skip entries with the same name in different stages
> +			 * to make sure an entry is returned only once.
> +			 */
> +			i++;
> +
> +		sub = submodule_from_path(&subrepo, &null_oid, ce->name);
> +		if (!sub)
> +			/* submodule not checked out? */
> +			continue;
> +
> +		if (is_submodule_active(&subrepo, ce->name)) {

Optional: This could be combined with the previous "if" block, so that
the following lines don't need to be indented.

> +			strbuf_addf(&sub_wt, "%s/%s", sub_worktree, sub->path);
> +			strbuf_addf(&sub_gd, "%s/modules/%s", sub_gitdir, sub->name);
> +
> +			connect_work_tree_and_git_dir(sub_wt.buf, sub_gd.buf, 0);
> +			connect_wt_gitdir_in_nested(sub_wt.buf, sub_gd.buf);

What's the difference between having this call to
connect_wt_gitdir_in_nested() and just passing 1 instead of 0 to
connect_work_tree_and_git_dir()? I see that the latter uses absolute
paths, but that would seem to have the same effect. (If not, I think a
comment is warranted.)

> +
> +			strbuf_reset(&sub_wt);
> +			strbuf_reset(&sub_gd);

I think we normally write the resets before the strbuf_addf(), so that
it's clearer that sub_wt and sub_gd are meant to start from scratch in
every iteration.

Overall, this version of the patch is clearer - thanks.
