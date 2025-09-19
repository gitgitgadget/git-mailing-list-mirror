Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3251223741
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 04:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758255955; cv=none; b=qCGcJgyNAWI/nFTxRUq4yDlib6Nf54BXYAocxLmCmJx/JGJDUR33+ME6BdZk54zPNmHLHeE9mURvf/4czKpu8SrEeko/LkEU1UawlopjCw5uTQRPXYAJaRkeVnrWinkBxRr8UDK3rG/vvKafGBmxZYyAx2EvqaTk1XV/dDGvZGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758255955; c=relaxed/simple;
	bh=Rjv/3Y9udJhP7Jk2qM2cyVPsJ/x/ApqB+1qMSb53ydI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EdAGNNAQyVmgcwKhBbSTHpKVO662+wvCRMU0faB9JeGBBaeyLPfcsWw/Ys2txkM0jFJcY4imuHV5msOxvDacM9/zgWQRCIFA3mv0agl5OWoeBFpps2oXT7GaamepCtmQHw8M6TXu4QsFQ3W6WQCt/uXv0EVQHqjKzDK5tqs6DZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Fe+u1qfP; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Fe+u1qfP"
Received: (qmail 126809 invoked by uid 109); 19 Sep 2025 04:25:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Rjv/3Y9udJhP7Jk2qM2cyVPsJ/x/ApqB+1qMSb53ydI=; b=Fe+u1qfPvyvbM8/pLckKGvMTs1TdBXkuV7VPXgQSQWFQEPdgLHLfwFXF1AXm1dEbKHQwi8nMj64T3sV5JKV1144yjoMB5V6asPS3jceb21nc/NAY/R3lzHlpVRQXaVFIU3J4oYf2In8iXUEL5G9XBjB4Gl/qq5T8dPCbWBcw0+Z0cTQd1b8tqdM+FGMmUmg2RdaDgvOvd68X1ATqPo7xWbfXAH+PnPZIsqax2/yZtCb1mvT1QgokC6xeSmTabFjChxv3A7HeQxHcZyHgLq3RW5Ml8q5YLQoLGI8Yx90+Yo07wOqKZ+p7aKlBk7Oif81dHXduG905R6owZwHxxEav0g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 19 Sep 2025 04:25:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 201331 invoked by uid 111); 19 Sep 2025 04:25:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 19 Sep 2025 00:25:45 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 19 Sep 2025 00:25:45 -0400
From: Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH 0/2] doc: git-push: clarify section
Message-ID: <20250919042545.GA3979@coredump.intra.peff.net>
References: <pull.1973.git.1758144815.gitgitgadget@gmail.com>
 <aMymMLkJg7PkmxL7@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aMymMLkJg7PkmxL7@fruit.crustytoothpaste.net>

On Fri, Sep 19, 2025 at 12:39:12AM +0000, brian m. carlson wrote:

> In this case we have two possible implementations, AsciiDoc and
> Asciidoctor, but both use the man macros.  I think if there were some
> way to control the value generated as the argument to the `.RS` macro,
> then that would be what you want, but I have no idea how to adjust that
> in either one.  Personally, I would just leave it as it is, since I
> believe 4 is the traditional value used with the man macros, even if
> typographically or aesthetically it might be suboptimal.

I think both implementations will just generate XML via our Makefile,
and ultimately it is DocBook which will convert the <orderedlist> into
actual roff. So something like:

diff --git a/Documentation/manpage-normal.xsl b/Documentation/manpage-normal.xsl
index beb5ff8ec2..b494fbb5df 100644
--- a/Documentation/manpage-normal.xsl
+++ b/Documentation/manpage-normal.xsl
@@ -11,4 +11,6 @@
 <!-- unset maximum length of title -->
 <xsl:param name="man.th.title.max.length"/>
 
+<xsl:param name="man.indent.width" select="2"/>
+
 </xsl:stylesheet>

would affect that process. And I think there might even be a specific
list-indent variable, but I didn't dig very far. I agree it's probably
not worth going too far into the rabbit hole of manpage styling. The
parameter docs are here:

  https://docbook.sourceforge.net/release/xsl/1.78.1/doc/manpages/indent.html

I believe Asciidocttor _can_ generate roff directly, but we don't use it
that way. I don't think it would make sense to do so unless we are ready
to drop AsciiDoc support entirely (since keeping them as close together
as possible reduces the maintenance burden).

-Peff
