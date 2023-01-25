Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06805C27C76
	for <git@archiver.kernel.org>; Wed, 25 Jan 2023 16:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235171AbjAYQQX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Jan 2023 11:16:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjAYQQV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2023 11:16:21 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36808A61
        for <git@vger.kernel.org>; Wed, 25 Jan 2023 08:16:19 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id k20so5160592edj.7
        for <git@vger.kernel.org>; Wed, 25 Jan 2023 08:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unity3d.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KgLxwncG3k+MasdaWzIiBL3ubOmW4uFj9uMEGMjcahg=;
        b=XvGAKLmMyNKr19+p3ez9baqaOA44uqeTW/NaHn6y1wPfOUYoZjGvrJbCjcrIHZMI9V
         FIGYAfM5udftpzmmvC6SVHP683HU8aRmgsNzKxv8ZojdwzKTeIlp6xXv5cIK+4aHt70o
         yaAElJ/FYAKW/ZYa94jkWiFucXSaePAgs4pjqJsxECatUJBvkF4bLZWh/jN9xnUsEWim
         yhFBK3R56uzNjJ6xGZjU/o6yJgi7DXJZXMhi/K0JYyYVC5Jkt1pCW51+v4NMVdIj0Z6n
         FCXKZRc2fHgMkSnUuLo3AJsCScJY0vCOscJNZ4gTTOtntkqDI3J/PlOB0FiDQ3Z2159q
         Db/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KgLxwncG3k+MasdaWzIiBL3ubOmW4uFj9uMEGMjcahg=;
        b=FlQUIZ8kiy1mFCibHA5CtwjAcRneKx7Q54sYzlB7BBMwhWZBqBH/F7qpbTkD6VpiVa
         eTV/wUEJHQPKGAU//aBaI2/k9T9rbnP1aINRAU6UU1F4mZkO1JTG098FIijwA29yi2e+
         A0OUgMolcPSqwUtx+Ie3F29/PRPeZ8vxG4abfVkhBbVkFh0wb/U7XtSbB7NauDfJTCnk
         hU+fFLv8gnd+tHvkfDeZyyhSjRjvZFs1p9QT0T3LhmVFZPL9MKxzGmrFPMxC31iuiuH/
         yc8aXb+EtaC3aXkYSiX/+8vQk1LmoKJ/A92gCtIIcdeIp4w8GSfVL5EOvafCFg4r9PXj
         hx6Q==
X-Gm-Message-State: AFqh2koG698uZKCPtL8Du4NJg4AMuyMsG1RTc3vfrzu+iDOv4sDzjTC/
        pEyEFOa/LtKUATK78KJ5rUgS2g==
X-Google-Smtp-Source: AMrXdXvu6fu5S8F2ewApjYyGLXup+K7TczNmIsQB6wyaXfjYUfGAeBj/mEGuDBKWdRAAzyoriSuTNg==
X-Received: by 2002:a05:6402:4026:b0:49e:4786:a0e2 with SMTP id d38-20020a056402402600b0049e4786a0e2mr33655822eda.14.1674663378235;
        Wed, 25 Jan 2023 08:16:18 -0800 (PST)
Received: from [10.45.33.55] ([80.80.14.217])
        by smtp.gmail.com with ESMTPSA id da14-20020a056402176e00b0046dd0c2a08esm2543107edb.36.2023.01.25.08.16.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 08:16:17 -0800 (PST)
Message-ID: <18c94f70-4adf-1b4a-8777-206804c419e6@unity3d.com>
Date:   Wed, 25 Jan 2023 17:16:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v2] ls-tree: add --sparse-filter-oid argument
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>,
        William Sprent via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>
References: <pull.1459.git.1673456518993.gitgitgadget@gmail.com>
 <pull.1459.v2.git.1674474371817.gitgitgadget@gmail.com>
 <CABPp-BExS8UGfGzT+w9R_p0sY+_=A0-nRzU5QTOKwfBSmX6c3A@mail.gmail.com>
From:   William Sprent <williams@unity3d.com>
In-Reply-To: <CABPp-BExS8UGfGzT+w9R_p0sY+_=A0-nRzU5QTOKwfBSmX6c3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25/01/2023 06.11, Elijah Newren wrote:
> It looks like Ævar and Victoria have both given really good reviews
> already, but I think I spotted some additional things to comment on.
> 
> On Mon, Jan 23, 2023 at 3:46 AM William Sprent via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: William Sprent <williams@unity3d.com>
>>
>> There is currently no way to ask git the question "which files would be
>> part of a sparse checkout of commit X with sparse checkout patterns Y".
>> One use-case would be that tooling may want know whether sparse checkouts
>> of two commits contain the same content even if the full trees differ.
> 
> Could you say more about this usecase?  Why does tooling need or want
> to know this; won't a checkout of the new commit end up being quick
> and simple?  (I'm not saying your usecase is bad, just curious that it
> had never occurred to me, and I'm afraid I'm still not sure what your
> purpose might be.)
> 

