Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8DA120372
	for <e@80x24.org>; Fri,  6 Oct 2017 22:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752122AbdJFWK3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 18:10:29 -0400
Received: from mail-qk0-f174.google.com ([209.85.220.174]:43383 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751917AbdJFWK3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 18:10:29 -0400
Received: by mail-qk0-f174.google.com with SMTP id w134so19293271qkb.0
        for <git@vger.kernel.org>; Fri, 06 Oct 2017 15:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1mgnRYHv4MbpRKZRh+TyU6smbaUpt/qKq8tWr4Gqq+c=;
        b=BOeRQbXiHQfYQo5kz0ctNM+4MA3Of+lKwdbxwdDTUjon7c3PMc+kpkaFOWDS6g6DOC
         e9BNG316KpNR62joVuhtzt2GevPhvR5jgHcM8VvGVBCS8XI+7n7NRlVki4ufKfiejv21
         tB9Xy/kSBjaV4LM5D+NzwTvwbhCM+u+4BPdFJcEoSTUZpBKKMQLSYCO71U53ZM3nlWlR
         HtwBdduhNdCJnuR9HXG8x1BzOIZ2WHKFiBX8zicKjc/8DjjkYKtzhsE7L0V9vHIhXFCy
         xFjutXdyWlxAe+hAFWZDbzLe6Z9kDTNMgjGHrpGL0+pM2a5fq8SvMtQ2s7fV9huXh4r5
         iyRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1mgnRYHv4MbpRKZRh+TyU6smbaUpt/qKq8tWr4Gqq+c=;
        b=Wvm/eZO8Tm5ZIx/dqxxDurreYKSnnQUrq9qVGt3pDqdoYnGqWvdVf+zcKhKNVLXx6+
         C/txEo6UGrJdVXBLR7szH1dzgD4z7q8T2ovyQnFinltyVxoswEw9tGFlSDylhAFKeNiR
         bk+4fMo2fmQb3h1F9Qd2yWQIfWmPIMxEZjnO8cVbAO5KkG/qv6Uh9jq1asxDncVARqML
         gpmGzKsp9ShfYujk7jMjK8O1OQ2xvx68jFUsLP4jmgzQYHnikwyTwPm+Ly2TYE7o6VoL
         C8hZjL3wjU9vK2HAtX/ZBXKwSLJCwHxl+7MZ59QXcEpXk660CyFM9qJrzMQcv3W7Q38b
         VqHQ==
X-Gm-Message-State: AMCzsaVLcCASnLClW36Qmd2We0dYVviW6CwWK6K0cltCcRJig2z5WiEG
        jQQga289u63IUwDngWgf0N6/OFORZGC7355OEvS1IRPJH7s=
X-Google-Smtp-Source: AOwi7QDcq9dyuhs8oQYHD2kEbydiwO0ly4ZsH7n/A/ffcgf0UvabSKGLWbgzg4FVLz58hFkIJ+PRNc/kRkSQ7g/q/Ks=
X-Received: by 10.55.127.7 with SMTP id a7mr430408qkd.45.1507327828272; Fri,
 06 Oct 2017 15:10:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.46 with HTTP; Fri, 6 Oct 2017 15:10:27 -0700 (PDT)
In-Reply-To: <20171006220101.GZ19555@aiede.mtv.corp.google.com>
References: <20171006190006.19623-1-sbeller@google.com> <20171006190006.19623-2-sbeller@google.com>
 <20171006220101.GZ19555@aiede.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 6 Oct 2017 15:10:27 -0700
Message-ID: <CAGZ79kZhF=-baqPPqTCsbdyybOTV+SdvTqYiRbvsvB1epqpkZQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] tests: fix diff order arguments in test_cmp
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 6, 2017 at 3:01 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Stefan Beller wrote:
>
>> Fix the argument order for test_cmp. When given the expected
>> result first the diff shows the actual output with '+' and the
>> expectation with '-', which is the convention for our tests.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>
> Yes, this should make the output from failing tests easier to take in
> at a glance.
>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>
> How did you find these?  E.g. is there a grep pattern that reviewers
> can use to repeat your results?

The grunge work was done via scrolling through

git -C t grep test_cmp

However it occurred to me that checking for the completeness could be done
via

  git -C t grep test_cmp | \
    awk '{$1=""; print }  | \ # remove file name from output
    sort | uniq

There are some cases that are still pretty obvious what the
"actual" and the "expect" is, but they are not included in this patch
as the code (and file names) looked hairy.
