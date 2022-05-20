Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17405C433F5
	for <git@archiver.kernel.org>; Fri, 20 May 2022 18:33:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343770AbiETSdY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 14:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349121AbiETSdW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 14:33:22 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228FF6B7D9
        for <git@vger.kernel.org>; Fri, 20 May 2022 11:33:19 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id e15so9588159iob.3
        for <git@vger.kernel.org>; Fri, 20 May 2022 11:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3WgNYeBlbldv4JcQxcCqNuc1nueacsb9prjxF82s8hE=;
        b=OkSXyfTiSUqvAR8pFYCXdadkhBcbMwq3IOwgXdwiygnRQgEKCH6yx/Uo5mcNYZn5yw
         z2gFXT9oX5g9pzxDLDPUTUpU7a3Uvk1XpeMENgcoSN24zG6wDRcyPonwrIY/63CS2vPd
         NRqmV3rKeR/u4dEtyf+psncUqJT3qjUe8TZI6VPL6iJ/Cter5ZskmRLAzUNHy0ELWGqQ
         YIBDXlC2XzffyCRwU0slAN04aWwg41NnNHB1I/PWIxz+6DKDEeCro9radJuefyBp970D
         yOgX8kg7r9EY4M9H9L+viKav7QqT9yd/8KLcHqFn+zM8tFaQUVZiqKTBKeCWbIAPuRke
         RwLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3WgNYeBlbldv4JcQxcCqNuc1nueacsb9prjxF82s8hE=;
        b=irdzhD378xUsFZpcLzvMR8jpNYkhunESEBSimuI1xvc433OrTeX3B9dYk6XYn6Rhbs
         DNeyd8A9ceCaRFZqy/Ej2gI7QbLed6sPttnXF1xtOiBEqor93tn0MDxhXE3sdPmy6mtL
         YTqwAtKJ0mTUc0br1fKFMhys4TgXix2X1ccY8Ddm8samYCPs1d0SekqTX1eC46umZd/f
         QD8L2KLC6jmhzGuF+wlqtRPUtlH/RvevuR3X7f0HchMzbBccRdvJPVcCHmeyNGsVCtr0
         AtzDpA3c/Shy+gTOObWAEQESWjU2nJkt83dVYS7z81ZZy+ypM1/y8h0y/r4IQkZljacK
         w1Bg==
X-Gm-Message-State: AOAM532eRVZ7GcJ/ED/fnhcHl+c9rBDYcZr8+VPB929hnhAXA4m9kiiY
        Yth7oGIymcuL1dZuWMUM6SpE
X-Google-Smtp-Source: ABdhPJxZb/0gtdM+MSPHDbEfAhG/FVmGA2XY1igU3TYoGFLk3MVNNEw0lobASd6+kYTPdoYvCuMo1g==
X-Received: by 2002:a05:6602:1510:b0:65a:edd4:cdb4 with SMTP id g16-20020a056602151000b0065aedd4cdb4mr5476429iow.143.1653071598418;
        Fri, 20 May 2022 11:33:18 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:34b9:84ab:204:3752? ([2600:1700:e72:80a0:34b9:84ab:204:3752])
        by smtp.gmail.com with ESMTPSA id c18-20020a928e12000000b002d18e9deff4sm39180ild.53.2022.05.20.11.33.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 11:33:18 -0700 (PDT)
