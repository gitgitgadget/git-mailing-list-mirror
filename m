Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02A061F42D
	for <e@80x24.org>; Tue, 29 May 2018 15:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964982AbeE2Pwa (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 11:52:30 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:41592 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965187AbeE2Puq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 11:50:46 -0400
Received: by mail-oi0-f65.google.com with SMTP id 11-v6so13480510ois.8
        for <git@vger.kernel.org>; Tue, 29 May 2018 08:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hTW0pmKHSI7xrerPR9nGBLuMT+qPI0E+1XtqP9WNa9w=;
        b=BKzDDEOsJh7tZc/3dL5iuUo3OGpEDY/Cci04mUpX7AbQQgOA00UhFB4E2i37yVIdWi
         ydq8yQix/8YZEKEP0OX6PJDboRFb4EIsoiTcp0n38io3QdYdE7zy97u6AQlA3WYmtmLr
         FB8J6yguOSMrQ/OnbXNzmo4tKwh4eFFVQDVoggVBEit90/9pwAT2RpHMGc9rel7witS5
         9oneFdmsG6x/PauLsv/jISI6Fm2OsWir/EPNT+Z4ddVSKsR2wPRF39wAFYbYvgMByn5+
         XDjBCqRfc+ycQl+u+z6WSiAqm/tuF3tGL31s6XJ0vznR6sBrhbGlt2cRWUAbdNEuck7/
         1Hqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hTW0pmKHSI7xrerPR9nGBLuMT+qPI0E+1XtqP9WNa9w=;
        b=Z1NctGiexdOj+eKpTCXcthlNNP1xDov+kkjhOoeNgQ6aH0Z8uv5ICxbddfFZw3qiUt
         ZkJN/DkxvI9FipPp4lPU8NeigrpMl9hx3W9RbfK5NtQCSFuJ942AnETm8TUXDp6P6VAi
         Ag75ncyigYUIPKaYL8vMV2bHtBxjufKgwsHjONkbvMboKvYvREVOZEWOA2OZO5zVEkBi
         8039P4zLlbWTQzI29/rsrvLHOzK8KNOEweluXY8oajyi2kunQzSTwgvdmeX/jG7sl6FP
         uTyD8d4BpesPbJ1iQJVym3mWyu/1Ck1GaB/2qIZo9d4kNeIZXFMQRn5qLzj2+I26IVtj
         Hb7g==
X-Gm-Message-State: ALKqPwff4Xfn/jhqqzAAqqJDdYsziEvUyfCF/q5Yl2I+t+W7IcepTh9A
        7T6Ra0SnZdGJjC1KGPtY82c8OztzLcj8XHNHcqM=
X-Google-Smtp-Source: ADUXVKImVn5eid+cvkIeAXweYsSH9Rw6fHXHsmCHEpYHk2hA0E2QXhTFZt/Yje/45Xf7EIErGYoUF1kZo3X8vb5mBew=
X-Received: by 2002:aca:110e:: with SMTP id 14-v6mr10595148oir.56.1527609046280;
 Tue, 29 May 2018 08:50:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:b285:0:0:0:0:0 with HTTP; Tue, 29 May 2018 08:50:15
 -0700 (PDT)
In-Reply-To: <CAN0heSq1y3XibCFDYsae5b6jmzZOzcLHT4atCZ+KCb4dL5As0g@mail.gmail.com>
References: <xmqq8t88nllj.fsf@gitster-ct.c.googlers.com> <cover.1527279322.git.martin.agren@gmail.com>
 <ef5b4e28e00ad0c95dbe625d2e7305957f9fe5ba.1527279322.git.martin.agren@gmail.com>
 <xmqqin78jfnl.fsf@gitster-ct.c.googlers.com> <CACsJy8CgzDfbES2jC+Rv+bKj_JAk8dzEDCm89JMuBFQmyGg9Gw@mail.gmail.com>
 <xmqq8t83ihd7.fsf@gitster-ct.c.googlers.com> <CAN0heSq1y3XibCFDYsae5b6jmzZOzcLHT4atCZ+KCb4dL5As0g@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 29 May 2018 17:50:15 +0200
Message-ID: <CACsJy8C-BT158DW_Tz24ea_QUfQHQpToCC-=E+-zZeZeAD9heQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] usage: prefix all lines in `vreportf()`, not just
 the first
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 29, 2018 at 6:49 AM, Martin =C3=85gren <martin.agren@gmail.com>=
 wrote:
> On 28 May 2018 at 23:45, Junio C Hamano <gitster@pobox.com> wrote:
>> Duy Nguyen <pclouds@gmail.com> writes:
>>
>>>>> +error:       sub/added
>>>>> +error:       sub/addedtoo
>>>>> +error: Please move or remove them before you switch branches.
>>>>>  Aborting
>>>>>  EOF
>>>>
>>>> This shows the typical effect of this series, which (I subjectively
>>>> think) gives us a more pleasant end-user experience.
>>>
>>> Also, very subjectively, I'm torn about this. To me, just one
>>> "error/warning/fatal" at the start of the first paragraph feels much
>>> better. If we have to somehow mark the second paragraph that "this is
>>> also part of the error message" then it's probably better to rephrase.
>
> Would you feel the same about "hint: "? We already do prefix all the
> lines there. It seems to we we should probably do the same for "hint: "
> as for "warning: ", whatever we decide is right.

It may depend on context. Let's look at the commit that introduces
this "hint:" prefix, 38ef61cfde (advice: Introduce
error_resolve_conflict - 2011-08-04). The example in the commit
message shows the hint paragraph sandwiched by an error and a fatal
one:

      error: 'commit' is not possible because you have unmerged files.
      hint: Fix them up in the work tree ...
      hint: ...
      fatal: Exiting because of an unresolved conflict.

I think in this case (dense paragraphs of different message types) yes
it might make sense to prefix lines with "hint:". But when there's
only one type of message like the "error" part quoted at the top, it
feels too verbose to have error: prefix everywhere.
--=20
Duy
