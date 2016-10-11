Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FA452098A
	for <e@80x24.org>; Tue, 11 Oct 2016 11:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752307AbcJKLAU (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 07:00:20 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:33290 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751136AbcJKLAT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 07:00:19 -0400
Received: by mail-io0-f195.google.com with SMTP id q192so1355550iod.0
        for <git@vger.kernel.org>; Tue, 11 Oct 2016 04:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8UB/1mI4uNjH1aZQzh3RHTaKchbxgzmmMZW5DP07tG0=;
        b=aLh9aDyWwJkOmDM/piQVGs04T7AYypCgmghjdSiMZCRJwbc//uHXay1lmJH0jPcEvc
         aGmC3Kq61le5XgRgY7psrKoso20DWPGft8WSsFQmEFGJ8CeyE7oVFg6gYtc8lX0cd20q
         JBLCn8bL7Jb6Nt9d1bBB+kM2B2RZY5z+E2MmzOtJQffAXBHVcZC2XkzhLOb2T7rtHRgl
         2gZfFGTWDANyb0pxnFjcsgSuchM7xDNveS3ipu1MdXYiC84H13KfLrDLgr60eKZQAu60
         nps0SS8uRHTbDZXfKnIW/rWakYt7Eq2RbgNvLdm28oC/fZg8xPZJAX15P/JMk0LzwyzZ
         Uq9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8UB/1mI4uNjH1aZQzh3RHTaKchbxgzmmMZW5DP07tG0=;
        b=KaV0weBch0CzQGpEcgZyuJQJH8x/O2e4BY+olF3/94WMJeCECWXHFoRg4P74w2flqt
         B5/X2o+pE4+k1D9oAWNGsxEI9OF0KPH0p4hpqpXVms3JPa5O+ctrE4Gj6YNhZvkcmkwP
         dif3r0GYQPT6NNeqZFiypXh8lz5lyd3hEQ3cxKKMVSgpGqB0S5NkwiAtfiuTrm5o95nG
         YwaJr8aqNVda6LHYRYoBELMeiWCyJIf+rSoQDZF7zkPm31YMWOPmBmdZ8UAjuDL8Hzy8
         V/OYn7BojpWi5QRN5n39zzF+otvgKbsb1YVPOusXd569ZsSNKI/WYEhV6IgY3EYxsAOs
         8PEw==
X-Gm-Message-State: AA6/9RkfhDU8KN2vdUg9KuV9WAxUs/z7MyZBL9m2BKmrm+KEvA8mzfDX/E5oYIkBcPHAO8sxnAFtKxgKdxyLPg==
X-Received: by 10.107.44.17 with SMTP id s17mr4912107ios.212.1476183618391;
 Tue, 11 Oct 2016 04:00:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.230.206 with HTTP; Tue, 11 Oct 2016 03:59:47 -0700 (PDT)
In-Reply-To: <20161010151517.6wszhuyp57yfncaj@sigill.intra.peff.net>
References: <cb81631e-9623-9020-f955-ec215b493a50@hale.ee> <f35965e9-2901-b9b5-92e5-9bc7fe673637@web.de>
 <65d8def3-df62-6c45-7d8f-79b6a8769bf5@hale.ee> <25c17e16-2456-7da3-ae22-2dc812a3aa0d@web.de>
 <20161009234617.y6xfjyv6xjkf2afi@sigill.intra.peff.net> <CACsJy8CroyynVMctbPhuVr2VVQB7YyfcxDaMT25BikQ4R4We0Q@mail.gmail.com>
 <20161010142818.lglwrxpks6l6aqrm@sigill.intra.peff.net> <20161010151517.6wszhuyp57yfncaj@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 11 Oct 2016 17:59:47 +0700
Message-ID: <CACsJy8ABn_hp4nC-7ao7UPLc1vrC1B+50YwaRNyK5J-H_7f6JQ@mail.gmail.com>
Subject: Re: [PATCH] pretty: respect color settings for %C placeholders
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Tom Hale <tom@hale.ee>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 10, 2016 at 10:15 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Oct 10, 2016 at 10:28:18AM -0400, Jeff King wrote:
>
>> > We could add some new tag to change the behavior of all following %C
>> > tags. Something like %C(tty) maybe (probably a bad name), then
>> > discourage the use if "%C(auto" for terminal detection?
>>
>> Yeah, adding a "%C(enable-auto-color)" or something would be backwards
>> compatible and less painful than using "%C(auto)" everywhere. I do
>> wonder if anybody actually _wants_ the "always show color, even if
>> --no-color" behavior. I'm having trouble thinking of a good use for it.
>>
>> IOW, I'm wondering if anyone would disagree that the current behavior is
>> simply buggy. Reading the thread at:
>>
>>   http://public-inbox.org/git/7v4njkmq07.fsf@alter.siamese.dyndns.org/
>>
>> I don't really see any compelling reason against it (there was some
>> question of which config to use, but we already answered that with
>> "%C(auto)", and use the value from the pretty_ctx).
>
> So here's what a patch to do that would look like. I admit that "I can't
> think of a good use" does not mean there _isn't_ one, but perhaps by
> posting this, it might provoke other people to think on it, too. And if
> nobody can come up with, maybe it's a good idea.

I think you covered all bases with %C(always,..) and updating
for-each-ref code. And changing behavior of visual features like this
sounds more like "evolving" than "breaking backward compatibility" to
me. So +1.
-- 
Duy
