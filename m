Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7034395274
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 21:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772142015; cv=none; b=T/+RFH1K5+BFD/lgcf0X4i/Ar6H3Mgbp446cDnHYRdHTyDhZKbBTKcFbK1c9A8xfU6w5IZsc/iNE+wzbcng2iXDXABi9X/mMJaDZg3aUYacWLOIma46BeYwwitlUWcl+bowWWIaG7VJkWtbhIPDo4yQjnaTIvBvCZPLEIXKCkpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772142015; c=relaxed/simple;
	bh=YSijgVKvbbFtq+z7ih45BSdi7b5p5nEYHmXds3+iyQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZKt+he9RApuXzz81VmKyXC3cb4+ZSKLw+qEa88UHPYY4cROree/0qN/lrcDigpOG1jIsjnwGtyxDjoEwCzrqcAI8qqewaaKWaBlSBxdcQMf7QCJgwIKcEInnXzNur5oMeAPfxy6bs5fgASYp017TXOytA988dsrNTQP2sn0uEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=G47KDPPy; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="G47KDPPy"
Date: Thu, 26 Feb 2026 22:40:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1772142010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XpFlP9gtayHyLYXOJ0CHe+7JEO/BbNPvCYOGu2pa2Ds=;
	b=G47KDPPyh9lpNtijr/SyXGz4TYpB403uYqevrmdQsYD6NWjNiSAINSWbhUR7uGu58PHUsc
	ybicvEEO/ZHNSmlitsY6d4duLnslMvWtbnwgj5hSprBonnRUy2rfyGRHWLSQJ4FMGZYSOa
	m6CTIu8uzTZMcRcOp71HYVd5tCEwwl522hiB87HKUWoz1e8vEaIhXlJ2baC3fzHxsYrTM9
	ierHbSTz18dXp+SqKRmh8F8o6U0WiyzoypW8bsJ0G2su69pH66o4o5kaRlHgocNZqpGSzC
	6QWhYDG7GDSIg+te/QQvjLRAjqHY2en8a7kENvtyjZbABnSVEqQRLcYxnO6oLw==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, 
	Mirko Faina <mroik@delayed.space>
Subject: Re: [PATCH v2 2/2] format-patch: add commitListFormat config
Message-ID: <aaC81Hk3tO5N2Rl0@exploit>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1403; i=mroik@delayed.space;
 h=from:subject:message-id; bh=YSijgVKvbbFtq+z7ih45BSdi7b5p5nEYHmXds3+iyQg=;
 b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBpoL2YZnQ/JiqFeo+aH+s9m8MFuPP+R0m96TH9J
 f1lDVwKwgiJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCaaC9mAAKCRBIeX6hnBm+
 0UtLD/9To/7j6z+E3tsRAG5NrXNPgrYkni7sEPWIpiX7H42V1hxw9/rpQBOJOQT+2SrlLB0+g6E
 iNpFlV8px2FzBhZe+XrIe2DglL9Ypi/VXSHMclArOGiUnXRFb1haVfgltYKLPdhx+76MqwnLM8e
 Mrudo1iGtNGReIHvKMM7aZZbHEX89yxMBaOUz+gSHOmL3MnQGSrvyiqOVq6IUyZfLXmrscH79ra
 2sVAMUu7Br0cmPRrNGu5auPbBA8xaOTpsDxwZzQSjcw5xogBnckP5leon8KFFnz98pYNP/1VNV6
 tJNtGLYczG+18T60XyEaVh5dRbGU2CW0ULw+Qi5mgVUpM4bilJFuSFBS3K6Dn++r3tnNWtu8R/v
 xfVDDkPYGx+c3Wim4K2ncSLsoInRVosTbXij5NQrK5H4AhY0csXDICdcXw8Kcqur7LMhuF8u/O4
 4Z64G87tdMF6zwfSmvCPVJroWO/8Gh0BaJVrVsvGNFX/qj8P4NVK9N+XxnG2caOvo6SawC/Syzu
 pS71H0DjJAhhQoMyx0TE5es0wU+2BGPBVJQNbnbGa0jhl8IXaqcbhUh63Sp5vfYgUwGUSSvvKjt
 YqYah6wjAr9fTTdW1o8tXZxCChFCUEEh5H5xslDTI5xiEVptcqsaGSKkFfUKHv1rVQsdnUuebR7
 XClVQCV+R2BQsKA==
X-Developer-Key: i=mroik@delayed.space; a=openpgp;
 fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
References: <20260224040400.751247-1-mroik@delayed.space>
 <cover.1771925291.git.mroik@delayed.space>
 <6a0c7aecfd6dc1ee873d5e81110b723fa2d225fb.1771925291.git.mroik@delayed.space>
 <xmqqqzqaggln.fsf@gitster.g>
 <aZ46xqCusF1av-va@exploit>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZ46xqCusF1av-va@exploit>
X-Spamd-Bar: --

On Wed, Feb 25, 2026 at 01:14:13AM +0100, Mirko Faina wrote:
> > > +		strbuf_release(&tmp);
> > > +		return 0;
> > > +	}
> > >  	if (!strcmp(var, "format.outputdirectory")) {
> > >  		FREE_AND_NULL(cfg->config_output_directory);
> > >  		return git_config_string(&cfg->config_output_directory, var, value);
> > > @@ -2318,6 +2333,13 @@ int cmd_format_patch(int argc,
> > >  		goto done;
> > >  	total = list.nr;
> > >  
> > > +	if (cover_letter_fmt && (strcmp(cover_letter_fmt, "shortlog") && strncmp(cover_letter_fmt, "log:", 4))) {
> > 
> > Overly long line.
> 
> Will fix.
> 
> > Stepping back a bit, even if we do not validate the format *here*,
> > shouldn't the code that does use cover_letter_fmt later in the
> > control flow *already* be checking the validity of the format and
> > complaining?  If that happens early enough, perhaps we do not want
> > to have an extra "early check and die" here.
> 
> That is true, and initially I did not introduce a check here, but
> make_cover_letter() is called after the cover letter file has already
> been created. Failing before format-patch could create a file or print
> anything on screeen seemed more clean to me, that's the only reason
> there's a check there.

May I have a confirmation on this. Is it ok to leave the extra check
here or would you like me to remove it and just let make_cover_letter()
handle it?
