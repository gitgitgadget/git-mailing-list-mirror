Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF67AC46467
	for <git@archiver.kernel.org>; Mon, 16 Jan 2023 12:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjAPMOJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Jan 2023 07:14:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjAPMOH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2023 07:14:07 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59A31A4B1
        for <git@vger.kernel.org>; Mon, 16 Jan 2023 04:14:05 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id vm8so67611261ejc.2
        for <git@vger.kernel.org>; Mon, 16 Jan 2023 04:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unity3d.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aORdwt7l0TYCh3tNudG/AqQnhDq+Uq6fYGSwnmnAF6Y=;
        b=gciYIXFn4MlQgWuEXIRouh/0u/jVIQdg7HIjMAaFep6TiJChnVB9WajOsepO/eiBrN
         b64GCgdZkREBf0CG2uXQu7czlOJtKa9QOuiZDdKtJupwHqlnCWKXnjRAIbM+HsEjSBWP
         qG8VF033Xpmc/4wFmH8bjGsmq+2UxZyaMxgCvyD9QTWz1wEobS9g88zi0CL2xhBZgR7J
         5zSTU8yxTQLZbu8UfzqYZrbYgf4GoqECU1pBSBSLzPlzD0Ff+uBKcCjQbfu3ghsmcDso
         eIXsI4d66ptWVvWTpATr7673zDMbUs66te2Wk+fbVo+DXQwiRoJ3sFYYtct9ugJzO6wf
         ydPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aORdwt7l0TYCh3tNudG/AqQnhDq+Uq6fYGSwnmnAF6Y=;
        b=PC2oVCCZJ4TZEBy+K3si6AjtdmFfmiem9geX3kXAlT3F/lBQ2cH02ZqVEcUiVXNDHO
         GXIRv6r6fKdddvicPhOdYLeRU1lmUVlVtE5Z+S8d5vKWwtbVMUCWwdgZaSe4NhI9rsR1
         +EamTLq0R0KwarUYF+r1kWwgmuUXoK5Z5Xts/Z6PdVkTFl7XPeAAqTsECBm4Vxz6maef
         H0HV0aPlVda8ReCtRhlA74ge6d0Vas7YVpvf/XEY+v9GEhUQ1wWlYX/NEZKvfA1SEGH5
         Lffd5CCCWT2epsbYJgEVh8iTix3ywYX8L7Isu1s9SdWe4TfZY0xjzRSEavRDi1gf1CW5
         L4hA==
X-Gm-Message-State: AFqh2kqCdK1DpQ0jElhh4aJhUvBRuiT79b0e0aDM1g6btQolq06bG1wT
        sg4VKJTsqjNrKxyP4NL8j859Xs9iQiuoWd3mmyw=
X-Google-Smtp-Source: AMrXdXvEGms5u5ms4qSh02qoSpZUqKHQKDbhYWDkVuKReCdwQdeaJxTce9unXNrC8uMcFOEEVwdnWw==
X-Received: by 2002:a17:906:99ca:b0:871:9359:3763 with SMTP id s10-20020a17090699ca00b0087193593763mr1301483ejn.40.1673871244190;
        Mon, 16 Jan 2023 04:14:04 -0800 (PST)
Received: from [10.45.33.169] ([80.80.14.217])
        by smtp.gmail.com with ESMTPSA id j17-20020a17090623f100b00770812e2394sm9581582ejg.160.2023.01.16.04.14.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 04:14:03 -0800 (PST)
Message-ID: <26f026f6-6c17-7578-e341-d56fe53c95df@unity3d.com>
Date:   Mon, 16 Jan 2023 13:14:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH] ls-tree: add --sparse-filter-oid argument
Content-Language: en-US
To:     Eric Sunshine <sunshine@sunshineco.com>,
        William Sprent via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.1459.git.1673456518993.gitgitgadget@gmail.com>
 <CAPig+cRgZ0CrkqY7mufuWmhf6BC8yXjXXuOTEQjuz+Y0NA+N7Q@mail.gmail.com>