Message-ID: <8c093377-74f7-0a1e-fbcc-8a1aedfe3fca@github.com>
Date:   Fri, 20 May 2022 14:33:17 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 07/10] sparse-index: partially expand directories
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com, shaoxuan.yuan02@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1208.git.1652724693.gitgitgadget@gmail.com>
 <pull.1208.v2.git.1652982758.gitgitgadget@gmail.com>
 <346c56bf2560c5a89850ef4f8a58fbe17cde10fc.1652982759.git.gitgitgadget@gmail.com>
 <xmqqbkvshxvn.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqbkvshxvn.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/20/2022 2:17 PM, Junio C Hamano wrote:> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> @@ -231,18 +236,41 @@ static int add_path_to_index(const struct object_id *oid,
>>  			     struct strbuf *base, const char *path,
>>  			     unsigned int mode, void *context)
>>  {
> 
> OK, this function is a callback of read_tree_at(), whose caller is
> walking the source (=current) index, and while it is copying
> existing non-directory entries to the destination (=ctx->write)
> index, it found a tree in the source in-core index that does not
> match the cone pattern (or we are expanding fully).  Our job is to
> expand the given tree as a "subdirectory" in the project into the
> destination index.
> 
> We used to just let the calling read_tree_at() fully and recursively
> walk the tree while adding any non-tree entries to the destination.
> Now, we have the pattern list in the context, we go more selective.
> 
> The design makes sense.
> 
>> +	struct modify_index_context *ctx = (struct modify_index_context *)context;
>>  	struct cache_entry *ce;
>>  	size_t len = base->len;
>>  
>> +	if (S_ISDIR(mode)) {
>> +		int dtype;
>> +		size_t baselen = base->len;
>> +		if (!ctx->pl)
>> +			return READ_TREE_RECURSIVE;
> 
> Fully recursive case.  We can do without any match, just like the
> caller (i.e. expand_to_pattern_list) did, when the pattern list is
> NULL.
> 
>> +		/*
>> +		 * Have we expanded to a point outside of the sparse-checkout?
>> +		 */
>> +		strbuf_addstr(base, path);
>> +		strbuf_add(base, "/-", 2);
>> +
>> +		if (path_matches_pattern_list(base->buf, base->len,
>> +					      NULL, &dtype,
>> +					      ctx->pl, ctx->write)) {
> 
> If that sample path in the directory matches (MATCHED or
> MATCHED_RECURSIVE) the patterns, we recurse into the tree to expand.
> 
> Can the function return UNDECIDED here?  If so what should happen?
> As written, the code will behave as if it matched, and it is not
> quite clear if that is the behaviour intended by this patch or an
> accident.

UNDECIDED can only be returned when not in cone mode. We are in cone mode
when this helper is used.

>> +			strbuf_setlen(base, baselen);
>> +			return READ_TREE_RECURSIVE;
>> +		}
> 
> The caller found a tree at path <path> in the index.  We check if
> our patterns match a fictitious path <path> + "/-", which may exist
> if the <path> is a directory and if there is a funny named file or
> directory "-" in it.
> 
> Why "-"?  Are we trying ot see if "ctx->pl" matches "anything" in
> the directory that is at <path>?  Is the assumption here that pl
> only names directories literally without blobs (I presume that is
> the same thing as assuming the cone mode)?
> 
> I am trying to see if there is a way that expresses the intention of
> this code more clearly than using an arbitrary path "-" (and trying
> to figure out if I got the intention right in the first place ;-)..

The '+ "/-"' is there to give us an example file path for "<path>" as a
directory. This is specifically because path_matches_pattern_list() checks
the parent directories for matches, expecting the input to be a file name.

This could use a comment. I'm thinking...

/*
 * Have we expanded to a point outside of the sparse-checkout?
 *
 * Artificially pad the path name with a slash "/" to
 * indicate it as a directory, and add an arbitrary file
 * name ("-") so we can consider base->buf as a file name
 * to match against the cone-mode patterns.
 *
 * If we compared just "path", then we would expand more
 * than we should. Since every file at root is always
 * included, we would expand every directory at root at
 * least one level deep instead of using sparse directory
 * entries.
 */

>> +		/*
>> +		 * The path "{base}{path}/" is a sparse directory. Create the correct
>> +		 * name for inserting the entry into the index.
>> +		 */
>> +		strbuf_setlen(base, base->len - 1);
> 
> This removes that phoney "-" while keeping the trailing "/".  Just
> like "-" was unclear, understanding this "- 1" requires that the
> reader understands why "/-" was used earlier.
> 
> The resulting "base" is used in the newly created cache entry to
> represent the (unexpanded) directory below, and such a cache entry
> is supposed to have a path with a trailing slash, so it makes sense.
> 
>> +	} else {
>> +		strbuf_addstr(base, path);
> 
> For any non-tree thing, we use the given path for the cache entry to
> represent it.
> 
>> +	}
>> +
>> +	ce = make_cache_entry(ctx->write, mode, oid, base->buf, 0, 0);
>>  	ce->ce_flags |= CE_SKIP_WORKTREE | CE_EXTENDED;
>> -	set_index_entry(istate, istate->cache_nr++, ce);
>> +	set_index_entry(ctx->write, ctx->write->cache_nr++, ce);
> 
> And the cache entry (newly created) is added to the destination.
> Unlike what happens in the caller (i.e. expand_to_pattern_list) that
> moves the cache entry taken from the source index to the destination
> index, the caller will discard the cache entry taken from the source
> index after read_tree_at() returns, and we create a new instance for
> ourselves here, even if we _could_ have reused it (by passing it in
> the context structure, for example).
> 
>>  	strbuf_setlen(base, len);
> 
> And we restore the length of the path in the base to the original
> before we return.
> 
>>  	return 0;
> 
> Returning 0 as opposed to READ_TREE_RECURSIVE here means "we've
> dealt with the entry; don't recurse into subtree even if you called
> us with a tree", which is the right thing to do here, as we did have
> done all we need to here.
> 
> OK, except for that "/-" thing, all of the above makes sense to me.

Thanks for your careful read. Hopefully my explanation of the "/-" thing
helps.

Thanks,
-Stolee
