Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 040761F859
	for <e@80x24.org>; Wed, 31 Aug 2016 18:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933997AbcHaSkG (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 14:40:06 -0400
Received: from mail-oi0-f45.google.com ([209.85.218.45]:35426 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933923AbcHaSkF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 14:40:05 -0400
Received: by mail-oi0-f45.google.com with SMTP id p186so48237652oia.2
        for <git@vger.kernel.org>; Wed, 31 Aug 2016 11:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twitter.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QK6+WpkA4m/em0EICaw1kt0muHCGJdMQoQJ9X28Rihc=;
        b=c0ScJELCvIbbvZtPeu3wRlZXFgqPpxEJDVtn/Di08cFgAtktgCvrntQavWwd0iQqyM
         pbDHaMEwPfDqOro/xOtnSVs3AdX7T1iSZTyLZISaImZofec/2cRVkQ7jFcF7P73zs4SL
         /4N0XqbPMktsv0spB+bohPUo3wcDOEf0mcdR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QK6+WpkA4m/em0EICaw1kt0muHCGJdMQoQJ9X28Rihc=;
        b=QFjKlySvsqMiCs4ymV/KyXOrmu7oxARUGsdpVgI/oOE5wV7S4xP88qPSxd3xmlAGmd
         /FLQ6qsl1Rnq3noEpDHutvOCya0577+xZFKi67ZNBgxs+nxlXuoM256ujD8bQMkoeS9D
         yEBeqH4tkHz0IBuerPpk/mvWAJ5IOHT7vLjuA8/WfwUw9dG7w/QGG9dhCBolpFhYkCmm
         NTBIsn0oR7qmJjQ02Une0PP9AsItCVeczjuOw/BSK1aWFa05dvx7weztbalxglssoZi7
         HMtnPGtre2lJ3BaMA2GOmRXJ3qGPAVxGEnWbGbGUxpZ7B4UBWX9fFX9pxoVjJxc5VMc/
         nRig==
X-Gm-Message-State: AE9vXwOY42V2dIktlvx0Vwzl+wUReCNQPyBCpJX59NQ62rRVV8SJ69gu0pZWupVzcDCmhRJ7V0dFqW1Ss0e8pE7u
X-Received: by 10.202.108.86 with SMTP id h83mr10730423oic.92.1472668804053;
 Wed, 31 Aug 2016 11:40:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.55.226 with HTTP; Wed, 31 Aug 2016 11:40:03 -0700 (PDT)
In-Reply-To: <xmqq7faw3n5w.fsf@gitster.mtv.corp.google.com>
References: <CAN5XQftQH8B+hWVh4JQgZwAp+rkbz51P5NZDc_+Tfm0EB1zkew@mail.gmail.com>
 <xmqqlgzf9wch.fsf@gitster.mtv.corp.google.com> <CAN5XQft6S+LG0mBgRFPrMZiOxHSfRhjLmQdeMdBeHKoWQSRUEA@mail.gmail.com>
 <CAPc5daVhY6WdHkXGLYea48uOw0-rTzLLZ=7mNo=VPebZ9AG4jQ@mail.gmail.com>
 <CAN5XQfty6Fshzf6kN7eXhFekU9+=VPwbzEPN1a92yVB=9nm0Vg@mail.gmail.com>
 <CAN5XQfsg_sJbyjfdc=-e85jiCQNUqagwgh6TVOXN+NskZ7KkVw@mail.gmail.com>
 <xmqqbn0b6ua8.fsf@gitster.mtv.corp.google.com> <CA+P7+xosGg955msq-gyKz_HyCZf7fPFQJdKZ3P8U3+poBBfuWA@mail.gmail.com>
 <CAN5XQfsv+BEYDWR6Xjs4mCtYDVR12a2UzB1-_H4A_xfjUUOe2g@mail.gmail.com>
 <CA+P7+xohfRsoV9VXgUrRaXPb9HvCc5gs4-KSWp38X_d_6EfkTA@mail.gmail.com>
 <CA+P7+xpGnsKzBPLVgPNSmZ7K00vY7-eJp7kSHWMRHM+cOsL_XQ@mail.gmail.com>
 <CAN5XQftCC+TUm2Jx4q3V9oFbXndtFx3H+daoB3TD3eWUs6s54A@mail.gmail.com>
 <xmqqzinu3zyw.fsf@gitster.mtv.corp.google.com> <CAN5XQfuoq6MV4e98RzUCG02KvZO6VZAbs1oxAzpdg5zswqpHGw@mail.gmail.com>
 <xmqq7faw3n5w.fsf@gitster.mtv.corp.google.com>
From:   Uma Srinivasan <usrinivasan@twitter.com>
Date:   Wed, 31 Aug 2016 11:40:03 -0700
Message-ID: <CAN5XQfvK7M5eSkMfz5iRTnE_va9VGjONAPO5hmF+iQg-i3XEpQ@mail.gmail.com>
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

FWIW, I tried the following quick change based on the info. provided
by Junio and it seems to "fix" my original problem. I'll let you
experts figure out if we need a more complete fix or not.

diff --git a/submodule.c b/submodule.c
index 5a62aa2..23443a7 100644
--- a/submodule.c
+++ b/submodule.c
@@ -960,6 +960,9 @@ unsigned is_submodule_modified(const char *path,
int ignore_untracked)
                return 0;

        }
+       /* stuff submodule git dir into env var */
+       set_git_dir(git_dir);
+
        strbuf_reset(&buf);

        if (ignore_untracked)
@@ -1279,5 +1282,9 @@ void prepare_submodule_repo_env(struct argv_array *out)
        for (var = local_repo_env; *var; var++) {
                if (strcmp(*var, CONFIG_DATA_ENVIRONMENT))
                        argv_array_push(out, *var);
+               if (strcmp(*var, GIT_DIR_ENVIRONMENT))
+                       argv_array_pushf(out, "%s=%s", GIT_DIR_ENVIRONMENT,
+                                        get_git_dir());
        }
+
 }

