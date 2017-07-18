Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12DB71FF30
	for <e@80x24.org>; Tue, 18 Jul 2017 22:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752734AbdGRWro (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jul 2017 18:47:44 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:34871 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751997AbdGRWrl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2017 18:47:41 -0400
Received: by mail-it0-f42.google.com with SMTP id h199so17049121ith.0
        for <git@vger.kernel.org>; Tue, 18 Jul 2017 15:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=hhWVYgK1/Lbx1TCWHdwB0EUiACvykNg2yJvirPZCPVk=;
        b=Bpf2y16GCqnvFW+IHqb18XyI5q4eXb3604X5/GPhi0E+A9JVrKEz4/kUm2d+1u+Yr5
         oVL0Lm5GLoZv4RNTKWytDKKv9759GYX4okMpAX7uOeyn5DspSXBCmbgi4Y7Y5p6V1luU
         tIvZoJOJ//c1d9dmPFpBek5OBOsfb+Bi+Svd8CiWBJAquqeKuWatHiw0SFpc6U5cdfvU
         /whTSFRQSSJ6cbsdgk5UsvwC3pU5/SeJgboqTtf4Vn3OeNA9M4P5+58reQlBSuvrEv0p
         0SVWgCIbRMEiegODM9RLOKx5k7kSIXpNh+s/+Ap5R3U7rzkpKAdJ/lAtU2fgckms7dOb
         fCHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=hhWVYgK1/Lbx1TCWHdwB0EUiACvykNg2yJvirPZCPVk=;
        b=Snj7Zp4ozQ6+eV67mA0YZcx8kyV8iDVUUlxLoYfY433OGIjxDybr/NU+IQ+Uqzgsqq
         UKyGcjhNSdE+8cgbZOU+6cw3mmTehC+yyFk8V+e7XJLbPB81H7sit3QLYwPC25W1xh31
         RjH+0oBJPYlAsoRfglutIxp70vR03r2QyDXv5WDOgI3dp04CguMn+5mSnCB9wCXXpRxI
         1xP5tVsLiPdOGSBL7Df3ahWYV8k7g8cmhauC+7KzGo41HRPpk2mG8bhFD0kexY3soS3w
         jTZg1cNvOMPeyfI1xCOBivLQxILhETLaHzXZQYFJSsBKMzOYvZpxxIZnAB4DUXxSb7mE
         y4zQ==
X-Gm-Message-State: AIVw110bxPZ9aq5aHKlAiQvHY2ZwXBCGtGFvAly+JaZi+jX31/4ngf25
        7I+446cJYzCukxuOrviEzB3RCsywHJh9
X-Received: by 10.36.40.196 with SMTP id h187mr4446499ith.43.1500418060859;
 Tue, 18 Jul 2017 15:47:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.20.136 with HTTP; Tue, 18 Jul 2017 15:47:20 -0700 (PDT)
In-Reply-To: <CAGZ79kYDD076Xbrh19nTPd4DiTsGvO0Zm=P8W-Zv1GFvp9XQOg@mail.gmail.com>
References: <20170718204904.3768-1-pc44800@gmail.com> <20170718204904.3768-5-pc44800@gmail.com>
 <CAGZ79kb48kNggPv64ubbBNK-Sk8AW4eXxhZt=PZZCPKr9OiuLQ@mail.gmail.com>
 <xmqqmv81ml4i.fsf@gitster.mtv.corp.google.com> <CAGZ79kYDD076Xbrh19nTPd4DiTsGvO0Zm=P8W-Zv1GFvp9XQOg@mail.gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
Date:   Tue, 18 Jul 2017 15:47:20 -0700
X-Google-Sender-Auth: aIJA5NSQLcePlGsvem7ZsCIldVI
Message-ID: <CAPc5daUF9ZAm0=icHB+EtZkpaErODczgHJd+XbQ3F6dBfO3VJA@mail.gmail.com>
Subject: Re: [GSoC][PATCH 4/8] submodule: port submodule subcommand 'status'
 from shell to C
To:     Stefan Beller <sbeller@google.com>
Cc:     Prathamesh Chavan <pc44800@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 18, 2017 at 3:44 PM, Stefan Beller <sbeller@google.com> wrote:
> On Tue, Jul 18, 2017 at 3:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>
>>>> +       if (!lstat(list_item->name, &st) && !ce_match_stat(list_item, &st, 0)) {
>>>> +               print_status(info, ' ', list_item->name, sub_sha1, displaypath);
>>>
>>> The question from the last round still stands
>>> https://public-inbox.org/git/CAGZ79kb18z5zc9iu3Vv5aVZWJmoZzmwbMVpy89VC-t-ei2M+bw@mail.gmail.com/
>>>
>>>   I am not an expert in the diff area  and wonder how
>>>   the cmd_diff_files functionality is achieved with just a stat call
>>>   and then comparing it to  ce_match_stat. 'Using "dirty" ignores
>>>   all changes to the work tree of submodules, only changes to the
>>>   commits stored in the superproject are shown.' So I'd have
>>>   expected ce->oid to be compared (is there an index entry differing,
>>>   i.e. more than one stage?)
>>
>> ce_match_stat() calls into ce_compare_gitlink() for a 160000 entry,
>> which would resolve HEAD ref there and compares ce->oid with it.
>
> Oh in that case this should be fine, as in the original we did
> "git diff-files --ignore-submodules=dirty <path>",
> which did precisely that.

Are you sure that this will work correctly when ce is unmerged?
run_diff_files() has quite a lot of code for that case.
