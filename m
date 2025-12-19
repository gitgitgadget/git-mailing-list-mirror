Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C82425A2DE
	for <git@vger.kernel.org>; Fri, 19 Dec 2025 08:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766131453; cv=none; b=ZPLz/JU55ZFONgZ8kXSglEtCajOcbAvFjfCEH/ifw1z4st+GUwJ5qVhBBxbZstBY2yxDVONyfhpZ1Xx/PBcjjoFdPMNRDGIdabKlcbIaQ5woETPB4LWyIXgyzgVpUZHpw1GYmvTWFBIB0u2/F8K/je9aO4Ru3iR9T0lbaXV//2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766131453; c=relaxed/simple;
	bh=4qB7t/ZsHzwkTZOQ87gh+zQN9l1S/Dzi96qvamrUlZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=la7z2E25xhy1iM2DruOMWjidoIGhfQb3Ke2weg1updLqanqcwndx7wFb0qmXNYUn4Y4+V0RgpD7xjbws0GELBlBssTKXVSG5swW8fudxRMpV8OjuK6pVFpbUs9yJPjdSDR/6yylJGEujtV9U4PB++rEtEv9q3TULmtPni19hYoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=M4VrB0Hw; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="M4VrB0Hw"
Received: (qmail 396467 invoked by uid 109); 19 Dec 2025 08:04:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=4qB7t/ZsHzwkTZOQ87gh+zQN9l1S/Dzi96qvamrUlZQ=; b=M4VrB0Hwzo5LRuoB/pf4KymsXvPOW47taWaxdQYoRCcjbW7ORR3EiAyU9tN+rSPwIp7O7DatOEdF951jteAEL8TD4H3yuyTjk6itybxEh7HCH2LLFJQDqQAjTE+nq6yLajuhjDw4WDzmkc4U25Dv4BVJ+c+V3oIywJ0x9+iA0bmd7qVmPd2t+rJAweyiicHCLs2ggVs9thZfbv3cenBKDU8Zu775BTJvSbZA/sFVitnQFWdqlByd2HNbEgIq4Sdc5+u/k5LsE42Dp0HRk+u0f+Yh+lOZYbErtqYJFFg0PsFgDa+oPGpSx24hrDKEYn6ADhg/ri0HPInIaAXVMSowwQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 19 Dec 2025 08:04:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 530392 invoked by uid 111); 19 Dec 2025 08:04:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 19 Dec 2025 03:04:14 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 19 Dec 2025 03:04:09 -0500
From: Jeff King <peff@peff.net>
To: Daniel Stenberg <daniel@haxx.se>
Cc: git@vger.kernel.org, Matthew John Cheetham <mjcheetham@outlook.com>
Subject: Re: [PATCH 0/3] test-suite fixes for upcoming curl 8.18.0
Message-ID: <20251219080409.GC3784564@coredump.intra.peff.net>
References: <20251218121120.GA3252258@coredump.intra.peff.net>
 <613s97no-7021-pp15-79s4-302o39p7n5r8@unkk.fr>
 <sn7p46s1-4o20-q05n-173r-s6716s8145q6@unkk.fr>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <sn7p46s1-4o20-q05n-173r-s6716s8145q6@unkk.fr>

On Thu, Dec 18, 2025 at 05:49:27PM +0100, Daniel Stenberg wrote:

> On Thu, 18 Dec 2025, Daniel Stenberg wrote:
> 
> > >  [3/3]: t5563: relax whitespace assumptions for unfolded headers
> 
> > I did not fully consider the impact this might have on users such as
> > you. Allow me to rework that a little bit further and get the former
> > white-space behavior back. Thanks!
> 
> I just merged a fix [1] into curl that should restore the unfolding behavior
> to match previous releases. It would be awesome if you could verify.
> 
> [1] = https://github.com/curl/curl/commit/9941e7c95bf26f00fd87888a

Thanks, I took a look at it. Unfortunately I think it only gets us
halfway there. It drops the extra space when folding this:

  printf 'Foo: bar\r\n'
  printf ' \r\n'
  printf ' baz\r\n'

which will yield:

  Foo: bar baz

and it fixes the first of Git's failing tests. But if we swap out the space for a tab
like this:

  printf 'Foo: bar\r\n'
  printf ' \r\n'
  printf '\tbaz\r\n'

then we get collapsed whitespace, but it's a tab. I.e.:

  Foo: bar\tbaz

(where "\t" is a literal tab). I think that does violate the standard
(which says it should become spaces). I think in most headers the
grammar allows OWS/RWS fields that are spaces or tabs, so in theory it
shouldn't matter. But I wouldn't be surprised if that causes some
surprises in the real world.

Sadly the input buffer to http_parse_headers() is const, so we can't
just write a space over the original tab. ;) But I think rather than
walking back to preserve that final leading whitespace byte, we could
just always add in our own space separately, like this:

diff --git a/lib/http.c b/lib/http.c
index ea62219542..eaa8bf73c2 100644
--- a/lib/http.c
+++ b/lib/http.c
@@ -4388,6 +4388,7 @@ static CURLcode http_parse_headers(struct Curl_easy *data,
     {
       /* preserve the whole original header piece size */
       size_t header_piece = consumed;
+      bool did_unfold = false;
 
       if(data->state.leading_unfold) {
         /* immediately after an unfold, keep only a single whitespace */
@@ -4398,17 +4399,18 @@ static CURLcode http_parse_headers(struct Curl_easy *data,
           blen--;
         }
         if(consumed) {
-          if(iblen > blen) {
-            /* take one step back */
-            consumed++;
-            buf--;
-            blen++;
-          }
           data->state.leading_unfold = FALSE; /* done now */
+          did_unfold = TRUE;
         }
       }
 
       if(consumed) {
+        if (did_unfold) {
+          result = curlx_dyn_addn(&data->state.headerb, " ", 1);
+          if(result)
+            return result;
+        }
+
         result = curlx_dyn_addn(&data->state.headerb, buf, consumed);
         if(result)
           return result;

-Peff
