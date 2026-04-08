Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538218462
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 17:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775670594; cv=none; b=JXDlVfgVkzfIOQHd5AR2HNPCXHw4rdU5FRzjQ8gTVd94MzYN8l6t0V5X9OzSQZdO+0mpz5G7N21tETxbnwD74to1ldpLTzIDiFK167QkMDKdsb3aeXikp/c7y7ZH+XCenxgv0oeDGNjDTvj/nfXJYgodL/kbmlKq/XZgYx8hRjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775670594; c=relaxed/simple;
	bh=O/SAJ6wmdG472tqDBD478VVlOMOneQjUneVWRtrlU2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=okeQfm9psIjO/QillKxGLsI6/p/wCptf8rVwFPGpFSwlnoB0pZB0WihLdkZMUq6wmpC/dNmXEk7nuiceP3pmVsy34+9hvOcwo8tsnprtB5DG0vrtmyRWkbswLzwFhJcaZZeeWACru92ygONKVGUuRk7SPvuuVUl6OzObV7r+f40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OQXaPaey; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQXaPaey"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-67c250805ccso9224eaf.1
        for <git@vger.kernel.org>; Wed, 08 Apr 2026 10:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775670592; x=1776275392; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bXbsneQBw+mzm9+IrTqqIqZfhXeBqa5coKkCPzlqAf8=;
        b=OQXaPaeyeMcuBGNGsg5izXDr8p76r4cyIpE22nRevPBdHAhdDe6X7nfvt9TCQkYSFY
         ELzYvQzWjnO24jDPi5eUw332RSc0+cyk7/zL2i2mw/LOl3OK1KjMbce2N5Wq/a073jZ9
         dzzqYBqNqI0SWu6EHLiDm9WETraCe3rdRJlhlOBorti5YLlSamIAPZNcTSfx4xWnCR/u
         1Gzgc84/RAVo5XheEuGZ2jyyEmfKNeuov0xm0f+2gnHOiUOY/+BWirVyJUdI9i/A7ffm
         sytu4B6JB8PHz0jLFQPLuUHynPKskMOag8MAP+iWi+di4rU319dwxkuD8+qd5/YvKkYe
         1d6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775670592; x=1776275392;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bXbsneQBw+mzm9+IrTqqIqZfhXeBqa5coKkCPzlqAf8=;
        b=kMhe4NjaNFwQvalLXZYmiud/HODW+QwehsXJSTX/xRmGf+kfxWMzyvB2oYlEEqvVsC
         m6vsbJcNYV4VaszjdLo75OKYTsu/TAAJuHoi0QV/+VmMQ3X2xdxRImXA4N+n6Bf5Cyoi
         JV4HWcb5kCd8FnPDAp4rdocNYR0iSD9dhda6Qmqz6ZW7xM1L5h66k5W7oHv7DtFj7AkN
         dfrfjU9OTyUZvyThkaDu5WjgHycL0x2Z34Inrhimto1Bx0wO0FyXDB3FVdiSv1p7cDC1
         rAT7QRp6JIxLsvUSQfE6ni8qPmXCXTdY7cLTBZ1CsyAuZpd0MNBzVkrJYV3JyLE6uyhg
         Sjpg==
X-Gm-Message-State: AOJu0Yxps5xu+wmAnBqylNSq77z7/f5cO8Kh8ibYqpi3k/yVYNtZhCzV
	EtmtAac43fQSI3f572/s5bs6RF2/I4If7YAnILpMycMtP4BkXIDCQDawLYnYgw==
X-Gm-Gg: AeBDievp5BlEJM7m1d5pwEa/yHIlgi/R5TC+FIp5uoMjCKB0CPdck6lbOwX9Y3/m17c
	r7p2HggNuY/pu8zqUEh3z+r7+sXy19G02a0srJi1+tNffH7RDKa4ofhJSNa000QS4Nfj09FlUcx
	Ym3PdU0WKCj5KG54pRHYnxw/z/g64/L23mG3YnjUyjZl+VMDP5/s00VsRfQLzVIwMgcrVPYl3/Z
	Wldr48sLF8YIuTWbI7Ac2Yhe0Tu5yBeJalPvtfsOTMQyhdxU+W4I5Y6dC+w/rSk8moFGzObBUEd
	6hCI5oD6KkNoFE4ka9s/DGr3g+pXkqmF/I2LlTtbU0zJ1WBv7sZllHBwiHerkAVqBJhyJ4s2Su4
	NhQ9Vthli4egvICLMXtcUt8EK61ZwoYKrx/odGmZdDROEhWYBO7UsdcRl/XEbIa8Bzh5Uv6DR/b
	r6MfTVaSO1xQSw9sTR
