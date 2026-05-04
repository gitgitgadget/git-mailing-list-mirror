Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B91236998B
	for <git@vger.kernel.org>; Mon,  4 May 2026 10:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777888859; cv=none; b=JdhGGe37W1x1+/OPVbPvNMlwZLVC/9M5Z0CDuHvPETJHRL09ZaVQxK52rAf1OihCUsEh+DZR1jPwrkPzXk/Fo83qAzaI3B/AXcduMVPYQmahn44GfguNMgys3Ym1tIfia+U/xeST1WfMQSG9x96TRQSN4lIu/pmEuxeHnMrJ5WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777888859; c=relaxed/simple;
	bh=aKUewSyGeznqepxBowsXGjoArvk3Q6rzArIn53/oTus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IPJkU9QYt+DGjUxGcrp6yTKPhRNQLQpTjlCONLLSb/xPbFrdItaCwjjrcrq5tAy8lfZGkkPHD2g+ofEbefyukdz/D0VkKkcDCeL58F6uaV2rE+/9RQO+GrRimghZtyWUoiJw/Qt2YH8+jz2MXr87M2HQFyTOJQycEaCAmOkYN2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=PH+OTq6u; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="PH+OTq6u"
Received: (qmail 28105 invoked by uid 106); 4 May 2026 10:00:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=aKUewSyGeznqepxBowsXGjoArvk3Q6rzArIn53/oTus=; b=PH+OTq6uJ42rvRcgcxvUX0blK7vAMtzeHz/ztFLdaY6IWsZufr1WMSXxNVsdWIcc3GVa22xqppQSPgHgf/Xi2keQK8nDOTS/Whvi+QkaFhROxRDFvWMIZHLQCwtRX/xXavHk+/wAnSgCPzPcxi8kqoTB1N6UQCw4nMqGbe95RkojI//Vpe5gQSllsbzhw63ZlajrYQVMer/xsUsUD4v0aRwKtBjK3l2Tzoy+hGQqRJ2WlAvPUcXV7rC551DvhP9SprBqmbunaC5Re1XinKpgYloZgtHd9YsH7NSNNas8HNGyN1c4WCd1S9uSLYcucfntb8z1nlisXRMpTCLxfuykCg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 04 May 2026 10:00:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 55040 invoked by uid 111); 4 May 2026 10:00:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 04 May 2026 06:00:56 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 4 May 2026 06:00:56 -0400
From: Jeff King <peff@peff.net>
To: "sebastien.stettler" <sebastien.stettler@proton.me>
Cc: "phillip.wood@dunelm.org.uk" <phillip.wood@dunelm.org.uk>,
	"chris.torek@gmail.com" <chris.torek@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"j6t@kdbg.org" <j6t@kdbg.org>
Subject: Re: git rename/moved status unreliable in ruby
Message-ID: <20260504100056.GB599780@coredump.intra.peff.net>
References: <OsOzcjEwvHCQSghLE8LD_wHb_jDlil9I88OUuhpiRONnVd1o9p3gStbK1mx4q7OwY3ePtbZO-BBgTNOCeJ2DMyvBsdlMhRmDrTP894KP5xo=@proton.me>
 <CAPx1Gvd_VEWHrBWtUjNeWZ+wfmsAOTamKmL6fhBSQi=MbmXRcw@mail.gmail.com>
 <IC7a4NnSKMdvXlVyaSDYEtU7iRlKdJGzCwrXNCFKrtFfnBJTMrwY522rHF8PfzYxFs43huo0KFGrqB6f4IQjmvYi2B8Ehh0cwfjHHOYW_RU=@proton.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <IC7a4NnSKMdvXlVyaSDYEtU7iRlKdJGzCwrXNCFKrtFfnBJTMrwY522rHF8PfzYxFs43huo0KFGrqB6f4IQjmvYi2B8Ehh0cwfjHHOYW_RU=@proton.me>

On Sat, May 02, 2026 at 09:34:18AM +0000, sebastien.stettler wrote:

> Has there been explorations of ignoring white space for the similarity checker, i would 
> assume that majority of white space movements across many languages would result in a 
> semantically similar document in most cases.

I don't think anybody has ever looked into it. We do have "-w" and
friends for diffs, and it makes sense that there might be some mode to
soften renames in the same way (especially if you are doing a "-w"
diff, or a merge that ignores whitespace).

The line you need to touch is probably this:

diff --git a/diffcore-delta.c b/diffcore-delta.c
index 2b7db39983..379f6010d3 100644
--- a/diffcore-delta.c
+++ b/diffcore-delta.c
@@ -147,6 +147,8 @@ static struct spanhash_top *hash_chars(struct repository *r,
 		/* Ignore CR in CRLF sequence if text */
 		if (is_text && c == '\r' && sz && *buf == '\n')
 			continue;
+		if (is_text && (c == ' ' || c == '\t'))
+			continue;
 
 		accum1 = (accum1 << 7) ^ (accum2 >> 25);
 		accum2 = (accum2 << 7) ^ (old_1 >> 25);

but:

  1. The option to ignore whitespace would need to be plumbed through
     the rest of the diffcore code.

  2. This concept probably throws off some other rename heuristics.
     E.g., I think we do a rough check that the sizes of the objects are
     not too far apart before even looking at the content. So you could
     construct a pathological case where the line "a\n" was changed to
     have a million spaces, and the files would look like they couldn't
     possibly be similar, even though they are identical when ignoring
     whitespace. I think in practice you could just ignore this, as sane
     cases would tend to have a reasonable ratio of content to
     whitespace changes.

-Peff
