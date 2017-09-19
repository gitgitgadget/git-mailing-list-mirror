Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88BFD20281
	for <e@80x24.org>; Tue, 19 Sep 2017 00:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750864AbdISApX (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Sep 2017 20:45:23 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:43782 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750772AbdISApW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2017 20:45:22 -0400
Received: by mail-wm0-f52.google.com with SMTP id a137so15735563wma.0
        for <git@vger.kernel.org>; Mon, 18 Sep 2017 17:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JwXgDjvuRmzKIlNaowTAVl9cN0+ViYvsFnSLHZKEUrI=;
        b=tnyoz+ER8LKliSdCacTQBSd9jAcatNZRFwe3JaDH1oZ0CF82YgIZBb/h5bX0sjnvCw
         vGrvIVdpcLEXP9lQ/KfESl5ZX0B30zaUzXehybJY+t4ZVjxfxTzrw56h/NoUJsyFVaS8
         Hz6dUlM9kr8Vr2KtRslvGky36M5PntyujXRITBtiginZkZQ86DzQ/oejMEGomu7/p66R
         eYEl9BE+A0MzHuU8dZjNaqrbYmofDkuaxBETqyYGjEdNw7uJ5XPKNCEqftVKCTNRfoR0
         3AuqjLGDcZvZ3VA5otbuQTGKhbzN8Kzt5PPn5WsS5/miUnYQMDk0aE8jD+9XJLpZHNpZ
         709g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JwXgDjvuRmzKIlNaowTAVl9cN0+ViYvsFnSLHZKEUrI=;
        b=gN3wFy3m/Ea6/FWT22yz7z+XwhNcd9jrcIYlM5xB3hftRQFwM4sfbBXzLy2oBxmWOi
         TibXA33YWITynIAW2PPaC76RVynEHihJEt+zytwqbcJPp6y71Z6b6NxuGVIzpR6ptVoo
         Z02bL2Ar6epyYoAJDdEOcsGR5XRdg/Q/Kv+//OwaO/c2ax0OsH+7F4oAo2klH2nA/N2M
         83ypIzgfMLDTZ0HOXDkUx1tjcYv1y9v0sXTZqsnhstzcwTxlpawOiwz+IAEhSgIMZocL
         cTeM8t1Uv+jOJYuwDDMhItiF2F3W1ZJ4B0BSkBlNEJwYFRWcRrSw4spoFBmwUjffKdqY
         8NcQ==
X-Gm-Message-State: AHPjjUgBkYJIHmlzRScIWvjzPvBNlbdiiIm8ojZ33W6cMR8Y+fNiH5yP
        7X5bvnqeSvFkGYH/oAlM+nlOchx4xHrHYaDkMAi8cg==
X-Google-Smtp-Source: AOwi7QAOhYABY+swj7s/k349brorBt94sk+xFaSITynDrIaTzkqp3jqy23uVE//gXQQ1uPoz9Wo0ZfbqCtM/UwAmsvk=
X-Received: by 10.80.146.56 with SMTP id i53mr13102eda.148.1505781920798; Mon,
 18 Sep 2017 17:45:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.146.185 with HTTP; Mon, 18 Sep 2017 17:45:00 -0700 (PDT)
In-Reply-To: <xmqqzi9rsgxz.fsf@gitster.mtv.corp.google.com>
References: <20170917142416.30685-1-max@max630.net> <xmqqzi9rsgxz.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 18 Sep 2017 17:45:00 -0700
Message-ID: <CA+P7+xqTTXFoUnkD2Z0q3e9G8ByoCmAN1ZuXtZquRX7ofKewCA@mail.gmail.com>
Subject: Re: [PATCH] describe: teach --match to handle branches and remotes
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Max Kirillov <max@max630.net>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 18, 2017 at 4:52 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Max Kirillov <max@max630.net> writes:
>
>>  --match <pattern>::
>>       Only consider tags matching the given `glob(7)` pattern,
>> -     excluding the "refs/tags/" prefix.  This can be used to avoid
>> -     leaking private tags from the repository. If given multiple times, a
>> -     list of patterns will be accumulated, and tags matching any of the
>> -     patterns will be considered. Use `--no-match` to clear and reset the
>> -     list of patterns.
>> +     excluding the "refs/tags/" prefix. If used with `--all`, it also
>> +     considers local branches and remote-tracking references matching the
>> +     pattern, excluding respectively "refs/heads/" and "refs/remotes/"
>> +     prefix; references of other types are never considered. If given
>> +     multiple times, a list of patterns will be accumulated, and tags
>> +     matching any of the patterns will be considered.  Use `--no-match` to
>> +     clear and reset the list of patterns.
>>
>>  --exclude <pattern>::
>>       Do not consider tags matching the given `glob(7)` pattern, excluding
>> -     the "refs/tags/" prefix. This can be used to narrow the tag space and
>> -     find only tags matching some meaningful criteria. If given multiple
>> -     times, a list of patterns will be accumulated and tags matching any
>> -     of the patterns will be excluded. When combined with --match a tag will
>> -     be considered when it matches at least one --match pattern and does not
>> +     the "refs/tags/" prefix. If used with `--all`, it also does not consider
>> +     local branches and remote-tracking references matching the pattern,
>> +     excluding respectively "refs/heads/" and "refs/remotes/" prefix;
>> +     references of other types are never considered. If given multiple times,
>> +     a list of patterns will be accumulated and tags matching any of the
>> +     patterns will be excluded. When combined with --match a tag will be
>> +     considered when it matches at least one --match pattern and does not
>>       match any of the --exclude patterns. Use `--no-exclude` to clear and
>>       reset the list of patterns.
>
> OK, I find this written clearly enough.
>
>> diff --git a/builtin/describe.c b/builtin/describe.c
>> index 94ff2fba0b..2a2e998063 100644
>> --- a/builtin/describe.c
>> +++ b/builtin/describe.c
>> @@ -124,6 +124,22 @@ static void add_to_known_names(const char *path,
>>       }
>>  }
>>
>> +/* Drops prefix. Returns NULL if the path is not expected with current settings. */
>> +static const char *get_path_to_match(int is_tag, int all, const char *path)
>> +{
>> +     if (is_tag)
>> +             return path + 10;
>
> This is a faithful conversion of the existing code that wants to
> behave the same as original, but a bit more on this later.
>
>> +     else if (all) {
>> +             if (starts_with(path, "refs/heads/"))
>> +                     return path + 11; /* "refs/heads/..." */
>> +             else if (starts_with(path, "refs/remotes/"))
>> +                     return path + 13; /* "refs/remotes/..." */
>> +             else
>> +                     return 0;
>
> I think you can use skip_prefix() to avoid counting the length of
> the prefix yourself, i.e.
>
>         else if all {
>                 const char *body;
>
>                 if (skip_prefix(path, "refs/heads/", &body))
>                         return body;
>                 else if (skip_prefix(path, "refs/remotes/", &body))
>                         ...
>         }
>
> Whether you do the above or not, the last one that returns 0 should
> return NULL (to the language it is the same thing, but to humans, we
> write NULL when it is the null pointer, not the number 0).
>
>> +     } else
>> +             return NULL;
>> +}
>
> Perhaps the whole thing may want to be a bit more simplified, like:
>
>         static const *skip_ref_prefix(const char *path, int all)
>         {
>                 const char *prefix[] = {
>                         "refs/tags/", "refs/heads/", "refs/remotes/"
>                 };
>                 const char *body;
>                 int cnt;
>                 int bound = all ? ARRAY_SIZE(prefix) : 1;
>

I found the implicit use of "bound = 1" means "we only care about
tags" to be a bit weird here. I guess it's not really that big a deal
overall, and this is definitely cleaner than the original
implementation.

>                 for (cnt = 0; cnt < bound; cnt++)
>                         if (skip_prefix(path, prefix[cnt], &body);
>                                 return body;
>                 return NULL;
>         }
>
> The hardcoded +10 for "is_tag" case assumes that anything other than
> "refs/tags/something" would ever be used to call into this function
> when is_tag is true, and that may well be true in the current code
> and have been so ever since the original code was written, but it
> still smells like an invitation for future bugs.
>
> I dunno.
>
>> +
>>  static int get_name(const char *path, const struct object_id *oid, int flag, void *cb_data)
>>  {
>>       int is_tag = starts_with(path, "refs/tags/");
>> @@ -140,12 +156,13 @@ static int get_name(const char *path, const struct object_id *oid, int flag, voi
>>        */
>>       if (exclude_patterns.nr) {
>>               struct string_list_item *item;
>> +             const char *path_to_match = get_path_to_match(is_tag, all, path);
>
>> +test_expect_success 'set-up branches' '
>> +     git branch branch_A A &&
>> +     git branch branch_c c &&
>
> Was there a reason why A and c are in different cases?  Are we
> worried about case insensitive filesystems or something?
>
>> +     git update-ref refs/remotes/origin/remote_branch_A "A^{commit}" &&
>> +     git update-ref refs/remotes/origin/remote_branch_c "c^{commit}" &&
>> +     git update-ref refs/original/original_branch_A test-annotated~2
>> +'
>
> Thanks.
