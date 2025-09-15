Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0A1A927
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 02:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757904394; cv=none; b=u/6Eu6F8a0MxNsNamnDcdojvP0PuuPkKD4PxlBIcctyAajboKGyhX1soMRPYkHMmL40ceP3+MYLmo5r5XQRPE2CqBnXNIRYt19w51hf6cux5daRwPxVk6PqisunKmH66h6tgsdtGuIePKA3naxcjwPYlPTkh+5vaqY3GcXRQOxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757904394; c=relaxed/simple;
	bh=ZXbz4vc6Ok1JAAKORmosP3LqXBNGi02L2iycsebyjGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p2NlKSgXhgKZkAuSB3+9H/yB3em6NKe0nclHzmlPqfg0QlMusWIY6mFpwOY12rw+I3Asgg2Ngd106+Rj/MNXfCcWNb2fa9+T1u3RQm40B8suoqVKbk5+dArdKCn3VF93/AX3TUYNWpWzuyiMk6or304RHcR77BOGDuvAfgS10Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Z9AU1cMt; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Z9AU1cMt"
Received: (qmail 83877 invoked by uid 109); 15 Sep 2025 02:46:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=ZXbz4vc6Ok1JAAKORmosP3LqXBNGi02L2iycsebyjGE=; b=Z9AU1cMtlLGdC+nuMXIkv5Uq4onraLyGN4LYCRUsJePdrZVX6dleuXK3YotlQYMZxF9gGJmnKjdcuMb13JajsMdogNtsGEghCteW5I6s1CR5A6fUIr9syy+Fe9tNK/kf7xyHqCDr3zVIjDRlUZuHqizvHBJqOvof3w8vxZzff+wwIG8H7wBuTpKSasCz90EXdSnv5haYnXA+OAw2iAqMrdVAAz6/kPovk+KM/+7oQDKrhio6+VbORPJ3fPPa4ncjfu0rR2aqhBWA5Zi8xXgw6XZpcs72o742rVC9fOU4vHRHWcFoesjIpsuvG4kkhEjRHmeBwkN4DTv0DpVLLqoePQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 15 Sep 2025 02:46:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 141093 invoked by uid 111); 15 Sep 2025 02:46:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 14 Sep 2025 22:46:31 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 14 Sep 2025 22:46:30 -0400
From: Jeff King <peff@peff.net>
To: Marc-Jano Knopp <y--gitbugs@marc-jano.de>
Cc: Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
	git@vger.kernel.org
Subject: Re: [SOLVED] Re: safe.directory does not work at all (git 2.39.5,
 2.51.0)
Message-ID: <20250915024630.GA595592@coredump.intra.peff.net>
References: <duuus2ifgydpwpja6vccvxbcnxdgy6mc6h63okzv7xdqo23fpi@ermurkhms4j3>
 <lamzerhpp6kbgzbhztgaqvdcymaqvec232sen67t6wx4rmobih@lqqivgroonmp>
 <hbghuae56gm6ypox6q34mt4q6awoeb3itxsnmgpouycn7qodch@4pjsh24jhmqs>
 <20250915022301.GA593748@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250915022301.GA593748@coredump.intra.peff.net>

On Sun, Sep 14, 2025 at 10:23:01PM -0400, Jeff King wrote:

>   - could upload-pack install a die() handler that prints the message in
>     an ERR packet? I worry a little that older versions of Git would not
>     handle this great, as I don't think they were always prepared to see
>     an ERR packet at any point. OTOH, it is probably better than sending
>     nothing, which is what we do now.

Just for fun, I tried the patch below on v2.39.5:

diff --git a/builtin/upload-pack.c b/builtin/upload-pack.c
index f446ff04f6..ad40143beb 100644
--- a/builtin/upload-pack.c
+++ b/builtin/upload-pack.c
@@ -13,6 +13,21 @@ static const char * const upload_pack_usage[] = {
 	NULL
 };
 
+NORETURN
+static void send_err_pkt_on_die(const char *fmt, va_list ap)
+{
+	struct strbuf buf = STRBUF_INIT;
+
+	/* format into a buf since interfaces below do not handle va_list */
+	strbuf_vaddf(&buf, fmt, ap);
+
+	/* write our ERR packet */
+	packet_write_fmt_gently(1, "ERR %s", buf.buf);
+
+	/* and then do the usual die to stderr */
+	exit(die_message("%s", buf.buf));
+}
+
 int cmd_upload_pack(int argc, const char **argv, const char *prefix)
 {
 	const char *dir;
@@ -38,6 +53,8 @@ int cmd_upload_pack(int argc, const char **argv, const char *prefix)
 	/* TODO: This should use NO_LAZY_FETCH_ENVIRONMENT */
 	xsetenv("GIT_NO_LAZY_FETCH", "1", 0);
 
+	set_die_routine(send_err_pkt_on_die);
+
 	argc = parse_options(argc, argv, prefix, options, upload_pack_usage, 0);
 
 	if (argc != 1)


The results are...not great. You get every message twice, of course,
because we still print it to stderr. Though that could easily be fixed.
But for the multi-line message in question, the "remote error" part is
hard to see amidst the other lines:

  Cloning into 'foo'...
  fatal: detected dubious ownership in repository at '/tmp/foo.git'
  To add an exception for this directory, call:
  
  	git config --global --add safe.directory /tmp/foo.git
  fatal: remote error: detected dubious ownership in repository at '/tmp/foo.git'
  To add an exception for this directory, call:
  
  	git config --global --add safe.directory /tmp/foo.git

Probably it would help to look for newlines and prefix every line with
"remote: or similar. But an even bigger problem is that we die
immediately on seeing the remote ERR packet, so we miss out on any local
error messages. An obvious one is trying to clone something that doesn't
exist at all. We used to say:

  Cloning into 'does-not-exist'...
  fatal: '/tmp/does-not-exist.git' does not appear to be a git repository
  fatal: Could not read from remote repository.

  Please make sure you have the correct access rights
  and the repository exists.

Noting that we saw an error from the remote side and giving some hints.
And the stderr from the other side is enough to give us the more
specific message (though again, over http the user would not get that
stderr message; however, if we get a 404 we do show a useful message).

But with the patch above we just relay what the other side says:

  Cloning into 'does-not-exist'...
  fatal: '/tmp/does-not-exist.git' does not appear to be a git repository
  fatal: remote error: '/tmp/does-not-exist.git' does not appear to be a git repository

which seems worse to me.

So probably not a very productive direction. Oh well.

-Peff
