Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CDA35C698
	for <git@vger.kernel.org>; Sun, 11 Oct 2026 23:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791759960; cv=none; b=sogc94DNwfXztih0PEE8AdHbqaUZzIWqdpoMR8xQNN0zMD0AI10JhOUHh+d8UiXUXXjo+M/HCE+QS3/E3h4yS7hMDeCkLDOufb2y124y7hHTZC1sYfjMgBS+Ooy75EaZwEkTqNiszHxkVewxbeTsEYOmFdo8zewLye5VlbP7ayU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791759960; c=relaxed/simple;
	bh=byOcUWfI1FdikvZNo0hdxii+1X/eV6wthy+ayOAfvaQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qTrndGCbYOa/bR/2PYROVrtwHeHQI5eKb/iJAuhC9QKvvKaeMPtS4UvkNumGNIossX7IGxWP+kiAS5czmbRgldkX+EmD8jX3ip9Ji4LrcIoaukmE8GUt1ux3DCee/AiIA2oL5wnY6iXkDgS6Zf0jTM/YcpDLNyLnrmXQEx3RWgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=h+xBdXbX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FdqmEBN8; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="h+xBdXbX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FdqmEBN8"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 36D9F1400087
	for <git@vger.kernel.org>; Sun, 11 Oct 2026 19:05:57 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Sun, 11 Oct 2026 19:05:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791759957; x=1791846357; bh=9OUecbdm8L
	HTsUAFvkUVwsNdKKp9Jva7e1Gt09UfJmc=; b=h+xBdXbXKrsxxQ/C+yDP6mlyZ5
	cFtAH3MaYH1GLbwk69IiYA1whe0klSILoIoULEV541td/vnpAq8hklzqPLSKJm7L
	fXKKavjxVsAOz5WPFePfDAt7bhsIOHG8VCHFBFWL1DmfSuz4+0/1u3q7g4K9BHAy
	gTEtlsZYGV9Tk/ZljcAx2UqGpnUV1c9+bclUzW5qW/Aj1IS2GCW4Cnhnz/tczNjl
	mk766LF48/Fx6kbZSZXx/WqVEwOdmP1VDuoVtA05xSAfAux0DJIIVuoMGEF07gyP
	4lNVusUEg+2+Q5fDWuaII31ATFTByn8jGsVzo2xOEm+tjdEe5VwTPQEGgdzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791759957; x=1791846357; bh=9OUecbdm8LHTsUAFvkUVwsNdKKp9Jva7e1G
	t09UfJmc=; b=FdqmEBN8sZilSeElM8+qGvX9yfCGgS8Ybqe0wkdm1s9BUEdmw5y
	SF0FkISL0UROs+zVAH15+wVLzMPpyFgXWrc/SN0UAYLjALTL1Pz8tVelcTTy0Qqd
	+TZfCTLHYW9kApqDc3+6OFmOPHeFy3l/0PmpyFXN7LNYvQTcviFGyeu+9/CbAd3Q
	A+WsU/SYSDzgO6LZlMrpPXaE4+ZL41sINXjqy61YZ6Q09QEP781q8o68asJJPbtO
	+g3vYDRc8kxoK/xYCZKlFFtJmwoLap9jFNx2+wiz1j+zgBlswCkyGqnsZGjY4+lJ
	wpMDCyq8RsvtipDLsg5tr1nlJmfZrwRMrAQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791759957; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:gkAaq0C/ql1JwDrLEel6niJhf/4tyP3/Uvfn8BOehgwoycs
	Ps+ZdpoaICtdMTRIXbzYqHByiybRL8xIG+UuIAJZxrG6iIWWxMXQ6oB2nekRMnFR
	POoIcWlr8p7y3U7zQXOTyJNqwQ/6frVoMiqxj+0Vabay7CjrqJ0bKiQM8J0321kV
	nO3q0f5CFEVJA+3vAwnwW+hHNly5aAJlFjth1wC00w9y5bOSzKTH2eR9IP6uIf0o
	o7naZlYUT2tL7qBD40RnVCDyIYRA216Cl9aBUpaFdn15RIyDE4C/ox/NYmA0+JiT
	ctdaPAG73y7TZZY0Xg/CZF/nXBt612i7gcDI4jA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:l2Hcc3Fc7XPDjIIYZmdPsSOy917RRxefCkPdsgCTWXA=:byOcUWfI1FdikvZNo0hdxii+1X/eV6wthy+ayOAfvaQ=;