X-Received: by 2002:a05:6820:1885:b0:688:9956:d4df with SMTP id 006d021491bc7-68a6454875cmr250316eaf.43.1775670592086;
        Wed, 08 Apr 2026 10:49:52 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-680a63c7fd1sm12078286eaf.8.2026.04.08.10.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 10:49:51 -0700 (PDT)
Date: Wed, 8 Apr 2026 12:49:48 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] bundle-uri: drain remaining response on invalid
 bundle-uri lines
Message-ID: <adZ6yyGsoyjm7t0Q@denethor>
References: <20260408-toon-bundle-uri-no-uri-v1-1-d4a0e3937eba@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408-toon-bundle-uri-no-uri-v1-1-d4a0e3937eba@iotcl.com>

On 26/04/08 10:58AM, Toon Claes wrote:
> On clone, when the client sends the `bundle-uri` command, the server
> might respond with invalid data. For example if it sends information
> about a bundle where the 'uri' is empty, it produces the following
> error:
> 
>     Cloning into 'foo'...
>     error: bundle-uri: line has empty key or value
>     error: error on bundle-uri response line 4: bundle.bundle-1.uri=
>     error: could not retrieve server-advertised bundle-uri list
> 
> This error is bubbled up to `transport_get_remote_bundle_uri()`, which
> is called by `cmd_clone()` in builtin/clone.c. Over here, the return
> value of is ignored, so clone continues.

Ok, my first thought here is whether we _should_ be ignoring the errors
here. Bundle-URIs are indeed an optional feature, so if for example the
client were unable to retrieve the bundles advertised by the server it
certainly would make sense to skip over them and continue with the
clone.

But, from my understanding the problem here is that the server is
configured in an invalid manner and sending this invalid bundle-uri
"key=value" pair to the client. This is all part of client-server
negotiation for the bundle-uri feature. Why would a server want to
knowingly advertise the invalid bundle-uri info to the client in the
first place? It seems to be that server is misbehaving by not following
the expected bundle-uri negotiation protocol and _should_ know better.

Despite this, it may also make sense to make the client more resilient
to a misbehaving server.

> Despite this, it still dies with this error:
> 
>     fatal: expected 'packfile'
> 
> This happens because `get_remote_bundle_uri()` exited early, leaving
> some unprocessed packet data behind in the read buffer. This is
> misleading to the user, because it suggests a problem with the packfile
> exchange, when in reality it's caused by a misconfigured bundle-URI on
> the server-side.

This is certainly confusing, we should either immediately error out with
an error indicating the server is sending an invalid response, or
properly allow the clone to continue if we want to ignore it.

> Fix this by continuing to read packets when an error was encountered,
> but without processing the remaining lines. This drains the protocol
> stream so no stale data is left behind and the caller can use it if they
> like.

Ok.

