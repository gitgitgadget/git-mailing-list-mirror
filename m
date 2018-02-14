Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C01A21F404
	for <e@80x24.org>; Wed, 14 Feb 2018 22:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031915AbeBNW57 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 17:57:59 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:39188 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031852AbeBNW56 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 17:57:58 -0500
Received: by mail-pl0-f67.google.com with SMTP id s13so5781017plq.6
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 14:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=zXyUXW5PMNfycZYcA+Oq3WNqTH8yn3rNgQXqthk3VyY=;
        b=SuXwyk07qG9xkZrsdzUxpu75qxEeg8LvTA45cyF2Cf/xAetfxGHVC7Aj/2ERgysAeZ
         aGVthbhXqsXq46jMI0pNHN/0Q4vuV71U1RSPfURc2yxh7R9LkTWeTaTbpmF6eVRZZdWZ
         dY12Vx3r9F5s2Ze7S6hf187YKzbsOLO6mHmXlNYO0BrK/1+TdqoHFlia5AgqQjYAb+SA
         HtIy7FsGCjUWs1fICUEewOlVMNUdlTI1W1pC+sSs2Gn9sxWjx3XCkQ7GgFX/q8u8scCh
         wQ1bI1LlyUwXGLvNXXmKhQrI3zNrWTO/dTO7Qx1T7jiFCqPLd2/cxoSnCJqdGcJtBDES
         p/2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=zXyUXW5PMNfycZYcA+Oq3WNqTH8yn3rNgQXqthk3VyY=;
        b=svyaOApZVmWaE7CJunavjGKeG5qMhs1Z19v0Q+KO4Nv4n8EHcKJVtEdZowpYyAHcIR
         359UrQ3lljEp9BhryKR61mhoUG9gGsSDC14t9bzq9C2+QsyyJbsbgnvtkj8IBqwFiQgM
         /uHBbu9x9UNFrmpIwf2LmTUvX829rMWVu/AihJeQQxm+nqX7zlTO7gWpygsMC7KwU6Xh
         aG/7NskQbOTuFSFV+tsV9Lo7SKFYQl95u5WJOC3+nQIuUPstszp6ymaWJogaOYhTNNRI
         RNjjJ4E3TFt/Fx2tt/AsM7i5VEW25v7SkOZCtnTxWf3T2ayPAzEnuLbA7vealL/qzyXV
         N/TA==
X-Gm-Message-State: APf1xPAUGjVSJAvWj6AVEDbBRKFBhc1UuuIEq81DJMibBMbCmnkEweOi
        dZ4v10exCOi73H5g4vktTJk=
X-Google-Smtp-Source: AH8x227RZddmqh2Du5obLm7DG0kGdZ6jSEUbFK3xrH5842EQ8Y6Z1F4g8vKHRanGrgSPbzEfaIXMeg==
X-Received: by 2002:a17:902:2c83:: with SMTP id n3-v6mr558877plb.227.1518649078002;
        Wed, 14 Feb 2018 14:57:58 -0800 (PST)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id i194sm39186599pfe.145.2018.02.14.14.57.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Feb 2018 14:57:57 -0800 (PST)
Date:   Wed, 14 Feb 2018 14:57:54 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>, Petr Baudis <pasky@ucw.cz>,
        Benoit Bourbie <bbourbie@slb.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jari Aalto <jari.aalto@cante.net>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
        Marcus Griep <marcus@griep.us>
Subject: Re: [PATCH 3/8] perl: generalize the Git::LoadCPAN facility
Message-ID: <20180214225754.GC136185@aiede.svl.corp.google.com>
References: <20180214222146.10655-1-avarab@gmail.com>
 <20180214222146.10655-4-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180214222146.10655-4-avarab@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason wrote:

> Change the two wrappers to load from CPAN (local OS) or our own copy
> to do so via the same codepath.

nit: I think with s/to load/that load/ this will be easier to read.

> I added the Error.pm wrapper in 20d2a30f8f ("Makefile: replace
> perl/Makefile.PL with simple make rules", 2017-12-10), and shortly
> afterwards Matthieu Moy added a wrapper for Mail::Address in
> bd869f67b9 ("send-email: add and use a local copy of Mail::Address",
> 2018-01-05).
>
> His was simpler since Mail::Address doesn't have an "import" method,
> but didn't do the same sanity checking, e.g. a missing FromCPAN
> directory (which OS packages are likely not to have) wouldn't be
> explicitly warned about.

I'm having trouble parsing this.  Mail::Address didn't do the same
sanity checking or his didn't?

The comma before e.g. should be a period or semicolon, since it's
starting a new independent clause.

> Now both use a modification of the previously Error.pm-specific
> codepath, which has been amended to take the module to load as
> parameter, as well as whether or not that module has an import method.

Does "now" mean before this patch or after this patch?  Usually
commit messages describe the status quo without the patch in the
present tense and the change the patch will make in the imperative.
So this could say:

	Update both to use a common implementation based on the previous
	Error.pm loader.

[...]
> +++ b/perl/Git/LoadCPAN.pm
> @@ -0,0 +1,74 @@
[...]
> +The Perl code in Git depends on some modules from the CPAN, but we
> +don't want to make those a hard requirement for anyone building from
> +source.

not about this patch: have we considered making it a hard requirement?
Both Mail::Address and Error.pm are pretty widely available, and I
wonder if we could make the instructions in the INSTALL file say that
they are required dependencies to simplify things.

I admit part of my bias here is coming from the distro world, where we
have to do extra work to get rid of the FromCPAN embedded copies and
would be happier not to have to.

[...]
> +Usually OS's will not ship with Git's Git::FromCPAN tree at all,
> +preferring to use their own packaging of CPAN modules instead.

nit: I think the plural of OS is OSes, or something like
"distributors" or "operating systems".

[...]
> +    eval {
> +	require $package_pm;
> +	1;
> +    } or do {

also not about this patch: this mixed tabs/spacing formatting feels a
bit unusual.  I don't know if it's idiomatic for perl, and if it is
then no complaints; it just stood out a little.  Can
Documentation/CodingGuidelines say something about the preferred
indentation in Perl to avoid having to think about such questions?

> --- a/perl/Git/LoadCPAN/Error.pm
> +++ b/perl/Git/LoadCPAN/Error.pm
> @@ -2,45 +2,9 @@ package Git::LoadCPAN::Error;
>  use 5.008;
>  use strict;
>  use warnings;
> +use Git::LoadCPAN (
> +    module => 'Error',
> +    import => 1,
> +);

Nice!

Thanks and hope that helps,
Jonathan