I'm thinking mainly about a monorepo context where there are a number of 
distinct 'units' that can be described with sparse checkout patterns. 
And perhaps there's some tooling that only wants to perform an action if 
the content of a 'unit' changes.

Depending on the repo, it won't necessarily be quick to check out the 
commit with the given patterns. However, it is more about it being 
inconvenient to have to have a working directory, especially so if you 
want use the tooling in some kind of service or query rapidly about 
different revisions/patterns.

>> Another interesting use-case would be for tooling to use in conjunction
>> with 'git update-index --index-info'.
> 
> Sorry, I'm not following.  Could you expound on this a bit?
> 

I was imagining something along the lines of being able to generate new 
tree objects based on what matches the given sparse checkout patterns. 
Not that I have a specific use case for it right now.

I think what I'm trying to evoke with that paragraph is that this 
enables integrations with git that seem interesting and weren't possible 
before.

>> 'rev-list --objects --filter=sparse:oid' comes close, but as rev-list is
>> concerned with objects rather than directory trees, it leaves files out
>> when the same blob occurs in at two different paths.
> 
> s/in at/at/ ?
> >> It is possible to ask git about the sparse status of files currently in
>> the index with 'ls-files -t'. However, this does not work well when the
>> caller is interested in another commit, intererested in sparsity
> 
> s/intererested/interested/
> 
>> patterns that aren't currently in '.git/info/sparse-checkout', or when
>> working in with bare repo.
> 
> s/in with bare/with a bare/ or s/in with bare/in a bare/?
> 

Ah. Thanks for catching those.

