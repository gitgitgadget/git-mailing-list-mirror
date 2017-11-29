Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B183F20A40
	for <e@80x24.org>; Wed, 29 Nov 2017 21:04:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752791AbdK2VEv (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Nov 2017 16:04:51 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:47007 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752219AbdK2VEu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Nov 2017 16:04:50 -0500
Received: by mail-wm0-f49.google.com with SMTP id r78so9062367wme.5
        for <git@vger.kernel.org>; Wed, 29 Nov 2017 13:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=hQ7rqdavMbFQHA8+z47b9+vrn/Chu+dRtW+9FL7K0zs=;
        b=KehAkIzJX0+RgB/fet21HX7vEdRnjdN6O5JA+FUP25qgNQxs2TmolsT22pfSGdXI/7
         KwsUszEa3Njr1uzMFFD27Lke7C9GfZXrQqpIGlTVJLpk3eaP+zjQoLsTFJC/YclsuBx0
         md282RhDVlEYi2ISX0WuOOQNLkrRTjOmxLAoeK/4djaGynQej3X63yzO7EVNFyOvW+uN
         XLmGMkZ7JXiBWKmUYEjbe1H0gi6QohI2w3Vb6OjAlSbnK0yDh9d3ay1P/jA3I8WGZbO7
         yurlnIo+wZJ5e496evwcd99A6Q5aTH2s2XNP76Kh6/mR8zgvNL5AQNPDesXIrO9VTS/T
         r3Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=hQ7rqdavMbFQHA8+z47b9+vrn/Chu+dRtW+9FL7K0zs=;
        b=guX5GCnDn7rylKCbh7FcYuwV8HDe8T/YE+OPViwBspskAzccGMrt4thbQkD76zzIHn
         xjUqyepyZ+e2eHF5Ea+W4vcjTT4FNXxZ/XsmymeZrNO6uZd9neTdDXOC72ixS1Hr8fD+
         eXvVSLQmrjvdnEs3otwrcjhtPDD2i3ieqJX5w20Z9vGMb5x6+mqye1M8ZGbaDfW3UBix
         X+baEjdv0GrU9OHucCXQauGDi3rKg1d44QLJxbt/IbrC5AQXgogXdEwzmWq6GLKIGV4a
         ass2pV5qvk8si+S13K9D86Nv39oKsMyNPZZeZwwDFVxEYLI1Ghx7o3bgrbCTZ4TlDnm1
         PxvA==
X-Gm-Message-State: AJaThX5UJDIPkhf7ig1DxvaG9zA4p+wHllCTIjrxi2DLq+DPzT+s7L/R
        jLNIf0hOJKWfAIkFEvIDx4g=
X-Google-Smtp-Source: AGs4zMZWX6Z0AeqpmQF9CG8TRRcvDrqjdrTr+dDidgB9QCsOhuLNrHY67PKmzTJCRjB5cppwQRJsUQ==
X-Received: by 10.80.149.141 with SMTP id w13mr9480535eda.79.1511989489589;
        Wed, 29 Nov 2017 13:04:49 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id c25sm2557355edb.52.2017.11.29.13.04.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Nov 2017 13:04:48 -0800 (PST)
Received: from avar by evledraar with local (Exim 4.89)
        (envelope-from <avarab@gmail.com>)
        id 1eK9XD-0008Tf-TL; Wed, 29 Nov 2017 22:04:47 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Dan Jacques <dnj@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v4 3/4] Makefile: add Perl runtime prefix support
References: <20171129155637.89075-1-dnj@google.com> <20171129155637.89075-4-dnj@google.com>
User-agent: Debian GNU/Linux 9.2 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <20171129155637.89075-4-dnj@google.com>
Date:   Wed, 29 Nov 2017 22:04:47 +0100
Message-ID: <87indsvlsg.fsf@evledraar.booking.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 29 2017, Dan Jacques jotted:


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

Noticed after I sent the last E-Mail, this is missing @@INSTLIBDIR@@
which per my reading of it being initially introduced should be here in
addition to this relative path.

My reading of the intial patch that added it, as indicated in my patch,
is that it's the dir we're going to be installing our libs to, so I
didn't fiddle with it, but I think with your patches we need that dir
*and* or own $perllibdir.
