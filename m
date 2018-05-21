Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A2861F51C
	for <e@80x24.org>; Mon, 21 May 2018 19:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751363AbeEUTlA (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 15:41:00 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:34024 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751072AbeEUTk5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 15:40:57 -0400
Received: by mail-yb0-f193.google.com with SMTP id i1-v6so5487481ybe.1
        for <git@vger.kernel.org>; Mon, 21 May 2018 12:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Wu2QTdf+CQdDLDQH4+lLFNHNPwZdWGStv0wc/7jD+mU=;
        b=aAZ43ZcnkRrpfBqVCEa9yaW9JUxFQKb3Vum4re6BoY/3FBVQIt1y9fAt3REdlkNCsd
         M+BF16U2N8tKP8IDkgBMyn8k9lTXEkw31e65t9luxEpKSSo1A/A4Wc/XozhObqDXd0dW
         RbVZabp9DrMj5PRl713+lzae8jtYJTCt02XmfiIXVNrInDZeK8RoBjrlDwVx/87eVopa
         DZSuwvLwmL5/V8xSoJA6c+I5BpjwoxsH/1Z364t95QxTyNrYwWBnBCjX0RpS0lvxnpW7
         rz0ZM3dH22ZGC3SgKPdr5NLTNDJQOVQu6GhVl91vQYfUkbi8zw9LEejiOSG3BEASl4dY
         drqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Wu2QTdf+CQdDLDQH4+lLFNHNPwZdWGStv0wc/7jD+mU=;
        b=Nq08TjgIlXJv3W6KDp9eXz3g2dvV+MqLRf/HYgNMJOm/E8POrkRugofNx3C6UNOhhw
         VFadpE4qi0591jKV2TRtYYCaob8/uUrVvUr/5x/fr8Fnq2D+iG/oLcDB9RoO4SqC63Mi
         NPNQq/P+uihjEeeuzyWTshF+0jKJu3wwgCeo2SGZwgt7TSe64j6UgjQOnTP+kyXiRxdw
         PWCMJqXd2hjDn3960uwOcKzmle+mvA7peyd62EX/AVdApLYvJhd96dx1Yy+CJNaHs8Eo
         TsnkLWhjdyc0X0cyaYJa1R1LWIj6A96z/z6g8uBcNciQr0QfEtcLg2RJ4jLnVWJxwuxo
         yXDg==
X-Gm-Message-State: ALKqPweU4/iuR6eAVXwgGirQUtqi09GfjkNojGJ4plo27DxV59semxmw
        b24zHVjUZzH0e5ZL6aoBJKdmiwsX4XrHHCLwy+qOTA==
X-Google-Smtp-Source: AB8JxZowMdwi0wOtJeNpDXIZpCByrQpP5kROYwIyzwqx/f8ZtxqKQvotRSAHX3/Q+T+ldUNm7pC2n6OA4kTcRkYG0D0=
X-Received: by 2002:a25:ae45:: with SMTP id g5-v6mr3249848ybe.292.1526931297691;
 Mon, 21 May 2018 12:34:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:e87:0:0:0:0:0 with HTTP; Mon, 21 May 2018 12:34:57 -0700 (PDT)
In-Reply-To: <20180521055143.14701-1-chriscool@tuxfamily.org>
References: <20180521055143.14701-1-chriscool@tuxfamily.org>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 21 May 2018 12:34:57 -0700
Message-ID: <CAGZ79kbdVm-U16rMjtgnGL+TOVRqkZz+J5W_eqo=dh42xRgKBQ@mail.gmail.com>
Subject: Re: [PATCH] t: make many tests depend less on the refs being files
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@dwim.me>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        David Turner <novalis@novalis.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        David Turner <dturner@twopensource.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 20, 2018 at 10:51 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> From: David Turner <dturner@twopensource.com>
>
> So that they work under alternate ref storage backends.

Sometimes I have a disconnect between the subject and the commit
message, (e.g. in an email reader the subject is not displayed accurately on
top of the message).

So I would prefer if the first part of the body message is an actual
sentence, and
not a continuum from the subject.

Maybe elaborate a bit more:

  The current tests are very focused on the file system representation of
  the loose and packed refs code.  As there are plans to implement other
  ref storage systems, migrate most tests to a form that test the intent of the
  refs storage system instead of it internals. The internals of the loose and
  packed refs are tested in <TODO>, whereas the tests in this patch focus
  on testing other aspects.

>
> This will be really needed when such alternate ref storage backends are
> developed. But this could already help by making clear to readers that
> some tests do not depend on which ref backend is used.

Ah, this is what I picked up already in the suggested edit above. :/

> This patch just takes care of many low hanging fruits. It does not try
> to completely solves the issue.
>
> Signed-off-by: David Turner <dturner@twopensource.com>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>



> ---
>
> Thanks for all the great feedback regarding implementing reftable [1].
>
> Looking at David Turner's tests in [2], it seems that they could indeed
> be already valuable, so let's start by extracting most of the simple
> improvements they make.

Thanks for tackling refstables!

Stefan
