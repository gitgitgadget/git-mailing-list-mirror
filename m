Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B4AF2070F
	for <e@80x24.org>; Thu, 15 Sep 2016 22:29:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757015AbcIOW24 (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 18:28:56 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:32972 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757196AbcIOW2d (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 18:28:33 -0400
Received: by mail-io0-f176.google.com with SMTP id r145so7002811ior.0
        for <git@vger.kernel.org>; Thu, 15 Sep 2016 15:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XYCzyCoMl8vwbXRDvOH0B2hU+4Agoweri5IoMGqfRJs=;
        b=GWGP1ugL649y6Rip+Yrrz7C1kBN/SA7iWbPGwxFezThJipbaJDjYNBFIIhmZ+ocRZZ
         3ciCkCraYYTnaBtrUk1q/EKoXEdP8buMqKRJVxs3DagxKKkjNMGENBP0IufSaQnCywSG
         iIlc555nXiJ4jpHwlbDlcf3BBkD0l8QTXqDgqBKHlvjnzsBb2j37JlDiZJaYYBeJvA4M
         KENtLRoigXRcGJcI7aQsUSJMGOlVQc62B3ROFfqboBdbcg2h1UcO6Uhx2/6BhcrhhKU9
         wWg6oj2XDedJHNVxQLVRXJSs2kurlgxK6Su7aBHorEZp0u5wvSfNvxmjcVCQDs/jXnFN
         jLBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XYCzyCoMl8vwbXRDvOH0B2hU+4Agoweri5IoMGqfRJs=;
        b=GU9w4rw2F5U/SSaOV4Txtapz3aSQwSe+BEmF/+sFyF9RHTqsbaK3l0pvVn2P+LriIa
         ZM3gMQHBOYQA3OKgSTjCe1FU5sir2gUfGrDYvcdoBRcZHXYxnA6TxgxNmTmw+evtBYSF
         jiHKNcaq0w8VreoJzcZGf7fLYUg5WcLrYYHrRC48NqPeK4GjvTzPjpFWMVURSSJJ08NY
         HfwHc/hj7STFDkiuyGSxUWzC2mk571CfRsXeKQ+qm8vVJTXWL2mSN3MO00Eqpx4QVtMy
         OQ84RvbbpmO2lt2nECcw1ri1bQ/N+T6L0geZloPII3IWYRJrkXG3OadS6ZdWyD/lfDWx
         hfaQ==
X-Gm-Message-State: AE9vXwM9/QqTrDaB+Iq33NjO8W7ZhheSPBv9WiNOjFQI0kzs9khNRxLldbfLuGBCNV2mdqRUQqM+MAE3tmA7R8pb
X-Received: by 10.107.180.11 with SMTP id d11mr4015679iof.203.1473978501685;
 Thu, 15 Sep 2016 15:28:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.173.98 with HTTP; Thu, 15 Sep 2016 15:28:21 -0700 (PDT)
In-Reply-To: <xmqqr38klst6.fsf@gitster.mtv.corp.google.com>
References: <1473897473-154528-1-git-send-email-bmwill@google.com>
 <20160915115752.GA37903@book.hvoigt.net> <CAKoko1rtEydwbWoEq9MBW41qqa10Bm+x0d6zS+Bptk51RjMOMA@mail.gmail.com>
 <xmqqr38klst6.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 15 Sep 2016 15:28:21 -0700
Message-ID: <CAGZ79kZJUQhY_bEi1G3zMYR2iGq5gosfVsBP_CFoaMydXP6QUw@mail.gmail.com>
Subject: Re: [RFC] extending pathspec support to submodules
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Heiko Voigt <hvoigt@hvoigt.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>,
        Jens Lehmann <jens.lehmann@web.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 15, 2016 at 3:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Brandon Williams <bmwill@google.com> writes:
>
>> You're right that seems like the best course of action and it already falls
>> inline with what I did with a first patch to ls-files to support submodules.
>> In that patch I did exactly as you suggest and pass in the prefix to the
>> submodule and make the child responsible for prepending the prefix to all of
>> its output.  This way we can simply pass through the whole pathspec (as apposed
>> to my original idea of stripping the prefix off the pathspec prior to passing
>> it to the child...which can get complicated with wild characters) to the
>> childprocess and when checking if a file matches the pathspec we can check if
>> the prefix + file path matches.
>
> That's brilliant.  A few observations.
>
>  * With that change to tell the command that is spawned in a
>    submodule directory where the submodule repository is in the
>    context of the top-level superproject _and_ require it to take a
>    pathspec as relative to the top-level superproject, you no longer
>    worry about having to find where to cut the pathspec given at the
>    top-level to adjust it for the submodule's context.  That may
>    simplify things.

I wonder how this plays together with the prefix in the superproject, e.g.

    cd super/unrelated-path
    # when invoking a git command the internal prefix is "unrelated-path/"
    git ls-files ../submodule-*
    # a submodule in submodule-A would be run in  submodule-A
    # with a superproject prefix of super/ ? but additionally we nned
to know we're
    # not at the root of the superproject.

>    So we may have to rethink what this option name should be.  "You
>    are running in a repository that is used as a submodule in a
>    larger context, which has the submodule at this path" is what the
>    option tells the command; if any existing command already has
>    such an option, we should use it.  If we are inventing one,
>    perhaps "--submodule-path" (I didn't check if there are existing
>    options that sound similar to it and mean completely different
>    things, in which case that name is not usable)?

Would it make sense to add the '--submodule-path' to a more generic
part of the code? It's not just ls-files/grep that have to solve exactly this
problem. Up to now we just did not go for those commands, though.

Thanks
