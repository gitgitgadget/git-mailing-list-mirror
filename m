Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59418C19F28
	for <git@archiver.kernel.org>; Wed,  3 Aug 2022 14:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233932AbiHCOks (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Aug 2022 10:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbiHCOkq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Aug 2022 10:40:46 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8143264F
        for <git@vger.kernel.org>; Wed,  3 Aug 2022 07:40:45 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d16so1339726qtw.8
        for <git@vger.kernel.org>; Wed, 03 Aug 2022 07:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Cce+ZIvzQ2rWv0QzxLbDr896JS/hE8sHpd+YXbXEyu0=;
        b=aIorpIsHYo9DtYUvoEwA08sJwIDrjc81JZV4E4HlDqy+ZEJwo4ryTOvX+1czdi7ZaP
         oO6tiZ75x51U6PsiMwPE1MeDTTbUQ8P/Kr5SKVPvJyT6m9wEAfOMgilpV8cgywhnvVEK
         tmlz5cIHvYmFpiIzgF06Ep+PuU6k+QCg7yzocYhcvtLIFrk4SsDn4fDifA1HGsOPXZeW
         AZndTRQqkEYi1/U7eaFcHpRmpjO3A9D0Ww3jAuBtEDShZHcXatdrHuAG0WaJyeOeX3cW
         Ca7fF4pUGnMvl3GHixJ/e3pnCTnajvuoJI8cQwI95m6GOjyvMtkF34PECX654+3GHQwo
         H1lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Cce+ZIvzQ2rWv0QzxLbDr896JS/hE8sHpd+YXbXEyu0=;
        b=7w/1Wp7lyhcHMt7vItNdKDi6ludf5zJopslgsFk+yvFD23xmXfiHsAQsXeYoTxLh8A
         a4Bfojg8kxidv4T21/rskIV3CImVQAPyCVe82Y6c+lN5A/edlBCywlv1nXjcN7WPxyUV
         3uNFwkY5CnK6N35SApYQf8I6B95kKXQoTm52Uxw6yAqiyBlCY61JJ/s4s+fTe/HZHSH/
         FU5HlHNGfMMxjJg2MpqnzIEJq0aOVIOorspTS0kB+LQsihFs5YMIGSk3f7vwxHAwLRQO
         ODF/MD+SB15fyZwfLr3T6/fSuYCmhME+LGC9sWIQzPLd853zRiA8M37poDmXpkNMbPUG
         ZOEA==
X-Gm-Message-State: ACgBeo2FEoN8LgogRwtt9ct8y1NxAdD4o2sG5HCHmDd2PwCjs27nTlJ4
        /+qc2WlVclIpfO0eUdNXUdCi
X-Google-Smtp-Source: AA6agR5JYPwZWZuk95UtgV8YnU7/SP0MDLKIsmtOetzjoGdB6WZNwWXhhRqu4ce2b5Fce82s8N3csQ==
X-Received: by 2002:a05:622a:42:b0:33c:d71d:f6a5 with SMTP id y2-20020a05622a004200b0033cd71df6a5mr3870868qtw.52.1659537644831;
        Wed, 03 Aug 2022 07:40:44 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:d582:a76b:8dd3:e924? ([2600:1700:e72:80a0:d582:a76b:8dd3:e924])
        by smtp.gmail.com with ESMTPSA id bs8-20020a05620a470800b006a34a22bc60sm12808313qkb.9.2022.08.03.07.40.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 07:40:44 -0700 (PDT)
Message-ID: <475e8617-2adf-c75a-b697-d239dc4830b8@github.com>
Date:   Wed, 3 Aug 2022 10:40:42 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 3/4] rm: expand the index only when necessary
Content-Language: en-US
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>, git@vger.kernel.org
Cc:     vdye@github.com
References: <20220803045118.1243087-1-shaoxuan.yuan02@gmail.com>
 <20220803045118.1243087-4-shaoxuan.yuan02@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20220803045118.1243087-4-shaoxuan.yuan02@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/3/2022 12:51 AM, Shaoxuan Yuan wrote:
> Originally, rm a pathspec that is out-of-cone in a sparse-index
> environment, Git dies with "pathspec '<x>' did not match any files",
> mainly because it does not expand the index so nothing is matched.

This paragraph appears to be assuming that we've stopped expanding the
sparse index already. It might be worthwhile to rewrite this to say
"Before integrating 'git rm' with the sparse index, we need to..." or
something like that. 

> Remove the `ensure_full_index()` method so `git-rm` does not always
> expand the index when the expansion is unnecessary, i.e. when
> <pathspec> does not have any possibilities to match anything outside
> of sparse-checkout definition.
> 
> Expand the index when the <pathspec> needs an expanded index, i.e. the
> <pathspec> contains wildcard that may need a full-index or the
> <pathspec> is simply outside of sparse-checkout definition.
> 
> Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
> ---
>  builtin/rm.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/builtin/rm.c b/builtin/rm.c
> index 84a935a16e..58ed924f0d 100644
> --- a/builtin/rm.c
> +++ b/builtin/rm.c
> @@ -296,8 +296,9 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
>  
>  	seen = xcalloc(pathspec.nr, 1);
>  
> -	/* TODO: audit for interaction with sparse-index. */
> -	ensure_full_index(&the_index);
> +	if (pathspec_needs_expanded_index(&the_index, &pathspec))
> +		ensure_full_index(&the_index);
> +
>  	for (i = 0; i < active_nr; i++) {
>  		const struct cache_entry *ce = active_cache[i];

Looking back on the tests in patch 1, I don't see any tests that really
emphasize the kinds of pathspecs that could not ever integrate with the
sparse index. They are all of the form "folder1/*" or similar, making it
be something that could be seen as a prefix match. Such a pattern _could_
be integrated carefully with the sparse index.

Instead, something like `git rm "*/a"` would be much harder to integrate
with the sparse index. Could we add a test (in this patch) that checks
that kind of case. That would also help justify this as its own patch and
not squashed with patch 4.

Thanks,
-Stolee
