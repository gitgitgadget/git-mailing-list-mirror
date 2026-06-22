Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5123A545E
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 10:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782124202; cv=none; b=J3ucGFz4MG1kP2o669OFg2AVgmVzXiu0oSnPJdWkTyFhzH0mDz6pSk3gzSc2BFnsCsSUKysyUxdk1UE8jz7vt8E5d6jGyYupVLKGIQUptVi+ku5CHwNTzywkjNMEvjl7+uQRojwv1/9dNEaBz82TADOiDjHu2QziqTLZjKo70hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782124202; c=relaxed/simple;
	bh=fOFh0SC17mJ9IOnjNDX3C9CnVtk+QMKPTWV1+V9BNuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=phsj72iowae30ie0L06hOuIK6l4MaUBZaxuVgro76zjTAOWjCaDXK2buXM7YPktUeSOap6vq4U6yUms56LDtMO30ZAYQZJKzLwjDhiWKQN5NUQzVMbC/wQoEGkO6+g3FhA4+H1+1R1nTqTmVnjHF29ZWVP9X6Txlm9ENHde4ox0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kZri1DxH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wq3IeWxK; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kZri1DxH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wq3IeWxK"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 2364D1D000E2;
	Mon, 22 Jun 2026 06:29:59 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 22 Jun 2026 06:30:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782124199; x=1782210599; bh=IRsK0YdGnq
	0cQLEVAli4U/3SN3dn6nY+/alsvUn+mZg=; b=kZri1DxHJa2kgQirmxHC0E1yox
	z7/x3MUaVQf2uSvVm/RZeEUXi+zMPoZiWuFITD85IvbLR7LMRRdv945TJXAwu4WU
	9ljJZqsDP6m0s9Cjl4OurOrzO/4Pw8HRUucgWdfz7xQNLKB3jDcbYaXCY5X9/NVT
	HqhBeo/GmuPIZpL0f3OctN7gaGEApzmgLqYLOB6DmrHq4zc5dJpenS3SmJI8Sz/n
	BIX6sYhf932/LbOoredqCJXaydpIA7HJmFe3/7a+Kdcdt1O4G9SMAVl5zJ5P85uq
	D4ZCP4EYBxw2RQoI5GaRnxSQhpNj6YOQxrC4K0UENuuzP2cCxtD0XEpR4V6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782124199; x=1782210599; bh=IRsK0YdGnq0cQLEVAli4U/3SN3dn6nY+/al
	svUn+mZg=; b=Wq3IeWxKlNRuEv2breUql45PFp4A4I08mtD9gnx/CO9kc/lvaux
	TxoxEJUnMulUngjnY9dye439tkEWXRWWfChl0MMlnGD+mc5x5x88R5CIx2TKCQQu
	fP/24w2r+2fd7f+GtLrOLzkMiVhTF5pIjLn0f59n8euMqWpGryTuw3sPPZCa8iUQ
	wtr/Br48JcPab1kHsEB0nVCaJjGObu6Vn5AoNejDe3mCXTCL9YrfxKiFha4m2FHE
	Vl0PLXGhdiQ6pbEvsKwwrgt/8YNst8pbiggIeZcwXRIvhxyQJdams2R9Ktw1VEKk
	OSrppc7/SYVgchANXCCLaXmRePZDYhOzHuA==
X-ME-Sender: <xms:pw45alo6zW4jwAhEx1CQXke8R5ZVPvNrOt3OykUN3OWGVGusAI5gGA>
    <xme:pw45aup09cn-cil0pf5VbJjByB-BaSUft5P_UEXpy_Z97RmCn0FGHj7jnqXBdEMP2
    6p3DGQFdkdyTdmLd17I9GIFvQ25F4XVzT9UuPFQK3VJJC6-jp_LzA>
X-ME-Received: <xmr:pw45anMRL6ZooT0Z8hYjIPCxLsVHEzQG7LIaZ20Gmz8Kv7Q6KYQkuoydw0XVP9NFM-Qq58gltB3LXuafUAZ2PlNSnuUVNknl8a1G3r0a3g>
X-ME-Proxy-Cause: dmFkZTGQuQ/Fk7Mdr6tsh9i1yDVO/UzL3YHkpdziIB3RaN/G4K9zVa6FnwmsEqakgTbgf6
    03X4M4SjKUKSPdQYy5xjOF74fuL4qvtqvFi0p6Xa1RwCB2a+cvly67ue7krnkK8n1hrWJb
    3X7Iw4P3863dIwBMN6yT9jBnxi5HANvZGKtuBESDw2HbQt4Sxcb4tZFrzKEptRfZyf3QaY
    1P0Irjo/0sMmBBG12oI7+NMB2Uu1ilI1+wRxKfdxv+xHBlOmLhSVbQGk9W7aYrhZJITPfw
    9M1TQWfPhutGGxZn1mBsagoK+gD91Z/PtjdP/XNPhhWvRHTL4cOkZXNlGrtOQNZohy8ZL7
    Lpe1e+AyPsBJ3mIhQnwBuwwNfSNvw+vGOKB/SBaKZBK4IOWD0I+eYfASUppoyufV9fpFqO
    euj4vTDFbGjhHwT5sumOhkC44RGupQHwQZTtLkC7gpUt3hKT53AjkCNcx9SXmGqMFmQmR1
    Ca0W9RPm2Q1gtYgTeXx4GiXu0FwsRXtLGXwRwL+OYPMMoVf+cIvOo98ALInxCeo4O1lxxS
    b0bdxvK/It7gNuxPDtp74RPJ7yTm/uudjtm+n4IdrPvAYkmOB+bLtBlN7VPyX2Pm3vOXYx
    EJk5KhhhTL/HHtYAFTKmG03W/c+yICLc7kO6IXhor/vymp/MF8ph/YGT64cA
