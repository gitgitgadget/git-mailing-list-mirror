Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 764961F859
	for <e@80x24.org>; Fri, 12 Aug 2016 21:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752359AbcHLVWL (ORCPT <rfc822;e@80x24.org>);
	Fri, 12 Aug 2016 17:22:11 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:35516 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752180AbcHLVWJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2016 17:22:09 -0400
Received: by mail-yw0-f196.google.com with SMTP id r9so1612089ywg.2
        for <git@vger.kernel.org>; Fri, 12 Aug 2016 14:22:09 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XUgyFasAO4D6T7wfgo8MGUd4IG+ZQvq51s52ERVYAFo=;
        b=PPUveHnHfXshodyp2IN3DLjgLq/709gi007VYHs2fxKcLwbfm+yQjqH4fBOriqlbsc
         /KtcJsf0nqmmGVZKFZk7kY4XV2rAItK08U4CnB1FmLq2Xye6nK7+m/OrCRPNkMkT3o4P
         9c54K66LBk/Vo/GOc6WVw3er4z/IaY/Xf7ZOC0wnYRr0ScB1HjrptRY8ageomyAXWc4c
         cGhUGsYmAzyS751j68llRZe43Xba8jiSTrocK8TTzD5pfgKjFMWS9H/DdeZB8tY49jcW
         weHbixCLGKutVt5d6tEBMc6ndRYSHtmH0iUHf8V52SEkacTuLwAUffdSnm2fne3beMOR
         zI2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XUgyFasAO4D6T7wfgo8MGUd4IG+ZQvq51s52ERVYAFo=;
        b=VpY/AMnakiUxNUuR2LnrMqSPqCJL0FRNPNq1N6P1Thr5e8deKKTHG3/q2Ezs3U31vD
         QkGUr4jo4p7kPNkO4GZgHG58Kdcv3TaG9CtOekZVhCyIg+k5ha496VhKuSt7zGoXN7aI
         C/0cKJZa4BD2XnNtKtqBme4UedaEgX1x8/2rKeQzfiHQ8hC6LPaIKEk8weieZAI2XDh9
         bZhCx3NpUreq0pdM46W3vYCSuowXC87/S+7KcsyePUD1SvVmIcvhFUzKUrubKjjkzjcN
         gXW7CXM+dQBbCUxiOFcaqsMPZQGKjs6yhykb3VXSLUcwibqm7dRAPsmJiOyuCQn7WeGj
         40XQ==
X-Gm-Message-State: AEkoousY3txBq0du6/ci3wXhCqwJi6Vf45G745rhdFQLZ5x7n2WReiuRyZN1n9sWCNr65NU5MKWXqxWWtnl0bA==
X-Received: by 10.13.249.135 with SMTP id j129mr12882731ywf.267.1471036928768;
 Fri, 12 Aug 2016 14:22:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.50.196 with HTTP; Fri, 12 Aug 2016 14:21:48 -0700 (PDT)
In-Reply-To: <xmqqvaz5vgc7.fsf@gitster.mtv.corp.google.com>
References: <20160811225946.18381-1-jacob.e.keller@intel.com>
 <20160811225946.18381-2-jacob.e.keller@intel.com> <xmqqvaz5vgc7.fsf@gitster.mtv.corp.google.com>
From:	Jacob Keller <jacob.keller@gmail.com>
Date:	Fri, 12 Aug 2016 14:21:48 -0700
Message-ID: <CA+P7+xoX6AT7tGb5AJr1CSjzAQ67o8QXJFF1LxsV_7E_pF-moA@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] diff: add --diff-line-prefix option for passing in
 a prefix
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Jacob Keller <jacob.e.keller@intel.com>,
	Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Aug 12, 2016 at 2:15 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.e.keller@intel.com> writes:
>
>> The prefix shall come first prior to any other prefix associated with
>> the --graph option or other source.
>>
>> Add tests for the same.
>>
>> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
>> ---
>> - v5
>> * Changed name to --diff-line-prefix since --line-prefix might indicate
>>   for other commands such as log, when it only modifies diff output
>
> As you are adding this to "diff.c", I think the option would be
> visible to "git log" anyway, and more importantly
>
>     git log --line-prefix='I I ' --graph --boundary -p HEAD^..HEAD
>
> should honor the line-prefix for the log message part.  I'd expect
> that its output would be like:
>
> I I * commit 3c90ffd2f01e2d0d080c8e42df2ee89709b324de
> I I | Author: Jacob Keller <jacob.keller@gmail.com>
> I I | Date:   Thu Aug 11 15:59:45 2016 -0700
> I I |
> I I |     diff: add --diff-line-prefix option for passing in a prefix
> I I |
> I I |     Add an option to pass additional prefix to be displayed before diff
> I I |     output. This feature will be used in a following patch to output correct
> I I |     ...
> I I |     Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> I I |     Signed-off-by: Junio C Hamano <gitster@pobox.com>
> I I |
> I I | diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> I I | index 705a873..f924f57 100644
> I I | --- a/Documentation/diff-options.txt
> I I | +++ b/Documentation/diff-options.txt
> I I | ...
>
> Otherwise, a "git log --graph -p --submodule=log-with-diff", when
> showing a commit in the superproject that changes submodule from
> commit A to commit B, wouldn't be able to run "git log --graph -p A..B",
> i.e. as if the command recursed beyond the module boundary, would
> it?
>

Hmmmm, yes. I'll dig through and see if I can get the prefix to be
honored by the git log as well.

Thanks,
Jake

>
>
