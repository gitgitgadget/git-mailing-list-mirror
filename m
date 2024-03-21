Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F9E13AC0
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 07:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711006331; cv=none; b=LHC9rSTqmfpFRZSLwPUBIRfnljZHA5J1Up0+TAm9FlphrB9CdAvMzpm+x/S9HJSsFAdLXeQlLqeiXfnHUMsQXPMw4hpobIqJekk5RESLHDvAUD0MYrlQQgM2OZBL3kiwyB/G3h8ndiyFFoFum0tjjIwyLiUWmVO2cwGAvZ+b9uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711006331; c=relaxed/simple;
	bh=3PtgfOSIHxw6wsAc++VGBFJlASFSvot2p3xAvl2NzLk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K4M/BURqPVivgwG7RcVG90CUIlIhNbnzgsqg08hRv2MpBc50dPBATl97m+oxrdCTHnxi66kxYfFsjb9Ll1Yj8E9cvti6z/28MfnT648nFI0yrZE5OQA9JVyXQd+pqy7QMIYdBloSTg2Tadrw5mzEbbnR9s/SSdHJYklJ1MwH1es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=b+H4H4qU; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="b+H4H4qU"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id D7DD936208;
	Thu, 21 Mar 2024 03:32:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=3PtgfOSIHxw6wsAc++VGBFJlASFSvot2p3xAvl
	2NzLk=; b=b+H4H4qUiUPYd4Apmvnkt+KovrI80ESStJtCnxgpoktdHDPUCGnPLL
	KoG4sX/BHCFw4jpjBKPcmMolN1UkMnkdOZB9Y8SNwTuptKvhkS0Bof12azXhdEnT
	2kQDOYF6CqmylLbZQVDvZ5QgPbtw2STPp6lygIBuvXwbcLd80ldYg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id D048C36207;
	Thu, 21 Mar 2024 03:32:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D079C36206;
	Thu, 21 Mar 2024 03:32:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Dragan Simic <dsimic@manjaro.org>,  git@vger.kernel.org,
  rsbecker@nexbridge.com,  github@seichter.de
Subject: Re: [PATCH v4 4/4] config.txt: describe handling of whitespace further
In-Reply-To: <CAPig+cSYhYBa0NsvJCOYo4JsWzLJT9rU++U1QKA3jRB6Cptbhw@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 21 Mar 2024 01:11:26 -0400")
References: <cover.1710994548.git.dsimic@manjaro.org>
	<f84c5e8e4a90be3f9fe3cc853e0d40aed4e58826.1710994548.git.dsimic@manjaro.org>
	<CAPig+cSYhYBa0NsvJCOYo4JsWzLJT9rU++U1QKA3jRB6Cptbhw@mail.gmail.com>
Date: Thu, 21 Mar 2024 00:32:03 -0700
Message-ID: <xmqq8r2cca6k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1D8727D4-E755-11EE-A147-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Eric Sunshine <sunshine@sunshineco.com> writes:

>     Whitespace surrounding `name`, `=` and `value` is ignored. If
>     `value` is surrounding by double quotation marks (`"`), all
>     characters within the quoted string are retained verbatim,
>     including whitespace. Comments starting with either `#` or `;` and
>     extending to the end of line are discarded. A line that defines a
>     value can be continued to the next line by ending it with a `\`;
>     the backslash and the end-of-line are stripped.

Nice, but I am not sure how this captures how whitespaces between
value and comment are handled, e.g., in this line

	|  name = value # comment$

humans know the space before '#' is removed because it is
"whitespace surrounding value".  But there is a bit of chicken and
egg problem; before you realize '# comment' is a comment and strip
it from the line, you do not know where value ends, so your reading
of the above need to backtrack.