>> To fill this gap, add a new argument to ls-tree '--sparse-filter-oid'
>> which takes the object id of a blob containing sparse checkout patterns
>> that filters the output of 'ls-tree'. When filtering with given sparsity
>> patterns, 'ls-tree' only outputs blobs and commit objects that
>> match the given patterns.
> 
> This seems slightly unfortunate in that it makes things difficult for
> cone mode users to take advantage of.  They will have to figure out
> how to translate their directory list into sparse checkout patterns
> before passing it along, and currently the only way to do that is via
> `git sparse-checkout set <patterns>` and reading the patterns from
> $GIT_DIR/info/sparse-checkout, but that toggles the sparsity of the
> current working tree and avoiding changing the current sparse-checkout
> was something you listed in your commit message as something you
> wanted to avoid.
>  >> While it may be valid in some situations to output a tree object -- e.g.
>> when a cone pattern matches all blobs recursively contained in a tree --
>> it is less unclear what should be output if a sparse pattern matches
>> parts of a tree.
>>
>> To allow for reusing the pattern matching logic found in
>> 'path_in_sparse_checkout_1()' in 'dir.c' with arbitrary patterns,
>> extract the pattern matching part of the function into its own new
>> function 'recursively_match_path_with_sparse_patterns()'.
>>
>> Signed-off-by: William Sprent <williams@unity3d.com>
>> ---
>>      ls-tree: add --sparse-filter-oid argument
>>
>>      I'm resubmitting this change as rebased on top of 'master', as it
>>      conflicted with the topic 'ls-tree.c: clean-up works' 1
>>      [https://public-inbox.org/git/20230112091135.20050-1-tenglong.tl@alibaba-inc.com],
>>      which was merged to 'master' recently.
>>
>>      This versions also incorporates changes based on the comments made in 2
>>      [https://public-inbox.org/git/CAPig+cRgZ0CrkqY7mufuWmhf6BC8yXjXXuOTEQjuz+Y0NA+N7Q@mail.gmail.com/].
>>
>>      I'm also looping in contributors that have touched ls-tree and/or
>>      sparse-checkouts recently. I hope that's okay.
> 
> Of course!  It's encouraged, even.
> 
> [...]
>> diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
> [...]
>> +static void init_sparse_filter_data(struct sparse_filter_data **d, struct ls_tree_options *options,
>> +       const char *sparse_oid_name, read_tree_fn_t fn)
>> +{
>> +       struct object_id sparse_oid;
>> +       struct object_context oc;
>> +
>> +       (*d) = xcalloc(1, sizeof(**d));
>> +       (*d)->fn = fn;
>> +       (*d)->pl.use_cone_patterns = core_sparse_checkout_cone;
> 
> Hmm, so the behavior still depends upon the current sparse-checkout
> (or lack thereof), despite the documentation and rationale of your
> feature as being there to check how a different sparse checkout would
> behave?
> 
> I would hate to unconditionally turn cone_patterns off, since that
> would come with a huge performance penalty for the biggest repos.  But
> turning it unconditionally on wouldn't be good for the non-cone users.
> This probably suggests we need something like another flag, or perhaps
> separate flags for each mode.  Separate flags might provide the
> benefit of allowing cone mode users to specify directories rather than
> patterns, which would make it much easier for them to use.
>
I used 'core_sparse_checkout_cone' because I wanted to allow for the 
cone mode optimisations, but I also figured that I should respect the 
configuration. It doesn't change how the patterns are parsed in this case.

I agree that it is a bit awkward to have to "translate" the directories 
into patterns when wanting to use cone mode. I can try adding
'--[no]-cone' flags and see how that feels. Together with Victoria's 
suggestions that would result in having the following flags:

* --scope=(sparse|all)
* --sparse-patterns-file=<path>
* --[no]-cone: used together with --sparse-patterns-file to tell git
   whether to interpret the patterns given as directories (cone) or
   patterns (no-cone).

Which seems like a lot at first glance. But it allows for passing 
directories instead of patterns for cone mode, and is similar to the 
behaviour of 'sparse-checkout set'.

Does that seem like something that would make sense?

> [...]
>> +static int path_matches_sparse_checkout_patterns(struct strbuf *full_path, struct pattern_list *pl, int dtype)
>> +{
>> +       enum pattern_match_result match = recursively_match_path_with_sparse_patterns(full_path->buf, the_repository->index, dtype, pl);
>> +       return match > 0;
> 
> So your new caller doesn't care about the pattern_match_result, it
> just wants to know if it got MATCHED or MATCHED_RECURSIVELY...
> 
> [...]
>> diff --git a/dir.c b/dir.c
>> index 4e99f0c868f..122ebced08e 100644
>> --- a/dir.c
>> +++ b/dir.c
>> @@ -1457,45 +1457,50 @@ int init_sparse_checkout_patterns(struct index_state *istate)
>>          return 0;
>>   }
>>
>> -static int path_in_sparse_checkout_1(const char *path,
>> -                                    struct index_state *istate,
>> -                                    int require_cone_mode)
>> +int recursively_match_path_with_sparse_patterns(const char *path,
> 
> You claim it returns an int here, but previously you presumed an enum
> pattern_match_result from the new caller.
> 
>> +                                               struct index_state *istate,
>> +                                               int dtype,
>> +                                               struct pattern_list *pl)
>>   {
>> -       int dtype = DT_REG;
>>          enum pattern_match_result match = UNDECIDED;
>>          const char *end, *slash;
>> -
>> -       /*
>> -        * We default to accepting a path if the path is empty, there are no
>> -        * patterns, or the patterns are of the wrong type.
>> -        */
>> -       if (!*path ||
>> -           init_sparse_checkout_patterns(istate) ||
>> -           (require_cone_mode &&
>> -            !istate->sparse_checkout_patterns->use_cone_patterns))
>> -               return 1;
>> -
>>          /*
>>           * If UNDECIDED, use the match from the parent dir (recursively), or
>>           * fall back to NOT_MATCHED at the topmost level. Note that cone mode
>>           * never returns UNDECIDED, so we will execute only one iteration in
>>           * this case.
>>           */
>> -       for (end = path + strlen(path);
>> -            end > path && match == UNDECIDED;
>> +       for (end = path + strlen(path); end > path && match == UNDECIDED;
>>               end = slash) {
>> -
>>                  for (slash = end - 1; slash > path && *slash != '/'; slash--)
>>                          ; /* do nothing */
>>
>>                  match = path_matches_pattern_list(path, end - path,
>>                                  slash > path ? slash + 1 : path, &dtype,
>> -                               istate->sparse_checkout_patterns, istate);
>> +                               pl, istate);
>>
>>                  /* We are going to match the parent dir now */
>>                  dtype = DT_DIR;
>>          }
>> -       return match > 0;
>> +
>> +       return match;
> 
> Um, this last line seems like a potentially scary change in behavior.
> Why should UNDECIDED return a non-zero value?  Previously, we returned
> a 0 value for both UNDECIDED and NOT_MATCHED, but you've changed that
> here.  If the change in this last line is actually correct, it should
> be split out into its own commit and explained in detail in the commit
> message.
> 
>> +}
>> +
>> +static int path_in_sparse_checkout_1(const char *path,
>> +                                    struct index_state *istate,
>> +                                    int require_cone_mode)
>> +{
>> +       /*
>> +        * We default to accepting a path if the path is empty, there are no
>> +        * patterns, or the patterns are of the wrong type.
>> +        */
>> +       if (!*path ||
>> +           init_sparse_checkout_patterns(istate) ||
>> +           (require_cone_mode &&
>> +            !istate->sparse_checkout_patterns->use_cone_patterns))
>> +               return 1;
>> +
>> +       return recursively_match_path_with_sparse_patterns(path, istate, DT_REG, istate->sparse_checkout_patterns) > 0;
> 
> Oh, you compare to > 0 here...and digging around your only other
> caller just immediately compares to > 0 as well.
> 
> Why not just have recursively_match_path_with_sparse_patterns() do the
>> 0 check?  If it does, returning int is fine.  If it doesn't, it
> should be declared to return enum pattern_match_result.

I think my thinking was that it made sense in general for 
'recursively_match_path_with_sparse_patterns()' to expose the match 
result, but then failed to declare it that way. Thanks for catching it.
