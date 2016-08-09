Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3722B1F859
	for <e@80x24.org>; Tue,  9 Aug 2016 22:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932551AbcHIW5E (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 18:57:04 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:34447 "EHLO
	mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932526AbcHIW5C (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 18:57:02 -0400
Received: by mail-yw0-f193.google.com with SMTP id j12so1186641ywb.1
        for <git@vger.kernel.org>; Tue, 09 Aug 2016 15:57:02 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9Ix9+K6XfGe9SqZlQF1xGKnCLrKL5YKcDbOhYmO8xYE=;
        b=wDqw/mZzlVP5QRlORIE0mG3yUqC/5W/4dtl20xqWs4CP/mbIbUAaBwZ7N5ZEC7QRVW
         P5QhS55vnHIXSPdnzsEWld6uW5ZUejWK3BhV75UFoD1bnYKdqA7HFRTXx8vqo0eoDK1P
         IPf5zaRQDF34DXcFUmJmqlL7BX5b7D9StSyId9qq4BpMQuW4MBr/BziP7Jp27CZ3qHlg
         xuEAaXbgteWx6tmaaPhlY891lwSTUm7eiAYb75ka1hX/7OefvUTHGTJ4L2yoJ9JL2iBk
         V8Fye03i0++OG9MU3Wrk/wh44potYgf57h9vT9ybvFCmBGa6KZxzft9CMgT1i4urI2iA
         Le6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9Ix9+K6XfGe9SqZlQF1xGKnCLrKL5YKcDbOhYmO8xYE=;
        b=A0f3/lVFGbLHQXj6meO63PhhTfP9F8H6Eph2W7Dhq9OJCWlgNyb6/cIKhs0/g4P+Uo
         kN0MKO255tUvwjcHrvLvYSkAb9vG9QI2C+PnqAgNXaK6AE9ItxUB1scAsjGk3j+yBKyk
         sOy3dt6WSO42+EciarRNhl2kxgYBD5ugMk+J5Jaoq6qDekB/av2CwXaSdTo85LvTQd+u
         X23QK2EnT/ShzgVO+kIqf+iiK5U4dhaq0eDRkZDnLukARnjzjF6HPsV26P0NvM8kBxdf
         UskQpApsHANtLd4mVStVSMCfNHSKgigAZJEFKaSvV0Zp/dxswubRP/lbGTeSDWYEOJvB
         kMnQ==
X-Gm-Message-State: AEkoout9eGWclAq9VD8utKy7Wj5chQnBUl0xtFPFYKitsqpa0bEkUdimze9PgMm2YrZVW9EzHtJsUlAcBcFK4g==
X-Received: by 10.13.249.135 with SMTP id j129mr621715ywf.267.1470783421608;
 Tue, 09 Aug 2016 15:57:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.50.196 with HTTP; Tue, 9 Aug 2016 15:56:41 -0700 (PDT)
In-Reply-To: <CAGZ79kbzDhpsfpY8s=7O86_dNLA=VRkyC=8eiCqMambKvUnXmw@mail.gmail.com>
References: <20160809223219.17982-1-jacob.e.keller@intel.com> <CAGZ79kbzDhpsfpY8s=7O86_dNLA=VRkyC=8eiCqMambKvUnXmw@mail.gmail.com>
From:	Jacob Keller <jacob.keller@gmail.com>
Date:	Tue, 9 Aug 2016 15:56:41 -0700
Message-ID: <CA+P7+xqnALzwkgLXrP57BUtFGaxGudAEG7cmGTakP47ofFEjHQ@mail.gmail.com>
Subject: Re: [PATCH RFC] diff: add SUBMODULE_DIFF format to display submodule diff
To:	Stefan Beller <sbeller@google.com>
Cc:	Jacob Keller <jacob.e.keller@intel.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 9, 2016 at 3:50 PM, Stefan Beller <sbeller@google.com> wrote:
> On Tue, Aug 9, 2016 at 3:32 PM, Jacob Keller <jacob.e.keller@intel.com> wrote:
>> From: Jacob Keller <jacob.keller@gmail.com>
>>
>> For projects which have frequent updates to submodules it is often
>> useful to be able to see a submodule update commit as a difference.
>> Teach diff's --submodule= a new "diff" format which will execute a diff
>> for the submodule between the old and new commit, and display it as
>> a standard diff. This allows users to easily see what changed in
>> a submodule without having to dig into the submodule themselves.
>>
>> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
>> ---
>> There are no tests yet. Stefan suggested the use of child_process,
>
> Well you said "I just want this one command but don't know where to put it "
> so it's natural to suggest using child_process.  ;)

Right this is a straight forward way..

>
>> but I
>> really believe there has to be some way of getting the diff without
>> having to run a sub process (as this means we also can't do the diff
>> without a checked out submodule). It doesn't properly handle options
>> either, so a better solution would be much appreciated.
>
> Oh right, we would need to codify all options again (and all future options,
> too)


That's why I'd prefer if we had a way to do this via builtins, because
it would make option passing easier.

>
>>
>> I also would prefer if the diff actually prefixed the files with
>> "path/to/submodule" so that it was obvious where the file was located in
>> the directory.
>>
>> Suggestions welcome.
>>
>> +
>> +       if (start_command(&cp))
>
> I wonder if we want to stay single-execution here,
> i.e. if we rather want to use run_processes_parallel
> for all the submodules at the same time?
>
> Though then non deterministic ordering may be an issue.

There is no easy way to do this, we're given it one module at a time
and it would be a huge re-write to make it go in parallel. I think
that's the wrong way to think about this.

>
>> +               return -1;
>> +
>> +       if (strbuf_read(buf, cp.out, 0) < 0)
>
> So we keep the whole diff in memory
> I don't know much about the diff machinery, but I thought
> the rest of the diff machinery just streams it out?

Yea, but I can't figure out how to do that. Is there an easy way to
stream chunks from the pipe straight into the file?

>
>> +
>> +void show_submodule_diff(FILE *f, const char *path,
>> +               const char *line_prefix,
>> +               unsigned char one[20], unsigned char two[20],
>> +               unsigned dirty_submodule, const char *meta,
>> +               const char *reset)
>> +{
>> +       struct strbuf buf = STRBUF_INIT;
>> +       struct strbuf sb = STRBUF_INIT;
>> +       const char *message = NULL;
>> +
>> +       if (dirty_submodule & DIRTY_SUBMODULE_UNTRACKED)
>> +               fprintf(f, "%sSubmodule %s contains untracked content\n",
>> +                       line_prefix, path);
>> +       if (dirty_submodule & DIRTY_SUBMODULE_MODIFIED)
>> +               fprintf(f, "%sSubmodule %s contains modified content\n",
>> +                       line_prefix, path);
>> +
>> +       if (!hashcmp(one, two)) {
>> +               strbuf_release(&sb);
>> +               return;
>> +       }
>> +
>> +       if (add_submodule_odb(path))
>> +               message = "(not checked out)";
>
> When not checked out, we can invoke the diff command
> in .git/modules/<name> as that is the git dir of the submodule,
> i.e. operating diff with a bare repo?

We can actually do this every time. How would you pass that in a
child_process? I don't think it's "dir" but instead passing
"--git-dir" somehow?

Thanks,
Jake

>
> Thanks,
> Stefan
