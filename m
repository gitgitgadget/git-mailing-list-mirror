Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D250F218596
	for <git@vger.kernel.org>; Sat, 21 Jun 2025 13:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750512590; cv=none; b=rmxHE82f1oQMK1kKoYgPdPjzD5ShkjC4Hwabt7kC0koSEXulE5iJPm/rDGVN+XRT8M788RjqCOHyYSi2zbnj4EMBLmr3byHxrgySFv6niibjdXLp+bWwj+4G9h1OVmbqbNqycEI30wjPVUml+vB5KJ3o1zwnOoKcMH7De01hhBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750512590; c=relaxed/simple;
	bh=42Utm/SNDiAWpJqzBkfZHzgimuRZAHm+oQ7rTZAjYYw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LuUKQijDL4ITp0gES5/pZngASZoyWeAeKRhBU4RulCMO0dlB4vDJ38vy8XIJetzso6JTcFW7Jl6pEt61TdXVGOyGUiSB3saNuucbijQwlowtnrudaYUit97dE/h8ArtzJ9NXvA0sB8rcUFfTvA/iGAEyQnCb1Xz7VSdwPgFj+mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=guixotic.coop; spf=pass smtp.mailfrom=guixotic.coop; dkim=pass (2048-bit key) header.d=guixotic.coop header.i=@guixotic.coop header.b=Ve1k9aLo; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=guixotic.coop
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=guixotic.coop
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=guixotic.coop header.i=@guixotic.coop header.b="Ve1k9aLo"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <maxim@guixotic.coop>)
	id 1uSyHq-0032BC-BB; Sat, 21 Jun 2025 15:29:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=guixotic.coop; s=selector1; h=Content-Type:MIME-Version:Message-ID:Date:
	References:In-Reply-To:Subject:Cc:To:From;
	bh=/jUue+LI2Bf7gBQ7l2LQwyqlNIedhi7uRTZU84yG5Nw=; b=Ve1k9aLoHq6CFkUf4OKVYpU7zR
	O5XQoWT1rS/vLgaqxWmjhm+aJZ8kXDLwBf+S14rKXSELQrt8/cImRF1rUnPbJiM7BqZAGNpxWPUT3
	DNuK1qVHb7B0sIX2Q32JZUx+Mgex8gCkz6fx8SdIT9r5xdFnu9wq7KfWMM/wf8NBOGueQoMW95rat
	EGn0gIIEA0FolJYv194OrXbk6bbO/GSQmeiKqnXmA2J3fpxEAixxVydpyME2mSd7+dw88/iiBFAZb
	IZ2GTLTuMy0Wz/46XgVq46UNazqOt+z1yTVeJ8Pv2Oo/KdQjIJS+y58eXnVl8nUjSh5ap50ErstC+
	sekstHZA==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <maxim@guixotic.coop>)
	id 1uSyHp-0005OP-Vb; Sat, 21 Jun 2025 15:29:38 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1476852)]  (TLS1.2:ECDHE_SECP256R1__RSA_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uSyHl-00GkOj-62; Sat, 21 Jun 2025 15:29:33 +0200
From: Maxim Cournoyer <maxim@guixotic.coop>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Maxim Cournoyer <maxim@guixotic.coop>,  git@vger.kernel.org
Subject: Re: [PATCH] contrib: Honor symbolic port in git-credential-netrc.
In-Reply-To: <aFWwez5OEgLt0vRU@fruit.crustytoothpaste.net> (brian m. carlson's
	message of "Fri, 20 Jun 2025 19:03:23 +0000")
Organization: Guixotic
References: <20250620041239.27839-1-maxim@guixotic.coop>
	<aFWwez5OEgLt0vRU@fruit.crustytoothpaste.net>
Date: Sat, 21 Jun 2025 22:29:28 +0900
Message-ID: <87bjqhgr47.fsf@terra.mail-host-address-is-not-set>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2025-06-20 at 04:12:39, Maxim Cournoyer wrote:
>> Symbolic ports were previously silently dropped, which made it
>> impossible to use them with git-credential-netrc. This is a supported
>> use case according to 'man git-send-email', for --smtp-server-port:
>> 
>>    [...] symbolic port names (e.g. "submission" instead of 587) are
>>    also accepted.
>
> Does this work with credential managers in general (that is, in
> non-email contexts, such as HTTP)?  Also, do credential managers in
> general properly find credentials when they're stored in one form and
> looked up in another?  If so, is that still true when the lookup is in
> the URL form (e.g., `smtp://mail.example.com:587/`)?  Is this documented
> to work in the credential manual page?

I'm quite new to the credential-manager of git, so I do not have an
answer to these excellent questions.  But, as some perhaps useful
datapoint, at least using Emacs's auth-source library with a
~/.authinfo.gpg file (which is in the netrc format), if you use a
symbolic port name, you have to use it everywhere if you want
auth-source to match it correctly (it doesn't translate smtps to 465 for
example). If you put 'port smtps' in the .authinfo.gpg but specify the
SMTP port in the your Emacs MTA to a integer like 465, it won't match.

This could be considered a bug in auth-source.el, and git
credential-manager can do better by converting all port input values to
their integer form, as you suggested.  Then mismatched configurations
(e.g.: smtps in netrc and sendemail.smtpServerPort = 465 or vice-versa)
would be handled correctly.

> (To be clear, I would be very
> surprised if the answer to any of these were "yes" because I've
> literally never seen this usage before with Git, but I am open to
> updating my knowledge if that's the case.)
>
> If not, then I think the proper thing to do is to have `git send-email`
> rewrite the name into a port instead of having the netrc credential
> helper learn to handle non-numeric ports.

Did I understand correctly with my suggestion/rewording of yours above?
git-credential-netrc reads its input from the netrc file, which may well
have a symbolic port, so it should itself convert from symbolic to
actual port numbers, IIUC.

-- 
Thanks,
Maxim
