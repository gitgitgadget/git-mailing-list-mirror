Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985562EC0A5
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 04:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770697228; cv=none; b=CjukFcdQ5RouQYwJ47a2fNgabl3EGG3VDhxbSCdwRea/PwdPk27hUi6MqtE3Np4QRlOqXNc0a0oV6zTPWgLesB+psujgl2tSxzhJwCP7RLvsgMHi/KKNbv//61GfokC2RE4a1FVWbSTHMxdDu7s6rCnktPiCe4iUeIVSWxfq95s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770697228; c=relaxed/simple;
	bh=E74OKuyKUZaWh/jRZzKEhSGjKKG2i+nRNOoLgefyrtc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XUMB8RL2fhysvpJyOjKKesFrPb04xscPqALuyBmaX9KsvGHA+B5Ap8nmuhIrV5PBzM9quSgGISBX/Y0530/e86h5QtpNQAnbum3grp6fpg9s3kR89zkRPFSO1yJENqGuEaT+ym2+sL6ljJO9rxsG65e8HVlUweF5ZMbwxjAGpeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hjOxukf0; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjOxukf0"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5032e951106so3381401cf.0
        for <git@vger.kernel.org>; Mon, 09 Feb 2026 20:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770697226; x=1771302026; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X7Z/wow51LnDRt2s9OoGwaMhDN2cq8Z7Qrcl0OrquaE=;
        b=hjOxukf0BlQ7vzRnjT7Ubf+yc7sCfS/47MnGLXw3UlUZB/84P9QyXgO89EIGa0pevi
         Iez5AZqOnuZ0RNKH6ZlfijuX/3bL/Lf0BjdC76DE/n9kpcdxNXCKRZLvQWacMTWy77v9
         CB1AEyVGS8s7D6/tJM72TDHP4MSrm7zU97C7goRB66/clf7I++ITgBHFS00M+2BC70l9
         POVZYgUf9/QKMcCHEHMWjg/I7v2vGDQ3AT8wqvnHz3k2crzusgp9PsXA4dXYRArXppLg
         f/rRJ9wdWfzRWoiBQW2VAw6Zr6vQCzfsq1Mk8ToXFJ2RZTCUkgfcLc4u6nfdDYTBeY8D
         NAIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770697226; x=1771302026;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X7Z/wow51LnDRt2s9OoGwaMhDN2cq8Z7Qrcl0OrquaE=;
        b=bwIV4WTNBqWHKPI1rkMLclfcMyEoAgnw8XqeB1sHGLpE8Wntixrkt2fK5p9RxQ7MWc
         FEYy06f6JpqrDrLRdtt8/SzHZGC9sZNUDtXyswJdiSVBNAXisXbupRdJiBVKaxCurePf
         F+6VBS+X7EeQIB9odx2RNcnPx7L5LOFVfEZ8QenRQMmHridnwK7nTUMPMzjUtkcCn/W/
         /KXVrlHCrw+LvAEP9c07QQbI6yjnoZY/3Ax17tTsvqhcluuEfF7FPQwNQGB/xWjOy42u
         bsKn40JIhKiBvbpRRhEwwGZgqDby5kxdV7t3w4GWbxCZbwL2J6Ck9ydFZ4W3Lgl7PH9i
         Mx/w==
X-Forwarded-Encrypted: i=1; AJvYcCWYcuQARJ9uiJUcqKO5oa3N4o75gP05dncWPrMNZVbRrm0N/8IKEg1NeXnS/k0AAeuf29E=@vger.kernel.org
X-Gm-Message-State: AOJu0YymjDmMTA7PTEM1oD+izFHBL/djrbSikoTxKYWePUMSPPvI5Vov
	uaefVSKfSYAOf1W8nY2G3GnW1XfLu5DYeQllq5JQSN+RRWHPV4ptyFAS
X-Gm-Gg: AZuq6aKlhP9UiGM09JC+esrrcyqe9VK7z5qUtLBbq8jj6qrjSywkG09bd5y9z824Ki9
	u4PTFIppRKYt8/+WU6DsyI49T/qL9gNE4+eB5tR73bn/x+rlqCvohNVGCisHdpoXYgzyaOUptZ8
	BoZJdb+xv4WFic3ZSLQ8bAIPqOHw9vCiqloOPfEuhz4MpgGwhzZ94dFRkKxh/QjsRAnjfRxRTPE
	KETHuenBOwPGbQebN3kbRq3CCqppLh33oD87ZUPIRTFOfig8DUmA1S88IUefufJ+ayqc6A/E3Ne
	64YUTQoaqNwkInpEs6c/75inJB9iDPxciWL69EnmKYhJkdS6LX8855wDeVGsD9wuaHm4aPm3CR7
	5RcWEnEQ3XUyC4FVF7FYTVGp8DYjqgpRi/j1G4ZAmZFooVT8GXUKkfFeVp/xeoHKMBdb1QF3G0P
	P+gMbxDRF7Iju1f+KdmgnqdARaLlPn6lWKUmKHKk0XcWfRwWE2MFYEYyxh3QgRE3ApQeLW4Q==
X-Received: by 2002:ac8:570f:0:b0:4ee:1d84:306a with SMTP id d75a77b69052e-506399a0cd7mr181024981cf.71.1770697226544;
        Mon, 09 Feb 2026 20:20:26 -0800 (PST)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8caf7be4257sm943572785a.19.2026.02.09.20.20.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 20:20:26 -0800 (PST)
Message-ID: <d3a49329-ce24-406e-9f33-10c623f40df6@gmail.com>
Date: Mon, 9 Feb 2026 23:20:25 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] config-batch: create 'help' command
To: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com
References: <pull.2033.git.1770214803.gitgitgadget@gmail.com>
 <d5e0c32497581e6ac4890c6e71c5c33b92d67d51.1770214803.git.gitgitgadget@gmail.com>
 <a023e4a2-e58f-49c7-83ee-a84554b83bc6@free.fr>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <a023e4a2-e58f-49c7-83ee-a84554b83bc6@free.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/5/2026 11:49 PM, Jean-Noël Avila wrote:
> Le 04/02/2026 à 15:19, Derrick Stolee via GitGitGadget a écrit :

>> ++
>> +Here is the currentl output of the help text at the latest version:
> It may not be wise to talk about the "latest version". If the manpages
> and the git command are out of sync (the user compiles her own git
> version, but does not update the man pages), this may be confusing.
> 
> Is this specification of version critical to the understanding?

It's important to talk about how to build tools that work against
versions that don't match the current documentation.

If you build something against v2.58.0 and we deprecate them in
v2.59.0 and delete them in v3.0.0, then the tool should know that
the command isn't available (and maybe it was replaced with a v2).

The same holds for someone who builds against v3.0.0 but their
tool is run against v2.58.0 and the feature they want to use isn't
available (or not at the same version).

Thanks,
-Stolee

