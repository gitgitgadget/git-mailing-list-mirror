Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 961761FC46
	for <e@80x24.org>; Fri, 10 Feb 2017 22:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751626AbdBJW4R (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Feb 2017 17:56:17 -0500
Received: from mail-ot0-f171.google.com ([74.125.82.171]:36575 "EHLO
        mail-ot0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751440AbdBJW4Q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2017 17:56:16 -0500
Received: by mail-ot0-f171.google.com with SMTP id 32so39609201oth.3
        for <git@vger.kernel.org>; Fri, 10 Feb 2017 14:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GnVNabrMefwaUaFisBULkZbCyH6FGNMaHzHY8rmIbTc=;
        b=uypPX/QhMFDWP9b1FmtCOS90HDk5idplXuaLfT4Dpz1Z5wYFDItfYStVZCnS9dIjpo
         eGxQ+ibIX3i8vFq6T1HyOC1bIcOSlZhw1imaRLVCNp6+gLfgVITy1lkjMybw0e4t/XtC
         bw22nRg7K221FDvwi1RlgN57iYHWHgwDDFc7Nu9mZDuepmRjk1Tougn1vppQbcIivVf/
         ob5vt7kdDtWUtSYQainurInIIUfGXJ7zP02SJTX9tQ9KUHY5upWYJKgNfpwkyWJu2Mo2
         LUHaa0hZCZwmzeHH+Z0QseQ0nLtlBAQu7BYq/aA3sa1gt69gEdxHnoU04SapDh2J3+Rt
         07yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GnVNabrMefwaUaFisBULkZbCyH6FGNMaHzHY8rmIbTc=;
        b=sFi5e26FwNm3wldf1J2n1hzXXLu2JZhbYpmxR/TaWgrDFHKIMDRmSHpcI+KY0Q5UQl
         TzYVr2UKsImuoTETaBL+86P9877FXGIpv1HNS3s48kll7/xdSKJulI6DG+SPiu6pM7Jd
         ZE8mIQMYBKcMx0eblv7JYMQZgn0hWCoSHXvMXZh4cGlPz5MIY52e+gvhIrpjiwX7YwTF
         52tfVQVm8e4+DmAUW6xjGPLaNgaNNBxvbLUE0hPiy5lBIPh1/nkxRbOApitWyS5bEoEX
         lw2emvDHrf+f/FepxYdcT498sLPgLhOH8aFpRvBpyVgQemEofOAzdwVKVjBTEor2T5Ow
         Tatw==
X-Gm-Message-State: AMke39koJdGWbLrxQJe2/iaO2nKBjfSSg4Sn2vnoKYCM42WixLF+3x4hgCyhou02N7XMxO0b5K66ze7iBCW7eGS0
X-Received: by 10.157.48.51 with SMTP id d48mr5947362otc.207.1486767371626;
 Fri, 10 Feb 2017 14:56:11 -0800 (PST)
MIME-Version: 1.0
Received: by 10.157.39.79 with HTTP; Fri, 10 Feb 2017 14:56:11 -0800 (PST)
In-Reply-To: <xmqqlgtdiroz.fsf@gitster.mtv.corp.google.com>
References: <CAKwvOdn9j=_Ob=xq4ucN6Ar1G537zNiU9ox4iF6o1qO7kPY41A@mail.gmail.com>
 <20170210205749.c72ajnld7zjfjkwj@sigill.intra.peff.net> <CAGZ79kaG=oqDM=1+rz_zk6Qn-7wAszxPnBtqrkAJS29_qT7SoA@mail.gmail.com>
 <20170210214850.2ok62xdmemgotwnt@sigill.intra.peff.net> <xmqqy3xdisos.fsf@gitster.mtv.corp.google.com>
 <xmqqlgtdiroz.fsf@gitster.mtv.corp.google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 10 Feb 2017 14:56:11 -0800
Message-ID: <CAKwvOdmvYiu4ApxL7jVh_0WZUMVeC2jJ4Q_Zs5Z5-J6GNH8DdQ@mail.gmail.com>
Subject: Re: fuzzy patch application
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's not my call about the defaults, but users can be surprised by
such changes.

For the dangers related to fuzzing, is there more info?  I found
and old post on this from Linus calling fuzzing dangerous but
from what I could tell about my patch that wouldn't apply
without fuzzing, the only difference in bad hunks was
whitespace that had diverged somehow.

On Fri, Feb 10, 2017 at 2:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Making "am -3" default may also scare users who are not exactly
>> comfortable with reading "git diff" output during a conflicted merge
>> and resolving a conflict, but other than that there shouldn't be any
>> downside.
>
> Another obvious downside is that there are those of us who prefer to
> run "am" without "-3" first to notice that the patch we expect to
> apply cleanly does apply cleanly, which gives us a chance to catch
> mistakes.  I personally feel that as long as there is a configuration
> that makes -3 a personal default (with --no-3way override from the
> command line), it is a better design not to enable "-3" by default
> for everybody.  New people can first learn using both forms and then
> after they got comfortable with resolving merges, they can choose to
> flip the default for themselves.



-- 
Thanks,
~Nick Desaulniers
