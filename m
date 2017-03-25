Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C95322095E
	for <e@80x24.org>; Sat, 25 Mar 2017 18:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751616AbdCYSBx (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Mar 2017 14:01:53 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:38395 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751501AbdCYSAO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2017 14:00:14 -0400
Received: by mail-it0-f49.google.com with SMTP id y18so17982269itc.1
        for <git@vger.kernel.org>; Sat, 25 Mar 2017 10:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZEJUURjISmUqVADpim8w/gWpQIhCWmr9izBbthO3oJc=;
        b=rilHfZIAGayxgRfPvaejdXvOqLqJITVzeVAdnlDdedxKdCsMkIxjjg3MIhWkFKc7eE
         As1zq5usN5WYceNbDzwwKuVzjO6KrsGrDaoW4VMHQkCZoopr66tmjS6OhOreqcd2BQNI
         9qcU94Cl5M+6nbkfiAJDWevdXIdLijT90o9aVGqFITMwLvhgtyNLurlqzKp1hkh/IxmX
         JLulnGBuNANF1SXaQGYCiBnQYuA2k1qYiT2PlveQ5y7uZQd/YGOhoL+KF4ZNy0laUNIn
         nQWYuLHPRCpav4qmBYf/Vj7i90tiBoDA0odlVX+54XNQZuZ9Va2YsXfjV4XL4p6PtpfC
         Vq1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZEJUURjISmUqVADpim8w/gWpQIhCWmr9izBbthO3oJc=;
        b=j36O0uf6tQixQM3FJvxIC8tl2cQlqnjlo8NuFQPxHzF8F8yHJRmOhJC8+1nb8cQQ2h
         pjv1mFd7cxWLIjPI174fURjWO8MWgqltTH4CZ4ZYsXSOrmC+zjwA+XHcu4beftRgxU7S
         ZoAcGgECb/kf+piOsQPRtsrtg90Ngtt3JrWrcw/VUMMBNIQRR0u3VN0n4INwJFzXT3J9
         VxjPMbg4UFstz3Zsloy4u4DcLp7QYdyjV68Wf2pGLNav/jGV1viANJdRWw6yi1E4MIgw
         mnQ4bMRL0cYiY6nglFnnhNK2BGTHSd0AQBH8CiO6qz7aDXBuZ/VhvUPqOTsu7olb56t/
         BnJQ==
X-Gm-Message-State: AFeK/H32LEav2gM8vTC+vER7HqjDmKmNGdfuJe7EfJQvwL2ZImfjRrXh4Mzrf3AwOPHFuxqPOs+1LZqc7x0XIw==
X-Received: by 10.36.95.85 with SMTP id r82mr2510054itb.91.1490464301669; Sat,
 25 Mar 2017 10:51:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Sat, 25 Mar 2017 10:51:21 -0700 (PDT)
In-Reply-To: <CANgJU+WR4L-7-r97od7ids6VK9QyO-QzAntbg7SazmPGj0yWXA@mail.gmail.com>
References: <CACBZZX6F47uC9jLxppgkUnwVpGV2jpzzP4kwTuqKgayCevomeA@mail.gmail.com>
 <CANgJU+UCJ9qR-pi9w3+oYjEwDdhbtNX9Nv6brj31VXvt-k-3Lw@mail.gmail.com>
 <CACBZZX7dXsdu0bwt4Rznregw4=v=Sc3cFTQbxJcb-ynf3HXq3Q@mail.gmail.com>
 <CANgJU+UG1JGYomyQa1FgyN8Q6SkPeEtGKEJfNETrkbtGwrMn9g@mail.gmail.com>
 <CACBZZX4Haah8JmSG6BbfpdOA1aAxtjiuYirLH4=jt01kHL4eQA@mail.gmail.com> <CANgJU+WR4L-7-r97od7ids6VK9QyO-QzAntbg7SazmPGj0yWXA@mail.gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sat, 25 Mar 2017 18:51:21 +0100
Message-ID: <CACBZZX5bK=emjaQ80J7QuTHXHm=nT3G80zq4xogMqC7Eq9Bs+g@mail.gmail.com>
Subject: Re: Will OpenSSL's license change impact us?
To:     demerphq <demerphq@gmail.com>
Cc:     Git <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 25, 2017 at 5:57 PM, demerphq <demerphq@gmail.com> wrote:
> On 25 March 2017 at 17:35, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab=
@gmail.com> wrote:
>> On Sat, Mar 25, 2017 at 10:43 AM, demerphq <demerphq@gmail.com> wrote:
>>>
>>>
>>> On 25 Mar 2017 10:18 a.m., "=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason" <av=
arab@gmail.com>
>>> wrote:
>>>
>>> On Sat, Mar 25, 2017 at 9:40 AM, demerphq <demerphq@gmail.com> wrote:
>>>> On 25 March 2017 at 00:51, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <ava=
rab@gmail.com>
>>>> wrote:
>>>>> They're changing their license[1] to Apache 2 which unlike the curren=
t
>>>>> fuzzy compatibility with the current license[2] is explicitly
>>>>> incompatible with GPLv2[3].
>>>>
>>>> Are you sure there is an issue? From the Apache page on this:
>>>>
>>>> Apache 2 software can therefore be included in GPLv3 projects, because
>>>> the GPLv3 license accepts our software into GPLv3 works. However,
>>>> GPLv3 software cannot be included in Apache projects. The licenses are
>>>> incompatible in one direction only, and it is a result of ASF's
>>>> licensing philosophy and the GPLv3 authors' interpretation of
>>>> copyright law.
>>>>
>>>> Which seems to be the opposite of the concern you are expressing.
>>>
>>> The Apache 2 license is indeed compatible with the GPLv3, but the Git
>>> project explicitly uses GPLv2 with no "or later" clause
>>>
>>>
>>> Read the paragraph immediately (I think) after the one I quoted where t=
hey
>>> state the situation is the same with GPL v2.
>>
>> My understanding of that paragraph is that it's still laying out
>> caveats about exactly how GPLv3 is compatible with Apache 2, when it
>> is, when it isn't etc. But then it goes on to say:
>>
>> """
>> Despite our best efforts, the FSF has never considered the Apache
>> License to be compatible with GPL version 2, citing the patent
>> termination and indemnification provisions as restrictions not present
>> in the older GPL license. The Apache Software Foundation believes that
>> you should always try to obey the constraints expressed by the
>> copyright holder when redistributing their work.
>> """
>>
>> So they're just deferring to the FSF saying it's incompatible, the
>> FSF's statement:
>> https://www.gnu.org/licenses/license-list.html#apache2 "this license
>> is not compatible with GPL version 2".
>>
>> Anyway, I'm not a lawyer. Just thought I'd send some E-Mail about this
>> since I noticed it, if it's an issue (and we could e.g. get the SFC to
>> comment, Jeff?) we might need to add e.g. some checks / macros to
>> ensure we're not compiling against an incompatible OpenSSL.
>
> Just for the record this what Apache says, with the part I was
> referring to earlier in slash style italics, and a couple of a key
> points in star style bold:
>
> ----quote----
> Apache 2 software *can therefore be included in GPLv3 projects*,
> because the GPLv3 license accepts our software into GPLv3 works.
> However, GPLv3 software cannot be included in Apache projects. *The
> licenses are incompatible in one direction only*, and it is a result
> of ASF's licensing philosophy and the GPLv3 authors' interpretation of
> copyright law.
>
> This licensing incompatibility applies only when some Apache project
> software becomes a derivative work of some GPLv3 software, because
> then the Apache software would have to be distributed under GPLv3.
> This would be incompatible with ASF's requirement that all Apache
> software must be distributed under the Apache License 2.0.
>
> We avoid GPLv3 software because merely linking to it is considered by
> the GPLv3 authors to create a derivative work. We want to honor their
> license. Unless GPLv3 licensors relax this interpretation of their own
> license regarding linking, our licensing philosophies are
> fundamentally incompatible. /This is an identical issue for both GPLv2
> and GPLv3./
> ----quote----
>
> I read that as saying that you can use Apache 2 code in GPL projects,
> but you can't use GPL code in Apache projects. Which makes sense as
> Apache 2 is more liberal than GPL.

In GPLv3 projects only, not GPLv2 projects. The paragraphs you're
quoting all explicitly mention v3 only, so statements like
"incompatible in one direction" only apply to Apache 2 && GPLv3, but
don't at all apply to GPLv2, which is what we're using.