Thanks,
Uma

On Wed, Aug 31, 2016 at 9:42 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Uma Srinivasan <usrinivasan@twitter.com> writes:
>
>>> I might suggest to update prepare_submodule_repo_env() so that the
>>> spawned process will *NOT* have to guess where the working tree and
>>> repository by exporting GIT_DIR (set to "git_dir" we discover above)
>>> and GIT_WORK_TREE (set to "." as cp.dir is set to the path to the
>>> working tree of the submodule).  That would stop the "git status" to
>>> guess (and fooled by a corrupted dir/.git that is not a git
>>> repository).
>>
>> Here's where I am struggling with my lack of knowledge of git
>> internals and the implementation particularly in the context of how
>> environment variables are passed from the parent to the child process.
>
> Ah, I was primarily addressing Jacob in the latter part of my
> message, as he's looked at similar things in his recent topic.
>
>> Are you suggesting that we set up the child process environment array
>> (the "out" argument) in prepare_submodule_repo_env() to include
>> GIT_DIR_ENVIRONMENT and GIT_WORK_TREE_ENVIRONMENT in addition to
>> CONFIG_DATA_ENVIRONMENT that is there now?
>
> I was wondering if we should unconditionally stuff GIT_DIR=<the
> repository location for the submodule> in the cp.env_array passed to
> the function prepare_submodule_repo_env().  As cp.dir will be set to
> the submodule's working tree, there is no need to set GIT_WORK_TREE
> and export it, I think, although it would not hurt.
>
> After all, we _are_ going into a separate and different project's
> repository (that is what a submodule is), and we _know_ where its
> repository data (i.e. GIT_DIR) and the location of its working tree
> (i.e. GIT_WORK_TREE).  There is no reason for the process that will
> work in the submodule to go through the usual "do we have .git in
> our $cwd that is a repository?  if not how about the parent directory
> of $cwd?  go up until we find one and that directory is the top of
> the working tree" discovery.
>
> More importantly, this matters when your GIT_DIR for the submodule
> is somehow corrupt.  The discovery process would say "there is .git
> in $cwd but that is not a repository" and continue upwards, which
> likely would find the repository for the top-level superproject,
> which definitely is _not_ want you want to happen.  And one way to
> avoid it is to tell the setup.c code that it should not do the
> discovery by being explicit.
>
