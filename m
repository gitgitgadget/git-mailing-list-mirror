From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH ] t4210-log-i18n: spell encoding name "UTF-8" correctly
Date: Mon, 25 Feb 2013 11:06:37 -0800
Message-ID: <7vmwusxlfm.fsf@alter.siamese.dyndns.org>
References: <201302090052.22053.thom311@gmail.com>
 <7vsj56xsg5.fsf@alter.siamese.dyndns.org>
 <7vobfuxrns.fsf@alter.siamese.dyndns.org>
 <20130209002710.GA5570@sigill.intra.peff.net>
 <7vfw16xqvj.fsf@alter.siamese.dyndns.org>
 <7va9rexqii.fsf@alter.siamese.dyndns.org>
 <20130211191607.GA21269@sigill.intra.peff.net>
 <7v621ymxfv.fsf@alter.siamese.dyndns.org>
 <20130211205958.GA32740@sigill.intra.peff.net>
 <512B22DE.9070603@viscovery.net>
 <20130225151916.GA7725@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Thomas Haller <thom311@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 25 20:07:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UA3OJ-0002uM-5L
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 20:07:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759348Ab3BYTGq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2013 14:06:46 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35166 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759295Ab3BYTGq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2013 14:06:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B4BBCAD9C;
	Mon, 25 Feb 2013 14:06:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Jg+/IxI0pHeQ8jByEdd2rQ0X8Rk=; b=Q5FD+b
	yN8bKr27xqlNvJJen3dMwwt5OB/nIdxlIvqcrDvsDFc0ejgGIRbYYYFc+84TEtVE
	2d1+KP8WdghURwkJGjtXO/9TZqRhXPmyp73I/025hIp6m0fupRqMgFHi1QgccfJy
	I7bRVd78K5PaRG9mWujEbECDAYJ8A8rtzfbv8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jecFXsWf1WmkhK88S3h21gPu7Z7a4ExF
	4i1qL1wZ57umfT7/M035yiicdWmCPE8uFOZzkfIMLff0WWNkcBnMtCXexMKDd6Z6
	p5nilb9RoLrXlOlpxUANViYrXUz2Zjo/eaGvW7Z0plnBvJhtnyLjdrZyY4Ojto/A
	FME70f/aGFw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A9E7FAD9B;
	Mon, 25 Feb 2013 14:06:45 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1854CAD80; Mon, 25 Feb 2013
 14:06:43 -0500 (EST)
In-Reply-To: <20130225151916.GA7725@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 25 Feb 2013 10:19:17 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7F31AC52-7F7E-11E2-88DA-F3C82E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217086>

Jeff King <peff@peff.net> writes:

> ... I think the simplest thing would just be:
>
> diff --git a/utf8.c b/utf8.c
> index 1087870..8d42b50 100644
> --- a/utf8.c
> +++ b/utf8.c
> @@ -507,6 +507,17 @@ char *reencode_string(const char *in, const char *out_encoding, const char *in_e
>  
>  	if (!in_encoding)
>  		return NULL;
> +
> +	/*
> +	 * Some platforms do not have the variously spelled variants of
> +	 * UTF-8, so let us feed iconv the most official spelling, which
> +	 * should hopefully be accepted everywhere.
> +	 */
> +	if (is_encoding_utf8(in_encoding))
> +		in_encoding = "UTF-8";
> +	if (is_encoding_utf8(out_encoding))
> +		out_encoding = "UTF-8";
> +
>  	conv = iconv_open(out_encoding, in_encoding);
>  	if (conv == (iconv_t) -1)
>  		return NULL;
>
> Does that fix the tests for you? It's a larger change, but I think it
> makes git friendlier all around for people on Windows.

Yeah, if this is confirmed to work OK (from eyeballing I do not see
a reason why not...) I agree this is the cleanest way forward.
