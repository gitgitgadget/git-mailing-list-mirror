Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794329265;
	b=bTCTp60e/htXLfZCYUdV9Hlu7mxqJU04DV1C72r2PJvzcsgFJjBrFfZP80QNlf3ZfVyU
	 OuibhCTxu/iVkopSo4urpSzdM6PEoFQsmzYvp0hZTuKG02L+5ud1pxgKF6H63z7GWFIWI
	 nKmgWFF1OhdzfV77N0ktZYcgjKTMF2ic91ld94LldbU4exA2Gzcf1SXaC7v+f/Fwjy/d/
	 eKcP35zlWzEb42j7suEo6mKyGiqEaXyg5PhU/sHssBkCGVSAfakO0UMzkzh+vuDJXr3hr
	 n0h7RajzeG+Z/lYrILp1rj9iEA3ax1aUJSnxeMCFyZraw7AJnip0gH04HOMMSF+pc7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794329265;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:From:Subject:Reply-To:To:Cc:
	 References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=lrdTbngnPzlWuzLLoGWeBdGw8nMbpOVWxiXCI4OC8KI=;
	b=Ys4gaYQjON8RAU/nexsxX6imAoMSH0yAPqXV/TbeB9H4b8pMdd/E2GQuugzdgDn/Yncz
	 VG1vi+cNGgJ00/51ArIQqQ5+S7t8jfTwrqn6TB7ZJzoiZSwReFKSHXci1xy6BCby6Z5uh
	 FUV6WUF+6qV1vGYJ3Ed6GNWprR3oo4lFcj5/HQMicG3V0+Z+WLonISY/Sia8Yj9XgfAmt
	 D1yVGxpnaka2SgO+ynSw9uA+Df14bB89RQauBmwumtH0RqFReb1/C4O4WjDq3n49uHDM3
	 CL78jeddP3aG2pnqOILPiHEQnRgFWSnIcbickn+3Xp7XMT8zJAUJep1VHRl6EIxsOnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AaHY8Y6w;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43B1606A33F
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 16:47:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E43B1606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AaHY8Y6w
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48e1d0e5dafso1507844f8f.1
        for <git@vger.kernel.org>; Tue, 10 Nov 2026 08:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794329263; x=1794934063; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:reply-to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lrdTbngnPzlWuzLLoGWeBdGw8nMbpOVWxiXCI4OC8KI=;
        b=AaHY8Y6wsnvdKoVFMmJ6jN681tkTL+F32v/Y0YQZWNZWHokdITOFBfUrgpdR3RNGdZ
         /1/KEUH4+2jRo5hbmdgBWtG4+2kt4W0VsEDT300NIspKiwn5ZaFoBCpy4TXnyF+LBkES
         o4TBS7J64salwl78VPemNr8+vw5gI8ddwFNKT3EGyhWiOwivB4RLHKdAMM+xB6qvUva1
         xIb8yAYLU06IfVyYzKlEcLfrdLSUDQ9VWj39hcq7n+GEwcNFrVkUVquDM+aEfu3pHjKY
         S9ZbnuhiIa6FeyQ77OYRsjDRZEgpJ0iGHdSPy4F5X08nBLRqcvY8mVY6Hi0MDjEAAb13
         EV1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794329263; x=1794934063;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:reply-to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lrdTbngnPzlWuzLLoGWeBdGw8nMbpOVWxiXCI4OC8KI=;
        b=aH/tacVGLbhemmlOyCDMi5BBDx1zWA0AI9harMgOcezc0Zf3BNyQHQT9JkSU+rLk1X
         Lzet7Z/o8NDDFpSGaRsYFjTgXJan4U1RNS6W2KrvO7XrBv5tmzXvNnCD2OkNjyIHRLiB
         HjR9BwtHg4uXSNS02CZRw4ntq/d2IjjcwCd6TJj6ebl6iEMAaWMPDEWiJhUVPgqSpP2a
         wZgB25LAHWFsU/7xrG1GcYCkyMbthvj/4dC66P1bCQNBgBPq+ivxmpr43NGFSRwxKd5c
         6JZz/s5f4szdYHj6F4jEFskB8raQDzpRwZd3y7emESABA2tmfHJbgc3S0s4t2K66r9/5
         /aCQ==
X-Forwarded-Encrypted: i=1; AL+hErF+seKz5vVEGMoOJqP2jnzSjzg/gRoA+n6xddz8h1YRvLMef8az469ZEXaODKVVZbU0MWg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9W4mwO8MZBJUvc2sjVIxaerbhQ5ZVyRYnsbs1AITo4qxIuODYN
	vbhHvWimYXUEG93RjZcFDPqsyv2AzhLReczGf09wmse5X46NRow+QayI
