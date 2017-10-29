Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10F642055E
	for <e@80x24.org>; Sun, 29 Oct 2017 04:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750959AbdJ2EhT (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Oct 2017 00:37:19 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:47295 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750764AbdJ2EhS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Oct 2017 00:37:18 -0400
Received: by mail-qk0-f195.google.com with SMTP id m189so12584626qke.4
        for <git@vger.kernel.org>; Sat, 28 Oct 2017 21:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EsPvt0UVoMDxLAfjANlt58LjqPLBt6/C0bWNw8cOI2I=;
        b=e0R9OLn9yrJhLudO5N4B0DL8B22bnyyRg7sRbSO9mPS+Ky/7UBgiaZJsVuqHoogmmC
         b8b1Sn0DJYy/qeqEy/G8RHtNwVx4ouO2uJ+nYvvS5MWkPi7chA1SYXiTPYvLFLwbOiau
         ilSglCSypwXAKMh86KIjsFbNspqqbEFBg8dqC3QcydyFZYOhDV0HrqaSlvqk73E+wu+5
         ZLaE399/xS9aSsPys7a4eRu8pXiaZx6ThKF6hoALfIdpRqmjgFG6gU5BKfWI1SoAKuIi
         AFd6VF6qXp53jlhpyRPeK3KzHvHOkW/zPaMEDaJNG8ZFFaT9o3eVDUYlXw0qRIeEcXVR
         HauA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EsPvt0UVoMDxLAfjANlt58LjqPLBt6/C0bWNw8cOI2I=;
        b=MOZRC7vvw5K9BG6YFoTAAPKxO3GFF7rxTyYyr6RXI3tKG7/Azr8PKuzFcmbzKr0PlY
         lnv3GxXhUxHhIBNqNB6fXLpzGx6dMBTKtNxqhejSv7SJi48Bd/qyvc3lq3OEr/v7nX/g
         i5ciwIPEL27UfV2mNbD/7Qzvr2iJL8AkcJRCvaaQqi5E3vgtj+CzFq4RaxSefgaSAMok
         oqhfHi19WbOtlSkShY/yZdmXwVWGIxMGN5wSM47+8z9SKgfNII2G/SdulNpoALNo3zBx
         PoewxbO3lMBSWP3e5PSeTRulZdoLwZr2xa8UXFybsxD0W/eRUtKLRDknrgMYy9/etisb
         BvGQ==
X-Gm-Message-State: AMCzsaX0zgu7rUB2X55NiXioUbw3q0ObCoumxzPNqLzKARQC92ZAcZ9k
        3Q7PAM3SfSvokCZQVK5UqSC1RYPIFWgs65gefx+pZg==
X-Google-Smtp-Source: ABhQp+RTGZGwPAxMs/PCdgMaa9pV2svXdW8H5cujbjraNWMEk+NRaoJJLwpDFE/MWt1RUT7levepZIMRyXS1PmeJqj8=
X-Received: by 10.55.175.132 with SMTP id y126mr8087775qke.45.1509251837970;
 Sat, 28 Oct 2017 21:37:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Sat, 28 Oct 2017 21:37:17 -0700 (PDT)
In-Reply-To: <xmqq60aybvdp.fsf@gitster.mtv.corp.google.com>
References: <20171027222853.180981-1-bmwill@google.com> <xmqq60aybvdp.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Sat, 28 Oct 2017 21:37:17 -0700
Message-ID: <CAGZ79kb+NLT8fGc-QJEtzgt3V8rj4=ciROoYJVFtMOyG+0OLwQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] convert diff flags to be stored in a struct
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 28, 2017 at 6:22 PM, Junio C Hamano <gitster@pobox.com> wrote:

>> Some thoughts:
>>  * We may want to do a follow on patch to convert all the flags from being in
>>    uppercase to lower case.
>
> If and only if we do not use macros to set/clr/test, this makes a
> lot of sense.  Otherwise, probably not.

The .touched_flags is used just once in the code base for just one flag.
I wonder if we could get rid of touched_flags and instead introduce a new
flag (FORCE_TEXT_CONV instead of ALLOW_TEXT_CONV set by cmd_show
specifically) that will enable the special casing that is currently done via the
touched_flags.

Once we get rid of the special casing, we can get rid of the macros.
