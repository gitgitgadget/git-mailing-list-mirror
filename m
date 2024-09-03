Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D201B12C3
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 11:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725361912; cv=none; b=gFkFtmMknG0x7qvmoz5+8tlnA4YiX1LeHNEQ2kv2hHXwAS7iiStw8WCXF7xZmHnseiBvxmrbBVWEvk7P/ZJ0XBRPWMrLLgUNTv2COglvJGvIMZTeh6l5+NcakMFBF/Ehl77StGq2fagTmP96p+I9I4iSjrJuSA78zbQrfPQWPf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725361912; c=relaxed/simple;
	bh=SYYFpl8Jjon+i+e5M0p8C0t0R5/iRILBd0fdIx9YxYg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=eUlwL3wjSF4L0kV1+P9RdDcijLDOAoENzgzffgV3z4CgCAzykcw5mz/qbXdVmi+fa5pbwC5DfvJwJ+IrLzWgJKfZOXamJsyYYN9H2Z4JNbNCdknK+NLn/ZDdKU511USnNJcLTqTCCyYrzfXi/QpTqrXPAl1qYbfYrIib7xFnN/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=AN2Hl0EP; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="AN2Hl0EP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1725361905; x=1725966705;
	i=johannes.schindelin@gmx.de;
	bh=Titzp2qUeP3eWdbg/9KL/lfZoKrlwdioj3L4pudwbKc=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=AN2Hl0EP1urivE4IXagoMItWk3Ro0VtliBJcSoVtl+zSzRck0HlvCrrsvheP1IKd
	 /w0fAY1x8GYbS0tB+VdJdn0OAz0sDEGo2Q6Te9xHK2SY4aGs90VbqzH7pc8TXs54O
	 J7it/1yGn0UOE5+qWvpdw7V5AjYHBuZauLVrUfXG6Q9lFMfetK6gAK8ETCMlwgpKD
	 wJVJC2bBkogFTvK5SlamtVcSsQZ5hlUOGpukoihmiFEYsMs98MeInOTgzOxQos1g3
	 7Rwp3LiWJZGwFD4ikZ9SuCF+LutV2IldIvkTe9uIj1cZ1vQDme7XBKZ3wzGo/j2AA
	 OZW8MM12nZT5ElsC7g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.214.88]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M3lYB-1slAKg0tfv-00CpQ0; Tue, 03
 Sep 2024 13:11:45 +0200
Date: Tue, 3 Sep 2024 13:11:44 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Alex Henrie <alexhenrie24@gmail.com>
cc: cogoni.guillaume@gmail.com, stolee@gmail.com, gitster@pobox.com, 
    git@vger.kernel.org
Subject: Re: [PATCH] mergetools: vscode: new tool
In-Reply-To: <20240902025918.99657-1-alexhenrie24@gmail.com>
Message-ID: <78e1d2b8-4d22-9bc9-ec5d-aaa072cbd393@gmx.de>
References: <20240902025918.99657-1-alexhenrie24@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:5a7sYoepdnxwT02oMPc9b5j5m9PeNiQGcvHeIromoTP/DPrfVUZ
 8ZYhBHFmGG+gwxM6Y7gGZcbd/dhfysOInvb2oerODBxGJL7CcCdsEy2Gss4wQtP97WVXkzh
 kE/6+/sIKKneXoPanmY4s1XtWj/dnQ96u4IHihhefwSzIxXgUCocOr+1zc14Rq7ZeRRCzOQ
 HAVYuPMSptmwfNaMa0xKw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:v+Nrfp+6MPU=;PVLjpWDoLXqP+zY3SFMKFYsnMIp
 1yW6L1T+3DebxElKFyjxqUxhsEtK+BrBF636vAE09ebNvERHhkWBIPJg9jaHZro7H7R5aZCvN
 IjQNl9cQdSY58MJOQvvi4cf4VhsC6FySPqy217kS8ROkUl8osEIxugfBHnKjNSOzt7QkGRncb
 GSGrxXow3Y5mq8zaBlzK0hPAZi1ZN2j5RIB1YhTqUS9pHQ/2a8k+x7jhwHjH2pY8koNu5AkNB
 g0fkQfXfYVse7cqQ9t5T/fySqWPxbtkamlS8v/uolm7eVBnghqiwLItVqEAfYdGk8malB982B
 L5uq87l43ybjo5KFZnQLinq405A3pdmXDCwQhB2q/Wzc95g4z9eNinAGjPnbixN4hoXODhCfd
 JeIFRGOeMa67LKUFksmyA9PFGDYS/KVPBaGdo7jeS4fRhTZCbZzMe8uERN6+EcfEOMDbU85aP
 t1shLoOjlZ97cRZQJDrbASNBL1DsSo2o9+tNY+LPp9Bd8l5+e4UYLnLfeN3Shj2IxW8jJqWBz
 tyTspcEeLuVpVZUgh8dYwyfps2FbC/HCeujzrlBHsmn+DBiDWs4UvKsUtMk8zjiAgzpV7GZpt
 m+33WLTvqAY16zlazyqpGusJByIeyfTCATrZczV9tNoyDSG/1+L8cAhhlIjn3wzpdHjE4Im7/
 zAtOxqS6cb5+bJiBWfydW0GcrLQjzJoSzgQzpnZU/aPA6AZYaqKsJGwHisyPpicf8xZsV1wBy
 HtHV8sUM9j+PdHjOhc2X2R0M3/9hFxFMdAd+kUg/rutSjM4ATlIc83GbP0vbK3qZKDUv19+U6
 sdS2t07hEHE0yZjEWRZ1Gmzg==
Content-Transfer-Encoding: quoted-printable

Hi Alex,

On Sun, 1 Sep 2024, Alex Henrie wrote:

> VSCode has supported three-way merges since 2022, see
> <https://github.com/microsoft/vscode/issues/5770#issuecomment-1188658476=
>.
>
> Although the program binary is located at /usr/bin/code, name the
> mergetool "vscode" because the word "code" is too generic and would lead
> to confusion. The name "vscode" also matches Git's existing
> contrib/vscode directory.
>
> On Windows, VSCode adds the directory that contains code.cmd to %PATH%,
> so there is no need to invoke mergetool_find_win32_cmd to search for the
> program.

The commit message and the patch look good to me.

Thank you!
Johannes

>
> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
>  mergetools/vscode | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 mergetools/vscode
>
> diff --git a/mergetools/vscode b/mergetools/vscode
> new file mode 100644
> index 0000000000..3b39b458d6
> --- /dev/null
> +++ b/mergetools/vscode
> @@ -0,0 +1,19 @@
> +diff_cmd () {
> +	"$merge_tool_path" --wait --diff "$LOCAL" "$REMOTE"
> +}
> +
> +diff_cmd_help () {
> +	echo "Use Visual Studio Code (requires a graphical session)"
> +}
> +
> +merge_cmd () {
> +	"$merge_tool_path" --wait --merge "$REMOTE" "$LOCAL" "$BASE" "$MERGED"
> +}
> +
> +merge_cmd_help () {
> +	echo "Use Visual Studio Code (requires a graphical session)"
> +}
> +
> +translate_merge_tool_path () {
> +	echo code
> +}
> --
> 2.46.0
>
>
