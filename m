Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9399C1946B9
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 08:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735893336; cv=none; b=byzPKfLD+RxTA3qTrfv3kKQlQyVL7mihw4H670IKIXcfKlBoo2XNlRZvlKNk/133BqJx6wQT/zaEnyIcgSDpNBWjTXKAIENRFLDUabNkPmiR5qeYYvcW9PmNAhVkeUfvo/SKILoV+v7zQx5fbOu9RcKxShr/vIXe9nO/vdcSboQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735893336; c=relaxed/simple;
	bh=7Mh+Hp+F45ahvGMtedRWEAd6gWxFujWzXZXwjGrElw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gS0NvrAOsNNBgZPRurdeT53V5zikJeMCLNuAIjCsBL3O1w+v0tMz1/MP1xHNau61kMhJbQ73Q+70jtPlFkUhgl+ON40uhxljF8glNJRcEk3l2e5ra0ZAsde4whFRJH0zwiLxZpx3YjT5lMQev0JZWvuvbg5MwtQzEc34Vby8OAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VAJM4cpX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tFItR4zR; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VAJM4cpX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tFItR4zR"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 7394B138052D;
	Fri,  3 Jan 2025 03:35:33 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 03 Jan 2025 03:35:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1735893333; x=1735979733; bh=8oXSdqS7qV
	eBI/UM529unCLIs99CdZjifNWrdcIZFvk=; b=VAJM4cpXZEqIwrwoTdgRLfhWRl
	vpz8xBV9FahX47MH+Ns+oMK8HC16x11fH2JK0EemF0n3ADQEX6nRlfHgy1ny3+dd
	0pAbfjxOeJwnRNqBML2xLEw/3BbIDqri0H9poJFZCUBOWhpseZ/6AxwUeAMpapQx
	gJWWAP4Lhx9P8eLDnLTxz9yvwjUxdECzE5plJGp4OB+01WdLFMw7QLn4BtsVQ/Uo
	a0M6uyHEmw1//xUZCUuTcigWFDWRXb70Eg2XNRUId37FIJGuCgPS3J/n9nM5gNCB
	+4dgP5k0aWbxhUNasSUVNu1sLxkEoiPn9vMLXIU2yN4gD2vMumeI/oHdoXqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735893333; x=1735979733; bh=8oXSdqS7qVeBI/UM529unCLIs99CdZjifNW
	rdcIZFvk=; b=tFItR4zRYnSKCYAXmonYD7RND1jxeahlBDJjgbAAcB2H/AXTI7f
	nguC3r5xk3jjlC3b1/tqz4ifhve5Q/3W2hwL13IoKVGS+iVwTjdiULtvTRERl+HN
	CWpQlvJKGTtNtXUU3CyLWAbpfhDU951e6yARQ9IQ2db9JXLaEoE1hUHbfzrAUtYD
	nQ07Z40WziXl0m0YXf0pkivBjhayqGZxrKNsnWpS0RouizoRvqUVgLSFmvvzYHmI
	cdaGnKJRcHg6OufldJyIO0vWxlKcI9al1X7Ffg4d/ZRF2mJRWrrG6tYMOD6Go9kc
	DFwlZXa2MGkzHkYPqbUwwXZqDFUaXx/nssg==
X-ME-Sender: <xms:VaF3Z5Y5DOZfcdY_wV4r9zwbCudU0iDM4XCew2YklHda-yo2XCP9Rw>
    <xme:VaF3ZwZlL2GBNyl3ZvWWtZWtIN9c2m3xDoTOEdIBkjd4D0ETjTcq-4Lk9KnkTKjx_
    kTrAQRKrtU5wrI1yg>
