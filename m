Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 924B6C433EF
	for <git@archiver.kernel.org>; Wed,  6 Jul 2022 22:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbiGFWm4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jul 2022 18:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbiGFWmz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jul 2022 18:42:55 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBE923BFE
        for <git@vger.kernel.org>; Wed,  6 Jul 2022 15:42:54 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id bw5-20020a056a00408500b005251b5ea852so5041564pfb.4
        for <git@vger.kernel.org>; Wed, 06 Jul 2022 15:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=NV+GLCd5fMc0OJ8l0bwXBOxozzVkcF1ygZ+WwpmjHvY=;
        b=o01NHMPXe5gJ3vS/Ja21ScpQPLpQGNV4XfjL5c8JArfv+QPnErY1Bi6jpQ1KKlDFMi
         uZXdgEczZR6+VBNEPa9faJ/gzI+BMWP6yfOITjxq7bT1wR6rTjnBqlzocseio8b3XXv9
         0aXXgrQ092lzO0hycpM3EGd79Yzhd1yphiWhQQ8zxr3kZpftCBRBcrNVuLA7tSq3hukn
         m4mS7HrAPPw78XwjPRVPHLCGp7eU/SWNeyE5OiUoEPnNHeyPYsU/YMtxLKho9M8Gq17Q
         WhdzpZFsF9BmMPgxtGm4IrQFQYik/Upx2eRbz0Q4o+aCVkjxxfO8224ZI09/ahL6UcbB
         9lcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NV+GLCd5fMc0OJ8l0bwXBOxozzVkcF1ygZ+WwpmjHvY=;
        b=brldgQ/zcHKxvDLHV16IfNpnTe6KK6LYaOM5o8W4wTs6PQ3/I98pwKhfuyVTsow7Fb
         lXMFOPXVx40qjqRxm/tUBtPd2IRvX2UE9BgZkabmd/vZFfb7mKBXZeY9BYsyFp9pnjXE
         ydcvfCTH/moERcKncOzid7O4zSXSJU2JccJXZnL3fBV4v8TlgQ5ZVYPun6RzgETIrsFn
         J7H5/iTYrQqOUipzOlOvJHmEZhqyh/O43A0WwXLBod2NnG7iqSgYKDKiLNZsShXj+zKM
         wcKbPO+cydBWeVVTEYwa8iQMWuq+DVKTuz12fFIX1lbNEG0yg4v7AZtc8ISwSIyIw96E
         3P1Q==
X-Gm-Message-State: AJIora9Su07Tnp9yKTXTsrzEf1EvwoqxEtVOx69dmq+chOv6duFDQKi5
        TboiqXtJGflwQDFQn/EfsH7okATyjFQ+lw==
X-Google-Smtp-Source: AGRyM1sBtlrNC/EKaHhpeVm9l07VgG7ImM5NOgasNyWEx+1YuVPKlvFEXjVWdgOdGs+0Ch2Ru5c245Js46t+Fw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:d5c7:b0:16c:131:7409 with SMTP id
 g7-20020a170902d5c700b0016c01317409mr5924376plh.80.1657147373918; Wed, 06 Jul
 2022 15:42:53 -0700 (PDT)
Date:   Wed, 06 Jul 2022 15:42:46 -0700
In-Reply-To: <Yr5MZhgTBFgZh/XB@nand.local>
Message-Id: <kl6lczehsw0p.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <pull.1261.v5.git.git.1656354994.gitgitgadget@gmail.com>
 <pull.1261.v6.git.git.1656612839.gitgitgadget@gmail.com> <3efe282e6b94c3daed77590c5f601fad34137c9c.1656612839.git.gitgitgadget@gmail.com>
 <Yr5MZhgTBFgZh/XB@nand.local>
Subject: Re: [PATCH v6 3/5] config: learn `git_protected_config()`
From:   Glen Choo <chooglen@google.com>
To:     Taylor Blau <me@ttaylorr.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Thu, Jun 30, 2022 at 06:13:57PM +0000, Glen Choo via GitGitGadget wrote:
>> In light of constraint 1, this implementation can still be improved
>> since git_protected_config() iterates through every variable in
>> protected_config, which may still be too expensive. There exist constant
>> time lookup functions for non-protected configuration
>> (repo_config_get_*()), but for simplicity, this commit does not
>> implement similar functions for protected configuration.
>
> I don't quite follow along with this paragraph: it sounds like reading
> protected configuration is supposed to be as fast as possible. But you
> note that only the slower variant of reading each configuration variable
> one at a time is implemented.

Right. I should have been clearer that this implementation is "fast
enough without introducing too much noise/complexity", and not "as fast
as possible".