X-Gm-Gg: AYBFou3kvaPSqIIdLX26qJUlu9qrQhVgxJ1i+foPsLXfqVPqzlyS9CVfSFNMVgdM+X8
	TboA3l3qAtTeyruWS5AcNr0hlmhjFiaVMQH94+GnhpAUC2k/TjyADBWjUed4dVIk8g4I0XH/C/f
	0IezhYjURR29V+sq4MBphMVedofHmuUoVOLIhbbUZHCcuFzOr++RrjHuVtzZO0CglHbNgHbj4i+
	1CTL7qOuGf2CmmFDWr0PU/smk5IWS81BnEp8MQpJjEtakHfmP1hYLyZWtUCFxFSZHR51JhJhwwZ
	++CMYJ8ivXpuXAoX58gHDp71IdXUXjLh1pV/ElX80EEJqjAChredkND0ZK/+kcc5oNCZARvNr9T
	jQswfntHoHJevcZ+iRvs2FO7NOMrVFJUlfx+tDo7hQlyvIztlliS+/DY0aHqKU37exGh9sTm0zO
	RTDoWbNcmP5vibT6+dV0SD9fU05NRlEnBCrRnttYSZs/Tfmm+EijuguIvLxgGG2cIgWmW1D4ZnC
	iywY6N/ISYWv03T2hjtWXVGX913lkg5QKeZQiaW5PA4/ebNIGUIJy/S1rFkCyP2mss5DbqfR11U
	sape/+dphNKMYEnS9Y5AXk7+ppAEag/PIRBWJa747/Aj+ZErWWIql2ePjNPRriaduQVj0Dn+Qky
	AOd9uOS0=
X-Received: by 2002:a05:6000:4a1b:b0:48e:6264:c371 with SMTP id ffacd0b85a97d-49992cc70b7mr143888f8f.9.1794329263074;
        Tue, 10 Nov 2026 08:47:43 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498366c2793sm5956285f8f.45.2026.11.10.08.47.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 08:47:42 -0800 (PST)
Message-ID: <8358619c-959f-4109-ad4b-2f77a188511d@gmail.com>
Date: Tue, 10 Nov 2026 16:47:41 +0000
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v4 2/4] doc: for-each-ref: say how to read %(worktreepath)
 safely
Reply-To: phillip.wood@dunelm.org.uk
To: Jasper Mayone <me@jaspermayone.com>, git@vger.kernel.org
Cc: gitster@pobox.com, sunshine@sunshineco.com,
 kristofferhaugsbakk@fastmail.com, ben.knoble@gmail.com,
 haraldnordgren@gmail.com
References: <20261030142137.54750-1-me@jaspermayone.com>
 <20261102182930.3511-1-me@jaspermayone.com>
 <20261102182930.3511-3-me@jaspermayone.com>
Content-Language: en-US
In-Reply-To: <20261102182930.3511-3-me@jaspermayone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jasper

Thanks for adding this, it looks good

Phillip

On 02/11/2026 18:29, Jasper Mayone wrote:
> The path that %(worktreepath) gives can contain a newline, which
> breaks a script that reads one record per line. Say how to avoid
> that: use a quoting option, or end the atom with %00 and look for the
> NUL before the LF that ends the record.
> 
> Also say that only one worktree is shown when a branch is checked out
> in more than one worktree.
> 
> Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
> Signed-off-by: Jasper Mayone <me@jaspermayone.com>
> ---
>   Documentation/git-for-each-ref.adoc | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/git-for-each-ref.adoc b/Documentation/git-for-each-ref.adoc
> index a7b31e8aaf..9247737aa7 100644
> --- a/Documentation/git-for-each-ref.adoc
> +++ b/Documentation/git-for-each-ref.adoc
> @@ -183,7 +183,12 @@ but if used together the last option is selected.
>   `worktreepath`::
>   	The absolute path to the worktree in which the ref is checked
>   	out, if it is checked out in any linked worktree. Empty string
> -	otherwise.
> +	otherwise. If the ref is checked out in more than one worktree,
> +	only one of them is shown. The path can contain a newline, so
> +	use one of the quoting options such as `--shell`, or follow
> +	`%(worktreepath)` with `%00` and parse the output by looking for
> +	the `NUL` after the path and then for the `LF` that ends each
> +	record.
>   
>   `ahead-behind:<commit-ish>`::
>   	Two integers, separated by a space, demonstrating the number of