X-ME-Sender: <xms:VBbMaonCYtQVlPR7onVuLdjAycm3DZUciYjfGp0vSSByIsvfoUWtdg>
    <xme:VBbMargrkUQff4Dr3-4cDvS4QIv4sisHMxPWKgCiWzT64P4F47OrzfYUZT3hgvICS
    FFcZbTwp3zK8Ae-KfBZ1u2hQb9GuJ-iQoXpdtbzoS9n8HTLm3RTJSo>
X-ME-Received: <xmr:VBbMagdIesVGdkNQ6CKEkQYdTFmSUyFRi3GBxV79Zw6z44O7Oeiq84BDylWgzT8IONL-1zuIlX-YO8oDFTW0A9DomhLnc9GgdWdL>
X-ME-Proxy-Cause: dmFkZTEbafFqaMjJIyUmOb60dnFXPD9b13UiuU1+BeorziXb93kFGj6uqt1YDX82ooPgv8
    RACn+IG2sDACpbVIJI1voBBMQ9UFYKdekEU5MSzmXQkNt6Eri6kI+0JtZCkLM2j1G45r2D
    kqAmZtqoUlERZYsULvoE7q/wB8nqzkGVXwm/OL4dlhhafIwpxfue6v5PEuHrp9tT8ux+0c
    mKI+KWzTz0mN8i3ZCT5TDmyEFhA+/jm1r0sxWAvejKHqgLLF99EOLwHlYdkQy2vFXilxqn
    Yhpfsjv0pbUUGp1Fqg8TxP4o+GPSw9ntu/Oao+8BE0dqFOvoN65FudDAdlT9JV3CQ9QRCO
    rfIfkrd3FQp2kmrsMw/DuA5ZKfIk4nUF4GMu993az5kN4GH0EDn8nUXg6aIqAWdNWM6OX9
    xi2hMAO/LzN8n7lzzrT4W3MLPWN/kmQW13oQ2fdKrfY1k97kJFyM85BNvFt0kaGciOnW/x
    wNhbfs4eRr8qQqG1saZpK9iUJhBkL+xc3U2ktanrX+HwOx62rUK4hg8JC7jGo40I2FaVfP
    15OT6BLi5j5Ixpi+I0R6/9BWYWwxPsdHgDXeAwI7nBJ8lsJ3cC65RKbPbxse1wPm2u8NhS
    PW2Ssj49To/dfhzPrR0KqGi+z2BOaOuaJth++rIKuEZGZjUKBgypxrdj3y/g
X-ME-Proxy: <xmx:VBbMarhkKE5ZaFCvYp9e4YA0xki8jJ_5wqMpirK8l_6uSYLkTlw0xw>
    <xmx:VBbMaowBxmHhaXfsEuE6HIMAk1eYhfwGEVB3-DW0vIqpXXSrzWv7ng>
    <xmx:VBbManOP8uppCwrHNTTjlB16R7yuDLl_HO5hKR-rAJdfWVb3vfNb_Q>
    <xmx:VBbMapXcNPx_AqkqL4chyqhLtd57uKA_yKjiXUqHQFOFLj4maPDApg>
    <xmx:VRbMak3Df04Hr9nmZSinVv9ts5KqHw9syprpvhr9skVOEt2Za7WPSLIx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 11 Oct 2026 19:05:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Xiangfei Ding <xfding@google.com>
Cc: git@vger.kernel.org,  dev+git@drbeat.li,  davidben@google.com,  Xiangfei
 Ding <dingxiangfei2009@protonmail.ch>
Subject: Re: [PATCH] imap-send: use ASN1_STRING_length
In-Reply-To: <20261011210928.3900020-1-xfding@google.com> (Xiangfei Ding's
	message of "Sun, 11 Oct 2026 21:09:28 +0000")
References: <20261011210928.3900020-1-xfding@google.com>
Date: Sun, 11 Oct 2026 16:05:55 -0700
Message-ID: <xmqqcxtfet2k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Xiangfei Ding <xfding@google.com> writes:

> From: xfding <xfding@google.com>

This line is called in-body From: that is used to override the "From:"
header your MUA will add.  But in this case, I think you do not want
to override "Xiangfei Ding <xfding@google.com>", which is what your
MUA sent the message as.  In any case, either MUA From or in-body From
is used as the author identity when this patch e-mail is committed, so
it should match your sign-off we see later.

> X.509 has never stipulated that ASN1_STRING shall be null-terminated in general.
> In OpenSSL, `ASN1_STRING_get0_data()` returns an internal pointer to
> the raw string payload, which is lucky for us null-terminated.

