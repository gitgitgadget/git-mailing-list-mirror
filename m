Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CFA02021E
	for <e@80x24.org>; Wed, 16 Nov 2016 03:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964988AbcKPDMH (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 22:12:07 -0500
Received: from mail-vk0-f45.google.com ([209.85.213.45]:33130 "EHLO
        mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752020AbcKPDMG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 22:12:06 -0500
Received: by mail-vk0-f45.google.com with SMTP id 137so105299165vkl.0
        for <git@vger.kernel.org>; Tue, 15 Nov 2016 19:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QGiiLlf06qhwbhyhpcxiXRM+2dyJnxpKwAzMs8LR9Ic=;
        b=hNw/K4Si0J7KzBw77PDqgsUeD6P5fsy1yqaZQ738YLGl/7Mh1aftUCVjRgRnmaVMIS
         OyGdjs/ChSEKzIp42ouxZYsjCTOiIodtqRowmaEl/T1Jhdm6SsWWf3DPWLGi3VdG9UMk
         y8D+iSE7mZ/uzjBdF+FrbBNbsS5eTThfEF+al1Z3AeoQXZpQom4yQ4I4aa9SxApjA4LD
         fF3FcGRly0o7aaGWVGBu/+G52lPrz8ZRDo8ZzLqWgrshjVobOYOOxOJy+srG+pcCjkcx
         XYSGtTqtUTuRwiyFyGnkiWsOvhXJnQ1d+L3n08b9MrfJQBwetPeDP+1ja2JzIH8+/se9
         yWog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QGiiLlf06qhwbhyhpcxiXRM+2dyJnxpKwAzMs8LR9Ic=;
        b=LG6RtbHjOcF8LSg6962KM5npk3uWLEQSKNQyX9WmE3qCxVCcEWBmzqZYL59pxqTKeK
         PMK2mPtuI31E4eQJlL0GnI+uV382xV2SPSyTzQv6qSIC60Y9wOBUQsnHgZkogad0BW/Q
         +se1SsUEDOO33nmblHLG+1nieA5FYjfYrUVQx2pKT2aJM3xKYabSG9F6uDBkXhOi7Isw
         gPh5NDEXgrH8tFPXm6gnUMjIBgB+DgcKkxG3qVv9yGif6+ym1Da7/lFUn+E2NvB6sozF
         dxjbr/Oly5sVZ7YplBwl9xJoew1Skm/tPLmDigo/YjOnL5Kcc6RKYXWZeG/Oqla4r3Ek
         MCZw==
X-Gm-Message-State: ABUngve9OmLPuoyjUOgxCQssapgL/UXB7sT6+XOdvYjn8yjBm7R2Znd70tVSenB0cNYLmm4PT/Fx2C2ue+XwdQ==
X-Received: by 10.31.210.130 with SMTP id j124mr349894vkg.111.1479265925528;
 Tue, 15 Nov 2016 19:12:05 -0800 (PST)
MIME-Version: 1.0
Received: by 10.103.69.89 with HTTP; Tue, 15 Nov 2016 19:12:04 -0800 (PST)
In-Reply-To: <xmqqk2c4ryj8.fsf@gitster.mtv.corp.google.com>
References: <CA+i4re65SsxcaLcpGyMDnJygQFmAq4X_x_uxrkqB0yqQkEYPUQ@mail.gmail.com>
 <xmqqk2c4ryj8.fsf@gitster.mtv.corp.google.com>
From:   Douglas Cox <ziflin@gmail.com>
Date:   Tue, 15 Nov 2016 22:12:04 -0500
Message-ID: <CA+i4re4FZhshheftQnsogaY7601wgf_GfsFUxy+doLcOYPWv7Q@mail.gmail.com>
Subject: Re: Bug with disabling compression and 'binary' files.
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> This may or may not be related to the symptom
> you are observing (if it is, then you would see a packfile created
> in objects/pack/, not in loose objects in object/??/ directories).

No, the file is loose (it's in .git/objects/eb in this case). This is
seen immediately after the add, though I believe it's the same way
when doing a commit on a changed file.


On Tue, Nov 15, 2016 at 8:42 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Douglas Cox <ziflin@gmail.com> writes:
>
>> I narrowed this down to the '-text' attribute that is set when
>> specifying 'binary'.  For some reason this flag is cancelling out the
>> core.compression = 0 setting and I think this is a bug?
>>
>> Unfortunately core.compression = 0 is also global. Ideally it would be
>> great if there was a separate 'compression' attribute that could be
>> specified in .gitattributes per wildcard similar to how -delta can be
>> used. This way we would still be able to get compression for
>> text/source files, while still getting the speed of skipping
>> compression for binary files that do not compress well.
>>
>> Has there been any discussion on having an attribute similar to this?
>
> Nope.
>
> I do not offhand think of a way for '-text' attribute (or any
> attribute for what matter) to interfere with compression level, but
> while reading the various parts of the system that futz with the
> compression level configuration, I noticed one thing.  When we do an
> initial "bulk-checkin" optimization that sends all objects to a
> single packfile upon "git add", the packfile creation uses its own
> compression level that is not affected by any configuration or
> command line option.  This may or may not be related to the symptom
> you are observing (if it is, then you would see a packfile created
> in objects/pack/, not in loose objects in object/??/ directories).
>
>
>
