Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 169DE20281
	for <e@80x24.org>; Sat,  4 Nov 2017 07:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751751AbdKDHeX (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Nov 2017 03:34:23 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:47737 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751686AbdKDHeX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Nov 2017 03:34:23 -0400
Received: by mail-wm0-f45.google.com with SMTP id r196so5141633wmf.2
        for <git@vger.kernel.org>; Sat, 04 Nov 2017 00:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qc/IODqq4sBwi5WsPOjGLGOD5fZZ8FUv37PIbTS1vh4=;
        b=qiziyfkJZMgDxBkIGDp11KpfxMjJYVMAE1p/gCxZdGiBKY8o0HngH2zJchioYzOEB2
         kRQG6wZ7oaTRyBrYbbm8i6DWiA6veYvBu9H/67C2DIJH7GBr2XKl+UYdlVh2CQwTg2cC
         s27T3jYx1f2/NkDXqf7frL6GHTSpZNRhlAgPcNIM58JeECzlut1xzT43S3Ak7tYSaFUk
         t+47zbF5ImLty98uM+UdI3ZcM0PMdMg3I7BfKy0/yw8083WgprHIuTCXcdq9xdSaRZyY
         9PWk9J7RseCKbRnoBNd45b9yBTRGmBf5INp5CAePZ9t2RnoqXF5J0Npoo+2L5byeJabd
         +QDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qc/IODqq4sBwi5WsPOjGLGOD5fZZ8FUv37PIbTS1vh4=;
        b=ixRaOiE9ohJI4CD0JlZjwPaBn1Q/ZIED05oAjJsdzJWQVmrDdxdKFztDauLIIxuuNo
         Znl2b3f0YkteTzoO6hBh4vyrmJ1vVwuaOr+7C8mk7ww4IyrB21HVskKfdhFQES97dBP2
         4f9Tee62YZbI18gPH4+OqKEEpTw6CX1K9dLChAX5b51OpIylCYX8y+Gjlh5qEk//3297
         sfnvnpwuq5BSFHc6MUXPn8j30FvgWH1C/QlH92hheapo10ryNU40OtqqVM00gMKOZzit
         rhfztGKtNzhIPKQLyKD6Bjhi2QewCgrIWe0fVrALQX6/HmXcfBCq9SFa5Ke42g8couCR
         kGeQ==
X-Gm-Message-State: AJaThX702Bk3RnC1E9/gEgEgFlGopn08vQy7F0KdFC99VwjUqr0PFfAG
        9Af8k/04eVBWtkOT+MiRh2w=
X-Google-Smtp-Source: ABhQp+Qs2fxQpLIF8rcSh9as1VPiXiJNA4Z2MV+ZQaxZ92JKzx5ERlcdaXDveTsuMOy59z2Des/AfQ==
X-Received: by 10.80.164.196 with SMTP id x4mr3035342edb.191.1509780861666;
        Sat, 04 Nov 2017 00:34:21 -0700 (PDT)
Received: from [192.168.1.22] (101.154.108.93.rev.vodafone.pt. [93.108.154.101])
        by smtp.gmail.com with ESMTPSA id d30sm7577238ede.10.2017.11.04.00.34.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Nov 2017 00:34:21 -0700 (PDT)
Subject: Re: [PATCH v1 2/2] log: add option to choose which refs to decorate
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, me@ikke.info, hjemli@gmail.com,
        mhagger@alum.mit.edu, pclouds@gmail.com,
        ilari.liusvaara@elisanet.fi
References: <20171104004144.5975-1-rafa.almas@gmail.com>
 <20171104004144.5975-3-rafa.almas@gmail.com>
 <xmqq60aqn1ok.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?Rafael_Ascens=c3=a3o?= <rafa.almas@gmail.com>
Message-ID: <b0e3856b-e627-0d22-90da-3da1781f98b3@gmail.com>
Date:   Sat, 4 Nov 2017 07:34:20 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <xmqq60aqn1ok.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/11/17 03:49, Junio C Hamano wrote:
> Rafael Ascensão <rafa.almas@gmail.com> writes:
> 
>> Using `--exclude=<pattern>` can help mitigate that verboseness by
>> removing unnecessary 'branches' from the output. However, if the tip of
>> an excluded ref points to an ancestor of a non-excluded ref, git will
>> decorate it regardless.
> 
> Is this even relevant?  I think the above would only serve to
> confuse the readers.  --exclude, --branches, etc. are ways to
> specify what starting points "git log" history traversal should
> begin and has nothing to do with what set of refs are to be used to
> decorate the commits that are shown.  But the paragraph makes
> readers wonder if it might have any effect in some circumstances.
> 
>> With `--decorate-refs=<pattern>`, only refs that match <pattern> are
>> decorated while `--decorate-refs-exclude=<pattern>` allows to do the
>> reverse, remove ref decorations that match <pattern>
> 
> And "Only refs that match ... are decorated" is also confusing.  The
> thing is, refs are never decorated, they are used for decorating
> commits in the output from "git log".  For example, if you have 
> 
> 	---A---B---C---D
> 
> and B is at the tip of the 'master' branch, the output from "git log
> D" would decorate B with 'master', even if you do not say 'master'
> on the command line as the commit to start the traversal from. >
> Perhaps drop the irrelevant paragraph about "--exclude" and write
> something like this instead?
> 
> 	When "--decorate-refs=<pattern>" is given, only the refs
> 	that match the pattern is used in decoration.  The refs that
> 	match the pattern, when "--decorate-refs-exclude=<pattern>"
> 	is given, are never used in decoration.
> 

What you explained was the reason I mentioned that. Because some users 
were wrongfully trying to remove decorations by trying to exclude the 
starting points. But I agree this adds little value and can generate 
further confusion. I will remove that section.

>> Both can be used together but --decorate-refs-exclude patterns have
>> precedence over --decorate-refs patterns.
> 
> A reasonable and an easy-to-explain way to mix zero or more positive
> and zero or more negagive patterns that follows the convention used
> elsewhere in the system (e.g. how negative pathspecs work) is
> 
>   (1) if there is no positive pattern given, pretend as if an
>       inclusive default positive pattern was given;
> 
>   (2) for each candidate, reject it if it matches no positive
>       pattern, or if it matches any one of negative patterns.
> 
> For pathspecs, we use "everything" as the inclusive default positive
> pattern, I think, and for the set of refs used for decoration, a
> reasonable choice would also be to use "everything", which matches
> the current behaviour.
> 

That's a nice explanation that fits the current "--decorate-refs" behavior.

>> The pattern follows similar rules as `--glob` except it doesn't assume a
>> trailing '/*' if glob characters are missing.
> 
> Why should this be a special case that burdens users to remember one
> more rule?  Wouldn't users find "--decorate-refs=refs/tags" useful
> and it woulld be shorter and nicer than having to say "refs/tags/*"?
> 

I wanted to allow exact patterns like:
"--decorate-refs=refs/heads/master" and for that I disabled the flag 
that adds the trailing '/*' if no globs are found. As a side effect, I 
lost the shortcut.

Is adding a yet another flag that appends '/*' only if the pattern 
equals "refs/{heads,remotes,tags}" a good idea?

Because changing the default behavior of that function has implications 
on multiple commands which I think shouldn't change. But at the same 
time, would be nice to have the logic that deals with glob-ref patterns 
all in one place.

What's the sane way to do this?

>> diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
>> index 32246fdb0..314417d89 100644
>> --- a/Documentation/git-log.txt
>> +++ b/Documentation/git-log.txt
>> @@ -38,6 +38,18 @@ OPTIONS
>>   	are shown as if 'short' were given, otherwise no ref names are
>>   	shown. The default option is 'short'.
>>   
>> +--decorate-refs=<pattern>::
>> +	Only print ref names that match the specified pattern. Uses the same
>> +	rules as `git rev-list --glob` except it doesn't assume a trailing a
>> +	trailing '/{asterisk}' if pattern lacks '?', '{asterisk}', or '['.
>> +	`--decorate-refs-exlclude` has precedence.
>> +
>> +--decorate-refs-exclude=<pattern>::
>> +	Do not print ref names that match the specified pattern. Uses the same
>> +	rules as `git rev-list --glob` except it doesn't assume a trailing a
>> +	trailing '/{asterisk}' if pattern lacks '?', '{asterisk}', or '['.
>> +	Has precedence over `--decorate-refs`.

> These two may be technically correct, but I wonder if we can make it
> easier to understand (I found "precedence" bit hard to follow, as in
> my mind, these are ANDed conditions and between (A & ~B), there is
> no "precedence").  Also we'd want to clarify what happens when only
> "--decorate-refs-exclude"s are given, which in turn necessitates us
> to describe what happens when only "--decorate-refs"s are given.

I believe the same explanation mentioned earlier fits nicely here too.

>> diff --git a/log-tree.c b/log-tree.c
>> index cea056234..8efc7ac3d 100644
>> --- a/log-tree.c
>> +++ b/log-tree.c
>> @@ -94,9 +94,33 @@ static int add_ref_decoration(const char *refname, const struct object_id *oid,
>>   {
>>   	struct object *obj;
>>   	enum decoration_type type = DECORATION_NONE;
>> +	struct ref_include_exclude_list *filter = (struct ref_include_exclude_list *)cb_data;
>> +	struct string_list_item *item;
>> +	struct strbuf real_pattern = STRBUF_INIT;
>> +
>> +	if(filter && filter->exclude->nr > 0) {
> 
> Have SP before '('.
> 
>> +		/* if current ref is on the exclude list skip */
>> +		for_each_string_list_item(item, filter->exclude) {
>> +			strbuf_reset(&real_pattern);
>> +			normalize_glob_ref(&real_pattern, NULL, item->string, 0);
>> +			if (!wildmatch(real_pattern.buf, refname, 0))
>> +				goto finish;
>> +		}
>> +	}
>>   
>> -	assert(cb_data == NULL);
>> +	if (filter && filter->include->nr > 0) {
>> +		/* if current ref is present on the include jump to decorate */
>> +		for_each_string_list_item(item, filter->include) {
>> +			strbuf_reset(&real_pattern);
>> +			normalize_glob_ref(&real_pattern, NULL, item->string, 0);
>> +			if (!wildmatch(real_pattern.buf, refname, 0))
>> +				goto decorate;
>> +		}
>> +		/* Filter was given, but no match was found, skip */
>> +		goto finish;
>> +	}
> 
> The above seems to implement the natural mixing of negative and
> positive patterns, which is good.
> 
> Unless I am missing something, I think these normalize_grob_ref()
> calls should be removed from this function; add_ref_decoration() is
> called once for EVERY ref the repository has, so you are normalizing
> a handful of patterns you got from the user over and over to get the
> same normalization, possibly thousands of times in a repository of a
> project with long history.
> 
> You have finished collecting patterns on filter->{exclude,include}
> list from the user by the time "for_each_ref(add_ref_decoration)" is
> called in load_ref_decorations(), and these patterns never changes
> after that.
> 
> Perhaps normalize the patterns inside load_ref_decorations() only
> once and have the normalized patterns in the filter lists?
> 
This would be what a sane person would do. This detail went over my 
head. Will move it to load_ref_decorations()

>> +decorate:
>>   	if (starts_with(refname, git_replace_ref_base)) {
>>   		struct object_id original_oid;
>>   		if (!check_replace_refs)
>> @@ -136,6 +160,9 @@ static int add_ref_decoration(const char *refname, const struct object_id *oid,
>>   			parse_object(&obj->oid);
>>   		add_name_decoration(DECORATION_REF_TAG, refname, obj);
>>   	}
>> +
>> +finish:
>> +	strbuf_release(&real_pattern);
>>   	return 0;
>>   }
>>   
>> @@ -148,15 +175,15 @@ static int add_graft_decoration(const struct commit_graft *graft, void *cb_data)
>>   	return 0;
>>   }
>>   
>> -void load_ref_decorations(int flags)
>> +void load_ref_decorations(int flags, struct ref_include_exclude_list *data)
>>   {
>>   	if (!decoration_loaded) {
>>   
>>   		decoration_loaded = 1;
>>   		decoration_flags = flags;
>> -		for_each_ref(add_ref_decoration, NULL);
>> -		head_ref(add_ref_decoration, NULL);
>> -		for_each_commit_graft(add_graft_decoration, NULL);
>> +		for_each_ref(add_ref_decoration, data);
>> +		head_ref(add_ref_decoration, data);
>> +		for_each_commit_graft(add_graft_decoration, data);
> 
> Don't name that variable "data".
> 
> for_each_*() and friends that take a callback with callback specific
> data MUST call the callback specific data as generic, e.g. cb_data,
> because they do not know what they are passing.  The callers of
> these functions, like this one, however, know what they are passing.
> Also load_ref_decorations() itself knows what its second parameter
> is.
> 
>      void load_ref_decorations(int flags, struct decoration_filter *filter)
> 
> or something (see below).
> 
>>   	}
>>   }
>>   
>> diff --git a/log-tree.h b/log-tree.h
>> index 48f11fb74..66563af88 100644
>> --- a/log-tree.h
>> +++ b/log-tree.h
>> @@ -7,6 +7,10 @@ struct log_info {
>>   	struct commit *commit, *parent;
>>   };
>>   
>> +struct ref_include_exclude_list {
>> +	struct string_list *include, *exclude;
>> +};
> 
> The "decoration" is not the only thing related to "ref" in the
> log-tree API; calling this structure that filters what refs to be
> used for decoration with the above name without saying that this is
> about "decoration" is too selfish and unmaintainable.
> 
> How about "struct decoration_filter" and rename the fields to say
> "{include,exclude}_ref_pattern" or something like that?  The
> renaming of the fields to include "ref" somewhere is coming from the
> same concern---it will be selfish and narrow-minded to imagine that
> the ways to filter refs used for decoration will stay forever only
> based on refnames and nothing else, which would be the reason not to
> have "ref" somewhere in the names.
> 
I will make the corrections. Thanks for the feedback.
