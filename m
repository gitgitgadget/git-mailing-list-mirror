Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030E882891
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 08:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709801005; cv=none; b=R8RdbhvRlgqmwHX3zb9815eHdNxfeqdU1mlC/yzwnMBx/tY8Ai+gMwTkG5Ch778tUuB3EoS8K1TjVaRaNFn09BIm26ii2gBASMkahR/5PTy2m+VcT9NDQjgIG+Y6+rH6/GE06RYc4sa/2YsUiGYDKNW7TLA99vo90Nz37R9MUd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709801005; c=relaxed/simple;
	bh=XEAGpTsuDNYxNR+b+R7ZPheG3+pQiJvxrEGK9l4nsi0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=q5FJL7xE7idZrJ3yBOXnCqflQlY+xNdq0XZ6OfyBT9+iVHc+yNoKSn+mzhGxKq5SH5iXF7WxvkfV7pl8FpQgbOzXvEjuq6m7E1Ke8CcOkB6UXLX3L6RkaGb4feQktNn8BPP/hpNUGYXpEIFlsWL8j80wQr3kuP7fCG21xwhlVAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 6645 invoked by uid 109); 7 Mar 2024 08:43:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 07 Mar 2024 08:43:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12279 invoked by uid 111); 7 Mar 2024 08:43:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Mar 2024 03:43:18 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 7 Mar 2024 03:43:13 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH] doc/gitremote-helpers: fix missing single-quote
Message-ID: <20240307084313.GA2072022@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

The formatting around "option push-option" was missing its closing
quote, leading to the output having a stray opening quote, rather than
rendering the item in italics (as we do for all of the other options in
the list).

Signed-off-by: Jeff King <peff@peff.net>
---
Just happened to notice this while looking at the rendered manpage for a
different option.

 Documentation/gitremote-helpers.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitremote-helpers.txt
index ed8da428c9..07c8439a6f 100644
--- a/Documentation/gitremote-helpers.txt
+++ b/Documentation/gitremote-helpers.txt
@@ -526,7 +526,7 @@ set by Git if the remote helper has the 'option' capability.
 'option pushcert' {'true'|'false'}::
 	GPG sign pushes.
 
-'option push-option <string>::
+'option push-option' <string>::
 	Transmit <string> as a push option. As the push option
 	must not contain LF or NUL characters, the string is not encoded.
 
-- 
2.44.0.463.g71abcb3a9f
