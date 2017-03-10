Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80025202F8
	for <e@80x24.org>; Fri, 10 Mar 2017 11:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933880AbdCJLcB (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Mar 2017 06:32:01 -0500
Received: from mail-io0-f182.google.com ([209.85.223.182]:34851 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933194AbdCJLb5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2017 06:31:57 -0500
Received: by mail-io0-f182.google.com with SMTP id z13so46884349iof.2
        for <git@vger.kernel.org>; Fri, 10 Mar 2017 03:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=i0tU9mZvi7tPEJhw6kFuEfaa19k8gQVlLXZ+F63TyjU=;
        b=TD4aL/2e1YrXz6yyeXyxC39AiSHz6C8ZqETNJOrJa6vvaUyBmuiRX3crsFKQLIrcy4
         VhZGQEjHu5cojLnxYINXwUcRAACZLBF4Jo7dMUuatadvPvgVBKH07LbqtvS6f69fosMe
         Akfa7gRRpEEX7R+0OCGU7sJNhF1b2+Rnszx9AcX/HN9pAuhugFz3bZLvjyJdXP0R5hcS
         3te7lX/6LS50p4bEKXsf1Uke4VfxKnnWK0ThA01Uc/mGTccLo+yh4l+6GMdiv8wnE+Rt
         IN+G+CpUX73ETGTYxJcXpT4+CskmLHBqo3dOQJhH2fZmnrI64iy2/3FyQ1Ab4nO6lwo3
         y2AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=i0tU9mZvi7tPEJhw6kFuEfaa19k8gQVlLXZ+F63TyjU=;
        b=PWJit0uUk1G5/S6wPW+/eKSzbt2KxYol7OoZWr8T5aauqFFoPQsn2iJu0QJ3bZl7Oh
         qfIJijYcLlKAex8SREuKAi5JOtWmYVRoczFMHsxLgasbJkP1nHCZa6eIVj59mJ1jxjNh
         3h+qKByXUVnoAR+h7zigF2gmgIJvkuFGpI0UdFlz4mMUAKaK3RHxVmbEooxWaCcrwSpO
         pGU/RG5iiXQV0YsO2IB0P/yX7fKyVoxJ611BhbMGik/jsxCQSbjlwt2llv9PRzuP0waZ
         nIs7Ra1KRrjKMOXmk0LYmYdW75x5VszKxolU5Hw5Rq9vWzxuGX4CJQ8sYE2YWBt+j63Z
         yN4g==
X-Gm-Message-State: AMke39l9idfgtFGsT4Z7uIXnym77X68yokSM3wmYzgbj6YGa6ar/PsORZoWXoT4uT3cJRfSLB87cL8G2e7xO3Q==
X-Received: by 10.107.57.2 with SMTP id g2mr17565694ioa.117.1489145515636;
 Fri, 10 Mar 2017 03:31:55 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Fri, 10 Mar 2017 03:31:35 -0800 (PST)
In-Reply-To: <20170309145555.kzrttqya3bghdhe4@sigill.intra.peff.net>
References: <20170308202025.17900-1-avarab@gmail.com> <20170309100910.z4h7bwqzxw2xynyu@sigill.intra.peff.net>
 <CACBZZX53rMiB5-cA_7-SeU2Dt7d_Cr7_GgyC0rjQQPPf4qyCqw@mail.gmail.com>
 <20170309104657.7pwreyozxo2tdhk4@sigill.intra.peff.net> <CACBZZX5i+8bQLhLB4DnUAaUw1vA_KQjhtNBvm7drLepPAFFbAQ@mail.gmail.com>
 <20170309125132.tubwxtneffok4nrc@sigill.intra.peff.net> <CACBZZX4W7brFe5ecTvQPMmf4X5_zH+dw3cB5xeVg+2hWYps0Ug@mail.gmail.com>
 <20170309145555.kzrttqya3bghdhe4@sigill.intra.peff.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Fri, 10 Mar 2017 12:31:35 +0100
Message-ID: <CACBZZX7-OBUX5BiMq04HEV+RSPP-WeOmjzbXBi0z7Gf6=fFefw@mail.gmail.com>
Subject: Re: [PATCH] branch & tag: Add a --no-contains option
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Lars Hjemli <hjemli@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 9, 2017 at 3:55 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Mar 09, 2017 at 03:52:09PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> -       filter->with_commit_tag_algo =3D 1;
>> +       if ((filter->merge_commit + filter->with_commit +
>> filter->no_commit) > 1)
>> +               filter->with_commit_tag_algo =3D 0;
>> +       else
>> +               filter->with_commit_tag_algo =3D 1;
>>         filter_refs(&array, filter, FILTER_REFS_TAGS);
>>         ref_array_sort(sorting, &array);
>>
>> I think I'll amend the tip of my WIP v2 to have something like that,
>> and then we can follow-up with making these cases where you supply
>> multiple options faster.
>
> Yeah, that's another option.  I think you may find that it's unbearably
> slow if you have a lot of tags.

It's what I'm going for in my v2 currently. I think it's a rare enough
(and new) use-case that it's OK to slow it down for now & investigate
your line of patching separately.

>> > Looking at this, I'm pretty sure that using "--contains" with "--merge=
d"
>> > has similar problems, as they both use the UNINTERESTING bit. So even
>> > without your patch, there is a lurking bug.
>>
>> I'm currently running this:
>> https://gist.github.com/avar/45cf288ce7cdc43e7395c6cbf9a98d68
>
> Cute. I'll be curious if it turns up anything.

Currently at ~500 attempts out of 5K with no bad results.
