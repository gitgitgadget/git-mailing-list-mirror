Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D067E2047F
	for <e@80x24.org>; Thu,  3 Aug 2017 07:53:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751840AbdHCHxI (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 03:53:08 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:36188 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752024AbdHCHso (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 03:48:44 -0400
Received: by mail-qk0-f194.google.com with SMTP id d136so541713qkg.3
        for <git@vger.kernel.org>; Thu, 03 Aug 2017 00:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hgLbrWviPka4FW4+OdmdqFPdHcgPNTfhi7fV7zJ0Ysk=;
        b=Z934WEzZVtlGv/rodGsIFDygKxg6nsH94Wgt80XvHMLgh3MIk0Y0MRa7+CCYrH2Rtz
         T+sVnHiyA6xeE9kBwDACT6I6+I4LOZTJ565Mb7VrZJTnxFg9hBbPRDM/8zhpx+uQJuuK
         bGFlxZv4GDHN4MMnO1VGWp5I6se9L2a5AMNWxnI5mw1ak1nra93m2yoa3Dg5JHORWmCU
         r4GB7fiVSm20bapTUDKA6tNTJs35RB90DorBEI3M4ErmpAim1sZlgzpM4pcFjrv/OtEZ
         mfJ5CtHk/Z43IiWxjr0xyet8JHbxANQL5Vb1mDMAFymEwTviuYJ0b+EgF9RmLODTc3kj
         0Mxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hgLbrWviPka4FW4+OdmdqFPdHcgPNTfhi7fV7zJ0Ysk=;
        b=dwcJJISv+X2iOuX+TxFSGUG0X2ijP1KabWtovpdVkuD/Wn7cDX8hLR7rYf6hPGQ5UT
         EX7CCzqx5n/8MnZt1kdwL1Ybqk0zHVBRFbwoAOvuIa+e/GBK8KlFe7hIEP8ECyqFieRv
         L2+TY5fcCMGUZTmjRsvdN57oEwmZE5ZUhltTKsSGh4ZnmsieSrBiBUDOAzKcrNe5KdSe
         pBbLQk+9e9o1DCIprCTHFhtmIRuuE1JrItnJFem6nnd0FKgT7oEXAI7iL7YR6jsCX1bv
         QX7X32hZvfFl1nvB7w3v0lLdnOpFN1WmOwiTJVXo2x5X70VoNOIj+t3ksLQhAZNBWOrF
         30cA==
X-Gm-Message-State: AHYfb5gbxI3xaehUM9Wg8/m0uT61oQccc/Q67V+S5In6uu+FnDkkOadk
        eMKfhfSLembI7hHVDsYk523uNV1Gjg==
X-Received: by 10.55.138.71 with SMTP id m68mr1191309qkd.137.1501746523732;
 Thu, 03 Aug 2017 00:48:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.31.13 with HTTP; Thu, 3 Aug 2017 00:48:42 -0700 (PDT)
In-Reply-To: <20161130233721.7yqu7pbr2oc53o7v@sigill.intra.peff.net>
References: <20161130210420.15982-1-chriscool@tuxfamily.org>
 <20161130210420.15982-2-chriscool@tuxfamily.org> <xmqqmvggbl6m.fsf@gitster.mtv.corp.google.com>
 <20161130233721.7yqu7pbr2oc53o7v@sigill.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 3 Aug 2017 09:48:42 +0200
Message-ID: <CAP8UFD32uYggO1s3h9Ysqtp5hqDWg3LUkCr5_1LoPBLwY3fXgA@mail.gmail.com>
Subject: Re: [RFC/PATCH v3 01/16] Add initial external odb support
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 1, 2016 at 12:37 AM, Jeff King <peff@peff.net> wrote:
> On Wed, Nov 30, 2016 at 03:30:09PM -0800, Junio C Hamano wrote:
>
>> Christian Couder <christian.couder@gmail.com> writes:
>>
>> > From: Jeff King <peff@peff.net>
>> >
>> > Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> > ---
>>
>> By the time the series loses RFC prefix, we'd need to see the above
>> three lines straightened out a bit more, e.g. a real message and a
>> more proper sign-off sequence.
>
> Actually, I would assume that this patch would go away altogether and
> get folded into commits that get us closer to the end state. But I
> haven't read the series carefully yet, so maybe it really does work
> better with this as a base.
>
> I am perfectly OK dropping my commit count by one and getting "based on
> a patch by Peff" in a cover letter or elsewhere.

Ok I have dropped your commit count and added "Helped-by: Jeff King
<peff@peff.net>" in the patches that come from your work.

Thanks!
