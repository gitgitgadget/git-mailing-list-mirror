Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC14540DFC3
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 06:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774245720; cv=none; b=NT6Rc5OSIS9+cOaTIoKKVWXrFHCma86GEBjdDy2Fj8Cd/Y32nkkjDVOS/yr9/f9LTjVLnY+GuiWlBXlSjb4eComkV+KmfaPtqWMrrzOFoVYD5QXhjj+/anrkEwDKxq1LaeD8u+sxg/drNgPqPT3hKH0MWVsxbPcodfH/Atz4pvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774245720; c=relaxed/simple;
	bh=q8b9wZzrVghohSvz4snZe0OyD5SdjlnT0MNdBXE55+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E58R9Azzvh/ihdrFL6909N4Ao76keTLsrUXaj/qDpqsHmNiZy+5FD7TowR83oqdJdwyz9591JZwm9HWlgJsPdShgsBbjaFZPldwjegCGn2T1ZKxCCpu7bNhHUlY7EYcLfo/A5S/w7UO6W11e79j2vOaCUUTYc5oKGQCyX7bILx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Ln+HbbRy; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Ln+HbbRy"
Received: (qmail 110158 invoked by uid 106); 23 Mar 2026 06:01:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=q8b9wZzrVghohSvz4snZe0OyD5SdjlnT0MNdBXE55+o=; b=Ln+HbbRyRNt5OrlwBgJlTvGt5ViSFlDECFsSXqF0xU7JDrbe+JY3hD8XLCUvYazlm3cz2hPntQhN44fz4OYwIFhJmcf6r1EHXL/tZMIyXtzLXyi/KAa+FP8zpZzMKukfwCxCQPuZubeR8PCX27hSbC9QyKdobwOSzGmexoNXKPSqBh/CfH2f20vQuI0OW4rvChmmeK9wwAAWoTs9DGFnMZ0X2dP1EmQQBoukHL5pduc7YndEdUTTW5bbnfJGVq2Jk331pvJYCCNQWoYkk/3ZSwddpnKFOqV9lsqbeZrnEQOjowMsmRJFVDhnpwiPe0VNus+sO3l2VPNYCirK1ZytvQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 23 Mar 2026 06:01:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 146976 invoked by uid 111); 23 Mar 2026 06:01:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 23 Mar 2026 02:01:58 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 23 Mar 2026 02:01:58 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Tian Yuchen <a3205153416@gmail.com>, Scott Baker <scott@perturb.org>
Subject: [PATCH v2 1/8] diff-highlight: mention build instructions
Message-ID: <20260323060158.GA10482@coredump.intra.peff.net>
References: <20260323060139.GA10215@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260323060139.GA10215@coredump.intra.peff.net>

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
2.53.0.1051.ga14e96f895

