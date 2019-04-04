Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93EF520248
	for <e@80x24.org>; Thu,  4 Apr 2019 09:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730623AbfDDJuA (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 05:50:00 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55789 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbfDDJt4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 05:49:56 -0400
Received: by mail-wm1-f65.google.com with SMTP id o25so2252747wmf.5
        for <git@vger.kernel.org>; Thu, 04 Apr 2019 02:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=9Wj+pBa/Zkx/q5vmaCX6aqLEGPc9MK5fNhGep1vmgTA=;
        b=uEwdb2nMAzhnc9u2Vd+xEBwLDULgAoZPUmFltWwK1NylTQhVuIuBJRcdGraOWXjP7T
         pPMrhVwh8BXrF82FR/YvsV076eBtNXgsL+BuKPNwB+WU5Y1lOh7T47hgZ1BQbcsnONsD
         DASXwSDTIkoRmoWjtsF90N//WDx1OSHbkp2ie2pQlsTPAKwBoia6zcdPlVLDfoyIF+co
         2lnpn8qdwUl/wJZecXTmH+Yvk6SSPbp9KKi5RvW4qtOW9dYTl3tZ1dORiQSA+RmaxauF
         dfsUK38/nP7DtChJAC+ttS8Ux99HMu2AD+MgMjanYu1MWIIiJpZjFJUJnIE17gfhSS5w
         UaeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=9Wj+pBa/Zkx/q5vmaCX6aqLEGPc9MK5fNhGep1vmgTA=;
        b=iDWWEa4dasZ6IQyG70Zxr8o+vVvVUhAOAkpwJZduGIdJ2TWzpp7875N/yxDq8Yg+3H
         VgwYkGvZtGYAlwHT546w7NO/MxxUFMk8rt0Dq9iLNsvv/TJdw3B0KSTp8aThb7AwmRkB
         Q3EuE5QVvF2zj1u2YYY7F7wwhdW/v4Hre+2reUPOHSyaQrfKiOLEUv01TkV8GhsgLIeF
         v7L4ns9yRIAyd+EuJ8BIBZxeXwPIwZwTKSIjao3jGEI8lrgRXvPJwEHmvax/tna+wtMD
         7No60XgGk34ATbVUdjiDLOAHB6N6R1Af6gOlsiuHhXXRZPXh98HXSW4XY1Ceq9oXS57w
         i96A==
X-Gm-Message-State: APjAAAXsQOIqVYG1tRSzko1KU9EOJvE36S4Z/gKUseBtj1kAaJnXEibh
        ndAVWE3gB/cCBxIzURNzJKPzVthV3eo=
X-Google-Smtp-Source: APXvYqyoQcVI3wMFqeMXsD0v/DLFQezk5x0JympGlA5a4KRt18unfa4t/okK1fNKDFEM2zhX5y86fA==
X-Received: by 2002:a1c:804c:: with SMTP id b73mr3269291wmd.116.1554371394212;
        Thu, 04 Apr 2019 02:49:54 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id o4sm38639556wmo.20.2019.04.04.02.49.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 02:49:53 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     git@vger.kernel.org, Joe Perches <joe@perches.com>,
        Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: Re: [PATCH] send-email: don't cc *-by lines with '-' prefix
References: <eec56beab016182fb78fbd367fcfa97f2ca6a5ff.1552764410.git.baruch@tkos.co.il>
Date:   Thu, 04 Apr 2019 18:49:53 +0900
In-Reply-To: <eec56beab016182fb78fbd367fcfa97f2ca6a5ff.1552764410.git.baruch@tkos.co.il>
        (Baruch Siach's message of "Sat, 16 Mar 2019 21:26:50 +0200")
Message-ID: <xmqqy34qdrr2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Baruch Siach <baruch@tkos.co.il> writes:

> Since commit ef0cc1df90f6b ("send-email: also pick up cc addresses from
> -by trailers") in git version 2.20, git send-email adds to cc list
> addresses from all *-by lines. As a side effect a line with
> '-Signed-off-by' is now also added to cc. This makes send-email pick
> lines from patches that remove patch files from the git repo. This is
> common in the Buildroot project that often removes (and adds) patch
> files that have 'Signed-off-by' in their patch description part.
>
> Consider only *-by lines that start with [a-z] (case insensitive) to
> avoid unrelated addresses in cc.
>
> Cc: Joe Perches <joe@perches.com>
> Cc: Rasmus Villemoes <rv@rasmusvillemoes.dk>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  git-send-email.perl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 8eb63b5a2f8d..5656ba83d9b1 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1693,7 +1693,7 @@ sub process_file {
>  	# Now parse the message body
>  	while(<$fh>) {
>  		$message .=  $_;
> -		if (/^([a-z-]*-by|Cc): (.*)/i) {
> +		if (/^([a-z][a-z-]*-by|Cc): (.*)/i) {
>  			chomp;
>  			my ($what, $c) = ($1, $2);
>  			# strip garbage for the address we'll use:

OK, this fell through the cracks (and it did not help that a recent
ping message did not come as a response to it, but as a response to
another thread with an alternative implementation).  Will apply and
cook in 'next' to see what happens.

FYI, being in 'next' does not mean it will be in the next release.
Being in 'master' usually does, though.
