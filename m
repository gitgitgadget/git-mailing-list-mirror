Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BF031F6A9
	for <e@80x24.org>; Thu,  3 Jan 2019 22:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbfACWJP (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Jan 2019 17:09:15 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39665 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbfACWJO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jan 2019 17:09:14 -0500
Received: by mail-wm1-f68.google.com with SMTP id f81so31561590wmd.4
        for <git@vger.kernel.org>; Thu, 03 Jan 2019 14:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=hrZQsJHoEl/z8RgEWUv1XxlbcjA2pvifSUUIp/Mdksw=;
        b=AxYJuFKU8Z9OvI+HoUw5xWfMjwcX9adHlr/dlPPwdoj7r/YHNPB6hkBGvoeO+1T7Ux
         fAfdv3l3O6fH7NpWARSPwjXsIRsuUoTpR84udxP8HiY2VOtm1LmRFUxgAYZhkzphsiCz
         BggZqgdTxslOYpQBacvwyxYZB0mj7rAqiPrkmsete6/AGRszQRvHCTEDewmAnHpRbKlS
         qBxkH6bKPZqDKHrVzK/E+OPk7yFQW4YeThLvJsMNdgRQZ0baFXdjFYR6IRaMFW2g5Zkq
         RjBU2ncbyOnQLrd3y2S4InaYVQPSPCir8C+OX/XviW5TEUjxLwD4dsxYMmWY/YlYs/c5
         b1oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=hrZQsJHoEl/z8RgEWUv1XxlbcjA2pvifSUUIp/Mdksw=;
        b=Hjp9/vcU441NYuQbnnucdPn9kgn6RqB/P9p9nENL4qT50ikSx7uibHTebWc2nbEGCh
         xpdUZPfSyIvj+wYUorSuHy/BS9T8j7i6LAjMKj2R6Sgb1mJpcDzdzJijWxLkFEQDVcJP
         4SQoT9U6Qkih5pkeVIwhSXqRzvkpXdVm4ScrRvft2nVlgtmL6wQN4CEZHB4TjdE6rxLT
         12bT1b/0tJPupzdpqgwWVMfuRciSlAALGn4cNvLo3B6XEeGxExKUY9q+YsDWrprABM/L
         rQnIo+RNNMrWaIALFZVTnI5S3roDgMWolFyKuA5164n5OWGJwESuKURykp26EGsmq/K4
         bSvw==
X-Gm-Message-State: AA+aEWauT0d6/jjgi/ooTu99w3RHqfdtSiYbJSFwaqEXRKJM0/K6CqkH
        NH38MQPpUquKxnV4Cw0q+jQ=
X-Google-Smtp-Source: AFSGD/XAA7yr4ljyVNsEOZP9vXyw3WHtQr7ChDh0Wgckq6d6J50xKbHcH24eJO50ndJ6Q+779PL/Hw==
X-Received: by 2002:a1c:2902:: with SMTP id p2mr38858308wmp.19.1546553352765;
        Thu, 03 Jan 2019 14:09:12 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id a62sm38596158wmf.47.2019.01.03.14.09.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Jan 2019 14:09:12 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     "'Eric Sunshine'" <sunshine@sunshineco.us>,
        <randall.s.becker@rogers.com>, "'Git List'" <git@vger.kernel.org>,
        "'Randall S. Becker'" <randall.becker@nexbridge.ca>
Subject: Re: [Patch v5 2/4] config.mak.uname: support for modern HPE NonStop config.
References: <20190103210351.13920-1-randall.s.becker@rogers.com>
        <20190103210351.13920-3-randall.s.becker@rogers.com>
        <CAPig+cSkok+QttWZTMngCdUrxHiO0rg53M4q=1q1vsewn7Qy_Q@mail.gmail.com>
        <007901d4a3b0$5dd1d030$19757090$@nexbridge.com>
Date:   Thu, 03 Jan 2019 14:09:11 -0800
In-Reply-To: <007901d4a3b0$5dd1d030$19757090$@nexbridge.com> (Randall
        S. Becker's message of "Thu, 3 Jan 2019 17:04:52 -0500")
Message-ID: <xmqqo98xfl6g.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Randall S. Becker" <rsbecker@nexbridge.com> writes:

> On January 3, 2019 16:38, Eric Sunshine wrote:
>> On Thu, Jan 3, 2019 at 4:04 PM <randall.s.becker@rogers.com> wrote:
>> > A number of configuration options are not automatically detected by
>> > configure mechanisms, including the location of Perl and Python.
>> >
>> > There was a problem at a specific set of operating system versions
>> > that caused getopt to have compile errors. Account for this by
>> > providing emulation defines for those versions.
>> >
>> > Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
>> > ---
>> > diff --git a/config.mak.uname b/config.mak.uname @@ -470,7 +487,7
>> @@
>> > ifeq ($(uname_S),NONSTOP_KERNEL)
>> >         NO_MKDTEMP = YesPlease
>> >         OLD_ICONV = UnfortunatelyYes
>> > -       NO_REGEX = YesPlease
>> > +       NO_REGEX=NeedsStartEnd
>> >         NO_PTHREADS = UnfortunatelyYes
>> 
>> Style nit (probably not worth a re-roll): you lost the whitespace surrounding
>> '='
>
> I can fix this one in the next round of changes, or after this gets in, if that works, or signoff on this being fixed in place.

I've already tweaked this while queuing.  i.e. no need to resend
only to fix this one.

Thanks, both.
