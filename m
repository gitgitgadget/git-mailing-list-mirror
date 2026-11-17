Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794944003;
	b=j8C0SxWlbaugJALgAdwtAhGYNmZMTrqxrof3S8uM0giLUTp4lAzOTr2l2ijQQqKepUg8
	 fy2q66MPOEbU/yygxfJO7BDiBD/ZBhRSSkrEs3wWphPVEh6FF6ZUNYBbjScyuUnCSz0vA
	 8yKnpcRFvx1imxQQkW8vKGzlI7f9lAZo3OqKXcnfiqw3eY8Wtr5THcZKUXmbBGiiV3tPB
	 tltAjWUMD3YIDlL7qvGWn3O6UWI7bnPYcTAFCo5ad08CPL1ViywHQ6wnxIAUmKODbseOa
	 LmUcvExgPWJXSNQmTZfc82PqTSsIiF0byd+KICulTKRlSCNbHUBaIv//n29w8+E1sHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794944003;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=NaNGiAzc2gfajnpNme80uJsjDudFlB3Mrb85JyMfSJo=;
	b=RWFt1nJ85cJTG6dkNyIcNwKcTwiaN63HDXlPPDATGhW21gAr5mFsfdCMv5ClMuz60cQC
	 nlDmUSDgZZv9773x+pjn1AcA1qAZe9IgJ/o1QqXKCJh4RwG3eNFXx4GP8lTEXoYwEZ1UM
	 kDGWBkx6pRZ9DhNUnzRjq+JTBvIL7wkQke+5D2c/R7iJ10/vtM26pE0lrAMFC+NoJCfsH
	 y0VjCODJxFapqt1QkmlaRPwMqMsJoHimkW3F7B7eFQUlOhRi+Xe+P8HugGLFkgfFa/dIb
	 PGu5b5KxvASOuuF0rBStLhagrq6MvXUqCFQwbp0O59rXPlrB2LwlEPeChFk38F3+XvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b="dpw0js/G";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=qYqCJwg4;
	arc=none smtp.remote-ip=202.12.124.148
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E74606A890
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 19:33:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34E74606A890
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=dpw0js/G;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=qYqCJwg4
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 89A6E1D00216
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 14:33:22 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 17 Nov 2026 14:33:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794944002; x=1795030402; bh=NaNGiAzc2g
	fajnpNme80uJsjDudFlB3Mrb85JyMfSJo=; b=dpw0js/GXkZL9gKi5fPBUwlfhd
	vjsGuixfArZWFLLwbpJOkfMrIIhzyGQ4ycP7fXjbFbLbJw+3SgV04zfSY5gF6zBi
	JE5nLAO8wySAzoDjcfKWYAFXleIzf3DlEa3BvM1K5ms0vL5MvFr09mAJTdODkcIW
	1Iu1wBdfaQDk0in3v3gFWtl5flPXmiy+nfmTYTPVz9VXkXKns0L2pZLU+nnDeIwm
	f2vvbj9ykS++ErF2hBxL5KNCe1cCr95aMubymImw2ysfitTDWKmP3biHJwpoA6ef
	ORwc6v4wNw+krR5v4dCmQXK4++v/+Aflcu9PKU660OGpf+q6ygpC4Dln7T2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794944002; x=1795030402; bh=NaNGiAzc2gfajnpNme80uJsjDudFlB3Mrb8
	5JyMfSJo=; b=qYqCJwg4gQ43mU4AZAVdoZsYd7b9fAnd6b1luLt3bwP8X9ZYMXZ
	oFh9G5IzjPyQ5EVFckSobDzkDJxLjvFbJMyePNeERSSIrw9Lj9FgwYgjyV2F10NC
	8Hw57mZtsSQOPePCNGyKKcqwkjg4b0vn6yAU3fD8XRH3FXq1S0cRkBGtdL06KCB6
	HZeUVk8hZfBKRK+lKZzTb3uF+fRbJfmwrLf7vv+UVgeXFK9cZm6O4pIsSUwofeI1
	YO+EggBSa4i+RUNpcSkqc1go0axtZyfGR0KnkSp5u/LY+RwSF9Xavhk1rqJQY9j2
	Z227T5w5k2z13QRyFsuxEnpM7ykhmHMc3mA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794944002; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:oJy1IJVBHgog7f8qhJoQGTr25vZYqCQl/zzIKIHjIRWOtyb
	8xah5nNUB9meWP0f7gYbaFzccWjVYtMt03fY/ExOhizcQ06rJ2wJt+ZNdH8LU0gZ
	8DJq+d6NCph0F34GtMNDlNTCdwFqNNZP/Ch0fCGd/BeoP4XaQydRA6QiOGRzFy2T
	G2B6ApnpXFTafu3Wa1gN/02CWqL8y4wQJd65bWKZAW6nlVWvTZ1MSGgpUW2Q92a0
	yR5UOM7zEj1YTCfzyw3RGTRkhy4UISFrD+2vkXKypHZua89HUDuSzlShl9NyTBTG
	S+MeDE3N2ObfAxB+fqacPrdXmuv+hamz+R1dGGw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:kfAlB6jFtInO8tuRJY8PPzD08NRJnUIQF5FxyLyvmOs=:aeY8R7b9CLIFcmMTY9Te8OsM1vOLZi5MjMrK3zOf02Q=;
