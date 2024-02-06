Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D1013FE7
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 19:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707246731; cv=none; b=AKmChSmMenT6J4+0aPk83ebzgR8QOkQJtaS1y1wxqfuj8XNWtfPuS0nxByu9J1fwq6BRUjKPPl2+r53wYJqn93qZYnLTKlZSaKK9P+yd7PHyqruMopb+oT1O+eX9Cs570YfWr/kLqH+AqFgzh/eqP2snka0fASDx3hEir18PMcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707246731; c=relaxed/simple;
	bh=X5hYZNwVFxhDh07JlJAgvIChGHNzcwUQry6MOZxmjX8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=ZyMOmxBi0oI9aIsjXteFVrLdC05BTYqkankIQHg3/9xTDmf1+WItWtaMGAM7gy8SfsBiiHAp4h0KfHaOJM3eiHx7WFWD0NDOiNy1gi5OXkb5SQIGZe5QhUPa9YcjMrC05p1dphlbB4cQeiMXzmyhHFBRYr86iuZp3bEl5eVp9jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=v5ZJ5E4c; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="v5ZJ5E4c"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1707246725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dXbjlRz+3X+J8wvZr9hyE/h9iV32ZS5wD4QVZerSRuE=;
	b=v5ZJ5E4cCuJQV7zs6W0K9JK2L9iEVZwH7R9CFoBvxalI3Zit4rJaRBkk5qdkN9Wb9nCRVN
	FF1goEczQCjW7546GlxzLnrIaFLznxARh2R7s3X2eWZIf92xTdPayWprd35qB0OKbBGqA3
	EYRz4IDvLgkR/Pl65QeAqAJsc/y4km/RRWv80jvQ/HIy7OAdkCtRxhfoJ30GF6hu31vm0w
	RlNQbfytCZuQyrIdBZFEZeHM2tBrZvRXSJKu8ANmrRuxdONoU1cV/ichU5xam6fSsvaDzS
	jdqDzdx7nyZWGl6HC+QxEQU59+6K6/ASKqdQTzuqni2tVXLAzT2j0nZKYDx1iw==
Date: Tue, 06 Feb 2024 20:12:05 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, Tobias Boesch
 <tobias.boesch@googlemail.com>, git@vger.kernel.org
Subject: Re: git-gui desktop launcher
In-Reply-To: <xmqqle7xh1hc.fsf@gitster.g>
References: <beeab03c564e94861ab339d26c4e135b879a1ccd.camel@googlemail.com>
 <ZcFhNPRprfMqeRu1@tapette.crustytoothpaste.net> <xmqqle7xh1hc.fsf@gitster.g>
Message-ID: <c6be276bfc3c219e1a0ca1619f56c165@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-02-06 19:49, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> 
>> I think such functionality would be generally useful, and probably be
>> beneficial to a wide variety of distributors.
> 
> How have the various distros been packaging their binaries?  Would
> this change affect what they have done already?
> 
> As long as it does not conflict, I am all for it (i.e. we do it once
> and everybody benefits).

AFAICT, Linux distributions provided their own version(s) of the
.desktop file.  Perhaps the version provided by Fedora [1] could be
consulted, for example, to see what's already expected there, and
to provide parity in the version supplied by us.

[1] 
https://koji.fedoraproject.org/koji/fileinfo?rpmID=37302272&filename=git-gui.desktop
