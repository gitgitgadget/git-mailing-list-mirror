Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E860C1F859
	for <e@80x24.org>; Mon, 22 Aug 2016 17:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755944AbcHVRny (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Aug 2016 13:43:54 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:35071 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752999AbcHVRnw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2016 13:43:52 -0400
Received: by mail-it0-f49.google.com with SMTP id x131so99607588ite.0
        for <git@vger.kernel.org>; Mon, 22 Aug 2016 10:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=C7XRcYdmf8DDEdLSM4pPKMnwN0zV0C/QNsh7JdK5usA=;
        b=FKKViOcRP+jQklLm1CIX+QJRDhF+LtbA8BSsLv/5m/6Das3uiwtkz4vKbPStNTewzf
         D8oJmdqN0eZo0NO5olDyDyKaVtUDVhjj4VqMjc+C9Asfn1g2Ngbf3xwKJ/pnXS6cxfIQ
         691jpA4DvhhifoMRHflfRxf2cj44Z/AUKyZB/d7wqMZsbtVjTuRwWrU6hVRFDiafhtxq
         zZ23NPW20j6jrC0PgKg2R37jLvW73b02UPSJSSrkuW3Z0808pyEZ7DE6yhBmcmIorMv6
         0rJ5OGcBFepwniNcijJIhP1/6TMwBcdP1ZIUAIuSGPVRZ11OYGOm0PHZ7lqSrCdlBT9y
         OEZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=C7XRcYdmf8DDEdLSM4pPKMnwN0zV0C/QNsh7JdK5usA=;
        b=gAkhVoOphRAegunpAr+MOcua6hLnlsoqJrHj4IVsW/SQjVY7IMKHQsMwk8oV02pPKj
         ea8oAnBj2S98isyQlt5F+wnLqU0CjG8clYoRVOYEA/kDG49Jb1fOfOTo/WZFaEmBH257
         /L/zQsJvlay71JzIUF0QezYSKiEJGyuSThsgm2S1Pyz5Vuvd9sQWcpC7dlLqhbQJRmRR
         bfxO2HmGB+4CjyWlk4XJY8dELWSyluSuC+y/ehmCa+0APTsowWXXyaHj06b3f+7DfBj7
         7RB0ALsyH2x3O8WeCvZX2v0b+uVJ04SSqx9Rbx53At682sqXM61JqHQiwh/3b/LpZ8ud
         F6Xg==
X-Gm-Message-State: AEkooutWu548h9a9zVPC/ZdEuAhHECyArAo4VgvhMFjwnlN2gc4QNtzOd2VACKdkIiv5BfAReLhGp/Z+T7Tew5JN
X-Received: by 10.36.227.7 with SMTP id d7mr5565451ith.97.1471887805021; Mon,
 22 Aug 2016 10:43:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Mon, 22 Aug 2016 10:43:24 -0700 (PDT)
In-Reply-To: <CA+P7+xoazoY49cXMghVQmCd=X-aEj6xCTqQqr69zciFZAqmw_Q@mail.gmail.com>
References: <20160819233432.15188-1-jacob.e.keller@intel.com>
 <CAGZ79kZqkHO58kUvP772jfTUgyYXxYuDkgGB1sOTYYQ6nLCP4A@mail.gmail.com> <CA+P7+xoazoY49cXMghVQmCd=X-aEj6xCTqQqr69zciFZAqmw_Q@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 22 Aug 2016 10:43:24 -0700
Message-ID: <CAGZ79kaZS==if2OVz+tusYQGSmhtJ0MgR66_LAd=Fv2yKhw90A@mail.gmail.com>
Subject: Re: [PATCH v9 0/8] submodule show inline diff
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 19, 2016 at 11:16 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
>>
>>> +               if (submodule_config)
>>> +                       strbuf_git_path(buf, "%s/%s", "modules",
>>> +                                       submodule_config->name);
>>> +               else
>>
>> I do not think we want to assume the path as the name for the fallback, though.
>>
>
> I couldn't think of anything better to do.... There is no error return
> flow, so just... leave it as is maybe?
>
>> If `submodule_config == NULL` then
>> a) the path/name doesn't exist in the given version.
>>     (If null_sha1 is given, HEAD + working tree is assumed, whereas
>>     you could also check for a specific commit of the superproject
>>     with another sha1)
>
> I can't check for a specific version here because there is no
> mechanism to pass in the value we'd check it in... Maybe I need a
> separate function for that to check the specific sha1 instead of using
> nullsha1? But.. no I don't think that makes sense, we use the current
> working tree to get the submodule and then lookup old references in
> it... but if we checked an old tree it might be in the wrong path
> which does us no good because the name no longer matches? Hmmm

I agree, null_sha1 is the way to go.

>
>>
>> b) or the submodule config cache was not initialized
>>    (missing call to gitmodules_config())
>>
>> c) There is no c) [at least I never came across another reason for a
>> NULL return here]
>>
>> Using the path as the fallback is errorprone (e.g. to b. in the future
>> and then you get the wrong submodule repository which is shaded by
>> assuming the path and it is hard to debug later or write forward looking
>> tests for that now)
>
> Sure, but if it doesn't exist we just fail.. so what should I put in
> the string? just leave it empty? The function doesn't have an error
> return at the moment.

I thought a die(...) would be better instead.
Looking at the callers of do_submodule_path
(which is wrapped via strbuf_git_path_submodule and
git_pathdup_submodule), we end up in

./refs/files-backend.c:
    get_packed_ref_cache
    resolve_gitlink_ref_recursive
    read_loose_refs

other submodule related code:
    module_clone
    add_submodule_odb

The refs code doesn't have error handling code at the places where
we do the call to submodule path handling, so I think a die(..)
is still ok, as these cases would only happen if your super project
is hosed. e.g. I think to get into this state you'd roughly do this:

    git submodule update --init
    # make path and name different:
    git mv sub-foo sub-bar

    # (I think) two ways to hose a repository now:

        # a) delete the actual submodule repository
        rm -rf .git/modules/sub-foo

        # or b) rename the submodule name to break the
        # assumption of .git/modules/<name> as the sub repo path.
        git config -f .gitmodules --rename-section submodule.sub-foo
submodule.sub-void

    # now exercise the refs code:
    git status

A wrong path would do no harm in this case; in fact it is better to go
with a non existent wrong name as it then falls back to the error handling
of the refs code.

However, assume the path would exist. (As that happens when you
"swap" two submodules in their path, i.e. when a submodule path becomes
another submodules name.

In that case I think "bad things" may happen to the other submodule?

So after typing all this out, I think a call to die(..) is still the way to go.

Thanks,
Stefan
