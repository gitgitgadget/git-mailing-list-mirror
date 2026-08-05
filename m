Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1FE3E2751
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 07:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785914894; cv=none; b=GvT+7EyeY9Vvq7ZzNXU56CJ42IYpy2F+q9YN1J11EfdSi6HSUVqAbwJdzoH0KRkRXkmr1lxYajQUFGNOWU4TYt/EG8UscIHZJ9oNxS7zVJdr+PEnFShtx8HFKnkfeF2fIev0khbwHoQ1XfGExFBFvD8SAzA+a6Uc1tO89bX0inI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785914894; c=relaxed/simple;
	bh=pEoO0pX/4J6lllTOZr08qaHwjh2JbCA/V1jRActmK2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P1haJfmL1G82ubidL0QZu/kiRb8GXOk3jbgdHWhymuP55J9NSRR+WdxEwnTFDxD8gkiX7H2Imho3St2QfBsBN3hoz6Z5diIlRsRnH4f2dnGIse8MrotxkNbkx07HOix+Whnarjc5a7oaa08z6oMh1ywagZ+hxE3idDPzZpiFVHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nsFBn/LG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y0Gp2PJ9; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nsFBn/LG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y0Gp2PJ9"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C6A32140013E;
	Wed,  5 Aug 2026 03:28:11 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 05 Aug 2026 03:28:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1785914891; x=1786001291; bh=Fk4s4k7HYS
	yyBiJNAXe2sr+XrqsHuG7U2HioFnSQDuI=; b=nsFBn/LGwgxU2WtIVYaW5bwLws
	+vHaczri2UVDWBeIQ9ygRqgLHcW8uME7GUeTKLxtoe0B/0A64E3PNsQdbT9jObQs
	sUH/DXca2/ABYndENIhGLCqPGPkiVE9v36QruVncsqMB1YTgLHtw5TJWTCfcvndT
	tdhZeZmmMCDqkhadIwPf6pykKYQfEyl3KdSmdcLMqTmNhXQtpP1iQ56gkdX16u5Q
	PL04vh0mtEZKXZWB/cw3AGLamj9PSk7LAfp5BqCtGzs+98zuvV7XRZZNcV/zu6W/
	bcFQqEF3O8beiqyvOAGSXea1B0+/jAbkB96T+SwhXq58n8kd/IXnU5Isl7dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785914891; x=1786001291; bh=Fk4s4k7HYSyyBiJNAXe2sr+XrqsHuG7U2Hi
	oFnSQDuI=; b=Y0Gp2PJ9nw7PCpKi3NMzvWUCralRJXYBnM59SjIyQXwRRm4/IgS
	sLGrNCj65gXiJ44YoxgyA9w5cVMPQAnO3Ia+LtF1wDdyG6LI3U1y9920fwoFGvIF
	vOs5iAKnpvMT9Qd+JObGinP1FDs8xcynogzYEZcih9xQif3IE2qW2YswsMaTc7sJ
	6A5qbKPtUJ+K5TBMSAivctvyrZSxnwAmonmEb+MpQP97R0GdZJmgkWb9zcD2k6ru
	O1roEOYKQve4kEgC5XNbZmIC0eTA6onwDjcQbDas0uxXk1+JCn1MBvTFBGHuavWH
	tz038cUdBI5KKEcs7ytwFFFeFdglcGX+vRQ==
X-ME-Sender: <xms:C-ZyatIrC3x1IK-J9gZe8LkBzR16k0dp0h0E6PE-P04ghSm-WOdN-w>
    <xme:C-ZyagIV576vh5oO9Fcn-0ObsXFQIsBNNxeLrlEGYMt3Z7U1zCn6g2h07hS9wAbMP
    alTIMRZ4RtY3D2tFtE6BtAnYIxkOGe-VVWp8_hqW2517aJcQwbBRw>
