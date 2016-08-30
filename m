Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 916801F6C1
	for <e@80x24.org>; Tue, 30 Aug 2016 17:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932924AbcH3Rkj (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 13:40:39 -0400
Received: from mail-oi0-f52.google.com ([209.85.218.52]:35628 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932463AbcH3Rki (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2016 13:40:38 -0400
Received: by mail-oi0-f52.google.com with SMTP id p186so1228070oia.2
        for <git@vger.kernel.org>; Tue, 30 Aug 2016 10:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twitter.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SCDJTk1/zfJ8sapBm/BYUwZC2U7zN9Xnm9xteYb4VdQ=;
        b=mKZkHx6E/WFW9OjA5QpVnLah3tBnK7RNG/sU5zEmKNS8+XQduHV5ALrD2XXbRrwA5R
         Z+j7rvwqDu9gBQWdbX4JtTsxWS2r8H2vXfpbOqJuN0Bs7qspViTI9QOMVz1bUAlYMTm1
         bgWkD3LrpI0WVqU56BNA05bGRgyxuFtMtrjZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SCDJTk1/zfJ8sapBm/BYUwZC2U7zN9Xnm9xteYb4VdQ=;
        b=VL0ErdZ67oqRBn5ij7sUwBeMt1zF/AA0+Uoj9seKIVuVkRCb7JyGOnTeCzuI1lJbEm
         JdnEPHyYgjGgZgnXEqPh07jZ4IfjhGg+PC7qQr8z28eiIQgxdo9Z/iLHfnvZxgkXbU79
         ArRuTYSI2aU6U+GFvk8vSNd8ey5WLx8ySrlR6AvgDxQdq+b5kiMH8LbHQxMMr2hlfIPJ
         Ut3iaPnJO6Cm4AR7IX7o+YuCvzYRkWMRVtuoNNOk9vM4qbm6FlxYDE3sbyvWDjCjNCLK
         mL0UX/FZR/xXGQvAy2VJci7c8mGpI6tgBl/EiUnFfYMb8sMZLQzTjQL3FYCiRVDcEGt3
         A7lA==
X-Gm-Message-State: AE9vXwNFVAEX4mdDcP9lxVNt6dn2OdDfe0DwBJGG8GTWOmEB0RqClajEPmpesaO8xShZqPzxNnOH4AoDkGeXuGqe
X-Received: by 10.202.218.2 with SMTP id r2mr5093850oig.177.1472578837025;
 Tue, 30 Aug 2016 10:40:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.55.226 with HTTP; Tue, 30 Aug 2016 10:40:36 -0700 (PDT)
In-Reply-To: <CA+P7+xpGnsKzBPLVgPNSmZ7K00vY7-eJp7kSHWMRHM+cOsL_XQ@mail.gmail.com>
References: <CAN5XQftQH8B+hWVh4JQgZwAp+rkbz51P5NZDc_+Tfm0EB1zkew@mail.gmail.com>
 <xmqqlgzf9wch.fsf@gitster.mtv.corp.google.com> <CAN5XQft6S+LG0mBgRFPrMZiOxHSfRhjLmQdeMdBeHKoWQSRUEA@mail.gmail.com>
 <CAPc5daVhY6WdHkXGLYea48uOw0-rTzLLZ=7mNo=VPebZ9AG4jQ@mail.gmail.com>
 <CAN5XQfty6Fshzf6kN7eXhFekU9+=VPwbzEPN1a92yVB=9nm0Vg@mail.gmail.com>
 <CAN5XQfsg_sJbyjfdc=-e85jiCQNUqagwgh6TVOXN+NskZ7KkVw@mail.gmail.com>
 <xmqqbn0b6ua8.fsf@gitster.mtv.corp.google.com> <CA+P7+xosGg955msq-gyKz_HyCZf7fPFQJdKZ3P8U3+poBBfuWA@mail.gmail.com>
 <CAN5XQfsv+BEYDWR6Xjs4mCtYDVR12a2UzB1-_H4A_xfjUUOe2g@mail.gmail.com>
 <CA+P7+xohfRsoV9VXgUrRaXPb9HvCc5gs4-KSWp38X_d_6EfkTA@mail.gmail.com> <CA+P7+xpGnsKzBPLVgPNSmZ7K00vY7-eJp7kSHWMRHM+cOsL_XQ@mail.gmail.com>
From:   Uma Srinivasan <usrinivasan@twitter.com>
Date:   Tue, 30 Aug 2016 10:40:36 -0700
Message-ID: <CAN5XQftCC+TUm2Jx4q3V9oFbXndtFx3H+daoB3TD3eWUs6s54A@mail.gmail.com>
Subject: Re: git submodules implementation question
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Heiko Voigt <hvoigt@hvoigt.net>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the patch. Unfortunately, it doesn't help in my case as it
invokes the is_submodule_modified() routine which you didn't modify.
Here's my call trace....

#0  is_submodule_modified (path=path@entry=0x17c2f08 "groc", ignore_untracked=0)
    at submodule.c:939
#1  0x00000000004aa4dc in match_stat_with_submodule (
    diffopt=diffopt@entry=0x7fffffffde18, ce=ce@entry=0x17c2eb0,
    st=st@entry=0x7fffffffd840, ce_option=ce_option@entry=0,
    dirty_submodule=dirty_submodule@entry=0x7fffffffd83c) at diff-lib.c:81
#2  0x00000000004ab4f5 in run_diff_files (revs=revs@entry=0x7fffffffd920,
    option=option@entry=0) at diff-lib.c:217
#3  0x000000000054c0d4 in wt_status_collect_changes_worktree
(s=s@entry=0x7de280 <s>)
    at wt-status.c:559
#4  0x000000000054ecf6 in wt_status_collect (s=s@entry=0x7de280 <s>)
at wt-status.c:678
#5  0x0000000000422171 in cmd_status (argc=<optimized out>,
argv=<optimized out>,
    prefix=0x0) at builtin/commit.c:1390
#6  0x0000000000405abe in run_builtin (argv=<optimized out>,
argc=<optimized out>,
    p=<optimized out>) at git.c:352
#7  handle_builtin (argc=1, argv=0x7fffffffe570) at git.c:551
#8  0x0000000000405dd8 in run_argv (argv=0x7fffffffe320, argcp=0x7fffffffe32c)
    at git.c:606
#9  cmd_main (argc=1, argc@entry=2, argv=0x7fffffffe570,
argv@entry=0x7fffffffe568)
    at git.c:678
#10 0x0000000000405060 in main (argc=2, argv=0x7fffffffe568) at common-main.c:40


I think the following fix is still needed to is_submodule_modified():

        strbuf_addf(&buf, "%s/.git", path);
        git_dir = read_gitfile(buf.buf);
        if (!git_dir) {
                git_dir = buf.buf;
 ==>               if (!is_git_directory(git_dir)) {
 ==>                     die("Corrupted .git dir in submodule %s", path);
 ==>               }
        }


Thanks,
Uma

On Mon, Aug 29, 2016 at 11:23 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Mon, Aug 29, 2016 at 11:09 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
>> On Mon, Aug 29, 2016 at 5:12 PM, Uma Srinivasan <usrinivasan@twitter.com> wrote:
>>> This is great! Thanks Jake. If you happen to have the patch ID it
>>> would be helpful.
>>>
>>> Uma
>>>
>>
>> http://public-inbox.org/git/1472236108.28343.5.camel@intel.com/
>
>
> Actually correct patch is
> http://public-inbox.org/git/20160825233243.30700-6-jacob.e.keller@intel.com/
>
> Thanks,
> Jake
