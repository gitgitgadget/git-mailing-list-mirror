Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EF0B1F404
	for <e@80x24.org>; Sat, 24 Feb 2018 22:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751482AbeBXW2r (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Feb 2018 17:28:47 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:36868 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751399AbeBXW2q (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Feb 2018 17:28:46 -0500
Received: by mail-wm0-f51.google.com with SMTP id m207so10727090wma.2
        for <git@vger.kernel.org>; Sat, 24 Feb 2018 14:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=0jvGNywFou6RGqrrmOfb1w2E5ARjO4bq6MoBHU1s3Xk=;
        b=h7E14q3SdTRWQrB0C+juLVEqNom5P43yZ4OS1MWJiNbXmpu52vuvda65LrcCIlcSi3
         yRtF9Ar/vzoEV/Yxs38kPNIbWTY9gic2cI9owxwd7pfB5nVqB3tSj8ehst/VM0Tiw4zx
         3QtrQpDFYHRLHCfZg7c46lh+LHv+bhiVDM9afw74IgiZ0BTrEsUg4S41RctYFGwW3yl0
         SdH1x5pA0jMFXGIKsW9lGixIS9FCJqzyZ5vIIrpGa62mJWLWxzXsD6jNeMY+WZYR5wyM
         b8fMmqyaZ/dc/nrBtSNYEAWW2KtnNErooM3fMqBPTnjE0GtnjS9vhAepP580EktvSpRH
         9BNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=0jvGNywFou6RGqrrmOfb1w2E5ARjO4bq6MoBHU1s3Xk=;
        b=OCXSQ+EGiQs9xAZ53qSUCbV6fO0035J1tnxoNaqO04Wwb01UUxpfbNHB1mTGoBUSGB
         Q0skOuZDR8QP6G32a5S8J6PjP/rrfYucqU+jGnQLTJfrHV+NGCMm/U44yot/4RPq051Z
         bnbUMhEMHNSC9iIsd8mqXLPCDlgB+Ly0Bt4QQ79Aw518M95SMdP/DFosawuq82NsfMja
         UFF55oUURNUNkCg8Itq5IV+hb1u7T4a+qkYFHZRRa+KXH3fAgCnhjhD5Dd27huvJoWnT
         LiW742Rt6/7xqifOVJC0Z6EB7cPHpuGiimOhpkWYGT1FltUH+RUaphQQ1kq9T//jukjh
         zwFA==
X-Gm-Message-State: APf1xPBCof/Qethonl9Zz9s/BThPeHiXfOX2CnIobTyE+zQ05yhCCWs8
        jd72PL7X2xF9Z1omWBZOGN0=
X-Google-Smtp-Source: AH8x226Glf+3+nA9HgQsCbZE0YsHjSCNiUQSRKf6DFmSTIohhC5UB0h0qLd81mutS7XIlWmraK+EWg==
X-Received: by 10.80.166.99 with SMTP id d90mr8587236edc.174.1519511325127;
        Sat, 24 Feb 2018 14:28:45 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id g2sm4958314eda.85.2018.02.24.14.28.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 24 Feb 2018 14:28:43 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "Bernhard M. Wiedemann" <bwiedemann@suse.de>
Cc:     git@vger.kernel.org, Ben Walton <bdwalton@gmail.com>,
        Matthias Urlichs <smurf@smurf.noris.de>,
        Ryuichi Kokubo <ryu1kkb@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Call timegm and timelocal with 4-digit year
References: <20180223172045.32090-1-bwiedemann@suse.de>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <20180223172045.32090-1-bwiedemann@suse.de>
Date:   Sat, 24 Feb 2018 23:28:42 +0100
Message-ID: <87tvu6dntx.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Feb 23 2018, Bernhard M. Wiedemann jotted:

> amazingly timegm(gmtime(0)) is only 0 before 2020
> because perl's timegm deviates from GNU timegm(3) in how it handles years.
>
> man Time::Local says
>
>  Whenever possible, use an absolute four digit year instead.
>
> with a detailed explanation about ambiguity of 2-digit years above that.
>
> Even though this ambiguity is error-prone with >50% of users getting it
> wrong, it has been like this for 20+ years, so we just use 4-digit years
> everywhere to be on the safe side.
>
> We add some extra logic to cvsimport because it allows 2-digit year
> input and interpreting an 18 as 1918 can be avoided easily and safely.
>
> Signed-off-by: Bernhard M. Wiedemann <bwiedemann@suse.de>
> ---
>  contrib/examples/git-svnimport.perl | 2 +-
>  git-cvsimport.perl                  | 4 +++-
>  perl/Git.pm                         | 4 +++-
>  perl/Git/SVN.pm                     | 2 +-
>  4 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/contrib/examples/git-svnimport.perl b/contrib/examples/git-svnimport.perl
> index c414f0d9c..75a43e23b 100755
> --- a/contrib/examples/git-svnimport.perl
> +++ b/contrib/examples/git-svnimport.perl
> @@ -238,7 +238,7 @@ sub pdate($) {
>  	my($d) = @_;
>  	$d =~ m#(\d\d\d\d)-(\d\d)-(\d\d)T(\d\d):(\d\d):(\d\d)#
>  		or die "Unparseable date: $d\n";
> -	my $y=$1; $y-=1900 if $y>1900;
> +	my $y=$1; $y+=1900 if $y<1000;
>  	return timegm($6||0,$5,$4,$3,$2-1,$y);

I wonder if this whole thing was just cargo-culted to begin with. We
need to match (\d\d\d\d) here, so did SVN's format ever have years like
"0098" (just "98" wouldn't match), so I suspect the whole munging could
be dropped, but this change seems harmless. Just something that jumped
out at me reviewing this.

> diff --git a/git-cvsimport.perl b/git-cvsimport.perl
> index 2d8df8317..b31613cb8 100755
> --- a/git-cvsimport.perl
> +++ b/git-cvsimport.perl
> @@ -601,7 +601,9 @@ sub pdate($) {
>  	my ($d) = @_;
>  	m#(\d{2,4})/(\d\d)/(\d\d)\s(\d\d):(\d\d)(?::(\d\d))?#
>  		or die "Unparseable date: $d\n";
> -	my $y=$1; $y-=1900 if $y>1900;
> +	my $y=$1;
> +	$y+=100 if $y<70;
> +	$y+=1900 if $y<1000;
>  	return timegm($6||0,$5,$4,$3,$2-1,$y);
>  }

My Time::Local 1.2300 on perl 5.024001 currently interprets "69" here as
1969, but after this it'll be 2069.

Now I doubt anyone's going to be importing CVS history of projects a
little over 20 years before CVS was created in 1990 (although I suppose
old imports...), but just wanted to note it since it seems odd for code
that's auto-interpreting double digit years for the purposes of
importing existing data to end up in an edge case where it returns dates
more than 50 years in the future.

> diff --git a/perl/Git.pm b/perl/Git.pm
> index ffa09ace9..df62518c7 100644
> --- a/perl/Git.pm
> +++ b/perl/Git.pm
> @@ -534,7 +534,9 @@ If TIME is not supplied, the current local time is used.
>  sub get_tz_offset {
>  	# some systems don't handle or mishandle %z, so be creative.
>  	my $t = shift || time;
> -	my $gm = timegm(localtime($t));
> +	my @t = localtime($t);
> +	$t[5] += 1900;
> +	my $gm = timegm(@t);
>

Nice. Just using the 4-digit date is always more correct and won't ever
be buggy.

>  	my $sign = qw( + + - )[ $gm <=> $t ];
>  	return sprintf("%s%02d%02d", $sign, (gmtime(abs($t - $gm)))[2,1]);
>  }
> diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
> index bc4eed3d7..991a5885e 100644
> --- a/perl/Git/SVN.pm
> +++ b/perl/Git/SVN.pm
> @@ -1405,7 +1405,7 @@ sub parse_svn_date {
>  		$ENV{TZ} = 'UTC';
>
>  		my $epoch_in_UTC =
> -		    Time::Local::timelocal($S, $M, $H, $d, $m - 1, $Y - 1900);
> +		    Time::Local::timelocal($S, $M, $H, $d, $m - 1, $Y);

Ditto. Nicely caught.

>
>  		# Determine our local timezone (including DST) at the
>  		# time of $epoch_in_UTC.  $Git::SVN::Log::TZ stored the

Anyway, this all looks good to me as-is. That CVS edge case is obscure
and not worth focusing on, and the SVN one could be fixed up in another
commit if anyone cared.

I just spent a bit more time than I should have wondering what this
timegm() edge case was about and whether it might impact other
(unrelated to git) code I had.
