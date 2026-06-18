Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858ED318EE4
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 05:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781761250; cv=none; b=jDButDvyVEfR632DO87/5qgm7cSbtNtz0TmULhBFH+zCm5ojd//uqguE8IfRV5CAk0cG1SFDlr50YvTAdTYu9eSwPHFuduysrwO7nEXKhiJOLtHy7GotrSNW1bEhMnCPTTUx7lJqzuid3AtCSNqj4VWuqBu3d/qnhQgsKD5xYY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781761250; c=relaxed/simple;
	bh=GdqOFaa3CHYu5M0ioqk4or51oARuxGV7ORnBOc/R5xE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J8R34a5SkxRal5KZt4j+cshJK/TMy/+BrGKeD4T979zsrjKiCKj7Pc4o8DHeouxSWsBtCs8/Hi8qmbzsYjS4KFxBpKKFKG7cRLFqg9iIta0vbVw2DBF5eyk+keMt/aaoku4vtxZ+5a0ldVUUewq7qIWtf1M0tgE+GLgXY1Zih0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XJa1UAGY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Vwxvd96d; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XJa1UAGY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vwxvd96d"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 8BD641D000D3;
	Thu, 18 Jun 2026 01:40:47 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 18 Jun 2026 01:40:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1781761247; x=1781847647; bh=5/7veNgwfv
	zxL0RisGem6oUqwNs3SaWJ//C63eotGog=; b=XJa1UAGYBG0oT5WNNX9n6fi9nl
	hK33fapv0LGxZ/Pa/jaLdcgjUe8m70E+WjUCSWC8m63VvI69324xgtvxuE3FEPnu
	SpitbPe/MKcQ5SdUlinLhf5MKFjLJ0Xcy2QoBus5VCgURGIyeJIfxGlulozyfNtS
	2vwQJDShcOtu5LPwnO7y6c+YeuXz54mMOmMkxHthmVglV4XkdINgmdMyhm8s9icO
	j0AP5k/jnJsD8+FitHbPWVNlM3sQ3zAqqoh/mztLIxL/HBt/YHjGV7pRLo9K20ak
	lKLL8csSP+IKGTwoSURkkxreatcf/MEQJH3PQjBoEbCMBYiGM5nmR4zJdhmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781761247; x=1781847647; bh=5/7veNgwfvzxL0RisGem6oUqwNs3SaWJ//C
	63eotGog=; b=Vwxvd96d0N7RGin1xNAtET/d3lPs1eS2whYVYxzbKnAlVIj3an9
	WSC+cEWi1Q+8uyD1RtOAycC+gVa0H7j+u21qfabWorK1D5PZ5zr4Csk+iGGjx96B
	0d2HcYu5Gb9VLPRmlSkxUEExzf1cWZ8VNK1Ihjl9jlt+ZupyH//bR2HpuoNnpp2s
	zKhxrfre5Rkg5jEQC9lIxT1Pe/av4UDccWhmJLJeCV4Z/1SLjduTP05dVXAQyTzl
	1B51rJTsUWDmaWUS/vmyzVAypHFOeSkZFTQCCPIrRUXFr8HRVOIfJv67c96zWRdH
	7b7q+4gqqilLqPHNTMtV12f8nV04fHgBq4g==
X-ME-Sender: <xms:34Qzaom4f1j9BAOUt5QZGpmTaHIC6CdHJD5UWLW1Fk_M6HcUr_rxnw>
    <xme:34Qzat1HDDOjSXLs8wADUHXa2X6L0YavhkzOXgB6vCousV3boasink-dCF1uC14J4
    fYdePvkxf9yc-lQEiBrqgeUHYkhB0E5hLFTWBNvzCLO_UnFYjY8oQ>
X-ME-Received: <xmr:34QzakQd0N70mVGSPEZfvwsBUepBuSWdUyjyGLMcddgVQ3tpP4i3NPJYuSmxjXeFdZe7sIQV6iFal9nxFpqvEr9k9_qoZ2uu3997DEmSww>
X-ME-Proxy-Cause: dmFkZTGLewIcNaLosTbyz/9FAHyn83AOcUS4rgKI4DS2xiZpijptt9a6WmWLSLYmFlblwf
    /kKrtmb375Tw1PDcSCLMW6ERCGQ2XJoQlfb4COLUriM8bWhK+8AYkebm0K7knu9nmSUwtv
    ycpb/wJAqNOMv9mg84Sdlg+8b/51aJEa7cBHYJleV+XPwwo21X3nYQiYGK6oa/0Obp1ZvJ
    LEoOQ6fnwaEVeJbmvYKIhZt2FJ3IrF7rbQdwptWUMEkl7YRnMHStp/cW0JuGqlbj9fRqMd
    5B903TCIFEx9PwjkVGSGBCy8r85A3fPy9Aq9t/Bz7EWGyFfa84FffOqj++iafzzC56NPol
    tDPRfmMhZ8qcelCJ0k55MrBmJ7aXkgpmRlOgf0tUJ9cR0Y9V4b0BQ7YKFHrw+W8IsMUXcW
    bm9Lf88dFuwjnjdrTo5UadkqJVTKro9QpqkEryj9uanvgSkR9pkVyXXzBku4+XEOg5U3WA
    zdG7sYKwLXJ1/tEy2eLktF/bsIueyTdas/RjDRnipJFDUsYwF02rFNM9RDWEtKy8W7xnh9
    Vs2of+z0fZF3Mxd2CG4d3/oXFmM+FzbP4cKClFcvMzo/Yzo6OvZhMgOtJo2Hgqq3rE6lkT
    B9G0oQh1y6kWhCwm0LveaG15IRmIU8eqKAQMOMCnezEA8iY36ibW8D6JrzJw
