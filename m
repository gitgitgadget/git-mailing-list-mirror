Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291E032145E
	for <git@vger.kernel.org>; Fri, 12 Sep 2025 17:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757698665; cv=none; b=cY3SeCbiJ2Upm5KEU8r1rqvCdvQVVrEQSeGydBB9/VFJlwQHpO641ApA9IbUjB69C9uPyUTVGkDuXEOwi9irMaOhOIJfC9kXsK4Km2FR6UYQ1Nq/qnaeRFJ11qq4Fn2e/g4zcKgd/HbgyPuQED9+5/gBFfs9a9Fd3rFpLKPytMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757698665; c=relaxed/simple;
	bh=pJtsXOmXLL69WAZF3kUZYVdVHTlnngAS3hnhZo9wSeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZOTCCjSJko8OMQqRCzJS5R/MVgkmJZm/2RNL25n6y1fVNobcgmtVPJYJomle6Dtmx9nINrAH6ET+arS/QXEiLrHhAuFerdgGtEStURNo85WN1OzmeWj9oV5NaTRSTFB4Njlz+DfS/I5/D4sa+gEXGSyp4bXkbnBEutIkqBtxSB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VouK4KRR; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VouK4KRR"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-745a415bf72so859701a34.2
        for <git@vger.kernel.org>; Fri, 12 Sep 2025 10:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757698663; x=1758303463; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xY7n2pepW1hDciaF8IdkxXHZCM0Ov1ry6l79N54rRtc=;
        b=VouK4KRR43go1d+S9GzGoonTxK/i2+1daIdlhWmLdw8mxWijGW4NxHnt/oLxdghHxJ
         sU6zQPFCkHMtjQwDVspM57FI/dCrwcmtO64mNT4aH0MUW4GITFy+mC0RjMqYE31mB98e
         Y0qztsLES/Y+VsqhA7pAxUK58Of+4ZEf7ws7/DF5jDuSseCJFCwsS271rViwsXC09SVI
         6GZFWiPgdbV/IrcgPBDbE8e3SPKohEauReZxgrhO91/NVrSFMyMJYlydafje3+bTpeqC
         kasH5v68nb4IwxaVbjLn2Pgy8ypv4iIhhLnMfa1hjgN64yE1pG8xiPmnSuUMsC8IT/g2
         Kb1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757698663; x=1758303463;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xY7n2pepW1hDciaF8IdkxXHZCM0Ov1ry6l79N54rRtc=;
        b=LndXnojeMpMunzj9ireUe64OK1AOLtTSgx5Sn2cu74gWczSBC/9thuYsdzoACset9n
         snW1gK6rQYgWpoVZZNwpnR0GdcgF2akp0rVkpeN5ZIx2ffS5WVYFotgk+onnwKGiSOz+
         BzPp+gejOheaevKteXvkB3KJlBZsgY9O2xmxP90ixGDMS2cXNb8zowVePLF4BlPp24E3
         JUpaHJHtS9b0R1lf/xAjbaZ/Jpnv9tQeQNH1nVbhV6aZhG3HUvRgxOUXTaHTu5fm1B3I
         uvD8kgkoZHOtfkWlDx0lklS/LHMVpOEbZTKskIOMILBYN1IEFILcBiNCt5tjoGNUjcGW
         xLlQ==
X-Gm-Message-State: AOJu0YzFrsUQ250YLyfCKkVmKtaNi0eYDW/ucu+ny2hXA2eZTZuC2GcP
	9eUvAPZfa4T2/Sp4KaxeG+VbvSHwnEWkf/R/Ml9UErxsUZQnKNNMjki4ZUKJ5Q==
X-Gm-Gg: ASbGncucSP3EusrcEjKeczEzHF/TFp8fKwgxOxPAjH5iMVlqve0RDAxLXszIycizvbE
	73RE717Gf0wfN49t/9d8nn2HKtnKLCz1KHNnhdId90aVKmOByxhpsaksWk6pE6aoOXV1lWt8niR
	nB1WZ+kTtEx+iqB8E1+dx2Nj2HIGmipU0G8icB1u8QHsajRn3lvMaYV9YWT52m/Xz6cG2u9cYkh
	WlRbP42bo7Cs7HCbB9M3nxwc52vITrPx44QJU+zbnIvzCE3FgAD5HbdCNTXh57hXffXiib1YXjK
	EgDiqUQoiHNGC/KRCbCz9Ubpp/jP7ky8gW0jSiBUMVm2ddrgo9sJwN/C1yP1OUBR7uGFzuitJ8n
	XvPzsY7EPp00kZORuCItFmhuMa0NOfdq9EE0oEQ==
X-Google-Smtp-Source: AGHT+IGP1pa1FPKkwLvRMN/9+f0V1mhdmNzTIz5NKdEUd449WYocBqLzPCfsb7ij7fkHwW1eLkfIhQ==
X-Received: by 2002:a05:6808:18a1:b0:43a:81be:b702 with SMTP id 5614622812f47-43b8d8e58e1mr1724806b6e.20.1757698663003;
        Fri, 12 Sep 2025 10:37:43 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-43b82aff516sm896819b6e.31.2025.09.12.10.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 10:37:42 -0700 (PDT)
Date: Fri, 12 Sep 2025 12:37:41 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] bundle-uri: do not abort on invalid packet line
Message-ID: <yqyn5w6oq47lhrcbuziip5tajzrpylirswr5kyfyu35n3k7vgj@jn4rc7cwqwow>
References: <20250912-b4-toon-bundle-uri-no-uri-v1-0-f4525a406df8@iotcl.com>
 <20250912-b4-toon-bundle-uri-no-uri-v1-2-f4525a406df8@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912-b4-toon-bundle-uri-no-uri-v1-2-f4525a406df8@iotcl.com>

On 25/09/12 06:46PM, Toon Claes wrote:
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
> This error doesn't cause git-clone(1) to abort, because the return value
> from `transport_get_remote_bundle_uri()` is ignored in
> `builtin/clone.c`. This should allow the clone to continue *without* the
> use of bundle URIs.
> 
> Although when cloning over HTTP, the following error occurs after the
> above error messages:
> 
>     fatal: expected 'packfile'
> 
> This is happens because there remains unprocessed data from the
> bundle-URI negotiation.
> 
> Fix the error by continuing to read packet data when an invalid
> bundle-uri line is received.

Is there any reason that the server should be expected to invalid data
to the client? If the server is misconfigured, I wonder if it should
instead handle this issue by not sending the invalid bundle-uri in the
first place and printing a warning message on the server-side. From
client perspective, if it's a server-side issue there may not be much
they can do about the error and it could cause some confusion.

> Signed-off-by: Toon Claes <toon@iotcl.com>
> ---
>  connect.c                   |  4 ++--
>  t/t5558-clone-bundle-uri.sh | 25 +++++++++++++++++++++++++
>  2 files changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/connect.c b/connect.c
> index 8352b71faf..d2e2bd8cce 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -536,8 +536,8 @@ int get_remote_bundle_uri(int fd_out, struct packet_reader *reader,
>  		if (!bundle_uri_parse_line(bundles, line))
>  			continue;
>  
> -		return error(_("error on bundle-uri response line %d: %s"),
> -			     line_nr, line);
> +		warning(_("ignore invalid bundle-uri response line %d: %s"),
> +			    line_nr, line);

If I'm understanding correctly, an error here indicates some sort of
issue between the client and remote Git server while figuring out the
bundle-uri capability. I think it is reasonable for the client to always
expect the server to communicate in a way it understands and IMO should
probably be handled by fixing the server-side instead.

-Justin