X-ME-Sender: <xms:Aqz8agWLMeQXclkc3rCTW8GN2oTEpktJrHCyMYq5Fk6tM6yPxc5oGA>
    <xme:Aqz8am2zaCkpsvRfUO9MXeu1DXCxVw3SpqZbqzm-f7s25k1n_owroWfDJXJb-zefL
    7ldCDjGgAcwRakbE5vjTZEGa3rRdvYPbD4Tjxdlkg1tc74GQjyRVzU>
X-ME-Received: <xmr:Aqz8amoviIzteySAv7CF968KF2enACopm9ddNFVvmxXyqMgql3zHEEUGd5hXb5eXPmSZsVFzJVyx4cRU_h0Yg-7pNQ3XA1A1qEMv>
X-ME-Proxy-Cause: dmFkZTGDKcCWFUt/OsLeyUCGoWcsoGySPLoe7JijISdLMXS0w6dnGqj/jFZ1DfKq6P39AE
    j2LvAqrqAdp7vGiCLqERxZaNJ/9SR3ha2GC/SLGAPjd+VUZc1OjuL3ad9R40X6JABclS8X
    GFSrjvzEDY8Ea32QL3kAyLuxjrbk7OUEnJoSGWv7EZz+9kT+D2+lGZeGThsV0uX8IwQXWk
    NG/dN0k5ajQ5ifzjksP3V87wsCuBIpOc9QbGoIwB+2VtklAaUEC+RVE+ztbeAympgCGfUd
    Q1wfhZ2KUfx2GkABHNvrTj8i9qRV/fLMpOsevmfIewfEofCV2wVjW2pxCl7wCIVGXMx5Q2
    rJ0DZgyEKV1nHzDSkharjjXL/da4SXWgC5s51IqRTVsfi1/ik17CGe+RFKFquV3Asm8q/q
    NoHD1qKF4cYC3e5D8WfePZdG+VemWgqWPAp49xu29I34CflS5lIPQSC0IwFJgdaY4p/sof
    9YaKMmalPAV040qv6nQzX6qVdNCPcHAw3VaB4KEH0uhP+gjtStnxzOmYxzuAiaxN5COu7Z
    FFmJSuAH0UTW0RPLVCVpKjM6C/nCOUx0XXrenguVMZ9/dDHk7t+mBeBJzUBksWJXBVbJ3X
    xBOTb8AhGeVUCHjuu1MLm/oa8HTEZzXokDacJAWNl4RP602SzrBa2sarmWmw
X-ME-Proxy: <xmx:Aqz8alXa_GCvmqNDsel8cmsmgkdRz5zyZpjPjwC5Rhh8gyPbgGAw-Q>
    <xmx:Aqz8apYo4rtCY4VdVwW_EDZr2qeqNThughdF2wnhBy-M9vt4s3h67w>
    <xmx:Aqz8aqdrVwAefhDvT0Nln4dFVcxZZaazMoLD4hdXx92XYM9-1KpvYQ>
    <xmx:Aqz8ar07vzOt2AoTeBhHWHgvR0ZbfVe8yI2tOy_yJPtHe_j9N_SnIg>
    <xmx:Aqz8aqHqqX67xmz_wqrWdJkOyu-HZDzEZp24RFMxKikTHzdtr-tfsNKp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Nov 2026 14:33:21 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Elia Pinto <gitter.spiros@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
  Patrick Steinhardt
 <ps@pks.im>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/5] object-file: check size of inflated loose object
 against its header