X-ME-Proxy: <xmx:34QzavvWcfOE-JlsfqkUF2_1QDi4Nmp2TXRsIyEyZNgrjGmag6zvqg>
    <xmx:34QzapaIyLEj6GjUxaPv1BHo-KOZXqCa3nUSoR95o18l08lu9R6GAQ>
    <xmx:34QzakvX-HibLwImY7TZ8LIs1j6806ByChsfWGNDBRsLTZNTwX3txw>
    <xmx:34QzarG_GXIAJ1_W8DtNg0ZLB4z4TmnVz63t2RefIcpvCA0H6_nMbg>
    <xmx:34QzahVUyZtu7NfOEsoX7r2gp3TxcZuGxFmo5qEouIY9vvqBlp5ouSLW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jun 2026 01:40:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d57890f9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Jun 2026 05:40:44 +0000 (UTC)
Date: Thu, 18 Jun 2026 07:40:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] gitlab-ci: migrate Windows builds away from Chocolatey
Message-ID: <ajOE2XMBzgrXxbH8@pks.im>
References: <20260615-b4-pks-gitlab-ci-drop-chocolatey-v1-1-51a6e7d5e388@pks.im>
 <ajL1677NQShTO6tD@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajL1677NQShTO6tD@denethor>

On Wed, Jun 17, 2026 at 03:03:39PM -0500, Justin Tobler wrote:
> On 26/06/15 02:21PM, Patrick Steinhardt wrote:
> > Introduce a new script that downloads and installs dependencies
> > directly. This has a couple of benefits:
> > 
> >   - We can drop our dependency on Chocolatey completely, thus improving
> >     reliability.
> > 
> >   - We can easily cache the installers.
> > 
> >   - We get direct control over the exact versions we install.
> 
> Naive question: Do we expect to have to update the pinned versions
> often?

Not really, no, as we're quite conservative when it comes to updating
minimum required versions of dependencies.

> >   - Installing dependencies is sped up from roundabout 3 minutes to 1
> >     minute.
> 
> Is fetching the dependencides directly just plain faster? Or is this due
> to the caching?

Downloading the dependencies doesn't seem to be the cause -- fetching
them without a cache takes only ~3-4 seconds in total, and it didn't
take much longer with Chocolatey. I think it's rather that Chocolatey
does a bunch of extra steps and installs extra components that we don't
need, and that saves us some time:

  - Installing Git is reduced from 70 seconds to 40 seconds.

  - Installing Meson and Ninja is reduced from 20 seconds to 4 seconds.

  - Installing Rust is reduced from 70 seconds to 23 seconds.

> > diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> > index e0b9a0d82b..87a5343a94 100644
> > --- a/.gitlab-ci.yml
> > +++ b/.gitlab-ci.yml
> > @@ -161,11 +161,16 @@ test:mingw64:
> >      TEST_OUTPUT_DIRECTORY: "C:/Git-Test"
> >    tags:
> >      - saas-windows-medium-amd64
> > +  cache:
> > +    key:
> > +      files:
> > +        - ci/install-dependencies.ps1
> > +    paths:
> > +      - .dependencies
> 
> Nice that we can cache the installers now.

Yeah. The intent behind this is less that we save download time (which
as mentioned above is miniscule), but more that it should give us more
reliability because we have less interactions with the internet.

> >    before_script:
> >      - *windows_before_script
> > -    - choco install -y git meson ninja rust-ms
> > -    - Import-Module $env:ChocolateyInstall\helpers\chocolateyProfile.psm1
> > -    - refreshenv
> > +    - ./ci/install-dependencies.ps1
> > +    - $env:Path = "C:\Meson;C:\Rust\bin;$env:Path"
> 
> I assume Git is already discoverable on the path?

Good question -- in fact it's not, but in Meson we know to use the
well-known path of "C:\Program Files\Git" automatically and that's why
we don't have to add it here. That certainly is a bit hacky, but I'm not
sure whether we need to change it.

Just let me know if you think so.

Thanks!

Patrick
