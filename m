Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 492E41F4F8
	for <e@80x24.org>; Mon, 10 Oct 2016 09:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751214AbcJJJ1a (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 05:27:30 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:34517 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751027AbcJJJ13 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 05:27:29 -0400
Received: by mail-io0-f170.google.com with SMTP id r30so104973448ioi.1
        for <git@vger.kernel.org>; Mon, 10 Oct 2016 02:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=r+pTHE8WVFbukA0TWX2lm1TQ4WhAoJZXgm76DM7ITiI=;
        b=KFQtEyYSsOZ9O/TH9l5Gw7I3gJzykr6qJ3hvoyxU5OkB5I35VhuBjkTwO2vWFaeKf5
         gG3ts9DCgdk9zxn8AXJhsQPwx8QtcAqhB6vYMK/HqFlcrjqda3SaDsRWJoeWVtgGDwGv
         SMSykKO7lyxJr0aMTjD96tx4meHQIXIg31wNPvKt7TLDHiUiq+ugk6j23IFJBrKf8gG4
         D33Qsmc9V2kx8iUbKwn3996mO2P02NxVKyei1v6/07t5ckCE1PJFWCG6fk2g1NIidOW4
         C+KMgdpXWRcoI6hj9BeGjzxNsZIrAWHkB2mLwcDyR+6/G3d+f2MIqEts3TAp0RUv5ayv
         3SUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=r+pTHE8WVFbukA0TWX2lm1TQ4WhAoJZXgm76DM7ITiI=;
        b=RZENm4HmofG69LTZTP0SqEazCM/WqsnAPiyNH6QDlHIzlGOorSx8lLJ/Rpfof+UVWF
         2E3P6NHelLZnop7NQMGZ5fFSOetvq2R5te+tM3ry2kYWx0NXggBbiA479MZ4qM7paPNh
         nW85vsUahK1qcTP2TPsBhmdDyfOk92lQvVRy2Jouw2/FmYxZwW+wSXVVD97oOEhubz3A
         mooteoxPsyHjQU4p/JXIhomWZp0Hyado98o17CvbElUW4aBcSZQOqcyHvghOBSAwjfH5
         XvztHPC1DBMMiIuLF7NgzZWw/PzU0+oyZJuoc9eKpGfUUWAnYhv8LUicYJp4GVxAaBOc
         UNIw==
X-Gm-Message-State: AA6/9RnZeyvFqFxxJw6Hp0hF1cWcGGdohbfRaBJnH8JdaQXzDIiDjWHkYyWUNdD6RF2D7Kcm8kR0EJErWty96A==
X-Received: by 10.107.44.17 with SMTP id s17mr31371564ios.212.1476091609200;
 Mon, 10 Oct 2016 02:26:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.230.206 with HTTP; Mon, 10 Oct 2016 02:26:18 -0700 (PDT)
In-Reply-To: <20161009234617.y6xfjyv6xjkf2afi@sigill.intra.peff.net>
References: <cb81631e-9623-9020-f955-ec215b493a50@hale.ee> <f35965e9-2901-b9b5-92e5-9bc7fe673637@web.de>
 <65d8def3-df62-6c45-7d8f-79b6a8769bf5@hale.ee> <25c17e16-2456-7da3-ae22-2dc812a3aa0d@web.de>
 <20161009234617.y6xfjyv6xjkf2afi@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 10 Oct 2016 16:26:18 +0700
Message-ID: <CACsJy8CroyynVMctbPhuVr2VVQB7YyfcxDaMT25BikQ4R4We0Q@mail.gmail.com>
Subject: Re: %C(auto) not working as expected
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Tom Hale <tom@hale.ee>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 10, 2016 at 6:46 AM, Jeff King <peff@peff.net> wrote:
> On Sun, Oct 09, 2016 at 03:24:17PM +0200, Ren=C3=A9 Scharfe wrote:
>
>> Offering a way to enable terminal-detection for all color codes of a
>> format would be useful, but using the existing "auto," prefix for that
>> would be a behaviour change that could surprise users.

I wonder if we made a mistake associating terminal-detection with
%C(auto,...). The more likely use case is enable or disable all
colors, not "the next tag".

> Yeah. In retrospect, it probably would have been saner to make %C(red) a
> noop when --color is not in effect (either because of --no-color, or
> more likely when --color=3Dauto is in effect and stdout is not a
> terminal). But that ship has long since sailed, I think.
>
> If we do a revamp of the pretty-formats to bring them more in line with
> ref-filter (e.g., something like "%(color:red)") maybe that would be an
> opportunity to make minor adjustments. Though, hmm, it looks like
> for-each-ref already knows "%(color:red)", and it's unconditional.
> <sigh> So perhaps we would need to go through some deprecation period or
> other transition.

We could add some new tag to change the behavior of all following %C
tags. Something like %C(tty) maybe (probably a bad name), then
discourage the use if "%C(auto" for terminal detection?
--=20
Duy
