Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B4A21ADA4
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 13:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758808738; cv=none; b=FCNUs/8aA/sXCprxseqSVFm+fqfz2g/WdCXbA88uZX2mbf4pENbPveWQWlwJWzcv1xjFOuQ1T48qM2wPkGoCrf1+i8iCVHtmfC661I24DHvEb6+jmMusQeycwmEI7jQWSJ5g9+y4Ro1VdtBFMsoX1mu1FkFjsjrL1T0g0Mg+USs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758808738; c=relaxed/simple;
	bh=s5a6lFFrPe3t721PbuVjGXsF/bMV05agLxFATa2AyqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XFjnhAZkUSl69hPPJPv2hyHsBmosZN60h/VtzZgWtPfKdYZ2D28cv6FX1LFqvxfSaiw/QJjM3c9qFo1Lv0EhTR9XSDBU1gvQUvEAGEZmMGH+O0SHSiVojfJKooYyu66sosG3BuP0FdCoRTrWmsGp1gTb95xHvpkPmxpGRCugAec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jZgF2qay; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eLdxCaxh; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jZgF2qay";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eLdxCaxh"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B759A140008A;
	Thu, 25 Sep 2025 09:58:53 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 25 Sep 2025 09:58:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758808733; x=1758895133; bh=NOUMtk3+Hx
	3TBjjR4DVKIOwpGie1lYDabVEfYZ6NDrY=; b=jZgF2qayheJhmA4emD/GgIO81Z
	HKLHR6oClXw2ffdObfaS8hBdbSt4T+8PWM9OuSYPt8mqu0CE5p6h7L+XaHe3m6gM
	xJj0XO9lj9nResbq7y3xRcck0liKUwMLlNkKiCPzwT+5l7rVveSAGirZVnBv2AFR
	1zHBRMIkrmohYt5cqB0fZhY+q4UX6CpEWgAg+6dFj2rM2Z/XxfcOdJ62FzfW0+VM
	JEWKOrKK1piuMhOhESQPjNcBdnpUIPOKQGYVsC27rL2bD06sZMdmKF+Q7yoq9AS3
	vs9YpDBYRMlS0uwh41zwztY4lYKRvwhxB2fu22TY/zR2bOcIOT1LREmpW+TQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758808733; x=1758895133; bh=NOUMtk3+Hx3TBjjR4DVKIOwpGie1lYDabVE
	fYZ6NDrY=; b=eLdxCaxhApJbroXQQWclAqbN9MMJvB4RsboqcZHerpgSOD+AOv6
	sTR9jN0xcZC9XVHBXI5qmXbIfwfeqyv8BNY4ZuPYbWurIGxQNKnrEyLFycwHwVCe
	Iz0eSTDFFIzZNipEfbV1luCdNwssXMBMaux/SicyRH6WZCWMjIhXKkhYUHplkmUt
	Rz6gPLSZoaozxWd3QHJ67L8cC/1ftCsGDgBw/pHg1mIrHrh2YZc0p/+Cy5oCNH8B
	2RGrQjOVpwaqml9CzgFML+AJWvMZWOOCdznqDceZ4+ub5TA+Ygmd9L3Bgxv/G29V
	oDrK4g0GB+COgXTmxdRBOXkEytVx2oNJk3Q==
X-ME-Sender: <xms:nUrVaLsW_zS8vOuYxY5ucJUJGpOd_RvGYnv-odV2pTgD3-qfkLdggQ>
    <xme:nUrVaD6nPo-AfEPk-hcc_167j3YIjuvMvzHaY-fzzVjuUiRZo01Nb-XqFVln6rHTa
    3PH7yGl2NULFZrY3jxXbPQwV5K8Nca_lOS1bXWduz1QOjWL8nXAcQ>
X-ME-Received: <xmr:nUrVaMLxlG2U5PwqgAJIC_XMvVeqwxNw8umEtmQXLbD-bCLlz3wC1M8LKmDAOk_oYjsL8yIQd86-a3Gr4A8ZzX3g2tfi_aBzNHMYsVaxl-8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiieeijecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhlthhosg
    hlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrgh
X-ME-Proxy: <xmx:nUrVaD6_QX3Aal7n3APeQyIimfB3wrMfGV_e14eOcPoKi6kjb54pGg>
    <xmx:nUrVaPycWeKMUmmh5LyOg4peFSmq_duqMomkiW3iiloykuvU3d2XJA>
    <xmx:nUrVaHbAEy4EHO73mS04fuRWfM_baUny_GlnEJtpYrh19s5kmniVLQ>
    <xmx:nUrVaBQA7osb27A-itMl7heu7hrWJoXgSu0X6DfbAbKHWvdnuzwIkg>
    <xmx:nUrVaGVDpsw2Pvd3ZxhxEqAAu0XAGNJe4ikBS6gH05N0Z9l18_m5wGTG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Sep 2025 09:58:52 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bbb236c3 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 25 Sep 2025 13:58:51 +0000 (UTC)
Date: Thu, 25 Sep 2025 15:58:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com
Subject: Re: [PATCH v2 5/6] builtin/repo: add keyvalue and nul format for
 stats
Message-ID: <aNVKki1hXoYi8qCV@pks.im>
References: <20250923025700.3046260-1-jltobler@gmail.com>
 <20250924212426.2930029-1-jltobler@gmail.com>
 <20250924212426.2930029-6-jltobler@gmail.com>
 <aNTVdy4hhLDlMpVT@pks.im>
 <lqzdrznf6kynr35eo74zodbfeofj6hnmskm2wqk6ty3o7wwaci@nyytil34eyzq>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lqzdrznf6kynr35eo74zodbfeofj6hnmskm2wqk6ty3o7wwaci@nyytil34eyzq>

On Thu, Sep 25, 2025 at 08:16:06AM -0500, Justin Tobler wrote:
> On 25/09/25 07:39AM, Patrick Steinhardt wrote:
> > On Wed, Sep 24, 2025 at 04:24:25PM -0500, Justin Tobler wrote:
> > > diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
> > > index 0b8d74ed3e..db21b75522 100644
> > > --- a/Documentation/git-repo.adoc
> > > +++ b/Documentation/git-repo.adoc
> > > @@ -52,7 +52,26 @@ supported:
> > >  * Reachable object counts categorized by type
> > >  
> > >  +
> > > -The table output format may change and is not intended for machine parsing.
> > > +The output format can be chosen through the flag `--format`. Three formats are
> > > +supported:
> > > ++
> > > +`table`:::
> > > +	Outputs repository stats in a human-friendly table and is used by
> > > +	default. This format may change and is not intended for machine
> > > +	parsing.
> > 
> > Let's mention that this is the default format.
> 
> I didn't mention that it is "used by default", but I think the wording
> could be more clear here. Will improve in the next version.

Oh, I completely missed this. I guess I was looking for a sentence like
"This is the default." at the end of this paragraph, which is what we
often use in other parts.

> > > +`keyvalue`:::
> > > +	Each line of output contains a key-value pair for a repository stat.
> > > +	The '=' character is used to delimit between the key and the value.
> > > +	Values containing "unusual" characters are quoted as explained for the
> > > +	configuration variable `core.quotePath` (see linkgit:git-config[1]).
> > 
> > In the current state there is never any quoting, so this statement here
> > is a bit misleading. Should we maybe drop that part?
> 
> While there are currently not any values in the output that would
> require quoting, I'm inclined to leave this note in the documentation.
> That way we set the expectation regarding how parsers should handle the
> output from the start.

Fair enough.

> > > @@ -407,8 +447,20 @@ static int cmd_repo_stats(int argc UNUSED, const char **argv UNUSED,
> > >  	stats_count_references(&stats.refs, &refs);
> > >  	stats_count_objects(&stats.objects, &refs, &revs);
> > >  
> > > -	stats_table_setup(&table, &stats);
> > > -	stats_table_print(&table);
> > > +	switch (format) {
> > > +	case FORMAT_TABLE:
> > > +		stats_table_setup(&table, &stats);
> > > +		stats_table_print(&table);
> > > +		break;
> > > +	case FORMAT_KEYVALUE:
> > > +		stats_keyvalue_print(&stats, '=', '\n');
> > > +		break;
> > > +	case FORMAT_NUL_TERMINATED:
> > > +		stats_keyvalue_print(&stats, '\n', '\0');
> > > +		break;
> > 
> > This reads much nicer now. The newline as key-value delimiter is a
> > curious choice, but you simply do what we already do in `git repo info`.
> 
> I agree that the key-value delimiter chosen is a bit strange. The
> command is still experimental so we could maybe change it if want. Not
> sure if it would be worth it though.

Dunno. If we wanted to do it I'd do it in a follow-up patch series
anyway.

Patrick
