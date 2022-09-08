Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D3AC38145
	for <git@archiver.kernel.org>; Thu,  8 Sep 2022 13:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbiIHNT1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Sep 2022 09:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232378AbiIHNTY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2022 09:19:24 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBB7F56D2
        for <git@vger.kernel.org>; Thu,  8 Sep 2022 06:19:16 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id k6-20020a05600c1c8600b003a54ecc62f6so1738524wms.5
        for <git@vger.kernel.org>; Thu, 08 Sep 2022 06:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=b3nqck0BnBhen1SxLB3wTlGhjVJR6lsLrDOcHLA+DkY=;
        b=NVPZiKpEteZ6UZrlvMZKYxfFsxtrPxFnvKrfkKGAWo5QoykJHTLVhslMJQXFp8oDiX
         vBlCSTp99KC+xTbo0q0WjiybTc7rLniA74PvkzMDfGiIl+qcZHD3v8VEUcovYoTv7RYU
         bZZvN2vB4h4yU5DFplROKmLVQgIhLp+sOgNPV19J15LHiIOGO8TwDdGf1d+MJZzlX+8Q
         Nx8aUpL8JjlZZXjt8C+/AUonQrQzhaqsPgMqrq3DjK8dYAxay2ZRR9/fYkFvFA+pNYoF
         p2uTXi32xACSPbPaAhcXFuYrCLxHOrJB8KwX6ibf4mPvd51/yNaMPaFey3xrVw1lMEeb
         dKjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=b3nqck0BnBhen1SxLB3wTlGhjVJR6lsLrDOcHLA+DkY=;
        b=BcxMFgqKhafi1K+uLsCwhKioy64jD8Iee24NAEcscSysfgVJUoNrTOxdv6MakleGVE
         +LCb3pf3lR50r5W96FQtkfxQt9wnTiTWTeGlhr6U1yp2fxtU6vZJlbTzloLuDyYZSh6R
         4BcwR8L71D8TDkbBgWsk9/rL5NDabERDkbnCFQf4BfQEXwFvQtkcGiXcS67NbSkvOkQF
         lb5+wZdO6SlhR+cgJvVE4Mfc8F9dcW/Wxm1gUsytQNerWdJQ9VoIg3F2lszBjz7V5kWz
         ZNfd04BWXdUtK9dd9aZ8P8xO0fk8xIyEVfdSibs2h7W75b799kNdeRmjGYadWUorHwDn
         JSuw==
X-Gm-Message-State: ACgBeo10DlKhVK2aqW056MbdckP6AppNk4o8P/BNUZx+jEeRgipaFvWh
        P3Hf3Ma03bEoEQpc8Ou1pHA=
X-Google-Smtp-Source: AA6agR6aqQwEYs5/BYdQclTlDSNK+ofeUeZU236tC674RsVAirY380yNWdMAz8UqOB4AP+sBhE8HDw==
X-Received: by 2002:a05:600c:3c96:b0:3a6:58b2:a98 with SMTP id bg22-20020a05600c3c9600b003a658b20a98mr2321663wmb.43.1662643154966;
        Thu, 08 Sep 2022 06:19:14 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id f6-20020adff986000000b00229b76f872asm6247950wrr.27.2022.09.08.06.19.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 06:19:14 -0700 (PDT)
Message-ID: <e25127f3-6135-b716-a12f-5dbe4f40dc42@gmail.com>
Date:   Thu, 8 Sep 2022 14:19:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 3/7] rebase: store orig_head as a commit
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1323.git.1660576283.gitgitgadget@gmail.com>
 <pull.1323.v2.git.1662561470.gitgitgadget@gmail.com>
 <9daee95d434155742dbb19271eea8c0bc05eb365.1662561470.git.gitgitgadget@gmail.com>
 <xmqqzgfbuk95.fsf@gitster.g>
Content-Language: en-US
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqzgfbuk95.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

Thank you for your thoughtful comments

On 07/09/2022 19:12, Junio C Hamano wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> diff --git a/builtin/rebase.c b/builtin/rebase.c
>> index 56e4214b441..a3cf1ef5923 100644
>> --- a/builtin/rebase.c
>> +++ b/builtin/rebase.c
>> @@ -448,7 +447,8 @@ static int read_basic_state(struct rebase_options *opts)
>>   	} else if (!read_oneliner(&buf, state_dir_path("head", opts),
>>   				  READ_ONELINER_WARN_MISSING))
>>   		return -1;
>> -	if (get_oid(buf.buf, &opts->orig_head))
>> +	opts->orig_head = lookup_commit_reference_by_name(buf.buf);
> 
> This is not exactly a new problem, but I noticed it while looking
> for more iffy uses of lookup_commit_reference_by_name(), so...
> 
> At this point in the codepath, we expect buf.buf has full-hex object
> name and nothing else; the original should have used get_oid_hex()
> to highlight that fact.  lookup_commit_reference_by_name() allows
> object names that are not written as full-hex object name, and it
> may get confused if a branch or tag with 40-hex (or 64-hex in a
> repository with newhash) name exists.  It would be a more sensible
> conversion to use get_oid_hex() to turn buf.buf into an object name
> and then use lookup_commit_reference() on it.

