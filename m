Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 931151FA7B
	for <e@80x24.org>; Fri, 16 Jun 2017 21:10:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751812AbdFPVKs (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Jun 2017 17:10:48 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:37787 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750907AbdFPVKr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2017 17:10:47 -0400
Received: by mail-wm0-f53.google.com with SMTP id d73so32670020wma.0
        for <git@vger.kernel.org>; Fri, 16 Jun 2017 14:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=qDy8JPzWL9F9aVFaKdU0iyNudpnsEpwV3BMW4xbjc7A=;
        b=bUSV6+6K/qD+VZn+U4EWNEtLOz7oTnw+iPi8N/KSxFuESoAcpEv2/vYf+EdqpayKlg
         zt1Ru+xqZGI5FDUUu+H06RAKmBTNP2tVYjC1fYZ0WCVVo0scLzcDuXznxHUDmToP4HYX
         V8ONjUuLRNOHyCVlVDXWQPRGxn17Pv7WloupEuspwbl5dBBaK0+5Wpxn1iP5jxzwtUn8
         DAPl9GVvhr6OIs1QPFPSFquwjs0v8U5Ofl9CSf+L+Nu9TJDin8B/xMurEcVr/Hyf8Aoi
         TV96Vz+iShB9lIh3CH2DDwdkix4K2Iqn1AIeILb11GXF/kybNR7q8RDdrCpRI+kPqCh3
         zLvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=qDy8JPzWL9F9aVFaKdU0iyNudpnsEpwV3BMW4xbjc7A=;
        b=JZ0uPGyo1W4SK1EBaOSgQdS9/IiE1clJHmk5sSOiIbGPwid1vR+xQTjcNCyLNuu/yB
         GUuQOiDf2J32gjWSYCGjG5slVfszasKAUQi0LfWtMT4GP0NLEF9nK1PvJ1+WT//kgU8Q
         56EHHItBgNpr602EJlGdltDfJgpT2Xss6TJ69G1kKv8HQApM0SQyYbvwj0AYs7p5HD04
         0dOa8b18zBv/Xxs2KRzhCUqpxxcbAP4O46OsMhb7T4OuDgfOqd/mWdB2Qiq9OMj7LKap
         Fk6MLQfn5L+vluo2UyXJGXiPmBsY6AwjFIjmPRgYx/lV6TaOv78JvHUVSP4VOs0O+Tgh
         fstg==
X-Gm-Message-State: AKS2vOzX8qg5iWSeQ+uug4QzrhfoNush1DJUG19tS0jNdAu6zoObvlZD
        dnqROMZqgdaZ9g==
X-Received: by 10.80.152.22 with SMTP id g22mr8672081edb.10.1497647445558;
        Fri, 16 Jun 2017 14:10:45 -0700 (PDT)
Received: from snth ([92.109.130.42])
        by smtp.gmail.com with ESMTPSA id o1sm2589650edc.22.2017.06.16.14.10.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Jun 2017 14:10:44 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1dLyVv-0001yP-Ll; Fri, 16 Jun 2017 23:10:43 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCHv5 2/2] Documentation/clone: document ignored configuration variables
References: <CAM0VKjmxtqB2zrWOW8T9O1ReWNPTZA7V3-Dei7GecB3nxVh2Dg@mail.gmail.com> <20170616173849.8071-1-szeder.dev@gmail.com> <20170616173849.8071-3-szeder.dev@gmail.com> <87wp8b94gb.fsf@gmail.com> <20170616204109.GB133952@aiede.mtv.corp.google.com>
User-agent: Debian GNU/Linux 8.8 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <20170616204109.GB133952@aiede.mtv.corp.google.com>
Date:   Fri, 16 Jun 2017 23:10:43 +0200
Message-ID: <87vanv8wq4.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jun 16 2017, Jonathan Nieder jotted:

