Received: from smtpfb2-g21.free.fr (smtpfb2-g21.free.fr [212.27.42.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489321DDA1B
	for <git@vger.kernel.org>; Wed, 12 Feb 2025 11:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739360835; cv=none; b=iIRG2N98OT/2GAUEhP741Q4vsFvbktwU1eDwdcl4JW5gnsmf9WVbp7iIwzICwLuPI9Yaq0+OavdgExh+FRHEplRahft9uc6wwML0cYPk55/oxupOcZ5qMKnlShCGwjFHlzFNCnInWzswzQQmI/tBNr8lVhvWl+CAOk+8cwrOV1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739360835; c=relaxed/simple;
	bh=up/wC0JP/b2+xAM7JmY/YazXdJAllEPqcTEIKTHgN3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JP1q0g+9CkVrAf+GgfqnpT8MMXTgqIj2wGBh5pWBfmkVPaFe47dtO+ZW+5vQd0T6Y1rXAbX4nqk2u62BlhEz0g+Ro1WzNeQZBwYrpc/uEV4seusSHfqlBx/5yNMXSWybK3RBUuTIZe1ofG/2xL2t9W0YJm1Fs7Mi7ysXpw34wuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=drvRJeO1; arc=none smtp.client-ip=212.27.42.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="drvRJeO1"
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id 9F59342D39A
	for <git@vger.kernel.org>; Wed, 12 Feb 2025 12:40:21 +0100 (CET)
Received: from [192.168.3.164] (unknown [141.255.129.53])
	(Authenticated sender: jn.avila@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id 316E7780513;
	Wed, 12 Feb 2025 12:40:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1739360414;
	bh=up/wC0JP/b2+xAM7JmY/YazXdJAllEPqcTEIKTHgN3o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=drvRJeO1SVL2A1SmYIViopIlq3xbyTDl42L3vh9gVubZb25zeeO66FU8+giirkEwU
	 tBjLDHd1Z2sAYUCciYfN7HivFLb0iOCDGxWX5xiWeThePP1jzSfur2e+nrOUryR95M
	 ayTRIy1hzvV7uCAFKkR6AIDTM9zpjQY1M4DQ5lKnXk7ue4Fw1Z4WBxu5pcSCT+NCAa
	 rvWvRYhJgpSy7y83d3GBEr2QGlzxO8QtQedPDkWiaVsSTTFtNrmW4FTum4QcJ75Ou9
	 WaGWlEy/V7203sNOiZI4qj4i3QOsQbQGULlYOs9aClTa8jOjZJsjPnDUzTqLusqbZs
	 fo3S7qb7zR8XA==
Message-ID: <24dadfc4-6831-46df-b40f-98842d2865db@free.fr>
Date: Wed, 12 Feb 2025 12:40:11 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] builtin: introduce diff-pairs command
To: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org
Cc: peff@peff.net
References: <20241213042312.2890841-1-jltobler@gmail.com>
 <20250212041825.2455031-1-jltobler@gmail.com>
 <20250212041825.2455031-3-jltobler@gmail.com>
From: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>
Content-Language: fr
In-Reply-To: <20250212041825.2455031-3-jltobler@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 12/02/2025 à 05:18, Justin Tobler a écrit :

>
> +
> +SYNOPSIS
> +--------
> +[verse]
> +'git diff-pairs' [diff-options]
> +

This should read:

[synopsis]
git-diff-pairs [<diff-options>]



> +DESCRIPTION
> +-----------
> +
> +Given the output of `diff-tree -z` on its stdin, `diff-pairs` will

Please do not use the future form when describing the actual behavior.

> +reformat that output into whatever format is requested on its command
> +line.  For example:
> +
> +-----------------------------
> +git diff-tree -z -M $a $b |
> +git diff-pairs -p
> +-----------------------------
> +
> +will compute the tree diff in one step (including renames), and then
> +`diff-pairs` will compute and format the blob-level diffs for each pair.
> +This can be used to modify the raw diff in the middle (without having to
> +parse or re-create more complicated formats like `--patch`), or to
> +compute diffs progressively over the course of multiple invocations of
> +`diff-pairs`.
> +

JN
