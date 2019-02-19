Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PI_DNOT,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B32D1F453
	for <e@80x24.org>; Tue, 19 Feb 2019 13:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfBSNwx (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Feb 2019 08:52:53 -0500
Received: from mail-ed1-f53.google.com ([209.85.208.53]:43621 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbfBSNwx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Feb 2019 08:52:53 -0500
Received: by mail-ed1-f53.google.com with SMTP id m35so12831732ede.10
        for <git@vger.kernel.org>; Tue, 19 Feb 2019 05:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DkJJhSMxG+vLU+rA/TLkP9XPwz/CGuNBLXiywe1O+iY=;
        b=IiMKN5Y4yfWB9Gl2YZS/4ZnOG1b7TR9nTyuSPVvpBZN+1xIpzWeaX9bAsNd4IRA6iM
         xYrS0tiB9aRf3Cm9iuBCvIieNU7cc6N6bRFZ8AP5GXznMlvORX+aVuqQGuAasZkLA0oX
         YLqFZSlPVh0NdorA9vHcHSXQypOo2xI+EjuH9bL+XJefkr4W7SRZN43BtPjJU+e7QjWa
         uLGJ8lV4dxH41o+FXWRc4FTFboUNtUo9bZgMf4uhUjhfeM9LlIB6xRebJ5AsZZVGH7YW
         ndNKSUyv7ZuTULTTqdhNSasfkr+xk9E9QSfw+Nzxu/VsPjFu5r1JiIco9Z1bMn/BDyAw
         69bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DkJJhSMxG+vLU+rA/TLkP9XPwz/CGuNBLXiywe1O+iY=;
        b=qKveStv2uL/ANNVWYnbsJR8SN7dwFbLh3Ybe4USEclbKvrFUAT69E94xCkPokVL9vc
         xX4k25H4vRzbzbhlTMEXqHznC43aLrF06GuJnmgahyXd4xjbZSnOdfqwEDTf0jcfMcgx
         BZbijAgLtVu4IXqRGODbQeqkQH3WgKwuJywpxRK32BMCmiIjjv10HV0Za6/UapjYUigp
         QZX7PPOAeFyZqUKapnBw5CUi0lmzxx73S9aVK4hJr7piZhiY/VYfz9P9SijUHh9rzuH/
         Z0ciUFoPeaHMm4SxUhmemcrI0mH341AWHk7zmiXq0rwMIL9kM0AdikL9GrkRISTMne+O
         5xEw==
X-Gm-Message-State: AHQUAubpOJUnWrV4wB5KvbgKv1IIC+nE4XHpGrqneChSvVJnuOSZxeHk
        AFUkP2cEHDqoLy21Inq6wBIdTdTXSw50hPNNgUE=
X-Google-Smtp-Source: AHgI3IaGc9i0R8lACBaNOS63x5bmzjUfO7vi2PHabTWwgoJ53O6B3rzDiyNZRt4uiTkXS7GJ9kcebDqlOj2ux/5jXvg=
X-Received: by 2002:a50:d55a:: with SMTP id f26mr7568607edj.292.1550584371382;
 Tue, 19 Feb 2019 05:52:51 -0800 (PST)
MIME-Version: 1.0
References: <001601d4c7aa$460c0e70$d2242b50$@nexbridge.com>
 <xmqqimxh2b61.fsf@gitster-ct.c.googlers.com> <CAFacdQ_9=2hbC8-5+N=RdrGs=Anu2ku+TAj7x07OQNpa1b+gcg@mail.gmail.com>
 <87o97858ko.fsf@evledraar.gmail.com>
In-Reply-To: <87o97858ko.fsf@evledraar.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 19 Feb 2019 14:52:40 +0100
Message-ID: <CAP8UFD0WCmPSb1ccj+yRVEMC8T9oFbznJ6PPuOhGC-BCru6uAg@mail.gmail.com>
Subject: Re: [RFE] Demilitarize Documentation (was RE: Delivery Status
 Notification (Failure))
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Senol Yazici <sypsilon@googlemail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        git <git@vger.kernel.org>, msuchanek@suse.de,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        jpyeron@pdinc.us
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 19, 2019 at 12:23 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> Two things:
>
>  1) Whatever anyone's abstract position on the wording of our
>     documentation, either the one stored in git.git or at
>     https://github.com/git/git-scm.com there's only so much a
>     theoretical discussion like this can get us.
>
>     If you're willing to pursue this further I think it's best if that's
>     done in the form of patches to either repositories, either sent here
>     on-list (see Documentation/SubmittingPatches) or as a PR to
>     https://github.com/git/git-scm.com

I agree.

>  2) Any piece of software or technical tool is going to unavoidably need
>     to use some amount of jargon, or words that are lifted from a more
>     general vocabulary and intended to be understood in context.
>
>     Thus, when we talk about e.g. "trees" in git, it's understood that
>     we're talking about something in the context of this software
>     project, trying to go by the first Google result of "tree" isn't
>     going to get you anywhere.
>
> I for one thing those git-scm docs could be changed to eliminate those
> words for reasons entirely unrelated to them somehow being religious or
> militaristic.

I agree that it would be a much better outcome of this discussion.

>  * The docs already use "integration manager" and then introduce
>    "dictator" as a synonym in the context of explaining the workflow of
>    the kernel.
>
>    They could instead use "main integrator" or something, since the
>    point of the example is to explain how git can be used to manage
>    distributed repositories that are integrated in a hierarchical
>    manner.

I would suggest considering "maintainer" or "main maintainer" or "top
level maintainer", as I think "maintainer" is one of the most common
word used for the role in the Linux kernel and Git communities. By the
way it's often used in expressions like "sub-system maintainer", which
maybe could be used to replace "lieutenant".

(In Git Rev News I think I have always used "the Git maintainer" to
talk about Junio for example.)

>    Making assumptions about how much power the "main integrator" has to
>    approve/reject changes is irrelevant to that explanation.
>
>    E.g. the kernel could also decide to make the "main integrator" some
>    purely automated process that always approves changes from
>    lieutenants and the hierarchical example would be just as true.

Thanks for your insight on this,
Christian.