> With this, clone now continues successfully if invalid bundle-URI data
> was sent by the server. This is intentional, because since the inception
> of `transport_get_remote_bundle_uri()` in 0cfde740f0 (clone: request the
> 'bundle-uri' command when available, 2022-12-22) the return value of
> that function is ignored in `cmd_clone()` so the clone can continue
> without bundles.
> 
> Signed-off-by: Toon Claes <toon@iotcl.com>
> ---
> This patch is a leftover from [1]. In that series I've submitted two
> patches. Because that series was submitted a long time ago, I'm
> submitting this as a new series.
> 
> The first patch is in meantime superseded by [2], and thus is dropped
> from this series.
> 
> The second patch fixes a misleading "fatal: expected 'packfile'" error
> that occurs when cloning over HTTP from a server with misconfigured
> bundle-URIs. It is modified to address Junio's concerns[3]:
> 
> > I tend to agree.  Instead of papering over a misconfiguration, it
> > would be better to let the users know, so they have a chance to
> > report and/or correct such a misconfiguration.
> 
> To reiterate, in the previous series I changed the error() to a
> warning() and Justin and Junio both didn't like this. In this series I
> didn't remove the error(), but instead I'm ensuring the read buffer is
> flushed before get_remote_bundle_uri() exits. This leaves a clean state
> behind and clone can continue. (more details in the commit message).
> 
> In reply to that other series, Justin also insisted to implement a
> server-side fix when bundles are misconfigured. I'm currently on the
> fence about this, because I don't have a good idea how to address this.
> I see a few options:
> 
>  - Emit a warning on server-side: Personally I don't think this is a
>    good idea because this might just end up in the logs somewhere, and
>    no one might ever read them and they would just make the logs
>    explode.
> 
>  - Exit the upload-pack process: I like this even less. Bundle-URIs are
>    considered to be optional by design. Breaking clone operations
>    because of a misconfiguration of something optional is too drastic.
> 
>  - On the client-side, read the return value of
>    `transport_get_remote_bundle_uri()` and exit the clone in case of
>    error: This would make the user a lot more aware of the error, and
>    that would encourage the user to inform the server admin to fix the
>    issue. But that breaks their clone, and they cannot continue doing
>    whatever they wanted to do. Their only option to continue is to
>    disable the config transfer.bundleURI, but that's cumbersome.

From my understanding, the root of the problem is that the server is
sending a bundle-uri "key=value" where the value is empty. An empty
bundle-uri value is an invalid configuration and is causing the client
to misbehave. Wouldn't fixing the problem on the server-side be as
simple as not sending the invalid bundle-uri "key=value" to the client
in the first place?

Naively, I would assume the easiest way to fix the issue on the
server-side would be the following:

