Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5B46202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 22:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751212AbdKTWq7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 17:46:59 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:40767 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751158AbdKTWq7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 17:46:59 -0500
Received: by mail-wm0-f44.google.com with SMTP id b189so21662069wmd.5
        for <git@vger.kernel.org>; Mon, 20 Nov 2017 14:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=h6o4KSuu0R2F9VgE+To6mF/6Reb1QXfhyQQRDvllFKQ=;
        b=tGflghwvz87Bh/gnxNeXYenkn+F00imaRVyB2ZdrVWEqIdvDmDvFkXRJIL2PKQPcUh
         7DGQVE8eaGuu4bECaITDr4gAyBlRZ7dO96ggvXbcIvgEqz5TI4Vu9nSfZV8COp2/obPM
         umqvCbKguTIwbSM9qRtqXF6HuOG046AW7UvFWe5auSYYiaHykNcVfIH/veYCaA9cgHx5
         MX4fhJ852zOBKWuZFMeGSoj/5yFGTIganzhmse/llcNY3f8hjQt3ERyyfhAZ4xaAevqp
         f4A3CY9UWh5d7xAYlyh8tbDWL7VvTkXqiI5a/RE4eno9eookbKeF1rIZbRjHcx5q3i3D
         sF2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=h6o4KSuu0R2F9VgE+To6mF/6Reb1QXfhyQQRDvllFKQ=;
        b=EjE8oH1J6DnItexT0J7ywQyntWdaHoYqHUuXgpx/Z6s8cwLsgoV+DKlgLrFZLj1oCg
         o5iac8whozkNzKbxmjVoHb1xEvPUcGmicxh2bTAANHJmxZXaTRzm5Q0kZqBnTCG9Csyu
         cPhekgwS3AUeo6q19/bsACC2vGsaHjrrMLqn1kNT01oJxe2ONEku4SV+BnS5kg5EWGNQ
         ThfR0L6MD7u+b4DNHwhFmdfchBraHMX0k99Q5rzW1OmWM/puaXp2k7zYdD+tKO26qveg
         6BmLsU+6p4bDZj8IiSexSUMw7Lx4plYICpEdqYWnL3M5/joehthbBg/GJVXRiWVUGzry
         6Xlg==
X-Gm-Message-State: AJaThX5kx5ReJnX4Ve75C1P8KzzBl3OBSxhG85Kd061NKR/R3Hb0h824
        AczVIvxPcpOmB1UJUuNPbhg=
X-Google-Smtp-Source: AGs4zMY6bCw7cpzPKPlWqJpt7DCUdRPj1WyyT/FV4mOVSl14CT54gG46JLkoprjgYURNne5i+k2XYg==
X-Received: by 10.80.136.49 with SMTP id b46mr18289249edb.155.1511218017782;
        Mon, 20 Nov 2017 14:46:57 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id p45sm9299422edc.30.2017.11.20.14.46.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Nov 2017 14:46:56 -0800 (PST)
Received: from avar by evledraar with local (Exim 4.89)
        (envelope-from <avarab@gmail.com>)
        id 1eGuq7-0007Dc-Ts; Mon, 20 Nov 2017 23:46:55 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Dan Jacques <dnj@google.com>
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com
Subject: Re: Re(2): [PATCH 1/1] exec_cmd: RUNTIME_PREFIX on some POSIX systems
References: <87lgj0wtr9.fsf@evledraar.booking.com> <20171120215805.16994-1-dnj@google.com>
User-agent: Debian GNU/Linux 9.2 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <20171120215805.16994-1-dnj@google.com>
Date:   Mon, 20 Nov 2017 23:46:55 +0100
Message-ID: <87ine4wotc.fsf@evledraar.booking.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 20 2017, Dan Jacques jotted:

