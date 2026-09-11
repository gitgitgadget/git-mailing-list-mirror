Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B1B42848B
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 06:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789109469; cv=none; b=C+C0DY6bsNy3rtrCxzKf7A2FtbdtTPHiwW7AnFkNq1KxNplCVQSGn08wPBH1eUQJks4WMeMqrLngkpqeUBqxHWVS5RWSUbsBVYj3oaDNiK3OzjRyLdFwnUVP5RNya+/Uo4XqUs1wGrtCWSUvM6lxyqNlyQNaQxWoMSYZe3XewxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789109469; c=relaxed/simple;
	bh=z4Cp2mFYlRK1xA1mk7p5IIChIjLChIiC6LNOR6SYyxs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kBpv385cq2snBKDvwnIxvHZl3BMxq7XamIkS7cbnb8BHO+MVIIsW538egsECsZirAJ7iwn9PNiFSUlWuWk15+tiNRmtlsjFFXAg/JEqxFRdnrbu0k+qPl9FCUEhCdbnttuGj7DB4WEuR3BPWaEeofAmpzvPUHzP6ryOcTWKc7Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=K+o1nrdb; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="K+o1nrdb"
Received: from smtp-03.utu.fi (smtp-03.utu.fi [130.232.207.30])
	by fortymile.utu.fi  with ESMTPS id 68B6oiPk016639-68B6oiPm016639
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 11 Sep 2026 09:50:44 +0300
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-03.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1x4v5v-003ltL-U2;
	Fri, 11 Sep 2026 09:50:43 +0300
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 11 Sep
 2026 09:50:43 +0300
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id dba4725e;
	Fri, 11 Sep 2026 06:50:43 +0000 (UTC)
Date: Fri, 11 Sep 2026 09:50:43 +0300
From: Tuomas Ahola <taahol@utu.fi>
To: Junio C Hamano <gitster@pobox.com>
CC: <git@vger.kernel.org>
Subject: jk/ci-use-system-asciidoctor
Message-ID: <20260911065043.0SiOV%taahol@utu.fi>
In-Reply-To: <xmqqa4ppf1l5.fsf@gitster.g>
References: <xmqqa4ppf1l5.fsf@gitster.g>
User-Agent: s-nail v14.9.22
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: ex19-15.utu.fi (130.232.247.55) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhZX0gPARwbHA0aKBgHCgcQRgsH
 BUhYSFpIWVxIWVtYRlpbWkZaWF9GW1hIUEhYSFhIWkhYSFhIWEhZUUgPARwoHg8NGkYDDRoGDQRGBxoPSFhIWV9IDwEcGxwNGigYBwoHEEYLBwVIWA==
X-FEAS-Client-IP: 130.232.207.30
X-FE-Last-Public-Client-IP: 130.232.207.30
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=date:from:to:cc:subject:message-id:references:mime-version:content-type;
 bh=JsghzFDyqpVOTtbhSL7cS7sx/+tH7CaZvphIAOVaOXM=;
 b=K+o1nrdbEoOmvvwTmOctaUFRExVJY/oORAgH5a3IGqfJJiUcp4odvJB5QzwZKmXhZzoK1c40uYKD
	vmMkNcy1Kac+7+KHGaQJPQOjEiFgrgCFLyXLpeiNPHLmUql8rwSAkpd5j8gDjQFWLqhghYXzK8pC
	4D7Ia/Da8Fzqfnmhs9kpcH4kg1Ek3RUfV1fBXc7FdGYa4cyaZqvi5KYl3MHaIqe1tQ339tYYex/B
	3cFSCmlBpLTw+2lbEg+Z50ihkPCDDsO/k44NW/5PwUFYjMBNH1VwYUzMk9JqWoJ+U3R0Cz7Xxx4W
	+Q3b3UQec0QjpOVBm+vRvvBzUcE6UM/RHCt0oQ==

Junio C Hamano <gitster@pobox.com> wrote:

> * ps/ci-depends-on-ruby (2026-09-01) 1 commit
>   (merged to 'next' on 2026-09-08 at d0859510f8)
>  + ci: fix missing Ruby dependency in "documentation" job
> 

This seems to be duplicated...

> * jk/ci-use-system-asciidoctor (2026-09-02) 2 commits
>   (merged to 'next' on 2026-09-08 at e7621b4bad)
>  + ci: drop ALREADY_HAVE_ASCIIDOCTOR variable
>  + ci: fix missing Ruby dependency in "documentation" job
> 

...here---perhaps we would like to fix that when those topics graduate.

$ git describe --contains --all 7918bd7d08 691dc53e2a
remotes/origin/next~6^2~1
remotes/origin/next~7^2
$ git range-diff 7918bd7d08...691dc53e2a
1:  7918bd7d08 ! 1:  691dc53e2a ci: fix missing Ruby dependency in "documentation" job
    @@ Commit message
           ./ci/install-dependencies.sh: 23: gem: not found
     
         The root cause of this is that we never explicitly install Ruby, and
    -    consequently gem(1) isn't explicitly pulled inus, either. This used to
    +    consequently gem(1) isn't explicitly pulled in, either. This used to
         work alright because we transitively pulled in Ruby via asciidoc. But
         due to an update it seems that we stopped pulling in the transitive
         dependency, and consequently we don't have gem(1) available anymore.


It's always good not to immortalize typos in 'master' if we can choose.
