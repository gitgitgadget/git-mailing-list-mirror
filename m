Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F47A2047F
	for <e@80x24.org>; Mon, 18 Sep 2017 17:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754938AbdIRRnl (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Sep 2017 13:43:41 -0400
Received: from mail-wr0-f170.google.com ([209.85.128.170]:50368 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751664AbdIRRnj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2017 13:43:39 -0400
Received: by mail-wr0-f170.google.com with SMTP id w12so1145956wrc.7
        for <git@vger.kernel.org>; Mon, 18 Sep 2017 10:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/IaWmsM5N1tichBDknbora1YxT1jY7BML+U8IYDaJzU=;
        b=gcmzYOb81bhm+GjPiViQPQassD3GPgPay5g228y2SVdpb1oIXOba8z+W1sp0dE0Kew
         q5C67Jh2cefxSh98ccIGFpZBLvEpXzsGfzGG8ghb8crCM2mqe0jVVQbIQIBULNOwoOdd
         k6weyqK6NI9K78XUPluIQpluO1vvDKqnCbYBPs1MjxnOU5OS46SGE/+sSKEBC0w5jaLK
         hTLlf/97eAWrWWJsxc8Qx+Yq6SE9m18vHZI7fHWQMGUcEYSvAjTO3ambirwUuTigI0Ou
         PN6d673Knb8rwIYGZmM6Zgv3ApKMWt8XcwONvg+dq0VvIVT5bGeEv/M4wTdxG9VkIfW2
         8Rig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/IaWmsM5N1tichBDknbora1YxT1jY7BML+U8IYDaJzU=;
        b=ptqSkCKXzbRGz3Yfgr0YWuQLAcdijnYSM1O0SLav2GxVir3Y+mgkJUHP8tgoy4MbNB
         oxeB2vsakZBynFVvLnnTPzVb6QrK9mezDLm30ZYmpNhN/i7FIMew0v0fYZ7+HuriQPiU
         QbywDqt5jzr88KGs811PfeVFc8Hr/s18Bi7IHPvFM1/6Pwyk8TScaBOLK48ltdbnJ4F8
         c1mTC97L/DBXUDD6lL/HhgtGo9kriQZmAsd0Ue+68KcxjexzVthFX4KP9HpMPB4aKtnA
         FQ2mu/vsd2aqSo+3FCMxjNb6UHtG8ZO+eMYEX1q0XqN4MxpkvHqPkVJhA1DfviaoO55/
         YQ2w==
X-Gm-Message-State: AHPjjUgS+VlH+MQByvXmJkkBCGBVT1e6OuOcBRan/X9CbVrsjHAqddLg
        +os81qZ7cl0c9RIv8cwctqTCZ9PbKm/jcaQ4M6KzXzmG
X-Google-Smtp-Source: ADKCNb7ScNrXGTOXy5/6Hhg1U7zoc0i7a7Skgt+HwkUugnB+wTOAK6oeLAF7jHx+ngBMvblTcKQGNDZ4TZLD/C2rrVk=
X-Received: by 10.223.150.27 with SMTP id b27mr28252492wra.100.1505756618496;
 Mon, 18 Sep 2017 10:43:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.170.68 with HTTP; Mon, 18 Sep 2017 10:43:37 -0700 (PDT)
In-Reply-To: <20170918142205.r5kwkq7ouy5zxisz@LykOS.localdomain>
References: <20170906093913.21485-1-root@shikherverma.com> <CAGZ79kbxDh11KxrKCk_VjmN06kzp7x4iVO6XTV=a-qBmm39K5A@mail.gmail.com>
 <20170907091133.zygswf3f6z2bedfo@weakknees.security.iitk.ac.in>
 <CAGZ79kZO_u21JeAsNq7p7X88i0wmP6kJcg=JbKp62Bxdm4d4Uw@mail.gmail.com>
 <20170916072106.yxpwmndzif3lr2dp@weakknees.security.iitk.ac.in>
 <xmqqa81uumq6.fsf@gitster.mtv.corp.google.com> <20170918142205.r5kwkq7ouy5zxisz@LykOS.localdomain>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 18 Sep 2017 10:43:37 -0700
Message-ID: <CAGZ79kZnBoycG-LSftdivfsT8yE53R2JhNRDfVztwqmETeDFKA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] Add named reference to latest push cert
To:     Santiago Torres <santiago@nyu.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Shikher Verma <root@shikherverma.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 18, 2017 at 7:22 AM, Santiago Torres <santiago@nyu.edu> wrote:
> Hello, everyone.
>
> Sorry for being late in this thread, I was making sure I didn't say
> anything outrageously wrong.
>
>> That's Stefan; I wouldn't have suggested any approach that uses the
>> blob whose sole purpose is to serve as a temporary storage area to
>> pass the information to the hook as part of the permanent record.
>>

I put out a vague design that seemed to have more advantages
in my mind at the time of writing. :)

>
> Hmm, as far as I understand *this* is the status quo. We get an
> ephemeral sha1/oid only if you have a hook attached. Otherwise, you will
> never see the object at all, even if you have --signed set.
>
> I suggested preparing this RFC/Patch because of the following reasons
> (please let me know if my understanding of any of this is wrong...):
>
>     - I find it weird that the cli allows for a --signed push and
>       nowhere in the receive-pack's feedback you're told if the push
>       certificate is compute/stored/handled at all. I think that, at the
>       latest, receive pack should let the user know whether the signed
>       push succeeded, or if there is no hook attached to handle it.

How would a user benefit from it?
(Are there cases where the organisation wants the user to not know
deliberately what happened to their push cert? Do we care about these
cases?)

>     - *if there is a hook* the blob is computed, but it is up to the
>       hook itself to store it *somewhere*. This makes me feel like it's
>       somewhat of a useless waste of computation if the hook is not
>       meant to handle it anyway(which is just a post-receive hook). I
>       find it rather weird that --signed is a builtin flag, and is
>       handled on the server side only partially (just my two cents).

I agree, but many features in Git start out small and only partially.

>     - To me, the way push certificates are handled now feels like having
>       git commit -S producing a detached signature that you have to
>       embed somehow in the resulting commit object. (As a matter of
>       fact, many points on [1] seem to back this notion, and even recall
>       some drawbacks on push certificates the way they are handled
>       today)
>
> I understand the concurrency concerns, so I agree with stefan's
> solution, although I don't know how big of a deal it would be, if git
> already supports --atomic pushes (admittedly, I haven't checked if there
> are any guards in place for someone who pushes millions of refs
> atomically). It'd be completely understandable to have a setting to
> disable hadnling of --signed pushes and, ideally, a way to warn the user
> of this feature being disabled if --signed is sent.

That makes sense.