OK.

> This is probably
> about to change as OpenSSL derivatives like BoringSSL would adopt changes so
> that the data buffer would not be null-terminated anymore.

It is unclear from reading the above if you mean only derivatives
will adopt changes not to NUL-terminate, or OpenSSL will change
ASN1_STRING_get0_data() to return a string that is not
NUL-terminated, and derivatives will follow suit.

> Strictly speaking, printing or accessing `ASN1_STRING` data should always query
> `ASN1_STRING_length`. This means that we should adapt `host_matches` and
> `verify_hostname` to use `strncasecmp` and print strings with designated length.

Makes sense.  I take that the second paragraph to mean "not using
ASN1_STRING_length happened to be OK, but that is not true anymore
with various implementations of OpenSSL like libraries",
illustrating the need and urgency to make this change?

In our log message, usually all of the above (i.e., observation of
the current situation and pointing out problems in the status quo)
are followed by what to do to solve the problem by giving an order
to hypothetical somebody to update the code to "make it so", e.g.,

    Update code that assumes ASN1_STRING data are NUL-terminated to
    use ASN1_STRING_length and treat the data as <pointer, length>
    pair.

but the above description you gave is sufficiently detailed and left
no need to make a separate description of the solution.

> Signed-off-by: Xiangfei Ding <dingxiangfei2009@protonmail.ch>
> Signed-off-by: Xiangfei Ding <xfding@google.com>

What are these two separate sign-off lines doing?

Unless rules have changed recently, I think Google OSPO tells you as
a Google engineer [*] to use your @google.com address when making
contributions to open source projects, "unless you have a history of
contributing to the repo under a different email before your
employment at Google".  So only the second one would be what you
want to use, I presume?  Again, as I mentioned earlier, it matches
the address your MUA sent the message as, so you do not need/want
the in-body From: line.

[Reference]

 * https://opensource.google/documentation/reference/patching

> diff --git a/imap-send.c b/imap-send.c
> index bf1d2cf74d..bd306b8d0a 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -225,19 +225,21 @@ static int ssl_socket_connect(struct imap_socket *sock UNUSED,
>  static int host_matches(const char *host, const ASN1_STRING *asn1_str)
>  {
>  	const char *pattern = (const char *)ASN1_STRING_get0_data(asn1_str);
> +	int pat_len = ASN1_STRING_length(asn1_str);
>  
>  	/* embedded NUL characters may open a security hole */
> -	if (memchr(pattern, '\0', ASN1_STRING_length(asn1_str)))
> -	    return 0;
> +	if (memchr(pattern, '\0', pat_len))
> +		return 0;

OK, the above is essentially a no-op.  But we have the length in a
variable so we can reuse it in the rest of the function, which is
good.

> -	if (pattern[0] == '*' && pattern[1] == '.') {
> +	if (pat_len >= 2 && pattern[0] == '*' && pattern[1] == '.') {
>  		pattern += 2;
> +		pat_len -= 2;
>  		if (!(host = strchr(host, '.')))
>  			return 0;
>  		host++;
>  	}

OK, we check for "*." only when we have at least two bytes, and
consume these two bytes if they match.

> -	return *host && *pattern && !strcasecmp(host, pattern);
> +	return *host && strlen(host) == (size_t)pat_len && !strncasecmp(host, pattern, pat_len);

LIne-wrap this overly long line.

	return *host && strlen(host) == (size_t)pat_len &&
               !strncasecmp(host, pattern, pat_len);

Curious.  If we declare pat_len to be of type size_t, we would no
longer need to cast it here.  Even though we passed pat_len to
memchr() earlier, that call implicitly promoted int to size_t, which
would also become unnecessary.

>  }
>  
>  static int verify_hostname(X509 *cert, const char *hostname)
> @@ -278,8 +280,9 @@ static int verify_hostname(X509 *cert, const char *hostname)
>  		return error("cannot get certificate common name");
>  	if (host_matches(hostname, cname))
>  		return 0;
> -	return error("certificate owner '%s' does not match hostname '%s'",
> -		     ASN1_STRING_get0_data(cname), hostname);
> +	return error("certificate owner '%.*s' does not match hostname '%s'",
> +		     (int)ASN1_STRING_length(cname),

Because ASN1_STRING_length() is declared to return "int", this cast
is not strictly needed, but it is good to be explicit in a case like
this, I think.

> +		     (const char *)ASN1_STRING_get0_data(cname), hostname);

Great.  
