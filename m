Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24918221FDE
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 00:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773967331; cv=none; b=rz/xvW6RRn+ILZaCysNFIB8QSDHO9Rfzm917bjGNNLnxdnUxW1cDshhpbt2fpqUNgaZvP5B8Z/3HZ0yU+/ZWVTyjOjh1SNbGcPBNGIeTNE04Sg4KLJaZpiK37A1Y4yxu0P/xeoPiOi9uokmmypuYe+12Rhc/XaS9WDnWFffliMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773967331; c=relaxed/simple;
	bh=28K6f5MhaLM3wRDQhK7WTSS0P5ASQYscnutVXg/sFzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=POHECkgPDH8IDTe4Lh94KvVkGKMQ4KEQ8Cy6Jsrr0czxX/PTdLTgiu80Un3xsEIyJKiex1LNWC6CM0TKKk/3T0pDlPXo9GChbjvPJfATUbKb6NU63OCwAQ9mVEJfq08MsEq0/J3C8tL04SR37c0Px+WWFv4mkan2zRJwMLMTUv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=BjTpwNrv; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="BjTpwNrv"
Received: (qmail 62404 invoked by uid 106); 20 Mar 2026 00:42:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=28K6f5MhaLM3wRDQhK7WTSS0P5ASQYscnutVXg/sFzc=; b=BjTpwNrvPJ+iw1mudX65UJGDmmL9X2fqc9UJuv4nVbDq2x5L6203nYhytjYanPhKDCi7GFXP0u8dhOHLSVFqq8Eb+elrYBklkBrc6pwmm+6i0A6nmNjaBo0+oL81+e3rN4vxzZvNK23YCM1dRp5TDO8bRwDl2EFeCaI0udm/zCfFGiac6/wq/xTAKk3wU5+ns6hSNldlM2OAtvLVGSFBEyNF9FBLHX/b68HDD/b8V3DdWe+kRdSFAmtZ09SB9orTkzSW1g1W/FVXctu4Up7hiBdsrEhzsZwIdr+3AGtipItIZVmH7H5t9w92gwuFid93ABB2BOFWwcy5V6Myf8cOxQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 20 Mar 2026 00:42:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 91626 invoked by uid 111); 20 Mar 2026 00:42:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 19 Mar 2026 20:42:08 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 19 Mar 2026 20:42:08 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Scott Baker <scott@perturb.org>
Subject: [PATCH 1/8] diff-highlight: mention build instructions
Message-ID: <20260320004208.GA3654226@coredump.intra.peff.net>
References: <20260320004138.GA3653623@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260320004138.GA3653623@coredump.intra.peff.net>

Once upon a time, this was just a script in a directory that could be
run directly. That changed in 0c977dbc81 (diff-highlight: split code
into module, 2017-06-15). Let's update the README to make it more clear
that you need to run make.

Signed-off-by: Jeff King <peff@peff.net>
---
 contrib/diff-highlight/README | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/contrib/diff-highlight/README b/contrib/diff-highlight/README
index 1db4440e68..9c89146fb0 100644
--- a/contrib/diff-highlight/README
+++ b/contrib/diff-highlight/README
@@ -39,10 +39,21 @@ visually distracting.  Non-diff lines and existing diff coloration is
 preserved; the intent is that the output should look exactly the same as
 the input, except for the occasional highlight.
 
+Build/Install
+-------------
+
+You can build the `diff-highlight` script by running `make` from within
+the diff-highlight directory. There is no `make install` target; you can
+copy the built script to your $PATH.
+
+You can run diff-highlight's internal tests by running `make test`. Note
+that you must also build Git itself first (by running `make` from the
+top-level of the project).
+
 Use
 ---
 
-You can try out the diff-highlight program with:
+You can try out the built diff-highlight program with:
 
 ---------------------------------------------
 git log -p --color | /path/to/diff-highlight
-- 
2.53.0.945.ge67b727e8d

