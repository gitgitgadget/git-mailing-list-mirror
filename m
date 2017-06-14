Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E6D120282
	for <e@80x24.org>; Wed, 14 Jun 2017 18:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751774AbdFNSow (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 14:44:52 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:36166 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751644AbdFNSov (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 14:44:51 -0400
Received: by mail-pg0-f45.google.com with SMTP id a70so3894956pge.3
        for <git@vger.kernel.org>; Wed, 14 Jun 2017 11:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CHoJqp4TnEMyCXjfx5hiCkERTJ37uT2YupK6L0VI8BM=;
        b=NkHUQvBcqbfnbrQ19aO8iMy/wnhiqkIqdOfFkcvSm2DqKhVIFgJSfCrqvU5IwDmdLW
         hUrY2baX84U2YjbaVxzwfEvMEq9WNNjaVaOZO14mexpZ8No1h9jySfb49G8s7lpYGOGD
         qTUkLqXdJNgVM+ttVFBVxbpQIjbUiEvADXm0XJtVeAMWeDx6czoF7v0MkJfxVfHQ7ZYe
         8iHaYE1Sm+HHR++PeklGIsf7Z/mh4wHugx6sfCT7GyS27WRHVpYZAv1/kFAUBjsWHDs4
         6raPLoCocws0Zbpi1enil/y2HLeD2/pJxgeO46luxRfPcG+WhVioSFLIlWoRPxjxjia/
         PH0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CHoJqp4TnEMyCXjfx5hiCkERTJ37uT2YupK6L0VI8BM=;
        b=VfUk/PUPIywb5Al0Gferga5kbvh8s0DNeucNDu2nIkKqiNbGtulymBdbs576X1yjn0
         8uIqs+aGwTaYBXxzMCnDhoExps1lsY2jI9tTjK1HNlQGGJ8tvE4wjfW5wwXQRlxkxpcX
         iQqe9UekLLN2Xdm3mcnFvXGNmqgLaRR57wYGoOMJkLVzXRtEA5Co5WrcRtJVH2LloPey
         IXltnTKTGSn2tAky3MNK37ERbSD1RkvHqST/3pyxBEmP4d9QcwQ/6lAa6wh+0AhTQYb7
         tGVgkIYbQ5KFc5mUbH9ZQgNRDboAoGgeATixk8hJqvj0kXIgQZ2cDzxBfB7tC0UBhPgj
         nZJg==
X-Gm-Message-State: AKS2vOztAwI+ELehSTsrT9k7seS22F1L8DNCxuCdb1vcCjNtUOs6+xBu
        chSB+3UltThiF4naekZFqwhfoLO4Y20h
X-Received: by 10.84.137.165 with SMTP id 34mr1537593pln.167.1497465890774;
 Wed, 14 Jun 2017 11:44:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.218.134 with HTTP; Wed, 14 Jun 2017 11:44:50 -0700 (PDT)
In-Reply-To: <xmqqo9tq51yq.fsf@gitster.mtv.corp.google.com>
References: <xmqq1sqzkrui.fsf@gitster.mtv.corp.google.com> <CAGZ79kY2Z-fJYxczbzheu1hChLkKkdjEcDMwsP-hkN0TjUBotQ@mail.gmail.com>
 <xmqq8tl5apkk.fsf@gitster.mtv.corp.google.com> <CA+P7+xpvZDHum-A4omMySTebgBLFzhkpD=DiL-_Mm_Qv-OkMaw@mail.gmail.com>
 <CA+P7+xpCWUBap757N45DrGjvh+v51dg=A9MNOgN8xfVDqZtvog@mail.gmail.com>
 <CAGZ79kZU-QGYAiv+9tK9UoujuLVD8Ejar=zaHVm8YR2p4cbgOQ@mail.gmail.com> <xmqqo9tq51yq.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 14 Jun 2017 11:44:50 -0700
Message-ID: <CAGZ79kasPxbGLUEkvQ0sOJtjTvGO0BvAeUF_LeOiFNEhd7VBfg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jun 2017, #03; Mon, 5)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 14, 2017 at 2:54 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> The color experts agreed that (3) might be the best solution
>> as this gives most flexibility:
>>
>>     "I would be happy as I can configure the bounds highlighting
>>     to not exist, it would degenerate to a pure Zebra, which is
>>     very simple to understand. Junio seemed to like (2) a lot, so
>>     he would configure both dim colors to be 'context', but configure
>>     the highlight colors to be attention drawing. So everybody would
>>     be happy. It is also not too many colors, we are good at for loops."
>
> Another thing I found a bit confusing in the description of choices
> in the documentation was that description for some began with "Based
> on X.", and as a plain reader, I couldn't tell if that is saying
> "the implementation happens to be similar or shares code with X"
> (which is not all that interesting to the end user) or "the meaning
> this mode tries to convey is the same as X but the presentation is a
> bit different" (in which case the end user is hinted that it is
> benefitial to understand what informacion the mode X shows and how).

it is the latter, as I wanted to save typing. Maybe it was savings
at the wrong place.

>
> For example, I view what I prefer (i.e. (2)) as a variant of Zebra
> (i.e. (1)).

Ok, so in a reroll I'll add Zebra as the base (It conveys all
information that we have, any further modifications is just giving
a better finish to the painting.) and then make commits on top of it
adding the taping and water-dunking method on top.

By organizing it in multiple commits the algorithm may become clearer.

> Conceptually, you paint the diff output using water
> soluble paint into a Zebra pattern, then apply thin strips of
> protective tape to places where two Zebra colors are adjacent to
> each other (i.e. do not cover the boundary between a block of a
> Zebra colored moved lines and a block of context lines), dunk the
> whole thing in water and then remove the strips of tape.  Regions
> covered by the strips of tape will retain the Zebra colors, while
> the remainder of the Zebra colored part are colored in a much subdued
> way.  Understanding how Zebra mode marks the moved lines would help
> understanding its output, but your implementation may not share much
> code with the actual implementation of Zebra-painting.
>
> Thanks.
>

Thanks,
Stefan
