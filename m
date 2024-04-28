Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF475256
	for <git@vger.kernel.org>; Sun, 28 Apr 2024 03:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714273434; cv=none; b=IK+CHBx++YzILaTwHNyraawBQPLACkwEYj6RNMEZOPl9i4bUAsMAO/1KvqV6+qFv4R3WUiZwQx0pzCZEMs95nKEZpHIWkwQoJyrkyDojvWoQFZ9gKYV8/IWoeioxMxaZPLAX5ExDZ9SJPdFzyKhl7oBvbpCOP6hkvZaILWKKfTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714273434; c=relaxed/simple;
	bh=asRqgOrbRcydcTqO3JTa7yzWX5vQQb5EtgBCm8khgro=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=YjNODDMP7yg9yEZh4jVGsNkkjJ5SK2SuPcRjQyeI+lPbb/s+fUzw0glU1ygQglfk4LNTk0I463rujeGI+SSkk/CXmVLghA4zv8JCizxZy7NSscw3QiEkC47DXsCxwV4dHOlHPF0DGb4zsFnutCwJRBgbRd/FH7TrM4sabkLx9Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=Fuj8pP60; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="Fuj8pP60"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1714273428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CvqIWmjct8y86TxlxoHBqzoGIKQoYkvFn8LflIPdTIs=;
	b=Fuj8pP60pLm3iaH+M1cyKfb5Vj7lkDTYrVgRNnqZGrMWTfTNJGhnjljoqJkQTLFPu85KJF
	EtonSs9+qbMfPvWaqI+PsSsYFdRZAVisNks9s2LMBNkupzN8D2YUxqDcGDl9wtBxglgi8Y
	jWgMWvyxHMFiz6xkvFPXghB222B21h1DEjCfl7qeHUuZQV74l/i+T0I4HbQ6K6naCJzIsK
	idWyp/KOyNRyBhAfuvv+PnSAb3WM35TwMfWW+1tikM6YExm0JIx6Are9oOo/orwqY6LOO9
	Tdx6zKwHiCKR/xc70s708P9EjM3lud/SFmXzBQ396vKBIaKPCvllgCHKeDUFtw==
Date: Sun, 28 Apr 2024 05:03:47 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, code@khaugsbakk.name
Subject: Re: [PATCH v6 2/2] send-email: make it easy to discern the messages
 for each patch
In-Reply-To: <xmqqo79u4qlc.fsf@gitster.g>
References: <cover.1712732383.git.dsimic@manjaro.org>
 <c78b043b5a6cf0de712d36e6e000804bd6e1316d.1712732383.git.dsimic@manjaro.org>
 <xmqqh6g9w5bf.fsf@gitster.g> <7dcc6f23cc7cb823cb19ec63c69c60e4@manjaro.org>
 <0216a0e8369b8a3592dda90e5680be31@manjaro.org> <xmqq8r0y66ub.fsf@gitster.g>
 <d4d63b9f3c7692bb48ac3e7ac34b663b@manjaro.org> <xmqqsez64r4d.fsf@gitster.g>
 <xmqqo79u4qlc.fsf@gitster.g>
Message-ID: <499afd35a88df2c12327026f9f3ec468@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-04-27 20:18, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Well, v1 and v3-v5 saw comments only from me.  There was a comment
>> on v2 by Kristoffer Haugsbakk about phrasing in proposed log
>> message.  v6 had Eric's "Meh, either way".
> 
> FWIW, somewhere between v2 and v3 may have been a good place to
> stop.
> 
> "After calling send_message(), give an extra blank line before the
> next message" was extremely easy to see why it was a good idea.
> Mixing it with "oh, during the process of a single invocation of
> send_message(), there may be other places that want extra blank
> lines" made the changes less focused.  Personally I lost interest
> in the series at around that point.

Thank you for your additional feedback.

Admittedly, the whole endeavor could have been handled better from
my side, with fewer "oh, let's do it differently and a bit better"
iterations that inevitably made the whole thing harder to follow and
become interested with.

However, I find improving the way "git send-mail" works rather 
important,
because if it bothers me, it must be bothering other people, who may
simply not be on the mailing list.  As we know, a lot of people quite
regularly complain through different channels about sending patches by
email being not user-friendly, which should make any attempts to make
it more user-friendly quite important, if you agree.

I have some more plans for improving "git send-mail" and adding some new
features, but I need to get everything into the final shape I'm pretty
much 100% satisfied with, both from the design and the implementation
standpoints, before sending the patches over.