X-ME-Proxy: <xmx:pw45avzN27T-dy1AWUfBb0l0zKKtPipxH5bke4MyQAE09JPnsiP_Ww>
    <xmx:pw45agtSOJZubP5GLqOzRG34M3iK9XgxxM8d8kiBKwTqlYzAdcbptw>
    <xmx:pw45ao4eawrn2u3PpdTMZRkmLUZbMvd1_2XmsAKfIKR5cFU339kXHA>
    <xmx:pw45avSp4oMQgeyjtOhWVqU1VRCkDE6Fm4j_CucMxRd3AX7OXW34hw>
    <xmx:pw45ah6mqPe7y8cTkemWHFoajMyR62uboiLGlkUWyObY0GIe3MUvJ2PJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jun 2026 06:29:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8200a8c3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 22 Jun 2026 10:29:56 +0000 (UTC)
Date: Mon, 22 Jun 2026 12:29:53 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Michael Montalbo <mmontalbo@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFH] Why do osx CI jobs so unreliable?
Message-ID: <ajkOoRhqaAcy6gBg@pks.im>
References: <CAC2Qwm+9sh=ks1fuux415JGdDJ38Jq6eZrSH7-qzQxYCoy+Aug@mail.gmail.com>
 <20260621213407.GC2297179@coredump.intra.peff.net>
 <aji9MOE-NTHKXYqn@pks.im>
 <ajkEzhdqzmAePk_P@pks.im>
 <ajkGkB2ckf3p43QR@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajkGkB2ckf3p43QR@pks.im>

On Mon, Jun 22, 2026 at 11:55:31AM +0200, Patrick Steinhardt wrote:
> On Mon, Jun 22, 2026 at 11:48:01AM +0200, Patrick Steinhardt wrote:
> > On Mon, Jun 22, 2026 at 06:42:24AM +0200, Patrick Steinhardt wrote:
> > > On Sun, Jun 21, 2026 at 05:34:07PM -0400, Jeff King wrote:
> > > > On Sat, Jun 20, 2026 at 08:33:13AM -0700, Michael Montalbo wrote:
> > [snip]
> > > > > When it is wedged the whole chain sits at 0% CPU. upload-pack is
> > > > > blocked in write() on the ls-refs advertisement, curl blocked in
> > > > > select(). So it looks like an HTTP/2 flow-control stall on the
> > > > > response side. The same stall resets itself after ~60-85s on my Linux
> > > > > box and on a bare-metal Mac, but not on the GitHub runner; I haven't
> > > > > pinned down why yet.
> > > > 
> > > > We had some HTTP/2 stalls/deadlocks in the past, and they were dependent
> > > > on libcurl and apache (actually h2_mod) versions. IIRC some of the
> > > > non-TLS code paths for HTTP/2 were not well tested, which led to
> > > > 8f2146dbf1 (t5559: make SSL/TLS the default, 2023-02-23). Of course
> > > > after that commit those cleartext code paths should not be a problem, so
> > > > that is probably not exactly the issue now.
> > > > 
> > > > But it might be worth checking the versions you're running locally
> > > > versus what's in the GitHub runner.
> > > 
> > > I didn't observe any similar hangs in GitLab's CI systems, so I wonder
> > > whether this is because of different versions of curl. And indeed we use
> > > different versions:
> > > 
> > >   - On GitHub we use 8.6.0.
> > > 
> > >   - On GitLab we use 8.7.1.
> > > 
> > > Now this of course doesn't mean that updating the curl version is the
> > > fix to this whole issue, as there's a ton of other factors that could
> > > play a role in whether or not the test hangs. So while we could just
> > > upgrade parts of the stack and cross our fingers, but that feels rather
> > > unsatisfactory. Still, one place to start could be to update our build
> > > images to macOS 15.
> > > 
> > > But the big question to me is whether the hang is because of a bug in
> > > Git with how we drive curl, a bug in curl itself, or a bug in Apache.
> > 
> > I noticed that a osx-clang job failed today in t5551 [1]. This time it
> > didn't hang, but produced an actual error:
> > 
> >     2026-06-22T09:25:45.1984230Z ++ git -C too-many-refs fetch -q --tags
> >     2026-06-22T09:25:45.1984420Z error: RPC failed; curl 18 transfer closed with outstanding read data remaining
> >     2026-06-22T09:25:45.1984520Z fatal: expected flush after ref listing
> >     2026-06-22T09:25:45.1984610Z error: last command exited with $?=128
> >     2026-06-22T09:25:45.1984660Z ++ rm -f tags
> >     2026-06-22T09:25:45.1984710Z ++ :
> >     2026-06-22T09:25:45.1984830Z not ok 35 - http can handle enormous ref negotiation
> > 
> > There was a second test failing similarly.
> 
> Oh, and Linux is also failing in the same test suite [1], even though
> the job logs are truncated, so it's hard to say whether it's the same
> failure or not.
> 
> There certainly seems to be a deeper issue here. We could of course just
> disable the test again, but by now I do wonder whether this would paper
> over an actual bug.
> 
> Patrick
> 
> [1]: https://github.com/git/git/actions/runs/27940620478/job/82672854864

