Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A2272027C
	for <e@80x24.org>; Tue, 30 May 2017 13:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751148AbdE3NhX (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 09:37:23 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:35584 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750951AbdE3NhW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 09:37:22 -0400
Received: by mail-pf0-f173.google.com with SMTP id n23so72712063pfb.2
        for <git@vger.kernel.org>; Tue, 30 May 2017 06:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=V4pT/MDkq3a1ZlQGZ2YiRSuiY/X4ee5q5uWqSO5SANg=;
        b=TspoAHcSr6TGqITqVl0NQPiZxbQNCHEqZuG3vcAtfpJG2+0GiwlQidb+aWJkhLIvJQ
         OkO9y2Y2fLg+Gh41EDdIvd98phM+3KOfBD4+Xo+ZtxLR0ElAXQllG0MWcwb5cuY+zXBW
         CoafcVzyDJZfYaLfeRzeRxtXVDo/3PBGPPFgMfqyEOpgy8HWNHRhAW5YbzNSiASwo6aY
         S7zTATyWg1a/X/fZ8GRor9dhBhzbc5RETnwgSi4wjCWxcPQH/0imCy5fviw0KJYg7/Nw
         j33s0iX8++xjH539wWexoBxIuEz9NBwIDWWPLrc+i6Gk00DIHejmakYDeqEnx76Wz3si
         AVQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=V4pT/MDkq3a1ZlQGZ2YiRSuiY/X4ee5q5uWqSO5SANg=;
        b=JJpqX8HGs4ezWOFsk3dTbr9SPq6+YsL6fHhJGpTFiixrNjWBShE4Zjpfs2ZcnZ7RJm
         eXQmDlP3uw4sa3qM9h8ZG9MAHnSCIn46c8XXYQ/3YHxMfvUadSsfXb8vRkVg/6vZzJPs
         MkcMGxZTqcmXQlhWoU+wb6eE2ZiljQkZLC7u5mAodSmvP1InKn/Zn8tK7NBLBQfPWS1n
         d0dFvXGglRHRZioIz229osv/BWFVqJ+uITm5gvdTaAprKbMfxy6CZElUnkg4UTwep8YY
         2TzkZ3PWDil48CnctYzU/nlAXoqg+fa1kvLq+1zeoeEqauhZt7CD4hj7r4KY1TgT4Tqd
         6hYQ==
X-Gm-Message-State: AODbwcCyk3IUaatUhuHnXdrNirL0gIcfedCMUb8ea3kIY875dKRKsWGp
        zMTdwmqiGLi34h01N5Y=
X-Received: by 10.99.1.207 with SMTP id 198mr25089616pgb.37.1496151441718;
        Tue, 30 May 2017 06:37:21 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:f830:fc5f:a16b:f475])
        by smtp.gmail.com with ESMTPSA id a78sm26172154pfk.122.2017.05.30.06.37.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 30 May 2017 06:37:20 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Laszlo Ersek <lersek@redhat.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: FORMAT_PATCH_NAME_MAX increase
References: <99ac8ee7-67b5-5ae7-51cf-6be38de6217f@redhat.com>
        <CACBZZX5U=U1bpiFuuxH2t8ZWnmQQAjWm1ji8XYq_6-SJPGL1sw@mail.gmail.com>
        <c2453701-979b-ebc7-dcc3-483a27d4c157@redhat.com>
        <85970ab4-e9c8-c6b6-11d3-faafd3ed0708@redhat.com>
        <CACBZZX4-T50q_eVWwJuBzoC6ocuG+v14Tm8wfK8h7FB_cMQzdQ@mail.gmail.com>
Date:   Tue, 30 May 2017 22:37:20 +0900
In-Reply-To: <CACBZZX4-T50q_eVWwJuBzoC6ocuG+v14Tm8wfK8h7FB_cMQzdQ@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 30 May
 2017 14:41:03
        +0200")
Message-ID: <xmqqfufmbh4f.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> Just curious do you know about https://github.com/trast/tbdiff ? If
> not it might have a high overlap with what you're doing.

Yes, that is a very good suggestion.  You'd need to be able to
actually apply the patches but the way I often do a review is very
similar to (actually, I'd say it is identical workflow) Laszlo's,
and it goes like this:

    $ git checkout topic ;# previous round
    $ git checkout master... ;# check out the fork point of previous one
    $ git am mbox ;# apply the updated one
    $ git tbdiff ..@{-1} @{-1}..

With the second step, the commit immediately before the previous
round of patches were applied to is checked out as a detached HEAD,
and then with the third step, the updated patches are applied.
After these two steps, the history leading to HEAD is the latest
patches, and the history leading to topic (which can be referred to
as @{-1}, i.e. the branch we were previously on) is the previous
round.

"git tbdiff" takes two ranges and compares these two series of
commits.  The first one says "commits included in the branch we are
previously on (i.e. topic), excluding the ones on the current HEAD",
which means "the patches from the previous round", and the second
one says "commits included in the current HEAD, excluding the ones
on the previous branch (i.e. topic)", which means "the patches from
this latest round".

After that, I may conclude

    $ git checkout -B @{-1}

to update the tip of 'topic' with the latest set of patches (the
reason why I type @{-1} is because that can stay constant in the
workflow, no matter what the actual topic branch is called).