--- >8 ---
diff --git a/bundle-uri.c b/bundle-uri.c
index 3b2e347288..96d38bb80f 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -946,7 +946,7 @@ static int config_to_packet_line(const char *key, const char *value,
 {
        struct packet_reader *writer = data;
 
-       if (starts_with(key, "bundle."))
+       if (starts_with(key, "bundle.") && value && *value)
                packet_write_fmt(writer->fd, "%s=%s", key, value);
 
        return 0;
---- >8 ---

A quick check using the tests provided in this patch seems to show them
passing with the above. If we want, we could also have the server print
a warning on its end regarding the missing value too.

> Because bundle-URIs are optional by design, I believe the changes in
> this series are sufficient. Also, the series [2] takes a similar
> approach: have the client gracefully continue in case of misconfigured
> bundles.

I'm still largely of the opinion that a server-side fix should be
implemented first. Unless we really don't care that a server may
advertise invalid bundle-uri info to a client, making the client ignore
the error doesn't address the root of the problem. I don't see a good
reason why we would want servers to keep doing this anyways.

To be clear, I'm not against also making the client more resilient since
a "fixed" client may still try to talk to an older server that still
misbehaves though.

> [1]: <20250912-b4-toon-bundle-uri-no-uri-v1-0-f4525a406df8@iotcl.com>
> [2]: <pull.2134.v2.git.git.1766160106521.gitgitgadget@gmail.com>
> [3]: <xmqqbjnfmvwo.fsf@gitster.g>
> 
> Greets,
> Toon
> ---
>  connect.c                   | 10 +++++++---
>  t/t5558-clone-bundle-uri.sh | 25 +++++++++++++++++++++++++
>  2 files changed, 32 insertions(+), 3 deletions(-)
> 
> diff --git a/connect.c b/connect.c
> index a02583a102..e323455d3b 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -517,7 +517,7 @@ static void send_capabilities(int fd_out, struct packet_reader *reader)
>  int get_remote_bundle_uri(int fd_out, struct packet_reader *reader,
>  			  struct bundle_list *bundles, int stateless_rpc)
>  {
> -	int line_nr = 1;
> +	int line_nr = 1, err = 0;
>  
>  	/* Assert bundle-uri support */
>  	ensure_server_supports_v2("bundle-uri");
> @@ -536,10 +536,14 @@ int get_remote_bundle_uri(int fd_out, struct packet_reader *reader,
>  		const char *line = reader->line;
>  		line_nr++;
>  
> +		/* Do not parse if an error was encountered */
> +		if (err)
> +			continue;
> +
>  		if (!bundle_uri_parse_line(bundles, line))
>  			continue;
>  
> -		return error(_("error on bundle-uri response line %d: %s"),
> +		err = error(_("error on bundle-uri response line %d: %s"),
>  			     line_nr, line);

Ok, with this change we continue reading input even when an error in
encountered and thus allows the clone to continue. It looks like we will
do this for any parsing error not just an empty bundle-uri value. This
may be fine though.

>  	}
>  
> @@ -554,7 +558,7 @@ int get_remote_bundle_uri(int fd_out, struct packet_reader *reader,
>  	check_stateless_delimiter(stateless_rpc, reader,
>  				  _("expected response end packet after ref listing"));
>  
> -	return 0;
> +	return err;

Earlier it was mentioned that callers of this function ultimately ignore
its errors. I wonder if we should tighten the error handling here and
have callers fail on any error. We could make it so any error caused by
an empty bundle-uri value is handled internally here, but still returns
0. This allow us handle the specific known server error, while providing
a more useful error message to clients otherwise. This may not really be
worth it though it we just want to always ignore any client side errors
due to bundle-uri.

>  }
>  
>  struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
> diff --git a/t/t5558-clone-bundle-uri.sh b/t/t5558-clone-bundle-uri.sh
> index 7a0943bd36..514cc881b6 100755
> --- a/t/t5558-clone-bundle-uri.sh
> +++ b/t/t5558-clone-bundle-uri.sh
> @@ -1302,6 +1302,31 @@ test_expect_success 'bundles with newline in target path are rejected' '
>  	test_path_is_missing escape
>  '
>  
> +test_expect_success 'bundles advertised with missing URI' '
> +	git clone --no-local --mirror clone-from \
> +		"$HTTPD_DOCUMENT_ROOT_PATH/no-uri.git" &&
> +	git -C "$HTTPD_DOCUMENT_ROOT_PATH/no-uri.git" config uploadpack.advertiseBundleURIs true &&
> +	git -C "$HTTPD_DOCUMENT_ROOT_PATH/no-uri.git" config bundle.version 1 &&
> +	git -C "$HTTPD_DOCUMENT_ROOT_PATH/no-uri.git" config bundle.mode all &&
> +	git -C "$HTTPD_DOCUMENT_ROOT_PATH/no-uri.git" config bundle.bundle-1.creationToken 1 &&
> +
> +	git -c transfer.bundleURI=true clone \
> +		"$HTTPD_URL/smart/no-uri.git" target-no-uri
> +'

Ok, from my understanding a remote repository without any bundle URI
configured doesn't trigger the bug here. So this test would have also
passed before this fix. Makes sense to add still though.

> +
> +test_expect_success 'bundles advertised with empty URI' '
> +	git clone --no-local --mirror clone-from \
> +		"$HTTPD_DOCUMENT_ROOT_PATH/empty-uri.git" &&
> +	git -C "$HTTPD_DOCUMENT_ROOT_PATH/empty-uri.git" config uploadpack.advertiseBundleURIs true &&
> +	git -C "$HTTPD_DOCUMENT_ROOT_PATH/empty-uri.git" config bundle.version 1 &&
> +	git -C "$HTTPD_DOCUMENT_ROOT_PATH/empty-uri.git" config bundle.mode all &&
> +	git -C "$HTTPD_DOCUMENT_ROOT_PATH/empty-uri.git" config bundle.bundle-1.uri "" &&
> +	git -C "$HTTPD_DOCUMENT_ROOT_PATH/empty-uri.git" config bundle.bundle-1.creationToken 1 &&
> +
> +	git -c transfer.bundleURI=true clone \
> +		"$HTTPD_URL/smart/empty-uri.git" target-empty-uri
> +'

This test actually exercises the problematic scenario.

-Justin
