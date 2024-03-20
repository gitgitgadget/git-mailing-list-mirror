Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724F939AEC
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 09:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710926272; cv=none; b=DSRZa1s+oNUWxC5mkpO+rYNAS/GFd26yhrJdgpwW9yy/YnpvURZYpw9hsw6pKdNIITSSzPZjAv5ipRa5ibr5aFPxT8ZgY40b8Ap5D9K2HF7d0GnznRiEk4RZONcsWyPnvHxu0OW1s2zFHR929E3VnsDy268AU6Zb6e6/jT9XHiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710926272; c=relaxed/simple;
	bh=atn+rfHJAnjp1FfsZ1znCMSQ6u9TCWHQIGuHCKUZDoc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ta1SzAon4nCyQVvEruDtQPxOO4FUpUZzms2ZOitGGqn4Sgn7kzURFr5FbTZyauLgQKiQSZw1WTKRFoGhw8Nto7pJSqp4hqqWu0rmZYBS+GRAPV+VZznaez2HiTaBePwEZlWe+yrJsK4EtL2MN60sh1BZnDjgdUvDzbpSlLr3IGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 11087 invoked by uid 109); 20 Mar 2024 09:17:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 20 Mar 2024 09:17:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16618 invoked by uid 111); 20 Mar 2024 09:17:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 20 Mar 2024 05:17:53 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 20 Mar 2024 05:17:48 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH] doc/gitremote-helpers: fix more missing single-quotes
Message-ID: <20240320091748.GA2444639@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

There are a few cases left in gitremote-helpers.txt that are missing a
closing quote, so you end up with:

  'option deepen-since <timestamp>

with a stray opening quote instead of rendering correctly in italics.
These should have been part of 51d41dc243 (doc/gitremote-helpers: fix
missing single-quote, 2024-03-07), but apparently my eyesight is not
what it once was. Hopefully this is now all of them.

Signed-off-by: Jeff King <peff@peff.net>
---
This should go on top of jk/doc-remote-helpers-markup-fix.

 Documentation/gitremote-helpers.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitremote-helpers.txt
index 83e99192e1..cd4e16abad 100644
--- a/Documentation/gitremote-helpers.txt
+++ b/Documentation/gitremote-helpers.txt
@@ -470,14 +470,14 @@ set by Git if the remote helper has the 'option' capability.
 'option depth' <depth>::
 	Deepens the history of a shallow repository.
 
-'option deepen-since <timestamp>::
+'option deepen-since' <timestamp>::
 	Deepens the history of a shallow repository based on time.
 
-'option deepen-not <ref>::
+'option deepen-not' <ref>::
 	Deepens the history of a shallow repository excluding ref.
 	Multiple options add up.
 
-'option deepen-relative {'true'|'false'}::
+'option deepen-relative' {'true'|'false'}::
 	Deepens the history of a shallow repository relative to
 	current boundary. Only valid when used with "option depth".
 
-- 
2.44.0.650.g4615f65fe0