> Ævar Arnfjörð Bjarmason wrote:
>> On Fri, Jun 16 2017, SZEDER Gábor jotted:
>
>>> --- a/Documentation/git-clone.txt
>>> +++ b/Documentation/git-clone.txt
>>> @@ -186,6 +186,11 @@ objects from the source repository into a pack in the cloned repository.
>>>  	values are given for the same key, each value will be written to
>>>  	the config file. This makes it safe, for example, to add
>>>  	additional fetch refspecs to the origin remote.
>>> ++
>>> +Due to limitations if the current implementation, some configuration
>>> +variables do not take effect until after the initial fetch and checkout.
>>> +Configuration variables known to not take effect are:
>>> +`remote.<name>.mirror` and `remote.<name>.tagOpt`.
>>>
>>>  --depth <depth>::
>>>  	Create a 'shallow' clone with a history truncated to the
> [...]
>> But this is now cooking in pu, Junio: is it clear that this patchu
>> as-cooking ideally shouldn't land in next/master without the fix on top
>> which I mentioned in my mail above? I can just submit that as a patch on
>> top, but I'm confused about the current state with this cooking in pu,
>> so I thought I'd ask first how this should be handled.
>
> I think it's simplest to write a patch on top that discusses --no-tags.
> That way, Junio (and anyone else applying the patch) has the
> flexibility to apply or cherry-pick this change to old branches
> without the --no-tags discussion and newer branches with it.
>
> Would you like to write it (or suggest wording), or would you prefer
> if someone else does?

I can do that no problem.

I just first wanted to clarify what the status of this was, from
SZEDER's comments in the referenced E-Mails I had the impression that
this was only meant for an old maintenance release:

    SZEDER: "I assume because, as a bugfix, it will be included in
    maintenance releases for older releases, and those won't have the
    '--no-tags' option."

But thinking about it I don't see why we'd be doing such minor doc
changes in an old maintenance release. I haven't read the whole backlog
of this topic though, so maybe I missed something.

I initially suggested just adding "Instead supply the --mirror and
--no-tags options, respectively" to the patch quoted above.

But actually, thinking about this again now, and being recently familiar
with this code after having implemented  on --no-tags, I think this
whole wording is just misleading. It makes it sound as though git clone
is init + fetch, and that the initial fetch just ignores these two
specific options because of some quirk of the implementation.

In reality clone doesn't use fetch at all, they just share some of the
underlying fetch machinery.

I think something like this as a replacement is better, assuming this
really needs to be applied to pre-2.13.0:

    diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
    index 35cc34b2fb..2169e5c97f 100644
    --- a/Documentation/git-clone.txt
    +++ b/Documentation/git-clone.txt
    @@ -189,6 +189,14 @@ objects from the source repository into a pack in the cloned repository.
            values are given for the same key, each value will be written to
            the config file. This makes it safe, for example, to add
            additional fetch refspecs to the origin remote.
    ++
    +The underlying implementation of `git clone` isn't equivalent to `git
    +init` followed by a `git fetch`, but the two share some of the
    +underlying fetch machinery. Because of this, setting configuration
    +variables which would impact `git fetch` doesn't have any effect on
    +`git clone` at all. For example, setting `remote.<name>.mirror` and
    +`remote.<name>.tagOpt` will do to change how the initial fetch is
    +carried out.

     --depth <depth>::
            Create a 'shallow' clone with a history truncated to the

Or, in case this just needs to be applied on top of master we can
mention --no-tags:

    diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
    index 83c8e9b394..52a371176e 100644
    --- a/Documentation/git-clone.txt
    +++ b/Documentation/git-clone.txt
    @@ -189,6 +189,16 @@ objects from the source repository into a pack in the cloned repository.
            values are given for the same key, each value will be written to
            the config file. This makes it safe, for example, to add
            additional fetch refspecs to the origin remote.
    ++
    +The underlying implementation of `git clone` isn't equivalent to `git
    +init` followed by a `git fetch`, but the two share some of the
    +underlying fetch machinery. Because of this, setting configuration
    +variables which would impact `git fetch` doesn't have any effect on
    +`git clone` at all.
    ++
    +For example, setting `remote.<name>.mirror` and `remote.<name>.tagOpt`
    +will do to change how the initial fetch is carried out. Instead supply
    +the --mirror and --no-tags options, respectively.

     --depth <depth>::
            Create a 'shallow' clone with a history truncated to the
