Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C50C43334
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 18:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbiGSSB0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 14:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiGSSBY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 14:01:24 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B098E5246D
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 11:01:23 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id p8so2886029plq.13
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 11:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xowtibaFnNqJ4KmMxeirjut4FjeIpn6H7BMk5xRpetc=;
        b=GnNaVU5/5R7EARWm/oFmG1pCBzrkivH3z0wTBhcAFZ/8Aao5cZHN15fEq8Bkox3P1U
         ypXLD88sK5bkiI2vjiBEMMbR9jZyb1JaDYKOYLiY7OKACQFD1ozFlukE8jpDkXOMgyOY
         8mL8It9+sF4JhuU1Mjlflo2xl5UL7qN1BYXl2PcG5eG6zKmuMrWfjiedy7H5hWqT/qG4
         5WLGU6cVss/EMEH2hKDLuzBASIOy4On15/Wqq+xI2i4xroGP+0t4SybFmkSEgE7gvDEt
         Dq4dN18hhZbdByzKAJha09Opx5I2o01T5grV19Sp5aw9jZWCRY2dyrKI2ngo+ykPnKGg
         k8aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xowtibaFnNqJ4KmMxeirjut4FjeIpn6H7BMk5xRpetc=;
        b=JosqlP+vUfv/Z1vRiQbYAPBDV4+xy97ynyowuksisHjcTn0DVCgE85Wbwg04DLcg8n
         6MCS12ibt6YehePizad1IjBet3HPG1BnBtZ8FEhc7cCCUpaqE0GYIFtvV05lT312pq0t
         72pkFOTl3GBNvSKd06zFYeSAmkgTiEGO4mA0xNs9n0tmNwDKSkBH+wZyD/quLg2HN9CC
         M2C5mwL4DmDg3mcvWbFEqjPCQ0Ayq0WbKmBIzEffa0R3vNS//SCKYiBu1RrtkngWc3pH
         D9nqOR3I6ayW+mFt3vaoZpuUK5y4XOoeGIjZk3o7VsodU6IrcHKEYGXmw4GBiUqY1WDZ
         xT+g==
X-Gm-Message-State: AJIora9dOfbAzFzafDFvkQ6c55Lk/SUEKW4jadzjKGQ/oCagDOaUPZGN
        sotXaF77543XTvVL8NEe+ptn
X-Google-Smtp-Source: AGRyM1vHy5orPQXRmyG92tMoM+PcCLmXWCuNQQeaz2YPR/8hjsfETLE+psyE3d8GbiYHE/doup+AzA==
X-Received: by 2002:a17:902:ab0e:b0:16d:e87:ce8d with SMTP id ik14-20020a170902ab0e00b0016d0e87ce8dmr3571529plb.53.1658253683152;
        Tue, 19 Jul 2022 11:01:23 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id d22-20020aa797b6000000b0051c49fb62b7sm11766320pfq.165.2022.07.19.11.01.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 11:01:22 -0700 (PDT)
Message-ID: <6188fab7-df5e-b3fb-92a2-47039254ac45@github.com>
Date:   Tue, 19 Jul 2022 11:01:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v1 2/7] mv: add documentation for check_dir_in_index()
Content-Language: en-US
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>, git@vger.kernel.org
Cc:     derrickstolee@github.com, gitster@pobox.com
References: <20220719132809.409247-1-shaoxuan.yuan02@gmail.com>
 <20220719132809.409247-3-shaoxuan.yuan02@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <20220719132809.409247-3-shaoxuan.yuan02@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shaoxuan Yuan wrote:
> Using check_dir_in_index without checking if the directory is on-disk
> could get a false positive for partially sparsified directory.
> 
> Add a note in the documentation to warn potential user.
> 
> Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
> ---
>  builtin/mv.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/builtin/mv.c b/builtin/mv.c
> index 4729bb1a1a..c8b9069db8 100644
> --- a/builtin/mv.c
> +++ b/builtin/mv.c
> @@ -132,6 +132,11 @@ static int index_range_of_same_dir(const char *src, int length,
>   * Return 0 if such directory exist (i.e. with any of its contained files not
>   * marked with CE_SKIP_WORKTREE, the directory would be present in working tree).
>   * Return 1 otherwise.
> + *
> + * Note: *always* check the directory is not on-disk before this function
> + * (i.e. using lstat());
> + * otherwise it may return a false positive for a partially sparsified
> + * directory.

To me, a comment like this indicates that either the function is not doing
what it should be doing, or its name doesn't properly describe the
function's behavior.

Per the function description:

	Check if an out-of-cone directory should be in the index. Imagine
	this case that all the files under a directory are marked with
	'CE_SKIP_WORKTREE' bit and thus the directory is sparsified.

But neither the name of the function ('check_dir_in_index') nor the
function's behavior (hence the comment you're adding here) match that
description.

Since this function is intended to verify that a directory 1) exists in the
index, and 2) is *entirely* sparse, I have two suggestions:

* Change the description to specify that the non-existence of the directory
  on disk is an *assumption*, not an opportunity for a "false positive."
  It's a subtle distinction, but it clarifies that the function should be
  used only when the caller already knows the directory is empty. For
  example:

	/*
	 * Given the path of a directory that does not exist on-disk, check whether the
	 * directory contains any entries in the index with the SKIP_WORKTREE flag 
	 * enabled.
	 *
	 * Return 1 if such index entries exist.
	 * Return 0 otherwise.
	 */

* 'check_dir_in_index' doesn't reflect the "is not on disk" prerequisite, so
  the function name can be updated to clarify that (e.g.,
  'empty_dir_has_sparse_contents')

>   */
>  static int check_dir_in_index(const char *name)
>  {

