Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C050E1F404
	for <e@80x24.org>; Sun, 25 Feb 2018 18:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751881AbeBYS4m (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Feb 2018 13:56:42 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:35747 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751728AbeBYS4j (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Feb 2018 13:56:39 -0500
Received: by mail-wm0-f45.google.com with SMTP id x7so10964912wmc.0
        for <git@vger.kernel.org>; Sun, 25 Feb 2018 10:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=57ExUdxK4M+gaNwEUY2ObCOcAJ6oM1CwjxL+i/SaGIs=;
        b=nVWbJxEVN4MRHPagsT0Aygn5sWnxxpil2mv55tblhs41jwAH4rhT7WnyYG/57YMbO4
         r16wZcvOOkVyYa8UwfZtApdYcfqgvAKYJSazT4L2SOCrX0/rp6DlHPIqeanapeIhBmEG
         ABCHJlLrKfYEKaWAO2+RqPwqpVxEOXZ/YQg24j2W6A/usd4F3IxIy+3sLOOogbnuGbhH
         u+7ipDlrmz1qYCH0wzCeHTTXngCC96frZvd2jt/cd8MckLMhnnsB2+MBhgRKDAy3+mGN
         r6hdCXGfRwltoMxUZhBo9wwoa8fp2VDjfTOTC1kJyf7pyTqW6Gxw8qvUwmldARBJj4hS
         X6wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=57ExUdxK4M+gaNwEUY2ObCOcAJ6oM1CwjxL+i/SaGIs=;
        b=s6whPb3I2KJ1r7ZsX4RP7cODBMeGZSWo9Zr1h3+IgT2l1IgmYR1HCxQAhxcWSTgL8W
         A4KLKguhfTwCPrqPp4KDcUsLoWfsMTgP8M8bO5NiNuqfDjAz+FkVFVFTqF/eXPMan6t9
         r0QTcDkqQIVrOWXmg+hQYNFC0n7TRHQYE/a2d0EKkrpXJDC5zR8UG0GsVS6wWx4xLzO9
         mRUafATgHiUJbzxTyARe0OeGd028n5IjMfS5pMVfeDlNBaqKXxEusG7qbMh3VG/Ofd6a
         82vvzlmHmdfWJEb+SG7ZnNuK0dXPO/xUR1MFJCkTJdwURnU2lpTVWmFj9L0TQyPvyBZn
         jAlQ==
X-Gm-Message-State: APf1xPDxFJFbdZDW0fogdLPV5vTH+HaxoWcB/flt4lZEZ8AquozxspOB
        r8URXkls9QGvDJ3bDQIsGzR0M9+x
X-Google-Smtp-Source: AH8x226bJOMOErrLjGPlIokzaJ5352cII+1QJnkJYX/RkUthCvufDQ4bf8p8CsZ+WDg/jSPXv0Y0tg==
X-Received: by 10.80.172.131 with SMTP id x3mr11577477edc.260.1519584997466;
        Sun, 25 Feb 2018 10:56:37 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id u38sm6700659edm.50.2018.02.25.10.56.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Feb 2018 10:56:36 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>, Petr Baudis <pasky@ucw.cz>,
        Benoit Bourbie <bbourbie@slb.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jari Aalto <jari.aalto@cante.net>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
        Marcus Griep <marcus@griep.us>
Subject: Re: [PATCH 3/8] perl: generalize the Git::LoadCPAN facility
References: <20180214222146.10655-1-avarab@gmail.com> <20180214222146.10655-4-avarab@gmail.com> <20180214225754.GC136185@aiede.svl.corp.google.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <20180214225754.GC136185@aiede.svl.corp.google.com>
Date:   Sun, 25 Feb 2018 19:56:34 +0100
Message-ID: <87sh9oew4d.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 14 2018, Jonathan Nieder jotted:

> Ævar Arnfjörð Bjarmason wrote:
>
>> Change the two wrappers to load from CPAN (local OS) or our own copy
>> to do so via the same codepath.
>
> nit: I think with s/to load/that load/ this will be easier to read.
>
>> I added the Error.pm wrapper in 20d2a30f8f ("Makefile: replace
>> perl/Makefile.PL with simple make rules", 2017-12-10), and shortly
>> afterwards Matthieu Moy added a wrapper for Mail::Address in
>> bd869f67b9 ("send-email: add and use a local copy of Mail::Address",
>> 2018-01-05).
>>
>> His was simpler since Mail::Address doesn't have an "import" method,
>> but didn't do the same sanity checking, e.g. a missing FromCPAN
>> directory (which OS packages are likely not to have) wouldn't be
>> explicitly warned about.
>
> I'm having trouble parsing this.  Mail::Address didn't do the same
> sanity checking or his didn't?
>
> The comma before e.g. should be a period or semicolon, since it's
> starting a new independent clause.
>
>> Now both use a modification of the previously Error.pm-specific
>> codepath, which has been amended to take the module to load as
>> parameter, as well as whether or not that module has an import method.
>
> Does "now" mean before this patch or after this patch?  Usually
> commit messages describe the status quo without the patch in the
> present tense and the change the patch will make in the imperative.
> So this could say:
>
> 	Update both to use a common implementation based on the previous
> 	Error.pm loader.

All good feeedback, thanks. Incorporated into v2 which I'm about to
submit.

> [...]
>> +++ b/perl/Git/LoadCPAN.pm
>> @@ -0,0 +1,74 @@
> [...]
>> +The Perl code in Git depends on some modules from the CPAN, but we
>> +don't want to make those a hard requirement for anyone building from
>> +source.
>
> not about this patch: have we considered making it a hard requirement?
> Both Mail::Address and Error.pm are pretty widely available, and I
> wonder if we could make the instructions in the INSTALL file say that
> they are required dependencies to simplify things.

I can't remember when, but at some point this was discussed on list, and
the consensus was that us using perl should be kept as a non-invasive
implementation detail that would be as small of a pain as possible for
users.

It's easy for distros to package these modules, but for users building
from source who know nothing about perl it can be a pain.

I also think it's very useful to avoid the side-discussion about not
using some useful CPAN module in the future just because it's not widely
used, but would be perfect for some use-case of ours.

> I admit part of my bias here is coming from the distro world, where we
> have to do extra work to get rid of the FromCPAN embedded copies and
> would be happier not to have to.

I think there's a very good argument to be made for inverting the
NO_PERL_CPAN_FALLBACKS logic, but my soon to be submitted v2 keeps it
off by default.

> [...]
>> +Usually OS's will not ship with Git's Git::FromCPAN tree at all,
>> +preferring to use their own packaging of CPAN modules instead.
>
> nit: I think the plural of OS is OSes, or something like
> "distributors" or "operating systems".

Thanks.

> [...]
>> +    eval {
>> +	require $package_pm;
>> +	1;
>> +    } or do {
>
> also not about this patch: this mixed tabs/spacing formatting feels a
> bit unusual.  I don't know if it's idiomatic for perl, and if it is
> then no complaints; it just stood out a little.  Can
> Documentation/CodingGuidelines say something about the preferred
> indentation in Perl to avoid having to think about such questions?

Thanks, that sucked. Changed to \t. I still haven't gotten around to
hacking my $EDITOR settings for git.git (like for C & SH).

>> --- a/perl/Git/LoadCPAN/Error.pm
>> +++ b/perl/Git/LoadCPAN/Error.pm
>> @@ -2,45 +2,9 @@ package Git::LoadCPAN::Error;
>>  use 5.008;
>>  use strict;
>>  use warnings;
>> +use Git::LoadCPAN (
>> +    module => 'Error',
>> +    import => 1,
>> +);
>
> Nice!
>
> Thanks and hope that helps,
> Jonathan