> On Mon, 20 Nov 2017 22:00:10, Ævar Arnfjörð Bjarmason replied:
>
>> [...]
>
> Thanks for responding. I'll readily confess that PERL and the PERL
> ecosystem are not areas I'm very familiar with, so I'm really grateful
> for your feedback here.
>
>> You need to bust the perl/PM.stamp cache as a function of your
>> RUNTIME_PREFIX_PERL variable (or NO_PERL_MAKEMAKER).
>
> Good catch, I'll add that to the next version of the patch.
>
>> Other than that, is this whole NO_PERL_MAKEMAKER workaround just because
>> you couldn't figure out what the target RELPERLPATH is in
>> $prefix/$RELPERLPATH, which in this case is share/perl/5.26.1 ?
>
> Sort of. I actually had a version set hacked MakeMaker's $INSTALLSITELIB
> (same general result) and it worked.
>
> The executable path resolution logic that I built make assumptions about
> the layout of the installation, and I ended up favoring NO_PERL_MAKEMAKER
> because I could rely on its explicit and straightforward installation
> logic.
>
> I am not sure that MakeMaker adds value in a RUNTIME_PREFIX
> installation, since RUNTIME_PREFIX's motivation is fundamentally portable
> and my impression of MakeMaker is that much of the value that it adds is
> handling system-specific PERL installation details. Given that
> NO_PERL_MAKEMAKER is supported as a Git installation option, I opted to
> take advantage of the explicit installation rather than rely on
> MakeMaker as an intermediary.
>
> My other motivation is that if I integrate $RELPERLPATH into the MakeMaker
> installation, I'd still have to implement that behavior when
> NO_PERL_MAKEMAMER is enabled so that it is compatible with
> RUNTIME_PREFIX_PERL.

Right, it needs some if/else, or we could simply always add lib/ as well
to @INC (via "use lib") and it would work in both modes unconditionally.

> I'd welcome any insight on whether this is the correct way to proceed.
> If we decode to go forward with NO_PERL_MAKEMAKER, I'm happy to add some
> better documentation in the Makefile to detail the rationale for
> forcefully enabling it.

My impression is (see `git log --reverse -p -GNO_PERL_MAKEMAKER`) that
almost nobody uses NO_PERL_MAKEMAKER, so it would be better to make it
work with the more supported mode since it seems easy.

But I've now forgotten all the details of why we're even using MakeMaker
in the first place, if I ever actually knew them.

>> 1. The regex match you're doing to munge the dir could be done as a
>>    catdir($orig, '..', '..', 'lib'), that doesn't work as discussed
>>    above, but *might* be more portable. I say might because I don't know
>>    if the path string is always normalized to be unix-like, but if not
>>    this won't work e.g on Windows where it'll have \ not /.
>
> The regex-based approach was motivated by a perceived value to
> conciseness. Since a larger header code block seems to be acceptable, I
> could emit "$(gitexecdir)" as a constant in the header and operate on it
> at runtime. This would avoid having to calculate the correct sequence of
> "../" to walk up from "$(gitexecdir)" directly in the Makefile.

Yeah I think nobody's going to have any problem with a large header
block.

>> 2. You are 'use'-ing FindBin there unconditionally (use is not function
>>    local in perl), and implicitly assuming it loads File::Spec.
>>
>>    Ignoring the NO_PERL_MAKEMAKER caveats above I'd suggest something
>>    like this:
>
> Sounds good! I wasn't sure whether I should adhere to the one-line header
> that was being used before, but I am all for whitespace if that is
> acceptable.
>
> This seems a bit much to emit from a Makefile - what do you think about
> adding template files for each header in the "perl/" directory and
> preprocessing them via "sed" in the Makefile?

Sure, that sounds great.

>> 3. I may be squinting at this wrong but it seems to me that between
>>    your v1 and v2 reading GITPERLLIB here no longer makes any sense at
>>    all. You used to set it in git itself, now it takes priority but
>>    nothing sets it, presumably you'd have some external wrapper script
>>    that'll set it?
>
> $GITPERLLIB is (as far as I can tell) used for testing, so that PERL scripts
> invoked by tests can find the Git support libraries. I think it is still
> necessary in both RUNTIME_PREFIX_PERL and default worlds because tests run
> Git out of the repository root, so relative resolution logic based on
> installation paths will not work.

Ah, thanks. Makes sense, I missed that.
