Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F57E20A40
	for <e@80x24.org>; Wed, 29 Nov 2017 21:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752767AbdK2VA2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Nov 2017 16:00:28 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:46512 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752647AbdK2VA1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Nov 2017 16:00:27 -0500
Received: by mail-wm0-f67.google.com with SMTP id r78so9041209wme.5
        for <git@vger.kernel.org>; Wed, 29 Nov 2017 13:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=yVFwzj95n+LhAELS5zfmQc1F95EXT7GuIQbEuPZhfb0=;
        b=tyBqBXS+ElwjcEu/sJR1CvcyjbRNahSOKaWxgAPcDrGv7Te+mulu5KENzkXUOkV7VQ
         NVMBcCpNUfQwyOo0kMsC+mHe6cJdy9yGL0T+f6aPkEzxIENs5aBLgvjwschNb2gdIh7+
         Y4uqPMXec/bFnKCrNDtqpyeSv9CxAZuaRwBx4t8Zp9nTcqhjPRQskmYvqWuWw2+xWxHK
         ppDPS3bShMpfoHObq/5Uu0K7ivbEdT+odPlPWDdDZhwIBLKMk14gjkEqDh/T0MjE0Dvf
         RB/P4UXvSb/MExoznxTokO1IXHrVOj3rdho503KaC+xyZdS+ll/G1dqnMDnL7zgIPk8l
         up5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=yVFwzj95n+LhAELS5zfmQc1F95EXT7GuIQbEuPZhfb0=;
        b=AgjZmF1mgJqNgyNvkX5hZ07YVqle45fKHGcOMUq3w6vNxohgCu86tr0gf6jcDah/Qq
         H88RfZtbREzQZmiT9pIyuwoeuRdfbE5GUecB6AdPw1tE12HGRrtUOKTYV8/NL5F1elhX
         oOfRiWxnfFuANU85+ZTcpHRWiblTGoHB4QYHeWXjo4KenmRWz3OjIxm0ycVZvFUhFmZY
         aJganwdK8AOytLrAHEkKw4ZeWI+I7nj96ZnEqqc8gYJuqlWrQOwhBs1E+NtLrkTrdaNR
         VVe17mBxG/Gpy5J00E//PTljQ95jCrNmKpcLJplWCB/inDWFwvX3XyFWJCfN3/NWJIwc
         Uvrw==
X-Gm-Message-State: AJaThX5e8WFHM3lwZV3JmNwxL9nQBcIbKzLVa39zrvcbzn0aJ2QB50OV
        vMhgrZxR7EOjogkOrsYgrVhiw/Jz
X-Google-Smtp-Source: AGs4zMYcypTOIhbiK1Xs8nTcWApfg7mb552eUxY2+ldqeyoArfXbiNXgu1vkAd3TTikyhk5x6B8vnA==
X-Received: by 10.80.133.193 with SMTP id q1mr9453679edh.50.1511989225884;
        Wed, 29 Nov 2017 13:00:25 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id 4sm1965979edf.81.2017.11.29.13.00.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Nov 2017 13:00:24 -0800 (PST)
Received: from avar by evledraar with local (Exim 4.89)
        (envelope-from <avarab@gmail.com>)
        id 1eK9Sx-0008Qh-Ld; Wed, 29 Nov 2017 22:00:23 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Dan Jacques <dnj@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v4 3/4] Makefile: add Perl runtime prefix support
References: <20171129155637.89075-1-dnj@google.com> <20171129155637.89075-4-dnj@google.com>
User-agent: Debian GNU/Linux 9.2 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <20171129155637.89075-4-dnj@google.com>
Date:   Wed, 29 Nov 2017 22:00:23 +0100
Message-ID: <87k1y8vlzs.fsf@evledraar.booking.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 29 2017, Dan Jacques jotted:

> Add a new Makefile flag, RUNTIME_PREFIX_PERL, which, when enabled,
> configures Perl scripts to locate the Git installation's Perl support
> libraries by resolving against the script's path, rather than
> hard-coding that path at build-time.
> [...]
> diff --git a/perl/header_runtime_prefix.pl.template b/perl/header_runtime_prefix.pl.template
> new file mode 100644
> index 000000000..fb9a9924d
> --- /dev/null
> +++ b/perl/header_runtime_prefix.pl.template
> @@ -0,0 +1,24 @@
> +# BEGIN RUNTIME_PREFIX_PERL generated code.
> +#
> +# This finds our Git::* libraries relative to the script's runtime path.
> +BEGIN {
> +	use lib split /@@PATHSEP@@/,
> +	(
> +		$ENV{GITPERLLIB}
> +		||
> +		do {
> +			require FindBin;
> +			require File::Spec;
> +			my $gitexecdir_relative = '@@GITEXECDIR@@';
> +			my $perllibdir_relative = '@@PERLLIBDIR@@';
> +
> +			($FindBin::Bin =~ m=${gitexecdir_relative}$=) ||
> +			    die('Unrecognized runtime path.');
> +			my $prefix = substr($FindBin::Bin, 0, -length($gitexecdir_relative));
> +			my $perllibdir = File::Spec->catdir($prefix, $perllibdir_relative);
> +			(-e $perllibdir) || die("Invalid library path: $perllibdir");
> +			$perllibdir;
> +		}
> +	);
> +}
> +# END RUNTIME_PREFIX_PERL generated code.

Ah, I see. To answer my own question in
<87lgiovokg.fsf@evledraar.booking.com> you're making this stuff a
relative path so you can use it here later on. I.e. we $FindBin::Bin,
and then go from there. Makes sense.

We could use $ENV{GIT_EXEC_PATH} instead of FindBin here though, I
missed that the first time. But that's just a nano-optimization. I just
wondered whether git wasn't already passing us this info.

There is one remaining bug here. Git::I18N isn't doing the right thing,
I installed in /tmp/git and moved to /tmp/git2, and it has:

    our $TEXTDOMAINDIR = $ENV{GIT_TEXTDOMAINDIR} || '/tmp/git/share/locale';

And GIT_TEXTDOMAINDIR is not passed by git (it's only used for the tests
IIRC). Would need a similar treatment as this. Easiest to just set the
path we find here in $Git::Whatever and pick it up in $Git::I18N later,
it's not like anyone uses it outside of git.git.

But that does raise a more general concern for me. Isn't there some way
we can run the test suite against an installed git (don't remember),
then build, install, move the dir, and run the tests from the moved dir.

That would have caught this bug, and anything else that may be lurking
still.
