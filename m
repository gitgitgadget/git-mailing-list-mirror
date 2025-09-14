Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34729EEBD
	for <git@vger.kernel.org>; Sun, 14 Sep 2025 00:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757809124; cv=none; b=LQUTw6o6cKMLvCy6MxtwWmsC36b2O/A3ev1DFK7DOgi2XlrRiTLArF3zQmiUpCoOZng4fjkvZMQ2WiLdbm0YC5U0opVQH+zkYCj4CdjWKQ/xtKI45q2jd4xZOrSoDLaC7ES90fnhq7hPFxi7SnooF/MF5ihIhs4U3hhkBJFRdWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757809124; c=relaxed/simple;
	bh=nlrBDTRJ7h4WmLgPJ2ftUvB7u8J5uSiXk6sz08tyPI0=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=oCxada3s/k/hMGClFg7pUf+Wce9idU/vdgJkCBUu4jKrvTDM594YdyK8Xi942UjNucpNZsX+Ir1TBVu/110l5NidyL7Zw0mwpI5r6zUrLrQ4hAmA1QLhsSb58x4wFkBUaAN/58DaTiYgjYHrIJ3mf5JbVnK7Bn/OueHCeWKvsdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 58E0IQ4T007854
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Sep 2025 00:18:27 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Johannes Sixt'" <j6t@kdbg.org>
Cc: <git@vger.kernel.org>
References: <074901dc2422$2039a910$60acfb30$@nexbridge.com> <a5e01f0f-1789-427c-83c3-90644fa234c9@kdbg.org> <000201dc24bc$a1b8d9d0$e52a8d70$@nexbridge.com> <9a03a436-8240-4566-9383-7afbf740719e@kdbg.org>
In-Reply-To: <9a03a436-8240-4566-9383-7afbf740719e@kdbg.org>
Subject: RE: [QUESTION] mergetool environment variables
Date: Sat, 13 Sep 2025 20:18:22 -0400
Organization: Nexbridge Inc.
Message-ID: <004101dc250d$18173950$4845abf0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIIYP6OPNj0v3uszpSJmTqcmvS4YAMVDl7/AQ1O/a8DDc+Us7P/1nKA
Content-Language: en-ca
X-Antivirus: Norton (VPS 250913-4, 9/13/2025), Outbound message
X-Antivirus-Status: Clean

On September 13, 2025 5:04 PM, Johannes Sixt wrote:
>To: rsbecker@nexbridge.com
>Cc: git@vger.kernel.org
>Subject: Re: [QUESTION] mergetool environment variables
>
>Am 13.09.25 um 16:42 schrieb rsbecker@nexbridge.com:
>> Let me try to infer what is happening and please correct me if my
>> assumptions are wrong:
>I'm sorry to say that I can't help. I tried to disentangle what is =
going on, but this
>stuff is far too convoluted to be understood in a few minutes. I cannot =
tell if it is
>possible to write a mergetool that is not installed with Git.
>
>I would just copy one of the existing tool scripts and run `make =
install` from the Git
>source directory.

Yes, it needs to be in the git install area. Adding export BASE export =
LOCAL, etc.,
works to resolve the situation. I wonder whether that should be =
documented.