Sorry for the repeated spam.

I think the issue is rather simple: we're hitting timeouts in Apache. If
you apply the following diff:

diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index 40a690b0bb..4054fe008f 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -302,3 +302,5 @@ RewriteRule ^/half-auth-complete/ - [E=AUTHREQUIRED:yes]
 		SVNPath "${LIB_HTTPD_SVNPATH}"
 	</Location>
 </IfDefine>
+
+Timeout 1

Then you'll see the same errors locally:

    $ GIT_TEST_LONG=Yes meson test t5551-http-fetch-smart --test-args=-ix -i
    Failed to clone 'sub'. Retry scheduled
    Cloning into '/home/pks/Development/git/build/test-output/trash directory.t5551-http-fetch-smart/sub'...
    error: RPC failed; curl 18 transfer closed with outstanding read data remaining
    fatal: early EOF
    fatal: fetch-pack: invalid index-pack output
    fatal: clone of 'http://127.0.0.1:5551/smart_headers/repo.git' into submodule path '/home/pks/Development/git/build/test-output/trash directory.t5551-http-fetch-smart/sub' failed
    Failed to clone 'sub' a second time, aborting
    error: last command exited with $?=1
    not ok 36 - custom http headers
    #	
    #		test_must_fail git -c http.extraheader="x-magic-two: cadabra" \
    #			fetch "$HTTPD_URL/smart_headers/repo.git" &&
    #		git -c http.extraheader="x-magic-one: abra" \
    #		    -c http.extraheader="x-magic-two: cadabra" \
    #		    fetch "$HTTPD_URL/smart_headers/repo.git" &&
    #		git update-index --add --cacheinfo 160000,$(git rev-parse HEAD),sub &&
    #		git config -f .gitmodules submodule.sub.path sub &&
    #		git config -f .gitmodules submodule.sub.url \
    #			"$HTTPD_URL/smart_headers/repo.git" &&
    #		git submodule init sub &&
    #		test_must_fail git submodule update sub &&
    #		git -c http.extraheader="x-magic-one: abra" \
    #		    -c http.extraheader="x-magic-two: cadabra" \
    #			submodule update sub
    #	
    1..36

And Apache also logs this as a timeout:

    [Mon Jun 22 10:26:52.115717 2026] [cgi:warn] [pid 3686957:tid 3686957] [client 127.0.0.1:55114] AH01220: Timeout waiting for output from CGI script /home/pks/Development/git/build/git-http-backend
    [Mon Jun 22 10:26:52.115748 2026] [core:error] [pid 3686957:tid 3686957] (70007)The timeout specified has expired: [client 127.0.0.1:55114] AH00574: ap_content_length_filter: apr_bucket_read() failed
    [Mon Jun 22 10:27:01.567533 2026] [cgi:warn] [pid 3686958:tid 3686958] [client 127.0.0.1:54384] AH01220: Timeout waiting for output from CGI script /home/pks/Development/git/build/git-http-backend
    [Mon Jun 22 10:27:01.567559 2026] [core:error] [pid 3686958:tid 3686958] (70007)The timeout specified has expired: [client 127.0.0.1:54384] AH00574: ap_content_length_filter: apr_bucket_read() failed

This is because our keepalive mechanisms aren't helping:

  - The TCP-level keepalives don't help with Apache.

  - The application-level sideband keepalives don't apply to the
    "ls-refs" endpoint.

Whether that's the same issue like we see in macOS sometimes is a
different question.

Patrick
