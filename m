Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D65CF1FA26
	for <e@80x24.org>; Wed, 19 Apr 2017 07:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760293AbdDSHDO (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 03:03:14 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:36766 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760290AbdDSHDN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 03:03:13 -0400
Received: by mail-it0-f44.google.com with SMTP id b15so23792362iti.1
        for <git@vger.kernel.org>; Wed, 19 Apr 2017 00:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sZd3gAchi4ceVUS/lgcf4fxTEsTe30bn2aEcYgMSX+8=;
        b=nWrhQksrrs2HZ20d55PdVZaTWcTj7hqGdcN+U+pgHfcmUz1lt8CNGo14e10sD/k5eS
         mMOmQPvHF+FNoKA8yHwmUVzgWUMz23uqrJoqku1XJPckQJyFZDjNhK7gFZHngCwAlG5s
         OfW2BlTmootrV4DVfnCBq9cjYZFrVS3I/61MO8Xau0VxymK6+34cXGAxglSOLHnjKNct
         VhsjUSVMQXR/MSlBh1f3hBj68x6DArcC8NxrFSv5vwH23PbFpKHLghIvL9DB30FxCgrT
         obsvqMpVR91p12NkbuTBz7s74s0hBc0JMVVbUH/Fczyd7HcBAOFth6Wt/6ZIUw507/7Y
         XhDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sZd3gAchi4ceVUS/lgcf4fxTEsTe30bn2aEcYgMSX+8=;
        b=RoLOTKg/rGg3+tjmBHSvAGU2SOpHFw6YhkBRdvYIW3aPy1O0bhtQ/QUF+wkjri+fia
         umNZZGauoIfVe7jOuSy3gG72FIUFkYYTWCkaqDqGAb4QnD3uWMhLzspbxe57QqNG3tMy
         HK1pxSRpO9QLryXw2VxKeKyqE/dQ4+oiKoCE7WrNjPqLHnq+d5XqdAWcw42zg8ERWabd
         sAFyajxvHKEy0/RcjnxzY+oapf1afii0YdlCE7RZetQJsoUf98OGawLvLTwSjOOs+fXD
         wUW9bwq32fIRVtmOyY8q9ZdUt5J2dHAi5esyR9ICYwikuLRaeBV4t4wpJHzgZ3vP4oRV
         qcZw==
X-Gm-Message-State: AN3rC/4xRAy5AscpYkR2UX8nmHgsh8wxGCazNFK87/MVqh902lZCJvRq
        6+zMFb8foWySmLtx0ofaQyCrjgyWEA==
X-Received: by 10.36.43.77 with SMTP id h74mr1760109ita.60.1492585392970; Wed,
 19 Apr 2017 00:03:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.134.97 with HTTP; Wed, 19 Apr 2017 00:02:52 -0700 (PDT)
In-Reply-To: <20170419025016.we3tfuvgppuamc7g@sigill.intra.peff.net>
References: <20170418170914.9701-1-avarab@gmail.com> <de79d366-3609-8efe-b23a-7e793036b3ef@web.de>
 <20170419014143.56io56xn6mawy5xi@sigill.intra.peff.net> <xmqqh91lce6y.fsf@gitster.mtv.corp.google.com>
 <20170419025016.we3tfuvgppuamc7g@sigill.intra.peff.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Wed, 19 Apr 2017 09:02:52 +0200
Message-ID: <CACBZZX5wHvWgqjBaiD4pJsVQug=+-4xRwkvfZ0uZ=meE3xR6NQ@mail.gmail.com>
Subject: Re: [PATCH] various: disallow --no-no-OPT for --no-opt options
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 19, 2017 at 4:50 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Apr 18, 2017 at 07:40:37PM -0700, Junio C Hamano wrote:
>
>> > It might even be possible to detect the existing line and
>> > have parse-options automatically respect "--foo" when "--no-foo" is
>> > present.  But that may run afoul of callers that add both "--foo" and
>> > "--no-foo" manually.
>>
>> True but wouldn't that something we would want to avoid anyway?
>> That is, "git cmd [--OPT | --no-OPT | --no-no-OPT]" from the end
>> user's point of view should be an error because it is unclear what
>> difference there are between --OPT and --no-no-OPT.  And we should
>> be able to add a rule to parse_options_check() to catch such an
>> error.
>
> I meant that if you have something like this in your options array:
>
>   { 0, "foo", OPTION_INTEGER, &foo, 1 },
>   { 0, "no-foo", OPTION_INTEGER, &foo, 2 },

I may be missing something, but don't we already do exactly what
you're describing here? See commit f1930c587 ("parse-options: allow
positivation of options starting, with no-", 2012-02-25) from Ren=C3=A9
Scharfe.