That's a good point, we expect orig_head to be a commit but I don't 
think we have a function that takes an oid and parses it as a commit 
(lookup_commit() just looks in the commit in the repository's parsed 
object hash and returns a newly allocated object if the object is not 
there). lookup_commit_reference() de-references a tags which we don't 
really want to do here if we're being strict but I'm not sure there is 
an easy way to avoid that.

We should probably be stricter when reading 'onto' as well which is also 
using get_oid() rather than get_oid_hex().

>> @@ -866,15 +866,11 @@ static int is_linear_history(struct commit *from, struct commit *to)
>>   
>>   static int can_fast_forward(struct commit *onto, struct commit *upstream,
>>   			    struct commit *restrict_revision,
>> -			    struct object_id *head_oid, struct object_id *merge_base)
>> +			    struct commit *head, struct object_id *merge_base)
>>   {
>> -	struct commit *head = lookup_commit(the_repository, head_oid);
>>   	struct commit_list *merge_bases = NULL;
>>   	int res = 0;
>>   
>> -	if (!head)
>> -		goto done;
>> -
> 
> This one benefits from being able to avoid its own lookup_commit()
> because the caller already has it in the desired form.
> 
> This is not a comment on the new code, but it does make readers
> wonder if the conversion changes behaviour.  lookup_commit() takes
> an object name and requires it to be a commit object's name, doesn't
> it?  If we gave a tag to the program, the old code would have had
> the object name of that tag in head_oid and at this point and
> lookup_commit() noticed and would have stopped you from fast
> forwarding your branch to the tag, which was a good thing.  In the
> new code, since we turn the object name we take from the user into a
> commit object way before the control reaches this place, we won't
> get such an error here, but if we fast-forward to the object, we
> will still fast forward to the commit that is pointed by the tag,
> so the new behaviour is even better, perhaps?

I don't think head_oid can point to a tag in the original as we will 
have done

	commit = lookup_commit_reference_by_name(branch)
	oidcpy(&options.orig_head, &commit->object.oid)

when parsing the branch name given on the command line. If the user does 
not give a branch name then we use HEAD which should not be a tag.

>> @@ -1610,17 +1606,17 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>>   		/* Is it a local branch? */
>>   		strbuf_reset(&buf);
>>   		strbuf_addf(&buf, "refs/heads/%s", branch_name);
>> -		if (!read_ref(buf.buf, &options.orig_head)) {
>> +		options.orig_head = lookup_commit_reference_by_name(buf.buf);
>> +		if (options.orig_head) {
>>   			die_if_checked_out(buf.buf, 1);
>>   			options.head_name = xstrdup(buf.buf);
>>   		/* If not is it a valid ref (branch or commit)? */
> 
> This is iffy, or it may be just wrong.

It's wrong, thanks for pointing that out.

> The old code is checking if "refs/heads/$branch_name" is a branch
> and does the check.  If you had a branch "refs/heads/A" (whose ref
> is at "refs/heads/refs/heads/A") but do not have a branch "A", and
> if you fed "A" to this part of the code in buf.buf, then the
> original code would not have been fooled by the presence of such a
> funny branch.  New code (incorrectly) does because it prefixes
> "refs/heads/" to "A" and asks to turn string "refs/heads/A" into a
> commit object, triggering the usual ref dwim rules.
> 
> We end up setting options.head_name to a wrong thing (in this case,
> the user said "A", we turned it into a refname "refs/heads/A" that
> does not exist, and set options.orig_head to the commit object
> pointed by the ref "refs/heads/refs/heads/A", and we use that commit
> as orig_head, but use an incorrect head_name).
> 
> I didn't look as carefully as this one, but there may be similarly
> iffy uses of lookup_commit_reference_by_name() introduced by this
> patch that used to be more strict/exact; they may need to be fixed.

The only other use added in this patch is

-               if (get_oid("HEAD", &options.orig_head))
-                       die(_("Could not resolve HEAD to a revision"));
+               options.orig_head = lookup_commit_reference_by_name("HEAD");
+               if (!options.orig_head)
+                       die(_("Could not resolve HEAD to a commit"));

So now we will de-reference HEAD to a commit if it points to a tag but I 
don't think that can happen with 'git checkout' and we'll complain if it 
somehow points to a tree or blob.

Thanks for your comments, I'll fix and re-roll

Phillip
