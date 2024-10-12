Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64A8E55B
	for <git@vger.kernel.org>; Sat, 12 Oct 2024 15:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728748258; cv=none; b=kVt/3RxZcINiZoVHstvwwZWb0v9QlIRboNomqjxXtO1fsbWgENKZXhYIRU3zoNew60edDJOHVACxG7IlYL0aSkmvdJ+FE1EcCRp7K1wK7IsNb7IT22fzev49oOF8h31p06l3w8mvYJNi2n97C25ICij9zDYNSrZFLolOjZ8TTGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728748258; c=relaxed/simple;
	bh=qPbjKaMX2wOxnr8PdghYeqG6DGRmY9jb/DYliOJJwE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O67hRXLZR32DtKoltnPsnmZgUm7w28kOfk09zkka+IM5hwQMZC8gmgE/747UnBrCUro0RQOmhhtc8LE92UxfQ0sJHeMTitAA/rS6FnRJEYjKG82Mg1XRd4hjaOb7cCu+CoCLHQ9HfqyDgYkUTjre56f/x8kf1sHwnyfPrOgYoJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=pngALmm/; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="pngALmm/"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6e2e508bd28so23897637b3.2
        for <git@vger.kernel.org>; Sat, 12 Oct 2024 08:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1728748255; x=1729353055; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IZZOdcTusmgYVmxOzq2voWR0+ELehnJfUnBbbUZmhzI=;
        b=pngALmm/2tn2JOJWYQXhXokKMeP+U0GQAqq4mTi/ed/ZafGYH+tRfkH9dGMClJnHOS
         tsp0rJeWsz3BiaPS8VyIPu38wXB5bWP6QJ0QgRap+2CZej6KXJLhYp18yFYenTlc/Ad4
         Hzhosq50yY78Qfo0faJIs/bwPrpB+xfOys79oSBCGuze5i1XiO7Y1r6Lsrcj9UKnoUAc
         f3vxB6ZZwJEHCPrr/+T8okrIUnloB+Xs2j4afauxzi7dBpHDe2taoHgCQVFUZT2ikcLJ
         heIOPQmwx5G/wzdgfXm4V9qdb+6tP3ADh9x21zEZWWRqOXY4FufXusNI+6J4NW2ryfA9
         kEvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728748255; x=1729353055;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IZZOdcTusmgYVmxOzq2voWR0+ELehnJfUnBbbUZmhzI=;
        b=JdZs6MWdn0lYXps2owmI22ERxer7TjSR/e6C+v0NjUb9QjMQKgHozceu8Yoi1nkTjr
         yCp2K9gp8spx9mC27ZtbOpZRR/h50oOChl9/B0wSDmL/K6jsDCyxU/tSM6C5iYZGIRhG
         Rl1ER/L1Yn91CvT4zUBZIBknNzbXf24aZ1JCpwEpVpQef7BdwWV77LZs4SOigR0npBEB
         3BOJso26UbvzWFfD544hNwkoKI7XlTaJEQM8XButKCeMnwH7ewJoHV3WbnhP+OScenA5
         TMS4xBpNYXtYGuKncSeG1MWRvk4wjg5pnsBgIrff2FtQzWjVBrqoP743tVl5vORO2G+2
         ffcQ==
X-Gm-Message-State: AOJu0YwOzULUMp1tkhSKGOblH+tK5pFtR4meVo4VDKpOhMA7okWAB74q
	mots80UcE0O7c8Tc0krT4yTm8qTueB6lZFN4JCHsQ2eF86J3ShrPpq/Lzufo4H0=
X-Google-Smtp-Source: AGHT+IGifsn9TcLtn358Uq75K7iHP2mAAukxfYHjgttqLGv0lALS02dEPjuvyAeU3YNwkpqdqNOkyg==
X-Received: by 2002:a05:690c:4e81:b0:6dd:76ce:d6c9 with SMTP id 00721157ae682-6e347c8b639mr33054067b3.42.1728748255603;
        Sat, 12 Oct 2024 08:50:55 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e332bab60asm9739887b3.64.2024.10.12.08.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 08:50:55 -0700 (PDT)
Date: Sat, 12 Oct 2024 11:50:53 -0400
From: Taylor Blau <me@ttaylorr.com>
To: =?utf-8?Q?imme=C3=ABmosol?= via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,
	=?utf-8?Q?imme=C3=ABmosol?= <will+developer@willfris.nl>
Subject: Re: [PATCH] diff-highlight: link to diff-highlight in DESTDIR
 #Makefile #diff-highlight
Message-ID: <Zwqa3YFt9+dfKmHM@nand.local>
References: <pull.938.git.git.1728745399993.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <pull.938.git.git.1728745399993.gitgitgadget@gmail.com>

On Sat, Oct 12, 2024 at 03:03:19PM +0000, immeëmosol via GitGitGadget wrote:
> diff --git a/contrib/diff-highlight/Makefile b/contrib/diff-highlight/Makefile
> index f2be7cc9243..10c588a7929 100644
> --- a/contrib/diff-highlight/Makefile
> +++ b/contrib/diff-highlight/Makefile
> @@ -9,6 +9,7 @@ diff-highlight: shebang.perl DiffHighlight.pm diff-highlight.perl
>  	cat $^ >$@+
>  	chmod +x $@+
>  	mv $@+ $@
> +	ln --symbolic --target-directory=$(DESTDIR) $(abspath $@)

Hmm. I am not opposed to having diff-highlight's Makefile be responsible
for installing a symbolic link to the generated script, but I do not
think that this Makefile recipe is the right place to do it.

This recipe is about building the executable, not installing it. If you
want to introduce a separate .PHONY recipe for installing the script, I
think that would be a better place to introduce this change.

Thanks,
Taylor
