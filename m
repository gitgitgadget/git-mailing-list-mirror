Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D1491FBB0
	for <e@80x24.org>; Wed, 31 Aug 2016 02:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758200AbcHaCzc (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 22:55:32 -0400
Received: from mail-oi0-f43.google.com ([209.85.218.43]:35414 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752194AbcHaCza (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2016 22:55:30 -0400
Received: by mail-oi0-f43.google.com with SMTP id p186so17983310oia.2
        for <git@vger.kernel.org>; Tue, 30 Aug 2016 19:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twitter.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LKO14lO0d6lzpoWREClmd/3OepjKYbYEL4/15Vn+bao=;
        b=N6mjtfAZZOih914zOmIv68br4wOJa6PpK27hSjgTYPaXkCdCdnTOqDwZxGcPOHthov
         2HMU2tAF4pRM7aZ0qT7fa9Pbmj6HPAtHRoHPf9z91IJ74YycVVJalqGnUN+w+a/Cwp4m
         8iarGOJy/aSrkT7U6UoPZ6AtRIFB129hwv3N4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LKO14lO0d6lzpoWREClmd/3OepjKYbYEL4/15Vn+bao=;
        b=eB0XStOoaVyfyqLT/8K1cuTFKuZHWQgmGARneyV1gySbEPlDD/zqiOvX9LR+dELKAw
         piqUda6bzNF5dnceZ9LGxz6hWDfBSxHjQm39zcIFQVlwGqmoUMxEhPBMbU1XbQP0nfOg
         /jx4+aNPqA3kPDIULiyZrkXpM6DpyaJIW8oB+tLIvHTjvZZGhiAfDo4CuxOqfoWdFvOq
         15n0fjzCDh/abwJmg6Hr4CveQS5zdyWdibPrMawA2mvxnC9tSP0R1M8H9SX3ZO43sJzi
         XkVW/XZ6pbaN6pSXQQx7me4XOOHnQYPxt4hHoKkU9XNZ3oafnA7frZW+IA0F5kje0M5Q
         PQpA==
X-Gm-Message-State: AE9vXwNtIztlu1F7caaoPwJObbSnCIaf1lzTltGBNkPPMBg7UIZ1fdjug4gUGl1B3MeM4WrskLV263DlFS53cokc
X-Received: by 10.202.90.138 with SMTP id o132mr7574162oib.111.1472612053498;
 Tue, 30 Aug 2016 19:54:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.55.226 with HTTP; Tue, 30 Aug 2016 19:54:12 -0700 (PDT)
In-Reply-To: <xmqqzinu3zyw.fsf@gitster.mtv.corp.google.com>
References: <CAN5XQftQH8B+hWVh4JQgZwAp+rkbz51P5NZDc_+Tfm0EB1zkew@mail.gmail.com>
 <xmqqlgzf9wch.fsf@gitster.mtv.corp.google.com> <CAN5XQft6S+LG0mBgRFPrMZiOxHSfRhjLmQdeMdBeHKoWQSRUEA@mail.gmail.com>
 <CAPc5daVhY6WdHkXGLYea48uOw0-rTzLLZ=7mNo=VPebZ9AG4jQ@mail.gmail.com>
 <CAN5XQfty6Fshzf6kN7eXhFekU9+=VPwbzEPN1a92yVB=9nm0Vg@mail.gmail.com>
 <CAN5XQfsg_sJbyjfdc=-e85jiCQNUqagwgh6TVOXN+NskZ7KkVw@mail.gmail.com>
 <xmqqbn0b6ua8.fsf@gitster.mtv.corp.google.com> <CA+P7+xosGg955msq-gyKz_HyCZf7fPFQJdKZ3P8U3+poBBfuWA@mail.gmail.com>
 <CAN5XQfsv+BEYDWR6Xjs4mCtYDVR12a2UzB1-_H4A_xfjUUOe2g@mail.gmail.com>
 <CA+P7+xohfRsoV9VXgUrRaXPb9HvCc5gs4-KSWp38X_d_6EfkTA@mail.gmail.com>
 <CA+P7+xpGnsKzBPLVgPNSmZ7K00vY7-eJp7kSHWMRHM+cOsL_XQ@mail.gmail.com>
 <CAN5XQftCC+TUm2Jx4q3V9oFbXndtFx3H+daoB3TD3eWUs6s54A@mail.gmail.com> <xmqqzinu3zyw.fsf@gitster.mtv.corp.google.com>
From:   Uma Srinivasan <usrinivasan@twitter.com>
Date:   Tue, 30 Aug 2016 19:54:12 -0700
Message-ID: <CAN5XQfuoq6MV4e98RzUCG02KvZO6VZAbs1oxAzpdg5zswqpHGw@mail.gmail.com>
Subject: Re: git submodules implementation question
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Heiko Voigt <hvoigt@hvoigt.net>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 30, 2016 at 10:53 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Uma Srinivasan <usrinivasan@twitter.com> writes:
>
>> I think the following fix is still needed to is_submodule_modified():
>>
>>         strbuf_addf(&buf, "%s/.git", path);
>>         git_dir = read_gitfile(buf.buf);
>>         if (!git_dir) {
>>                 git_dir = buf.buf;
>>  ==>               if (!is_git_directory(git_dir)) {
>>  ==>                     die("Corrupted .git dir in submodule %s", path);
>>  ==>               }
>>         }
>
> If it is so important that git_dir is a valid Git
> repository after
>
>         git_dir = read_gitfile(buf.buf);
>         if (!git_dir)
>                 git_dir = buf.buf;
>
> is done to determine what "git_dir" to use, it seems to me that it
> does not make much sense to check ONLY dir/.git that is a directory
> and leave .git/modules/$name that dir/.git file points at unchecked.
>

Okay.

> But there is much bigger problem with the above addition, I think.
> There also can be a case where dir/ does not even have ".git" in it.
> A submodule the user is not interested in will just have an empty
> directory there, and immediately after the above three lines I
> reproduced above, we have this
>
>         if (!is_directory(git_dir)) {
>                 strbuf_release(&buf);
>                 return 0;
>         }
>

Good to know about this use case.

> The added check will break the use case.  If anything, that check,
> if this code needs to verify that "git_dir" points at a valid Git
> repository, should come _after_ that.

Okay.

>
> Shouldn't "git-status --porcelain" run in the submodule notice that
> it is not a valid repository and quickly die anyway?  Why should we
> even check before spawning that process in the first place?

I don't see any reason to disagree with this.

>
> I might suggest to update prepare_submodule_repo_env() so that the
> spawned process will *NOT* have to guess where the working tree and
> repository by exporting GIT_DIR (set to "git_dir" we discover above)
> and GIT_WORK_TREE (set to "." as cp.dir is set to the path to the
> working tree of the submodule).  That would stop the "git status" to
> guess (and fooled by a corrupted dir/.git that is not a git
> repository).
>

Here's where I am struggling with my lack of knowledge of git
internals and the implementation particularly in the context of how
environment variables are passed from the parent to the child process.

Are you suggesting that we set up the child process environment array
(the "out" argument) in prepare_submodule_repo_env() to include
GIT_DIR_ENVIRONMENT and GIT_WORK_TREE_ENVIRONMENT in addition to
CONFIG_DATA_ENVIRONMENT that is there now?  Can I use the strcmp and
argv_array_push() calls to do this? There are several callers for this
routine prepare_submodule_repo_env(). Would the caller pass the git
dir and work tree as arguments to this routine or would the caller set
up the environment variables as needed? Is there any documentation or
other example code where similar passing of env. vars to a child
process is being done?

Sorry for all these questions but I'm still a novice as far as the
code is concerned.

Thanks for your help.

Uma