From:   William Sprent <williams@unity3d.com>
In-Reply-To: <CAPig+cRgZ0CrkqY7mufuWmhf6BC8yXjXXuOTEQjuz+Y0NA+N7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13/01/2023 15.17, Eric Sunshine wrote:
> On Wed, Jan 11, 2023 at 12:05 PM William Sprent via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> [...]
>> To fill this gap, add a new argument to ls-tree '--sparse-filter-oid'
>> which takes the object id of a blob containing sparse checkout patterns
>> that filters the output of 'ls-tree'. When filtering with given sparsity
>> patterns, 'ls-tree' only outputs blobs and commit objects that
>> match the given patterns.
>> [...]
>> Signed-off-by: William Sprent <williams@unity3d.com>
> 
> This is not a proper review, but rather just some comments about
> issues I noticed while quickly running my eye over the patch. Many are
> just micro-nits about style; a few regarding the tests are probably
> actionable.
> 
>>      Note that one of the tests only pass when run on top of commit
>>      5842710dc2 (dir: check for single file cone patterns, 2023-01-03), which
>>      was submitted separately and is currently is merged to 'next'.
> 
> Thanks for mentioning this. It's exactly the sort of information the
> maintainer needs when applying your patch to his tree. And it can be
> helpful for reviewers too.
> 
>> diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
>> @@ -48,6 +48,11 @@ OPTIONS
>> +--sparse-filter-oid=<blob-ish>::
>> +       Omit showing tree objects and paths that do not match the
>> +       sparse-checkout specification contained in the blob
>> +       (or blob-expression) <blob-ish>.
> 
> Good to see a documentation update. The SYNOPSIS probably deserves an
> update too.
> 

Nice catch. I'll update it.

>> diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
>> @@ -329,12 +331,79 @@ static struct ls_tree_cmdmode_to_fmt ls_tree_cmdmode_format[] = {
>> +static void sparse_filter_data__init(
>> +       struct sparse_filter_data **d,
>> +       const char *sparse_oid_name, read_tree_fn_t fn)
>> +{
>> +       struct object_id sparse_oid;
>> +       struct object_context oc;
>> +
>> +       (*d) = xcalloc(1, sizeof(**d));
>> +       (*d)->fn = fn;
>> +       (*d)->pl.use_cone_patterns = core_sparse_checkout_cone;
>> +
>> +       strbuf_init(&(*d)->full_path_buf, 0);
>> +
>> +
> 
> Nit: too many blank lines.
> 
>> +       if (get_oid_with_context(the_repository,
>> +                                sparse_oid_name,
>> +                                GET_OID_BLOB, &sparse_oid, &oc))
> 
> Pure nit: somewhat odd choice of wrapping; I'd have expected something
> along the lines of:
> 
>      if (get_oid_with_context(the_repository, sparse_oid_name, GET_OID_BLOB,
>                      &sparse_oid, &oc))
> 
> or:
> 
>      if (get_oid_with_context(the_repository, sparse_oid_name,
>                      GET_OID_BLOB, &sparse_oid, &oc))
> 
>> +static void sparse_filter_data__free(struct sparse_filter_data *d)
>> +{
>> +       clear_pattern_list(&d->pl);
>> +       strbuf_release(&d->full_path_buf);
>> +       free(d);
>> +}
> 
> Is the double-underscore convention in function names imported from
> elsewhere? I don't recall seeing it used in this codebase.
> 

I took inspiration from the similar '--filter:sparse' argument for rev-list
which is implemented in 'list-objects-filter.c'. I've just given it a
search  and it looks like it that convention isn't really used outside the
list-objects files, which makes it a bit awkward here.

I get a bunch more hits for '(init|free)_', so I will change them to that.


>> +static int path_matches_sparse_checkout_patterns(struct strbuf *full_path, struct pattern_list *pl, int dtype)
>> +{
>> +       enum pattern_match_result match = recursively_match_path_with_sparse_patterns(full_path->buf, the_repository->index, dtype, pl);
>> +       return match > 0;
>> +}
>> +
>> +
> 
> Nit: too many blank lines
> 
>> +static int filter_sparse(const struct object_id *oid, struct strbuf *base,
>> +                        const char *pathname, unsigned mode, void *context)
>> +{
>> +
>> +       struct sparse_filter_data *data = context;
> 
> Nit: unnecessary blank line after "{"
> 
>> +       int do_recurse = show_recursive(base->buf, base->len, pathname);
>> +       if (object_type(mode) == OBJ_TREE)
>> +               return do_recurse;
>> +
>> +       strbuf_reset(&data->full_path_buf);
>> +       strbuf_addbuf(&data->full_path_buf, base);
>> +       strbuf_addstr(&data->full_path_buf, pathname);
>> +
>> +       if (!path_matches_sparse_checkout_patterns(&data->full_path_buf, &data->pl, DT_REG))
>> +               return 0;
>> +
>> +       return data->fn(oid, base, pathname, mode, context);	
>> +}
>> +
>> +
> 
> Nit: too many blank lines
> 
>> diff --git a/dir.c b/dir.c
>> @@ -1450,45 +1450,51 @@ int init_sparse_checkout_patterns(struct index_state *istate)
>> +static int path_in_sparse_checkout_1(const char *path,
>> +                                    struct index_state *istate,
>> +                                    int require_cone_mode)
>> +{
>> +
>> +       /*
> 
> Nit: unnecessary blank line after "{"
> 
>> diff --git a/t/t3106-ls-tree-sparse-checkout.sh b/t/t3106-ls-tree-sparse-checkout.sh
>> new file mode 100755
> 
> We often try to avoid introducing a new test script if the tests being
> added can fit well into an existing script. If you didn't find any
> existing script where these tests would fit, then creating a new
> script may be fine.
> 

Well there's a couple of things. The only ls-tree related test file
that isn't too specific is 't3103-ls-tree-misc.sh'. However, the
'sparse-checkout' command leaks memory, so that would require setting
'TEST_PASSES_SANITIZE_LEAK' to false.

For tests related to sparse-checkout, we both have the large
't1092-sparse-checkout-compatibility.sh' file. But there is also a
collection of files like 't3705-add-sparse-checkout.sh'. I guess
both could work fine in this case. I think I went with the latter
because I personally find the smaller test files a bit easier to
parse.

If someone feels strongly the other way, I'll gladly change it.

>> @@ -0,0 +1,103 @@
>> +check_agrees_with_ls_files () {
>> +       REPO=repo
>> +       git -C $REPO submodule deinit -f --all
>> +       git -C $REPO cat-file -p ${filter_oid} >${REPO}/.git/info/sparse-checkout
>> +       git -C $REPO sparse-checkout init --cone 2>err
>> +       git -C $REPO submodule init
>> +       git -C $REPO ls-files -t| grep -v "^S "|cut -d" " -f2 >ls-files
>> +       test_cmp ls-files actual
>> +}
> 
> Several comments:
> 
> Since the return code of this function is significant and callers care
> about it, you should &&-chain all of the code in the function itself
> (just like you do within a test) so that failure of any command in the
> function is noticed and causes the calling test to fail. It's a good
> idea to &&-chain the variable assignments at the top of the function
> too (just in case someone later inserts code above the assignments).
> 

That was an oversight. Thanks for noticing.

> It's odd to see a mixture of $VAR and ${VAR}. It's better to be
> consistent. We typically use the $VAR form (though it's not exclusive
> by any means).
> 

I'll remove the braces.

> Some shells complain when the pathname following ">" redirection
> operator is not quoted, so:
> 
>      git -C $REPO cat-file -p ${filter_oid} >"$REPO/.git/info/sparse-checkout" &&
> 
> Style: add space around "|" pipe operator
> 
> We usually avoid having a Git command upstream of the pipe since its
> exit code gets swallowed by the pipe, so we usually do this instead:
> 
>      git -C $REPO ls-files -t >out &&
>      grep -v "^S " out | cut -d" " -f2 >ls-files &&
> 

Good point. I'll do that.

> Minor: The two-command pipeline `grep -v "^S " | cut -d" " -f2
>> ls-files` could be expressed via a single `sed` invocation:
> 
>      sed -n "/^S /!s/^. //p" out &&
> 
> Nit: The first argument to test_cmp() is typically named "expect".
> 
> Error output is captured to file "err" but that file is never consulted.
> 

I'll remove the redirection.

>> +check_same_result_in_bare_repo () {
>> +       FULL=repo
>> +       BARE=bare
>> +       FILTER=$1
>> +       git -C repo cat-file -p ${filter_oid}| git -C bare hash-object -w --stdin
>> +       git -C bare ls-tree --name-only --filter-sparse-oid=${filter_oid} -r HEAD >bare-result
>> +       test_cmp expect bare-result
>> +}
> 
> Same comments as above, plus:
> 
> What is the purpose of the variables FULL, BARE, FILTER? They don't
> seem to be used in the function.
> 
> I suspect that the function should be using $FILTER internally rather
> than $filter_oid.
> 

I think I probably had plans with them and then forgot. Thanks for noticing.
I'll keep (and use) FILTER, but remove the others.

>> +test_expect_success 'setup' '
>> +       git init submodule &&
>> +       (
>> +               cd submodule &&
>> +               test_commit file
>> +       ) &&
> 
> Minor: test_commit() accepts a -C option, so this could be done
> without the subshell:
> 
>      test_commit -C submodule file
> 
>> +       git init repo &&
>> +       (
>> +               cd repo &&
>> +               mkdir dir &&
>> +               test_commit dir/sub-file &&
>> +               test_commit dir/sub-file2 &&
>> +               mkdir dir2 &&
>> +               test_commit dir2/sub-file1 &&
>> +               test_commit dir2/sub-file2 &&
>> +               test_commit top-file &&
>> +               git clone ../submodule submodule &&
>> +               git submodule add ./submodule &&
>> +               git submodule absorbgitdirs &&
>> +               git commit -m"add submodule" &&
>> +               git sparse-checkout init --cone
>> +       ) &&
> 
> Here the subshell makes sense since so many commands are run in
> directory "repo." Fine.

Thanks for taking the time to give some comments. I think they all
make sense to me. Besides the comments I've explicitly acknowledged above,
I've also applied all of the minor/nit/style comments to my local tree.


