Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558D01C32
	for <git@vger.kernel.org>; Fri, 23 May 2025 00:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747960486; cv=none; b=JnS/9NTFkeJLMz3tofSShiC7bRjuHMif5FCZDL6rYiWfBclzebvu1YcwcxGrESAqx+JuFFyisiPkF40EUdq+uZ5KLHitnF9kk6XdUuivHwp9oT7BPAtnh8FsCsm5Vc0lUvsSyk0Cldsl1mjT5e0JNOwBTrdGl7NkXp3oQN0Vtmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747960486; c=relaxed/simple;
	bh=MXxJspYFpZpGxVsKhinVoOt1VAC6hUKMfZjtek8Xlj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eifeTfQpdHgDspmesEjsTRIdtUpToeZ2nq4FsSmc/VoUo/JVVvpD1JGrr2/QoDg5NDCvqrL9ui4cUmT8ICSTqb5GWYSVZ4uWtMSJEqQ1IGqLQPRgHQ0UioEz0dic1bHXho01hqwmNuW6cfzpyi827z/sfjKbqS/nmFg6/yk1yYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=j0Y5LF3w; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="j0Y5LF3w"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-40331f302f1so5381202b6e.2
        for <git@vger.kernel.org>; Thu, 22 May 2025 17:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1747960484; x=1748565284; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4bivG9iMpW7lpwkHCN5joDLCRzjvGr+QxpKSI87I70Y=;
        b=j0Y5LF3wqs/936o4SZRiZBZngQGZdHMcSNLrxFlENPnOb+eBk9X3wC2O4FM3H2HYI+
         ORZO/IMa8oky5/MAWFq+hN8qsKchJflhzYFTkDauZMsuXImMHQ+lYo3f2SY6eopNjDqj
         ANjlt6cyPtu1anspeX1KWJ5QRvisZ2cURt/9mbxGgWLzoOamN4soPGeGhVWQaDGyXYA7
         awyNI6UHKh5XQC0KAur1wnftuHWhQlAmLFh67DItoqZAcPvxvV51IEroRs9dPQ3V0fH+
         bsjn9krStc0oEAcZu8FzwsrYyT/PS6whB7AYMnKFuCcbJZNHhmYzmpBkaaUKvNI4BbYM
         Oxzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747960484; x=1748565284;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4bivG9iMpW7lpwkHCN5joDLCRzjvGr+QxpKSI87I70Y=;
        b=opLjjcRK4nfvOl4SfP4IiyD6k+YkgIdf4C1D7+xL5uGv82DjHS43gCL+V5j1EKRcFn
         KwW2KqhkU0ufLbEcRxwEtWNmUtOycOpWRZqSMDsLMaCGXJ7wnKiYFggZGizrk56LjCT0
         vzF9+y67nCE8uEGI7qZQ6+Wh3E0vyoGfXs5vxc4FissLXtq7lytp4j1y1KWMH7YGe7Oi
         9SJPkOg0hHO7VXx9DOTaCw8lF40h9D2RJAVLq5o3osrYFOlssKI++xTz1TSgl9VaK53Z
         XjIWq/1lAWAPqDJf9hW/ToTU34+m5Ci7yWYFoMb40H0xnJfKi2+gmCNncT8EYvVOWwoO
         IQhQ==
X-Gm-Message-State: AOJu0YwerCQC3gUYOvKQIflmNCwmyW+8FdrflR81x0UtFqO6qX3Yt5WC
	moAc7S05SAYDQGl+zFO1fgtNLAedSTL5h7Qj6d8jFB/bpUzXdw6ZYVhC+tign4kMKcPSr1zu+Jd
	B/9rR
X-Gm-Gg: ASbGncsQ98oRwDU+6z7cP1e1Egq3IonIElwVluKm2FPVeQAnFSVpyOqIqrPAcUY2b6K
	b5m1N4c9FqScQQw43xLF8idRsVHY+EohogULom0ZUMLMvyh8+y3e0bXu2F6Cgp0+U/BEmZSCNrK
	MPBA58hA5za/LYLLXvehz6nJ2VHHCQkdNVKiOzZ0/GCgoI/uEPInUFWFG0yUcwxTSAgjdXuJkax
	8bu2nyFqEIM298YBXe6udfufgxgYHx39vIRuaDbT4FmpYyRCBOmgmw8JeEC0NATwkH1lieSTK5K
	o2TwhWVwW0zpOcGdEue/+gUUZMbHKZD2wrqmgBdO3L3Kt1Uc/Kx75MiRLGKCgz2AEwciG23zEMV
	F3KNWuHBX5a62TH2VTBCEYOg=
X-Google-Smtp-Source: AGHT+IGTTmUppBxpTmCQbfnk/8H3AhQ4zL6CTRC9RLOGaFbn9i0qErcArFfnT3ap5U6dDFje5/qLMA==
X-Received: by 2002:ac8:5c95:0:b0:494:a436:e610 with SMTP id d75a77b69052e-494ae357b94mr573380111cf.13.1747960473491;
        Thu, 22 May 2025 17:34:33 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-494ae445b99sm108679021cf.48.2025.05.22.17.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 17:34:33 -0700 (PDT)
Date: Thu, 22 May 2025 20:34:32 -0400
From: Taylor Blau <me@ttaylorr.com>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 1/4] midx repack: avoid integer overflow on 32 bit systems
Message-ID: <aC/CmFzz397p7hFz@nand.local>
References: <cover.1747753388.git.phillip.wood@dunelm.org.uk>
 <cbc5e69b908cef3800569abe79cb9c107f72bfec.1747753388.git.phillip.wood@dunelm.org.uk>
 <aCzBvvZDS2OFJ30h@nand.local>
 <a87e6f8f-e6b3-4d91-8b0a-312962819eb4@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a87e6f8f-e6b3-4d91-8b0a-312962819eb4@gmail.com>

On Wed, May 21, 2025 at 04:19:59PM +0100, Phillip Wood wrote:
> > >   		expected_size /= p->num_objects;
> > >
> > >   		if (expected_size >= batch_size)
> > >   			continue;
> > >
> > > -		total_size += expected_size;
> > > +		if (unsigned_add_overflows (total_size, (size_t)expected_size))
> > > +			total_size = SIZE_MAX;
> > > +		else
> > > +			total_size += expected_size;
> > > +
> >
> > But this part I am not totally following. Here we have 'total_size'
> > declared as a size_t, and 'expected_size' as a uint64_t, and (on 32-bit
> > systems) down-cast to a 32-bit unsigned value.
> >
> > So if 'expected_size' is larger than SIZE_MAX, we should set
> > 'total_size' to SIZE_MAX. But that may not happen, say if
> > 'expected_size' is (2^32-1<<32). Should total_size also be declared as a
> > uint64_t here?
>
> By this point we know that expected_size < SIZE_MAX due to the test in the
> context lines above this change. batch_size is declared as size_t and to get
> here expected_size < batch_size. I'll add a sentence to the commit message
> to make that clearer.

Ahh... makes sense. I don't think a comment is necessary, this should
have been obvious. The check you're referring to gives us the fact that

    expected_size < batch_size <= SIZE_MAX

So we're OK here; sorry for missing that!

Thanks,
Taylor
