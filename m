Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B30701FBB0
	for <e@80x24.org>; Tue, 22 Nov 2016 17:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932688AbcKVRQi (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Nov 2016 12:16:38 -0500
Received: from mail-qk0-f173.google.com ([209.85.220.173]:33854 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932669AbcKVRQh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2016 12:16:37 -0500
Received: by mail-qk0-f173.google.com with SMTP id q130so34528134qke.1
        for <git@vger.kernel.org>; Tue, 22 Nov 2016 09:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YanbC2vfTB/9dbBGhpSnxKIGTATlSSXRQdyGovmuh0c=;
        b=lY3lM6tbfIeDiZvjmWw7mpKao/RaeJBeGalBY+FIJOwNyy4W9wdhTTSIb2rUbKRQz5
         tgA0SJgvqaPut8lhQQw+5okxeLV5u3OruuF4Fxi3MpwU8CJcKXXA1MCmTKVjKJOAVk29
         d92iBeni4iRgbiSvxvRCnSj7drgTmRhzz8NcV0JYCg/LKu2kIb1ZL3gergdxTTipWzSb
         cAD/gUplOwLRaUG/kI1kIPVuIOY3GOYy7QEQfC4TRxoct6oOrK6vl9AbnCqH4QAkIRIo
         RokTslXEJbB9KAc1/3GxOWCIlUBA0isxvQjYqZ2Qv5QKkTUHptB3MnZgzzqqzz+rrLuQ
         jLFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YanbC2vfTB/9dbBGhpSnxKIGTATlSSXRQdyGovmuh0c=;
        b=TqLQmt6AA0gtsrNcmgzZNmwZFuK1TJn9XE2QMMPOXglNP2eHBf2eBsyaLUZNbnZ9JQ
         kXc/laYG5DuO+vnHLk6KVN2r8aaHupAgV1zyZEeIQkjSs7xxzRsdLwQLyISmpktCPdeX
         ri/nb7D11PXZ3Jey4qsSRmJkP/XOsAa/lhRC0AOdu2fLoSroklZeRjWBAQPhCsAtBsWa
         /E1dy1kL8fflY5XYieyaBGD0zjUeZHSUVVJ8eLMR7J/QW6O4ac3E9u8/WG+gS9HuR+mR
         ij53NwqUqJiZCgA8SxurUG7H5hRq3qNK5hgoOy4R2+MGqVBxfKJ+L6UR/9xhQrsvJ7A2
         ypOA==
X-Gm-Message-State: AKaTC00gCZiWghc6/OXVocdlHGLeCQNx+s0NQmSDZIUrGkShAvalHZR+vJbTkYwP+qD0FJ63pzz/bNIM+Bp2mM84
X-Received: by 10.55.186.3 with SMTP id k3mr26064291qkf.47.1479834996818; Tue,
 22 Nov 2016 09:16:36 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.134.65 with HTTP; Tue, 22 Nov 2016 09:16:36 -0800 (PST)
In-Reply-To: <xmqqmvgsf0wo.fsf@gitster.mtv.corp.google.com>
References: <20161121204146.13665-1-sbeller@google.com> <20161121204146.13665-4-sbeller@google.com>
 <xmqqy40ch6wp.fsf@gitster.mtv.corp.google.com> <CAGZ79kb_4wWs_90AfsT932iPWbCXf6yRq875JUxoRZjUcsBW5A@mail.gmail.com>
 <xmqqmvgsf0wo.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 22 Nov 2016 09:16:36 -0800
Message-ID: <CAGZ79kb7062abd6Cbf-ey3u0L6PXUcRf7m-og5EyCRZencOR6g@mail.gmail.com>
Subject: Re: [PATCH 3/3] submodule--helper: add intern-git-dir function
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Heiko Voigt <hvoigt@hvoigt.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 21, 2016 at 11:07 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> So I guess we should test a bit more extensively, maybe
>>
>>     git status >expect
>>     git submodule embedgitdirs
>>     git status >actual
>>     test_cmp expect actual
>>     # further testing via
>>     test -f ..
>>     test -d ..
>
> Something along that line.  "status should succeed" does not tell
> the readers what kind of breakage the test is expecting to protect
> us from.  If we are expecting a breakage in embed-git-dirs would
> somehow corrupt an existing submodule, which would lead to "status"
> that is run in the superproject report the submodule differently,
> then comparing output before and after the operation may be a
> reasonable test.  Going there to the submodule working tree and
> checking the health of the repository (of the submodule) may be
> another sensible test.

and by checking the health you mean just a status in there, or rather a
more nuanced thing like `git rev-parse HEAD` ? I'll go with that for now.

>
>>>  In the
>>> extreme, if the failed "git submodule" command did
>>>
>>>         rm -fr .git ?* && git init
>>>
>>> wouldn't "git status" still succeed?
>>
>>     In that particular case you'd get
>>     $ git status
>>     fatal: Not a git repository (or any parent up to mount point ....)
>
> Even with "&& git init"?  Or you forgot that part?

yes I did, because why would you run init after an accidental rm -rf ... ?