> If we care about speed (and I think we should here), then would it make
> more sense to implement only the lookup functions like
> repo_config_get_*() for protected context? That would encourage usage by
> providing a more limited set of options to callers.

I held off on implementing these functions because:

- It requires rewriting `safe.directory`, which reads a multivalued
  string using a config iterator. It's not onerous to do (I had a POC
  of this at some point), but it seemed pretty noisy.
- It seems too noisy to implement all of the protected_config_get_*()
  functions, and a little inconsistent to only implement the ones used
  in this series (but maybe a little inconsistency is ok?)

But maybe a little noise and inconsistency is worth the performance
improvement, especially since it's been brought up ~1.5 times before
this [1] [2]. I'll do this for sure if you feel strongly about it,
otherwise I'll just try it out just to see what I think about it.

[1] https://lore.kernel.org/git/802c3541-3301-43fc-c39e-edd44e61a4eb@github.com
[2] https://lore.kernel.org/git/xmqqbkv4t7gp.fsf@gitster.g

>> Signed-off-by: Glen Choo <chooglen@google.com>
>> ---
>>  config.c                     | 51 ++++++++++++++++++++++++++++++++++++
>>  config.h                     | 17 ++++++++++++
>>  t/t5544-pack-objects-hook.sh |  7 ++++-
>>  upload-pack.c                | 27 ++++++++++++-------
>>  4 files changed, 91 insertions(+), 11 deletions(-)
>>
>> diff --git a/config.c b/config.c
>> index 9b0e9c93285..29e62f5d0ed 100644
>> --- a/config.c
>> +++ b/config.c
>> @@ -81,6 +81,18 @@ static enum config_scope current_parsing_scope;
>>  static int pack_compression_seen;
>>  static int zlib_compression_seen;
>>
>> +/*
>> + * Config that comes from trusted sources, namely:
>
> Should we be using the word "scope" here instead of sources? I think
> it's clear enough from the context what you're referring to, but in the
> spirit of being consistent...

Good catch.

>> + * - system config files (e.g. /etc/gitconfig)
>> + * - global config files (e.g. $HOME/.gitconfig,
>> + *   $XDG_CONFIG_HOME/git)
>> + * - the command line.
>> + *
>> + * This is declared here for code cleanliness, but unlike the other
>> + * static variables, this does not hold config parser state.
>> + */
>> +static struct config_set protected_config;
>> +
>>  static int config_file_fgetc(struct config_source *conf)
>>  {
>>  	return getc_unlocked(conf->u.file);
>> @@ -2378,6 +2390,11 @@ int git_configset_add_file(struct config_set *cs, const char *filename)
>>  	return git_config_from_file(config_set_callback, filename, cs);
>>  }
>>
>> +int git_configset_add_parameters(struct config_set *cs)
>> +{
>> +	return git_config_from_parameters(config_set_callback, cs);
>> +}
>> +
>>  int git_configset_get_value(struct config_set *cs, const char *key, const char **value)
>>  {
>>  	const struct string_list *values = NULL;
>> @@ -2619,6 +2636,40 @@ int repo_config_get_pathname(struct repository *repo,
>>  	return ret;
>>  }
>>
>> +/* Read values into protected_config. */
>> +static void read_protected_config(void)
>> +{
>> +	char *xdg_config = NULL, *user_config = NULL, *system_config = NULL;
>> +
>> +	git_configset_init(&protected_config);
>> +
>> +	system_config = git_system_config();
>> +	git_global_config(&user_config, &xdg_config);
>> +
>> +	git_configset_add_file(&protected_config, system_config);
>> +	git_configset_add_file(&protected_config, xdg_config);
>> +	git_configset_add_file(&protected_config, user_config);
>> +	git_configset_add_parameters(&protected_config);
>> +
>> +	free(system_config);
>> +	free(xdg_config);
>> +	free(user_config);
>> +}
>> +
>> +/* Ensure that protected_config has been initialized. */
>> +static void git_protected_config_check_init(void)
>> +{
>> +	if (protected_config.hash_initialized)
>> +		return;
>> +	read_protected_config();
>> +}
>> +
>> +void git_protected_config(config_fn_t fn, void *data)
>> +{
>> +	git_protected_config_check_init();
>
> This may be copying from an existing pattern, but I think you could
> avoid the extra function declaration by writing git_protected_config()
> as:
>
>     if (!protected_config.hash_initialized)
>         read_protected_config();
>     configset_iter(&protected_config, fn, data);

You're right, I can drop this if I don't implement
protected_config_get_*(); this pattern only makes sense for
git_config_check_init() because it's called by multiple functions.

> Thanks,
> Taylor
