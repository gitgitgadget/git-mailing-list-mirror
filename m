Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85B661F859
	for <e@80x24.org>; Mon, 22 Aug 2016 13:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754945AbcHVNKL (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Aug 2016 09:10:11 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:36444 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754209AbcHVNKK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2016 09:10:10 -0400
Received: by mail-io0-f172.google.com with SMTP id b62so108986689iod.3
        for <git@vger.kernel.org>; Mon, 22 Aug 2016 06:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=D22ps+qdxxCxYkpniZ5ldCcs05jAx+JCrE95xPrlYzE=;
        b=Mzw3YqOSdQdD2j2DuPBonH6oGR1Z5D8MUcn/0jt+rIhDR8TNGziUDyPfKIsuDfvnNF
         NE+HmYkZyBcq5cv2UUeLexJd3QQtGQil4b/lzYZyIQYejh61Ae6OlTmkApPt/f9zM4NY
         CjwW5P1ElqNxSvtd0Iol67PbOfQLMYAWExVbK6VRWpTjmtckPZ7B+IvLxP2ZwaUO5aLg
         nzFVGPZUWke5RZt9o2OyBp6adOmKdk//0ZcdhCr38izv78uVB+iu25eQv3sXbcAr2tZw
         sXAeciE6gDXxRtI5Um6PY8KPQ1b9BISHaUALPxXYDwvqvEoGT2MlUOzcsBheIufKjUYz
         IT9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=D22ps+qdxxCxYkpniZ5ldCcs05jAx+JCrE95xPrlYzE=;
        b=VBnrvo6yTpLHu04FfkuKVSXTagQ6KqCiwimXCuOCkPpfeZAVNPfcJYBGy+t+ok7saf
         +CgIT/yIY0FYTmBYTdDJOTRgdiEti9wbgulUtTDjG3ss1EAnxDTY7y0iqhrh/dQPnrOp
         MX3asvRv7vwNXey5m3lIYCYvpdmVrGhgYV7ZVKNMJgfMpq4bgekY1bIa1+u9mesu6mkf
         NoeB6ymzKLDwfE2qzdBb0t4BOCqr6wdiRBTFvbGpeyQXEVAuiLDFkCKS2Nru4Zk/5Z58
         HLH0ZoinK3NjzuaVTbsew39/Q6W20okwhmxVSb0l4mCLoXC0Hek+Iu66mup6iPvNo7eM
         TBOw==
X-Gm-Message-State: AEkoouvQwrFl0AffNjOCp99GHttA/+PKEXVeO9nRfboAGsrZp1pY+ZQKPqrOL1aAkTRRq/XaAIliSu8i077gfA==
X-Received: by 10.107.8.140 with SMTP id h12mr24707391ioi.95.1471871410143;
 Mon, 22 Aug 2016 06:10:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.125.199 with HTTP; Mon, 22 Aug 2016 06:09:39 -0700 (PDT)
In-Reply-To: <vpqr39harit.fsf@anie.imag.fr>
References: <20160712164216.24072-1-pclouds@gmail.com> <20160714153311.2166-1-pclouds@gmail.com>
 <CACsJy8Bw0ZNu-6SB0P3dBZCLMJWJkbUqb64H_QOcn4UH+_AcNA@mail.gmail.com>
 <20160819135408.ckyw6ruseicvg2jt@sigill.intra.peff.net> <5c131421-ae7f-8a37-76ab-0fd05cbe3530@gmail.com>
 <CACsJy8C30=-LGMYQJ6MO17L8Vv1q=iQGC=R8TDhC5qM1f5Lh5A@mail.gmail.com> <vpqr39harit.fsf@anie.imag.fr>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 22 Aug 2016 20:09:39 +0700
Message-ID: <CACsJy8BNP8GDRxDGTQwcYWTovN9o11TCkUJ28=5zav3QnGv9nQ@mail.gmail.com>
Subject: Re: [PATCH v4] config: add conditional include
To:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Cc:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Sebastian Schuberth <sschuberth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 22, 2016 at 7:59 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Sun, Aug 21, 2016 at 4:08 AM, Jakub Nar=C4=99bski <jnareb@gmail.com> =
wrote:
>>> W dniu 19.08.2016 o 15:54, Jeff King pisze:
>>>> On Sat, Aug 13, 2016 at 03:40:59PM +0700, Duy Nguyen wrote:
>>>>
>>>>> Ping..
>>>>
>>>> There was some discussion after v4. I think the open issues are:
>>>>
>>>>   - the commit message is rather terse (it should describe motivation,
>>>>     and can refer to the docs for the "how")
>>>>
>>>>   - the syntax might be more clear as:
>>>>
>>>>        [include-if "gitdir:..."]
>>>>
>>>>     or
>>>>
>>>>        [include "gitdir-is:..."]
>>>
>>> Or
>>>
>>>          [include "if-gitdir:..."]
>>
>> I like this one. I can re-roll to address the first two bullet point,
>> if the last one, the open question, will not become a blocker later
>> on.
>
> I think the syntax should be design to allow arbitrary boolean
> expression later if needed.

I would be against that. We may extend it more in future, but it
should be under control, not full boolean expressions.

> Then, I prefer one of
>
>   [include-if "gitdir-is:..."]
>   [include    "gitdir-is:..."]
>
> because it may later be extended to e.g.
>
>   [include-if "not(gitdir-is:...)"]
>   [include-if "gitdir-matches:regex"]
>   [include-if "gitdir-is:... and git-version-greater:2.9"]
>   ...
>
> I actually already use "conditional include on version number" because I
> use push.default=3Dupstream which makes older versions of Git crash, but
> fortunately these versions of Git also ignore the "include" directive so
> having this push.default=3Dupstream in an included file works. It's a
> hack, it worked once but it won't work again.

We probably have a way to stop old git from reading new git's
features, including ones in config files: the config group
extensions.*. Assuming that "[include "blah"]" is new stuff, git can
be taught to accept that only when extensions.blah is present (which
old git would bail). It discourages adding too many fancy features
(because extensions.* in your config file would be a mess), which is
IMO a good point.
--=20
Duy