X-ME-Received: <xmr:VaF3Z7-_2UICp5X-JhI0OocE0xKYjgIfvCkyGVv4TTlJ-UmCvbzDKxPCtPNo5Ie6KYXwytvCjakJundddZt942awdUOmJTfYBNoN263gM8ElJb0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeffedguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:VaF3Z3qq88MnOTfnLhsU4JZScl2fBueotBUClZvmM5caA7A88FVZWQ>
    <xmx:VaF3Z0r2pIqHSzVQEnxW09ooVxX61n5MJTI8fd3Rvx0HSCYB0zG24A>
    <xmx:VaF3Z9T1ofaMZeczbp_D33mKlvXfhcplU1tsoDRCLU8IshpFfemfIg>
    <xmx:VaF3Z8q0329v1DzZOVjgUhA4djyRPgQSAwzbAZCf8hEJ9sKGS94EZg>
    <xmx:VaF3Z73CuJ-STSh5vk4lPK2HjJOKcsTOx7nK-Ra0zeRGpev70xcm7uHJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jan 2025 03:35:32 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f8ffd8b0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 Jan 2025 08:35:30 +0000 (UTC)
Date: Fri, 3 Jan 2025 09:35:29 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Subject: Re: How to use Meson (was: [PATCH 00/10] meson: wire up missing HTML
 documentation])
Message-ID: <Z3ehR4uaG_j3iWy7@pks.im>
References: <20241213-b4-pks-meson-docs-v1-0-0c7895952cd3@pks.im>
 <87wmfqfwh1.fsf@iotcl.com>
 <Z26ygb_4-DP7Ufab@pks.im>
 <874j2gl46v.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874j2gl46v.fsf@iotcl.com>

On Fri, Jan 03, 2025 at 08:58:00AM +0100, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > Yup, you are always expected to set up the top-level source directory,
> > not any of the subdirectories. The build instructions are then processed
> > linearly in Meson, so variables declared before a call to `subdir()`
> > would be accessible in the subdirectory, as well.
> 
> With Makefiles I can build individual targets (like `make docs`), or run
> `make` in the docs/ subdir, is something like that also possible with
> Meson? Or are you always configuring what to build in `meson configure`
> and building all that with `meson compile`?

You can in theory. It's already possible to build individual parts of
Git, e.g.:

    # We need to discern these two `git` targets because the same name
    # is defined once as a static library and once as an executable.
    $ meson compile git:static_library
    $ meson compile git:executable
    $ meson compile Documentation/git-add.1

We can also have a target equivalent to `make docs` by adding
`alias_target()`s to Meson. I ain't got these wired up yet, but it could
look like the patch at the end of this mail. And then you can simply say
`meson compile docs`. It does require you to have docs configured
though, otherwise the 'Documentation/' subdirectory does not get pulled
included in the first place.

Patrick

diff --git a/Documentation/meson.build b/Documentation/meson.build
index 2a26fa8a5f..4f8e2e7ebb 100644
--- a/Documentation/meson.build
+++ b/Documentation/meson.build
@@ -204,6 +204,8 @@ manpages = {
   'gitworkflows.txt' : 7,
 }
 
+docs_target = []
+
 docs_backend = get_option('docs_backend')
 if docs_backend == 'auto'
   if find_program('asciidoc', required: false).found()
@@ -364,10 +366,12 @@ foreach manpage, category : manpages
       install: true,
       install_dir: get_option('mandir') / 'man' + category.to_string(),
     )
+
+    docs_target += manpage_target
   endif
 
   if get_option('docs').contains('html')
-    custom_target(
+    docs_target += custom_target(
       command: asciidoc_common_options + [
         '--backend=' + asciidoc_html,
         '--doctype=manpage',
@@ -419,7 +423,7 @@ if get_option('docs').contains('html')
     depends: documentation_deps,
   )
 
-  custom_target(
+  docs_target += custom_target(
     command: [
       xsltproc,
       '--xinclude',
@@ -447,7 +451,7 @@ if get_option('docs').contains('html')
   ]
 
   foreach article : articles
-    custom_target(
+    docs_target += custom_target(
       command: asciidoc_common_options + [
         '--backend=' + asciidoc_html,
         '--out-file=@OUTPUT@',
@@ -502,3 +506,5 @@ if configured_manpages != actual_manpages
     error('Man page configured, but not found:\n\n - ' + '\n - '.join(superfluous_manpage))
   endif
 endif
+
+alias_target('docs', docs_target)
