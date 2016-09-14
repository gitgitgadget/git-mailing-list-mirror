Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63D9F207DF
	for <e@80x24.org>; Wed, 14 Sep 2016 06:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759495AbcINGaw (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Sep 2016 02:30:52 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:36133 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759431AbcINGav (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Sep 2016 02:30:51 -0400
Received: by mail-yw0-f194.google.com with SMTP id v2so316277ywg.3
        for <git@vger.kernel.org>; Tue, 13 Sep 2016 23:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BfmjWNNG5e82DmfCyf2RmWCC6ZHI/O58xPwGN3yTdHM=;
        b=xihiHaSknQwPsxbrHWfSOOWwtTd/5K+oZPO/C2clj4GYGy8924ZXM8DZjzdfUDKCuL
         GhGLRjCn996DtDv9JwcdIWgsiseNgiP9PR/+vMrv9cOrT4023++uk6iF4roVeyGPe56j
         Nk62k14QhKbPEJ2gJNDbOckEnOSDp8zzeUbjcAjrLdBx//2N7kstgtapIjdpt5oPqKuv
         xOR4kH6p/JiWWZLnpIhFhxZRrsftb/ncFX5c3dkcg5UwR7WD5EJ/fZy9eG/0bP40lCrP
         6bzq26eTXE60iarpUsZjU2EiZ4sSUMt2ESc+0tVECiDIFDJYhYaOZYzoTwsdDWKvF03z
         zGKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BfmjWNNG5e82DmfCyf2RmWCC6ZHI/O58xPwGN3yTdHM=;
        b=OaW4yMA4XhzlJTP6W5aER1ui+nFsdj+Qr2khN8gprwMYec9aRnxSO1Uox4h7DFYrmZ
         n/AX3f1sAn4ByJ6ZnO0ctwwQfTXR/TGziOA2TWd8YmL2MFsXTdHQNPG3IKKDv+vIyWgX
         3qrsw8kib2bbQpEwZOGhl+cIUixM3Lz8KhpTaFSJ7cim4cp2zOY4xg+ClZn3NKHeCpPg
         gQDsEBUOMJVdfOKXKgUDcfplTuWv81x76jpW6y6duWJbq43xtw7tkWnJx6PE1ePx2g0z
         RgZMgXCRLh4PsOVukbFsdQ4l5aXzXzMzQEn27CquVsbJu+FKp+YQ7uuuxVf1umrRt/oy
         E42g==
X-Gm-Message-State: AE9vXwO5xMw9Skufu7LmgMvVPIPVWFrvLEihx+DW/sZKWoxYFaD2PItAQXSEGYEiMVFYw4axoyc04jaWWQxlxg==
X-Received: by 10.13.199.132 with SMTP id j126mr868885ywd.150.1473834650040;
 Tue, 13 Sep 2016 23:30:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.10.197 with HTTP; Tue, 13 Sep 2016 23:30:49 -0700 (PDT)
In-Reply-To: <xmqq7fafv376.fsf@gitster.mtv.corp.google.com>
References: <20160913142628.15440-1-benpeart@microsoft.com> <xmqq7fafv376.fsf@gitster.mtv.corp.google.com>
From:   Oleg Taranenko <olegtaranenko@gmail.com>
Date:   Wed, 14 Sep 2016 08:30:49 +0200
Message-ID: <CABEd3j_FrWhOe_jXcc+VJWiyy80SG1JfbZC9woRU2cqdzjkGyA@mail.gmail.com>
Subject: Re: [PATCH v3] checkout: eliminate unnecessary merge for trivial checkout
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ben Peart <peartben@gmail.com>, git <git@vger.kernel.org>,
        pclouds@gmail.com, Ben Peart <benpeart@microsoft.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry for bothering, why not introduce a brand new option like git
checkout -b foo --skip-worktree-merge for such rare optimization use
case?

On Wed, Sep 14, 2016 at 12:34 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Ben Peart <peartben@gmail.com> writes:
>
>> +static int needs_working_tree_merge(const struct checkout_opts *opts,
>> +     const struct branch_info *old,
>> +     const struct branch_info *new)
>> +{
>> +...
>> +}
>
> I do not think I need to repeat the same remarks on the conditions
> in this helper, which hasn't changed since v2.  Many "comments" in
> the code do not explain why skipping is justified, or what they
> claim to check looks to me just plain wrong.
>
> For example, there is
>
>        /*
>         * If we're not creating a new branch, by definition we're changing
>         * the existing one so need to do the merge
>         */
>        if (!opts->new_branch)
>                return 1;
>
> but "git checkout" (no other argument) hits this condition.  It
> disables the most trivial optimization opportunity, because we are
> not "creating".
>
> "By definition, we're changing"?  Really?  Not quite.
>
> If you disable this bogus check, "git checkout" (no other argument)
> would be allowed to skip the merge_working_tree(), and that in turn
> reveals another case that the helper is not checking when
> unpack_trees() MUST be called.
>
>     Note: namely, when sparse checkout is in effect, switching from
>     HEAD to HEAD can nuke existing working tree files outside the
>     sparse pattern -- YUCK!  See penultimate test in t1011 for
>     an example.
>
> This yuckiness is not your fault, but needs_working_tree_merge()
> logic you added needs to refrain from skipping unpack_trees() call
> when sparse thing is in effect.  I'd expect "git checkout -b foo"
> instead of "git checkout" (no other argument) would fail to honor
> the sparse thing and reveal this bug, because the above bogus
> "!opts->new_branch" check will not protect you for that case.
>
> In other words, these random series of "if (...) return 1" are bugs
> hiding other real bugs and we need to reason about which ones are
> bugs that are hiding what other bugs that are not covered by this
> function.  As Peff said earlier for v1, this is still an unreadable
> mess.  We need to figure out a way to make sure we are skipping on
> the right condition and not accidentally hiding a bug of failing to
> check the right condition.  I offhand do not have a good suggestion
> on this; sorry.
>
>>  static int merge_working_tree(const struct checkout_opts *opts,
>>                             struct branch_info *old,
>>                             struct branch_info *new,
>>                             int *writeout_error)
>>  {
>> +     /*
>> +      * Optimize the performance of "git checkout -b foo" by avoiding
>> +      * the expensive merge, index and working directory updates if they
>> +      * are not needed.
>> +      */
>> +     if (!needs_working_tree_merge(opts, old, new))
>> +             return 0;
>> +
>>       int ret;
>>       struct lock_file *lock_file = xcalloc(1, sizeof(struct lock_file));
>
> With the change you made at the beginning of this function, it no
> longer compiles with -Wdecl-after-stmt, but that is the smallest of
> the problems.
>
> It is a small step in the right direction to move the call to the
> helper from the caller to this function, but it is a bit too small.
>
> Notice that the lines after the above context look like this:
>
>         hold_locked_index(lock_file, 1);
>         if (read_cache_preload(NULL) < 0)
>                 return error(_("index file corrupt"));
>
>         resolve_undo_clear();
>         if (opts->force) {
>                 ret = reset_tree(new->commit->tree, opts, 1, writeout_error);
>                 if (ret)
>                         return ret;
>         } else {
>                 struct tree_desc trees[2];
>                 ...
>
> I would have expected that the check goes inside the "else" thing
> that actually does a two-tree merge, and the helper loses the check
> with opts->force, at least.  That would still be a change smaller
> than desired, but at least a meaningful improvement compared to the
> previous one.  As I have already pointed out, in the "else" clause
> there is a check "is the index free of conflicted entries? if so
> error out", and that must be honored in !opt->force case, no matter
> what your needs_working_tree_merge() says.  I also was hoping that
> you would notice, when you were told about the unmerged check, by
> reading the remainder of the merge_working_tree(), that we need to
> call show_local_changes() when we are not doing force and when we
> are not quiet---returning early like the above patch will never be
> able to call that one downstream in the function.
>
> Regardless of what the actual checks end up to be, the right place
> to do this "optimization" would look more like:
>
>  builtin/checkout.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 2b50a49..a6b9e17 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -508,14 +508,19 @@ static int merge_working_tree(const struct checkout_opts *opts,
>                         topts.dir->flags |= DIR_SHOW_IGNORED;
>                         setup_standard_excludes(topts.dir);
>                 }
> +
> +               if ( we know we can skip the unpack ) {
> +                       ret = 0;
> +               } else {
>                         tree = parse_tree_indirect(old->commit ?
>                                                    old->commit->object.oid.hash :
>                                                    EMPTY_TREE_SHA1_BIN);
>                         init_tree_desc(&trees[0], tree->buffer, tree->size);
>                         tree = parse_tree_indirect(new->commit->object.oid.hash);
>                         init_tree_desc(&trees[1], tree->buffer, tree->size);
> -
>                         ret = unpack_trees(2, trees, &topts);
> +               }
> +
>                 if (ret == -1) {
>                         /*
>                          * Unpack couldn't do a trivial merge; either
>
> I'd think.  Note that the determination of "we can skip" would
> involve knowing the object names of the two trees involved, so for
> performance reasons, some of the parse-tree calls may have to come
> before the call to "do we know we can skip?", but that does not
> fundamentally change the basic code structure.
>
> Thanks.
