Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7404AEF0
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 14:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710945776; cv=none; b=u/gI6YEyVWiLkAd3golFVFalIyQh1Tr9e+pUp3VDlY3KBRgFBamcZiIH2m7V+bpV8sXIuc+wdEXagK2P0FR5NjlQfG0JrguTM71ScdTEQncjgwvjubCuHjCu3ojRPvenI7HcU/QenuZMbI7oZVHBjq+kdOcTidaahCtv3Aq1e5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710945776; c=relaxed/simple;
	bh=QD0B9s8gL0FCW2hMNfLNMpu5q49dLvqmiMMtUiDIs8I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ICKD/Z9WV1JMyttSF9i83CHKOD2efttSD7uRokjvheSFXfvtQJG+0qJo6Qr7UHzdZfcppB7qLwbz3vMF7z0gWkmUIAWHq7XLX9WeUlrmZCSJFCycG0zbETyAjI9QpRxtAYKyI2fNjMAxoL/flwxbtoEIMINkjqKiHvSN30JgIOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=VCH/u5X3; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VCH/u5X3"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 86F192FB6B;
	Wed, 20 Mar 2024 10:42:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=QD0B9s8gL0FCW2hMNfLNMpu5q49dLvqmiMMtUi
	DIs8I=; b=VCH/u5X3M4T/QzupsIxlWtoPuwzQyueM+M0fTBjYIIZdq4eLb5JwqI
	T43w2nbAl4JqnLdEHRJ1ehcgdmc7OsgOe0yOtgIP55tcGnolE/0tISX8dkEg8TD5
	F3gQnbNCiPX1CEI9s7ezYB6Vt/zhHaupkkkMdCMWsv2kjOLPJUJzc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 7F7522FB68;
	Wed, 20 Mar 2024 10:42:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6D0DD2FB67;
	Wed, 20 Mar 2024 10:42:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org,  rsbecker@nexbridge.com,  github@seichter.de,
  sunshine@sunshineco.com
Subject: Re: [PATCH v3 4/4] config.txt: describe handling of whitespace further
In-Reply-To: <c4f0e7311edce5d4ed4a55f290de9eaf@manjaro.org> (Dragan Simic's
	message of "Wed, 20 Mar 2024 08:23:48 +0100")
References: <cover.1710800549.git.dsimic@manjaro.org>
	<e389acbfacd5046a926b87346d41f9c7962e3c23.1710800549.git.dsimic@manjaro.org>
	<xmqqttl1js1o.fsf@gitster.g>
	<c4f0e7311edce5d4ed4a55f290de9eaf@manjaro.org>
Date: Wed, 20 Mar 2024 07:42:47 -0700
Message-ID: <xmqq4jd1hsm0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1FB1202E-E6C8-11EE-92ED-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

>>     Leading whitespace characters before and after 'name =', and the
> Hmm, "leading whitespace" and "after" don't go very well together.

True.  We can drop "leading" of course.  I meant to refer to, in
this sample illustration,

[section]
	var = value # comment

the fact that "\t" before "var =" is discarded, and " " after "var ="
before "value" is also discarded.

Thanks.
