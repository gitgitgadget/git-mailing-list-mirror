Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C3120C46C
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 09:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728638007; cv=none; b=QTadBJFXICr3o9a+OAAS+CfLMc8oxdUGRdijP62smviQIe9Mn2Ct5emATp1fqurZHLsL6qJ0RN6I8K7PJjz0DQfr5KSZj67Gkggzhncx1XIq9R0SYx2bvzp0QZpNI0Lp8em2fMfC2nxuAXcLyj9qyLEP68xSkz+oA5voQIKyPes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728638007; c=relaxed/simple;
	bh=CIVv11afA0FB5srv4LDxoJ07dyBGELWTSmNn1xc+r0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DuPxzzc9+jT/soyahWGnZhDUuh0+2w5BK+vzwl/MtjItL+AX2YmRRgWo6m6uNb9mzACnBHSUV3FiUAZSAeYPlXKI3i0fxnlOAQxYwTvZzOp6itJB+ztuoxAYrduVCOX0RUQ6JTHEEbRLNvrDVxNXgPo0SaC4Kgvif8V0W2Q9EE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b=as/qcoCN; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b="as/qcoCN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1728637996; x=1729242796;
	i=oswald.buddenhagen@gmx.de;
	bh=CIVv11afA0FB5srv4LDxoJ07dyBGELWTSmNn1xc+r0M=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=as/qcoCNXJ/m/5+iMBcZx5y5IpkU/6WXgmNUJFjhG7ltw1KQkg16NUrgIqXvMrQe
	 b3fNjdcsbbMVH4MiWFnLa6q5KalBA9fiFKfd76maZx2wL5Az3I7Mty8CPc7cBvdpq
	 6IB92Sg83Eq9m+X5wr/kMspWXmvE5VieVLZUrr5PSPUfmxyZGwLINEbpzT2PyzMfQ
	 HJT95gkzj4Z5gA8yUtHVd1eoO5De1Shg86PcKJQnIEUmLFZcx36CkUfCCm/WXvGVP
	 J/o5/SEWDB03QNdQEhR3CRMs4eY2rLeaBrLVrP+PdNKIQeB8GsSYpgWdgXewNNk5W
	 b4OKWuruyYmIdiRODQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ugly.fritz.box ([89.247.162.125]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N6bjy-1u2OsE1owo-012GVd; Fri, 11
 Oct 2024 11:13:16 +0200
Received: by ugly.fritz.box (MasqMail 0.3.5-13-g85b6fce-plus, from userid 1000)
	id 1szBhz-cXJ-00; Fri, 11 Oct 2024 11:13:15 +0200
Date: Fri, 11 Oct 2024 11:13:15 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org, eric.sesterhenn@x41-dsec.de, jarlob@gmail.com
Subject: Re: [PATCH 1/3] fuzz: port fuzz-credential-from-url-gently from
 OSS-Fuzz
Message-ID: <ZwjsK-uprX0eUAl5@ugly>
References: <cover.1728594659.git.steadmon@google.com>
 <625b8d607ed2c95e396e7794616d9f290f23d15c.1728594659.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <625b8d607ed2c95e396e7794616d9f290f23d15c.1728594659.git.steadmon@google.com>
X-Provags-ID: V03:K1:9afpxLbT91VSw2PQzbpmo2r4VVuC6pxB8XjXVfss8jntF0j+W3f
 4Sw0plj7GCSgdyDvrbscX3D9IEh2Y1ufusYzoMVu4aAUWt4UBhaVtJjV74x0KyrR1HHDW94
 eq7ZMKcrSp0wnBM0jPXjO8gRDrYPhrQkrAiJ2p65ii+ddxeAaZaIUd0reLT2Z8OGaQSAV0i
 ZH9FJztjhmQYjzebUnkGw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CjmdN6eLJmg=;o7Hync22+FMJMKlOJf9xlXvUXab
 SLfCjkuIFy8hPQGFeA21OhjOIMSByV+FLhVOTpWHLdeslJcQMimvS9AxUNLjcurAeFXOtSM53
 V20NY8CfLM1/GjUaKfX8BQnTcwoXz0lO59c3K9E5qudlBYPgP2Jfo7rFMFVadqsq/tvEOvAfv
 Uz1uMZ2LeRDNQR7X/JmqN10/um8+1WXxMar4SZjVQxGV2gkVFGdcKdDu5VkWxwaqhMTpgOIqn
 TT8ZUugfsIwNrvSXZvqWJFUoHw96HZnEZ99VhihmBSn+pluoPn6LiPHwlI/K4n+RF8VoJ+R0U
 EK0f/RsC2goDkraUpEdatpR1DdWFLwgtSmWDt3WubkmpprbpxIUeRrhYXTe6/GkRkXevAmrlA
 imS9WBaGxA3f9uRGjL834h+GSkPKTut0ZhJsL01k2rKtIL55YmAbQjL0Kb5o1ahQvB/o+F9dp
 EJK6XhpqHiN03G2WCvBZ8erEf/J0/1+RUaMzTfgKt1optTGpXDmEBbpjyBlgzORcXg6gjj+G2
 E5uBulcIgu0nHIc2fb/hFADrVr7ByCIxetN8dRwDuFJv52cQAJcIJ+qHl4gGlhVfMia9UjWFj
 wVQ4gYQbwKlyJg3NidMc8EzRggHjr2Sv/HyZgUXzTyTg5onuQCQipGnBWgQrTV+L8P+sUK8+w
 PJKBWrYO0nRpTHtStsJkxSOE5OaUMg/Dgi7IhRdCADcrZMxvE5NA2Ou7bIN2a4pKdya4n+W3t
 dzAKBGNn4ODS3ksDN25Rcu4SCCPNOOmGs1cIiiXsNSPrB0S4Lksn3wtQjpTbY1or9+zcLMfbU
 lGFAkASvrHGWB5nXhcCiRktQ==
Content-Transfer-Encoding: quoted-printable

just some nits:

On Thu, Oct 10, 2024 at 02:11:53PM -0700, Josh Steadmon wrote:
>+++ b/ci/run-build-and-minimal-fuzzers.sh
>+fuzzers=3D"
>+commit-graph \
>+config \
>+credential-from-url-gently \
>+date \
>+pack-headers \
>+pack-idx \
>+"
the trailing space-backslashes can be left out, which would make the
code less noisy. then the variable would contain linebreaks instead of
spaces, which the for loop would be just fine with (as $IFS contains
LF).

>+for fuzzer in $fuzzers ; do
>
the space before the semicolon seems excessive.

>+++ b/oss-fuzz/fuzz-credential-from-url-gently.c
>+int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size);
>+
are these seemingly redundant prototypes meant to suppress compiler
warnings?

>+int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
>+{