In-Reply-To: <edb5f34498e91beb0480d9b6ac417602580b3016.1794914210.git.gitter.spiros@gmail.com>
	(Elia Pinto's message of "Tue, 17 Nov 2026 12:38:54 +0100")
References: <cover.1793355390.git.gitter.spiros@gmail.com>
	<cover.1794914210.git.gitter.spiros@gmail.com>
	<edb5f34498e91beb0480d9b6ac417602580b3016.1794914210.git.gitter.spiros@gmail.com>
Date: Tue, 17 Nov 2026 11:33:20 -0800
Message-ID: <xmqqbj7ndzi7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Elia Pinto <gitter.spiros@gmail.com> writes:

> unpack_loose_rest() allocates a buffer of the size given in the object
> header and inflates the rest of the stream into it, but it never checks
> that the stream actually produced that many bytes. If the compressed
> data ends early we return success with the tail of the buffer never
> written, and callers like odb_read_object() hand it out as object
> content. For example, "git cat-file commit" on a loose object whose
> header says "commit 200" but which contains only 44 bytes prints 156
> bytes of uninitialized heap memory.

Interesting.

We only inflate to read up to the first MAX_HEADER_LEN bytes, and
that is sufficient to read "<type> <len>\0".  unpack_loose_rest()
first prepares a buffer that is <len> bytes big, copies the
remainder of the header buffer to it, and then goes into a loop to
fill the remainder of the buffer with the remainder of the zlib
stream inflated.  The condition to terminate the loop is for
git_inflate() to return something other than Z_OK, and we are
protected from the case where the deflated payload inflates beyond
the prepared buffer (i.e., the malicious or broken object file claims
it is smaller than the inflated data, attempting to cause a buffer
overrun) because we would stop the loop with Z_BUF_ERROR, which
signals that we prepared a buffer that is too small to receive the
payload.  But git_inflate() may return Z_OK without filling all of
the buffer we prepared (i.e., the malicious or broken object file
claims with <len> that it is larger than it actually is), and we did
not check for this condition.

> The opposite case slips through, too: when the whole object fits into
> the buffer filled by unpack_loose_header(), we copy only "size" bytes
> out of it, the stream has already ended, and the extra data is silently
> dropped.

In other words, when the object file is inflated into a buffer that
is MAX_HEADER_LEN bytes long, "<type> <len>\0" may be 10 bytes long;
MAX_HEADER_LEN is 32 bytes, so there can be up to 22 bytes of
payload already inflated in the same header buffer.  If "<len>" says
that the payload is only 10 bytes, even though it actually inflates
to 15 bytes, we happily copy the 10 bytes to the final buffer,
ignoring the remaining 5 bytes without even noticing.

> The packfile reader in unpack_compressed_entry() and index-pack already
> compare total_out with the expected size. Do the same here and report
> the object as corrupt if they differ. Today fsck notices the first case
> only by accident, because it hashes the uninitialized bytes and gets a
> mismatch.

;-)

> Teach loose_obj() in lib-loose.sh to write a bogus size, so that the
> tests can create such objects.

"lib-loose.sh" -> "t/lib-loose.sh" for clarity.

Nicely spotted.

> diff --git a/object-file.c b/object-file.c
> index e04ce0bc11..5d03ae94c7 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -212,14 +212,14 @@ void *unpack_loose_rest(git_zstream *stream,
>  			void *buffer, unsigned long size,
>  			const struct object_id *oid)
>  {
> -	size_t bytes = strlen(buffer) + 1, n;
> +	size_t hdrlen = strlen(buffer) + 1, bytes, n;

Earlier, "bytes" here was initialized so that buffer[bytes] points
at the first byte beyond the terminating NUL in "<type> <len>\0".
The parse_loose_header() function, which our caller has called to
find "size", guarantees that the terminating NUL exists, so it is
safe to call strlen().

Now we have a dedicated variable hdrlen that gives the length of the
header, including the NUL at its end.

>  	unsigned char *buf = xmallocz(size);

We allocate <len> bytes (in size) for buf[] for the payload.

>  	int status = Z_OK;
>  
> -	n = stream->total_out - bytes;
> +	n = stream->total_out - hdrlen;
>  	if (n > size)
>  		n = size;

The arithmetic is the same here as before.  n gives us the number of
bytes from the real payload we already have when we inflated the
header.  If that is larger than size (i.e., <len>, which the object
header claimed to be the size of the payload), we limit n to that
size.

> -	memcpy(buf, (char *) buffer + bytes, n);
> +	memcpy(buf, (char *) buffer + hdrlen, n);

And we copy the first part of the payload data out of the tail of
the header buffer to the beginning of buf[].

>  	bytes = n;

Here, as before, bytes keeps track of the number of bytes of the
real payload added to buf[].

>  	if (bytes <= size) {
>  		/*
> @@ -244,7 +244,14 @@ void *unpack_loose_rest(git_zstream *stream,
>  		}
>  	}

Before this point, we have an "if" block that reads more data from
the zlib stream after the initial part read by unpack_loose_header()
into buf[] until it fills up or until the zlib stream finishes,
whichever comes first.

Thanks to the condition of the "if" block covering the bytes==size
case, we would have made sure we called git_inflate(Z_FINISH) even
when we had all the payload bytes inflated into buffer[] by the
caller's call to unpack_loose_header().  So we can rely on status
being what we got from git_inflate().  And we are not going to bust
the end of buf[] because stream->avail_out keeps track of the
remaining space in buf[].

> -	if (status != Z_STREAM_END) {
> +	/*
> +	 * Make sure that the stream produced exactly as many bytes as the
> +	 * header claims. Otherwise we would hand back a buffer whose tail
> +	 * was never written (if the stream is short), or silently drop data
> +	 * (if the stream is long but ended before we noticed).
> +	 */
> +	if (status != Z_STREAM_END ||
> +	    stream->total_out - hdrlen != size) {

So a successful inflation of the payload should give us Z_STREAM_END
and total_out being the same as the sum of the payload <len> (aka
size) and the header length (aka hdrlen).  I might have written the
latter as

	stream->total_out != hdrlen + size

but that does not go beyond personal preference, I guess.  What I am
saying is that I see this patch is doing exactly the right thing.

Looking good.  Thanks.