X-ME-Received: <xmr:C-ZyaqvLBW0_6z3-w8cb9okfVC5fR8HNB_5vPvH_GD53rBVXIdlEIySg1gtnQRmTpq-0YinflnNw6ZoENz5oAQK6YhcK_xIqcALskwbAIw>
X-ME-Proxy-Cause: dmFkZTGwf3Pr9sJrZLSyl0izwhwblActY59P0a84QKtTU8RM81/CXG9hjXwq5KZcqvwhFg
    22g8uUrUjZdAxIMUashrSU365hjpskljuSy3mDFDfLXIET2nBNRDxVkeHdNWyzj/Kw3Dkr
    oonZbhP8j4/A8wWwUionwUHw2B4Yo17eyi1jS3GqTjMFfMwqeHmPAie3pbc/Qd9fGn5CcK
    fx26gDd6FATUaBVRpZLYrd6b82/39RegwzELgh3yvkiczRVHAe5NOlO8l3Rm7oI2dWg4GG
    FLubNG4yxogd/zVJjPcfEHrjoarA5DabWRwFv4DtgvebO46XsZnMTOXFXR/gIgdss8rpJ2
    cthAaotMXsQctOgee9bxBMdpwN4lZW9AYhR0c5NHelAg2VaiXb6+ZkI9Yd38ViOUNwl7Da
    icFZKiltu6CELPwUP3vvDPQXWOsahxa5jWHPEX5+l6u1jkY9lePzBfqcsKC6hduB00rR5A
    C0erU/NmEe9U8uotk1LDze8ywBAwBQr8hnIatRBz1xGJPOKZrzUJpJA0hWE57mtNxoMGrk
    5O0IqUHNvRyb+uvpNZicMAOX8r7srKi8jotnR2WiwBybtfKE6WylHiFRCQEQLWACWwXrMX
    Dirq4W7C+UiHlenJi9jnD4wKrLLbbTJjG8fIYJW3iTy1j5+0UbQSK7xB5Nzg
X-ME-Proxy: <xmx:C-ZyatRnN4V5VX4M6lS-qeDOPiQvb98DIPvkgd9viV4cRILPcwv-bg>
    <xmx:C-ZyagPjkLz2s96_mzAN43MMAqSPg7pDR2jgvWfVyFNaov_x-Vg1Ow>
    <xmx:C-Zyaiao_6QXQuyVcTzNnClrtLd3WMUjS8QJ4CYhGAw-rbr7YUBfvw>
    <xmx:C-ZyaqzP33DTnSeVGBdUR7_KewR7DZTrzo7ycCLpj_ZRBskIA34Zxg>
    <xmx:C-ZyajtqsRqqTDW5UpiYaDhLtsS48c6up-nNNsMl-OFbmSDafaHVHnNJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 03:28:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e892838e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 5 Aug 2026 07:28:07 +0000 (UTC)
Date: Wed, 5 Aug 2026 09:27:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 3/5] setup: defer object database creation
Message-ID: <anLl8Cy6Bkv5XA7-@pks.im>
References: <20260804-pks-odb-create-on-disk-v2-0-ddf8b59bd207@pks.im>
 <20260804-pks-odb-create-on-disk-v2-3-ddf8b59bd207@pks.im>
 <87bjbh67sl.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bjbh67sl.fsf@emacs.iotcl.com>

On Tue, Aug 04, 2026 at 08:48:42PM +0200, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > In a subsequent commit we'll make the creation of the on-disk data
> > structures of an object database pluggable. This will lead to an
> > in-between state where we have already configured the repository's
> > object database, but it's not usable yet until we eventually call
> > `create_object_directory()`.
> >
> > Defer the object database creation so that we handle both steps in the
> > same function.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  setup.c | 35 +++++++++++++++++++++++++++--------
> >  setup.h |  9 +++++++++
> >  2 files changed, 36 insertions(+), 8 deletions(-)
> >
> > diff --git a/setup.c b/setup.c
> > index 825572f5f1..a7b1b9eaef 100644
> > --- a/setup.c
> > +++ b/setup.c
> > @@ -1760,6 +1760,13 @@ enum discovery_result discover_git_directory_reason(struct strbuf *commondir,
> >  	return result;
> >  }
> >  
> > +static void get_object_directories(char **object_directory,
> > +				   char **alternate_object_directories)
> > +{
> > +	*object_directory = xstrdup_or_null(getenv(DB_ENVIRONMENT));
> > +	*alternate_object_directories = xstrdup_or_null(getenv(ALTERNATE_DB_ENVIRONMENT));
> > +}
> 
> Would it make sense to wrap these in a APPLY_REPOSITORY_FORMAT_HONOR_ENV
> guard?
> 
> I mean, below we call this function *only* when flags has that bit set.
> But the return values of that function are used at the bottom of
> apply_repository_format(), that's a bit awkard.
> 
> So can I suggest the following patch instead? That would remove the
> weird double pointer passing around, which feels a bit unneeded.

You're right, this is somewhat awkward. I have a different proposal
though: instead of creating a separate function, we can move handling of
environment variables into `odb_new()` itself. This also paves the way
for moving handling of these environment variables into the backend,
which is something I want to do soonish [1].

Patrick

[1]: https://lore.kernel.org/git/amLgMqkqxR8mKIbT@pks.im/
