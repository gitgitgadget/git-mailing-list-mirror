Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAF6D201CF
	for <e@80x24.org>; Thu, 18 May 2017 19:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932857AbdERTP1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 15:15:27 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:35299 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932107AbdERTP0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 15:15:26 -0400
Received: by mail-pg0-f50.google.com with SMTP id q125so27073051pgq.2
        for <git@vger.kernel.org>; Thu, 18 May 2017 12:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Ym5/a1Z+QVK+B8Ej9AqVrWNiwFxJHz5FSc9Jby5MW/M=;
        b=pPGOurWYu72usWi96amMaeWm/u15E+Lm/LsA+ZJ1cBYO4X9nS23wpbRoP1qjnUbj9b
         dLsn505L84Riib1lYEAEY/V5EP0D449VTlze7Lr4AhV9x/94R2mkpLac8YJfBq4WJE7S
         I1mb35swi++amL72v3kuqQ5uA5dnipuW9XFN6skVdCnYQmbxVYknseUOjTPr6HayEfFc
         sUbEGvU5sHxmQkLmz6DsxO7qo9w6qpCenTe1DfpS2giDkp1Lm6ieeMRQFT3JaiHiwB+4
         /5WR8FXB1+g7euUJZEKWcFiKNOe2a5s7XEIF3oaynRBWOWcrLqw+6d4aLNd2KRokIRqo
         utTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Ym5/a1Z+QVK+B8Ej9AqVrWNiwFxJHz5FSc9Jby5MW/M=;
        b=Cud89Hv05T8dzwLWP3N2uB9uHDR6csKt1yIBgNDrD7ie+eMOsDEBxeTzYzD3Vg4DaQ
         ChEQFSigZI7bGtKAWFgs3t74a0YDhsKkEXk05n0/Q6RNJIzmDlvtIZdscf8EXuCd2QhR
         jD14cpQvTfa9OD5dZkOa8v4IZx8Lnh7itQB9BdyH/haxeRmQYScRwFc88IGpq51nh7I0
         cTpea0XQg6bXR8x3XPQ79/EAmPudo54gNEKoGsDFq+Ryr3M6lYE8jFISGq+a+gRztbwr
         S27j/2/e34a+w4fcbw6aqZlzoRbgX/uMxQVXT+er/M3pS74JmokhL0+vnN98UjKIm3eD
         AgMw==
X-Gm-Message-State: AODbwcBHP41YxqHT8c0BU7AMheXCgWDguqNUcCBsENETaocK8MF4YLcy
        Y3Onj9Bk07joKSDsygLlZ+eKJUhbqf7ejSz21A==
X-Received: by 10.98.60.206 with SMTP id b75mr6151857pfk.19.1495134925467;
 Thu, 18 May 2017 12:15:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Thu, 18 May 2017 12:15:25 -0700 (PDT)
In-Reply-To: <20170518190027.GD112091@google.com>
References: <20170517213135.20988-1-sbeller@google.com> <20170517213135.20988-2-sbeller@google.com>
 <20170518153508.GA112091@google.com> <CAGZ79kZZF7L0Wv5kPO+LxM6_7tA=DrD2RSn9SM708yvnxPnW3A@mail.gmail.com>
 <20170518190027.GD112091@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 18 May 2017 12:15:25 -0700
Message-ID: <CAGZ79kb+31h6f_9fuUpbfeY7xxjP-kbvqz6J5K5sbPEmdPNvpw@mail.gmail.com>
Subject: Re: [PATCH 1/3] submodule.c: add has_submodules to check if we have
 any submodules
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 18, 2017 at 12:00 PM, Brandon Williams <bmwill@google.com> wrote:
> On 05/18, Stefan Beller wrote:
>> >> +static enum {
>> >> +     SUBMODULE_CONFIG_NOT_READ = 0,
>> >> +     SUBMODULE_CONFIG_NO_CONFIG,
>> >> +     SUBMODULE_CONFIG_EXISTS,
>> >> +} submodule_config_reading;
>> >
>> > Any way we can have this not be a global, but rather a parameter?  You
>> > could pass in a pointer to this value via the callback data parameter in
>> > the submodule_config function.
>>
>> As said in the reply to Junio, this patch has been sitting on my hard drive
>> for a while and was written before you started the attempt to de-globalize
>> the state of git.
>>
>> Ideally this setting would be part of the repository object. For example
>> the repository object would have a "submodule_config" pointer, initialized
>> to NULL, which can then be set to the read config or a static empty_config
>> if no such config exists.
>
> I'm not quite sure I agree, or rather we may be talking about two
> different things or I'm misinterpreting the patches.  From these patches
> it seems like 'submodule_config' that you are refering to is not the
> actual submodule configuration but rather some options that are stored
> in .git/config or other various config locations (home, system, etc).

You are reading the patch correctly.

> What would need to be part of the repository object (and is in my WIP
> that I'll hopefully send out so i can get some feedback) would be the
> submodule_cache which is the internal representation of a repository's
> .gitmodules files.

and in the light of this patch, we'd want to have a cache the flag if the
regular config contains any submodule related things, so for now a static
seems to be the best option and once we have the repo object we'd
have a bit from the flags section (assuming we'll have a flags
section down the road):

struct repo {
    ....
    struct regular_config *config_ptr;
    unsigned config_has_submodule_stuff : 1;
    unsigned config_loaded_submodule_config : 1;
}

Then the caching decision would be:

static int submodule_config(const char *var, const char *value, void *cb)
{
       struct repo *r = cb;
       if (!strcmp(var, "submodule.fetchjobs")) {
               r->config_has_submodule_stuff = 1;
               parallel_jobs = git_config_int(var, value);
               if (parallel_jobs < 0)
                       die(_("negative values not allowed for
submodule.fetchJobs"));
               return 0;
       } else if (starts_with(var, "submodule.")) {
               r->config_has_submodule_stuff = 1;
               return parse_submodule_config_option(var, value);
       } else if (!strcmp(var, "fetch.recursesubmodules")) {
               r->config_has_submodule_stuff = 1;
               config_fetch_recurse_submodules =
parse_fetch_recurse_submodules_arg(var, value);
               return 0;
       }
       return 0;
}

void load_submodule_config(struct repo *r)
{
      # assume r->config_has_submodule_stuff and config_loaded_submodule_config
      # was set to 0 on repo init
      if (r->config_loaded_submodule_config)
            return;

      git_config(submodule_config, r);
      r->config_loaded_submodule_config = 1;
}

That said, I agree that the

>> >> +static enum {
>> >> +     SUBMODULE_CONFIG_NOT_READ = 0,
>> >> +     SUBMODULE_CONFIG_NO_CONFIG,
>> >> +     SUBMODULE_CONFIG_EXISTS,
>> >> +} submodule_config_reading;

with its global state is counterproductive for your series, but I see
an easy integration path. As we do not have the repo struct,
I proposed it this way to make submodule progress.

Thanks,
Stefan
