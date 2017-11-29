Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37A2920A40
	for <e@80x24.org>; Wed, 29 Nov 2017 22:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752348AbdK2WiM (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Nov 2017 17:38:12 -0500
Received: from mail-qt0-f175.google.com ([209.85.216.175]:33716 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752071AbdK2WiK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Nov 2017 17:38:10 -0500
Received: by mail-qt0-f175.google.com with SMTP id e2so6509936qti.0
        for <git@vger.kernel.org>; Wed, 29 Nov 2017 14:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lYkSZyRzLT5B4tRRUww2jBJmBEBW/lcc1aiSrAtTyOE=;
        b=eNo5iZp+hrPtdKqV/ubdC9d7nQgBULQvJ2Q/Odi/XIGnWKykrvQDYqyj7ymTvMRKZl
         i5sScjCWL3ladJfrE1pYBlcvyVFLkzSDZJ61XDHP35RCiJrufEfTY5cSs8YD0Stl3sZ0
         NVCDJnJWysjZlplKi90urAhymrVRwX26EZA3jP2dZAchttF3ho9LKXllWjm8u7lyYTXj
         TgxXb3i/Ih8jHmwcFxgtFo2UyJAIqMI0Fs8yOLUVZG4Ij1Fvi5QBp9bp2/NntBLDNJ5A
         oN0UPZ/f+UqZf8aQZvoFkhdzUJChHyzxOfT4VSCAJEydh3jqMQqpXwD5bRJVTDwHctaB
         RPhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lYkSZyRzLT5B4tRRUww2jBJmBEBW/lcc1aiSrAtTyOE=;
        b=GpZzfJaJe4vrFUzXiqaj+CAVspR2fKRdV8M3hNQHrHVgrVju3P/tJA3xYXdUgH8Sng
         JG5dcD24Vqo1QLYWbNRpYghRFjKaqP34N7uI9+33aq+PoRrKdikcJtizwjVG/jKga1po
         C/UquDsmAPkaYEtsFyF/ctuXf1LG6jQWbSqcaY1RaXtPmqIznjvYI0lw6ml+XupeQjbj
         RkiBGgtguqUAXijVuOIemajkJrtiLQc6N6kGgOvOLzwIolT30Zjv6ns1UvFfx9zJcOEW
         IaaxtGN6vAypcOQqf290/7pJKvMgPnl8CI37jRzuOgu2IHfaA5f6AymkssgxaXfnigFP
         qT1w==
X-Gm-Message-State: AKGB3mKWxDURiMVcCYqcy/7jYSofKpizfTM7q3S93lgUKNTG/oxGpw7M
        9Encu30Z5Fu4cXtopufHeKl1jg==
X-Google-Smtp-Source: AGs4zMYmYkEHzaFBRBR7SnfTJuXNzyHNCRd1FTv/9sE4DmJpyV1Ql+pQCt/1c7kdwLiBlfiHXEotJg==
X-Received: by 10.200.4.154 with SMTP id s26mr756837qtg.156.1511995089412;
        Wed, 29 Nov 2017 14:38:09 -0800 (PST)
Received: from dnj-macbookpro.fios-router.home (pool-108-32-46-175.pitbpa.fios.verizon.net. [108.32.46.175])
        by smtp.gmail.com with ESMTPSA id g47sm1979772qtc.69.2017.11.29.14.38.08
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 29 Nov 2017 14:38:08 -0800 (PST)
From:   Dan Jacques <dnj@google.com>
To:     avarab@gmail.com
Cc:     Johannes.Schindelin@gmx.de, dnj@google.com, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH v4 0/4] RUNTIME_PREFIX relocatable Git
Date:   Wed, 29 Nov 2017 17:38:07 -0500
Message-Id: <20171129223807.91343-1-dnj@google.com>
X-Mailer: git-send-email 2.15.0.chromium12
In-Reply-To: <87h8tcvlew.fsf@evledraar.booking.com>
References: <87h8tcvlew.fsf@evledraar.booking.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> In general this whole thing structurally looks good to me with the
> caveats noted in other review E-Mails.
>
> I haven't done anything but skim the details of the "where's my
> executable" C code though, just looked at what it's doing structurally.
>
> I think it makes sense for this to land first ahead of my patch. This is
> an actual feature you need, whereas I just hate our use of MakeMaker,
> but that can wait, unless you're keen to rebase this on my patch. Would
> probably make your whole diff a bit shorter.

I'm not strictly pressed for time here, so we can put this off if that's
strategically appropriate. Chromiuum, right now, just manually patches
upstream Git with a similar patch set, so it's working and function. This
is just an effort to upstream those changes for everyone else to enjoy!

I think that landing in either order is probably okay, so if your RFC
goes through pretty quickly I don't mind rebasing, but if this is otherwise
good to go in v5, I wouldn't mind landing it and then removing the
obsoleted parts during the Makefile update.

> The whole converting our absolute to relative paths in the make code is
> unavoidably ugly, but after having an initial knee-jerk reaction to it I
> don't see how it can be avoided. I was hoping most of these paths
> could/would just be a fixed path away from our libexec path, but alas
> due to having had these configurable all along that simplicity seems out
> of reach.

Yeah I spent no small amount of time massaging that code hoping some better
formulation would shake out, and this is what I ended up with.
UNTIME_PREFIX_PERL is a specialty build with a stronger set of assumptions
than the standard installation (RE prefix-relative paths).

> Maybe I asked this before, but I don't see any obvious reason for why
> RUNTIME_PREFIX_PERL is a different thing than RUNTIME_PREFIX as opposed
> to us just doing the right thing for the perl scripts.

I did this to isolate Windows builds from the Perl script changes. Git-for-
Windows uses (invented) RUNTIME_PREFIX, but runs its Perl scripts in a
MinGW sub-environment which, internally, has the Perl libraries installed
at a fixed path, so it doesn't need any special resolution logic.

I support that if Git-for-Windows wants to, a trivial future patch can
merge the two, so I opted to play it safe and keep these changes isolated.

===

> We could use $ENV{GIT_EXEC_PATH} instead of FindBin here though, I
> missed that the first time. But that's just a nano-optimization. I just
> wondered whether git wasn't already passing us this info.

Oh good idea - I'll go ahead and do this.

> There is one remaining bug here. Git::I18N isn't doing the right thing,
> I installed in /tmp/git and moved to /tmp/git2, and it has:
>
>     our $TEXTDOMAINDIR = $ENV{GIT_TEXTDOMAINDIR} || '/tmp/git/share/locale';
>
> And GIT_TEXTDOMAINDIR is not passed by git (it's only used for the tests
> IIRC). Would need a similar treatment as this. Easiest to just set the
> path we find here in $Git::Whatever and pick it up in $Git::I18N later,
> it's not like anyone uses it outside of git.git.

Good catch! I'm going to see what I can do here.

> But that does raise a more general concern for me. Isn't there some way
> we can run the test suite against an installed git (don't remember),
> then build, install, move the dir, and run the tests from the moved dir.
>
> That would have caught this bug, and anything else that may be lurking
> still.

I am not aware of such an option, but I'll take a look again. This sort of
thing might just require a reformulation of the test suite in general to
make it run against a Git installation instead of the intermediate
artifacts. A positive outcome would be the ability to remove the Perl
path environment variable hacks ($ENV{...} || ...) and just use production
resolution logic, increasing the test surface! But I think that's a bit more
work than I have time for at the moment.

===

> Noticed after I sent the last E-Mail, this is missing @@INSTLIBDIR@@
> which per my reading of it being initially introduced should be here in
> addition to this relative path.
>
> My reading of the intial patch that added it, as indicated in my patch,
> is that it's the dir we're going to be installing our libs to, so I
> didn't fiddle with it, but I think with your patches we need that dir
> *and* or own $perllibdir.

INSTLIBDIR is used for the standard fixed-prefix header, but not in this
one. This one uses a combination of GITEXECDIR and PERLLIBDIR. PERLLIBDIR
is effectively the prefix-relative part of INSTLIBDIR, so it's here in
spirit!

Thanks for taking the time to review! I'll go ahead and see what I can do
RE your comments.

Cheers,
-Dan
