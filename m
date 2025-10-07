Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293E6255E34
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 08:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759825764; cv=none; b=a5WPFvvcoXyR72EdqutXQeBw1NhsoF6MGJC8Yvqgzdo0s/efPQ2q3EtF9zeQm12Zo+atdCPuROAxlhIV02jh5JT8zq2UUObPAKhcq1yKSx7sANLwAxcKb4JKAfujexZ5rcZ0pwLIcBtL+R+JzKipUaeXLV3+lMXv9d5iSYyLmK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759825764; c=relaxed/simple;
	bh=rf1RG0DMDa/UYS13ed8DP0qiEsLXDUQIOSXtpUatB4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XDRNbo6PlSKnBNONquE0ojYlz7cdCxqEB6B1/9uVTOioP+GMnCcaoEn4gZ89pPxdeKZhAiwPhdA1oryQU9gfNkEgWL4a1+vn/TRmBZNUPhdk4wVbHUB477SYkbN4Ibw1kuJqO1/6DS9M6MLwD4IwEO7k9yhaDjOlkvujjFuqJgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=HyG6+aid; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="HyG6+aid"
Received: (qmail 156327 invoked by uid 109); 7 Oct 2025 08:29:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=rf1RG0DMDa/UYS13ed8DP0qiEsLXDUQIOSXtpUatB4Y=; b=HyG6+aid0GcXe75oQ5F41jBakjSDRN9Pi3+1RS+dq4iZPVAXTgnsffTyB2P8+UNnZJ1VbxTTSuIN1u+JUu6K7I53MJXBmns+0i0ZSHoGZgYU/SDWmz6Xe+RPV1hZ3NqgRcAL8KZTU2HJ5VtGVd6ta5CU8dOFbzROH3PPku0Z24h03osPyPmyZH4GHvNxmmTPT5nVdZkEtIX1BM+KncdgTyPlCmT+wDgUFi0oTm6lf94q1afxouKhqQly/QvqR7kfkG+G6ssZD8+agbSjT0NiPIHvOEy2m72Dy9OlWpvTgGI08DIxtyxtFmZqiJsErMmEpCylKMsz9B2INV+wO8z37Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 07 Oct 2025 08:29:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 230897 invoked by uid 111); 7 Oct 2025 08:29:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Oct 2025 04:29:21 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 7 Oct 2025 04:29:20 -0400
From: Jeff King <peff@peff.net>
To: Langbart <Langbart@protonmail.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Git Status Short Output Color Inconsistency with -z Flag
Message-ID: <20251007082920.GA3349249@coredump.intra.peff.net>
References: <XCDlwEkTlgoZIyIf_8BfOGl1C3C63Ioxeib4BRNJ9Jm_CtYWKT3qu-pDaeXVtS1Ifq6E4pT9G0yDbIS_nSwN-uiBuBNAlMyrOv0R1RyM7oc=@protonmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <XCDlwEkTlgoZIyIf_8BfOGl1C3C63Ioxeib4BRNJ9Jm_CtYWKT3qu-pDaeXVtS1Ifq6E4pT9G0yDbIS_nSwN-uiBuBNAlMyrOv0R1RyM7oc=@protonmail.com>

On Sun, Oct 05, 2025 at 12:48:43AM +0000, Langbart wrote:

> What did you do before the bug happened? (Steps to reproduce your issue)
> 
> 1. Create an untracked file and modify an existing tracked file
> 2. Run: git status --short -z
> 
> What did you expect to happen? (Expected behavior)
> 
> All status markers have colors disabled
> 
> What happened instead? (Actual behavior)
> 
> - Modified marker (`M`) appears colored
> - Untracked marker (`??`) appears *uncolored*

There is a bug here, but I don't think your expectation matches the
documentation. In the --short output, we do still respect color. We do
not for the machine-readable --porcelain output, which is also implied
by "-z" without another format.

So either of:

  git status -z --porcelain

  # this implies --porcelain=v1
  git status -z

will do what you expected. Asking for "-z --short" is a bit unusual,
since "--short" is meant to be human-readable and "-z" generally is not.
So I'd expect it to be used only for relaying colorized information to a
human over another channel or something.

But back to the bug. As you noticed, one item is colorized and the other
is not. I think the fix is probably this:

diff --git a/wt-status.c b/wt-status.c
index 8ffe6d3988..e12adb26b9 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -2042,13 +2042,13 @@ static void wt_shortstatus_status(struct string_list_item *it,
 static void wt_shortstatus_other(struct string_list_item *it,
 				 struct wt_status *s, const char *sign)
 {
+	color_fprintf(s->fp, color(WT_STATUS_UNTRACKED, s), "%s", sign);
 	if (s->null_termination) {
-		fprintf(s->fp, "%s %s%c", sign, it->string, 0);
+		fprintf(s->fp, " %s%c", it->string, 0);
 	} else {
 		struct strbuf onebuf = STRBUF_INIT;
 		const char *one;
 		one = quote_path(it->string, s->prefix, &onebuf, QUOTE_PATH_QUOTE_SP);
-		color_fprintf(s->fp, color(WT_STATUS_UNTRACKED, s), "%s", sign);
 		fprintf(s->fp, " %s\n", one);
 		strbuf_release(&onebuf);
 	}

which matches how other output functions like wt_shortstatus_unmerged()
behave (handling color before hitting the null_termination conditional).

-Peff
