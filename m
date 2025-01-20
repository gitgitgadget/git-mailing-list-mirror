Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2746AC2FB
	for <git@vger.kernel.org>; Mon, 20 Jan 2025 17:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737395714; cv=none; b=oe1W+naKsmO2rPXP+o4bhQm9HLHMknqmdWmlH9HN6ishiiDrR2yVPklxX7CyhkRjT2YRaS7VwzwC/Xi0anfPZL9kTazf0nYMIX6/NMbACeGor9sHgnsFsdTfMYBkVfWBBaCUHSfe60miGLy3d5CK/uq5sKsUENIfYcY6IylFTS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737395714; c=relaxed/simple;
	bh=Cx+f++xECLTftHHecggCrIuOofgOEq3oT0bIOezd1ew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ng96mYioYcX3hkVDvt5C99xj8OA+S77ggWt/UTZ4ZTjCJylPdOubUClxd5h4ERlYCuUXslJKPytArrNAK9Stlq7Snj2jOOgetcbheZJngaEansW+0Cv3FkfxG4MmddzKAsmCm3oEi93M2AKGzW9GuI+HMM1JeDzPnQKXoHcuCJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ffq7kUWr; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ffq7kUWr"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5db6921ad3dso8808215a12.2
        for <git@vger.kernel.org>; Mon, 20 Jan 2025 09:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737395711; x=1738000511; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bDyt2GqSFGurqNfwl2rlRbh/usLk8EXxtiV0RaIIpPo=;
        b=Ffq7kUWrW6QVuGJilAB2UnezL2opUzLLh1m+mwqE3uQShaLc7C5WIQyndClP0u+0Lb
         tx+9wy7f8V43dhBiYTP9+eEDzZw6q+1DZ3m34TutqV6a0Lukqy8sNAygzEw5tdH/1UDU
         2pAC2Te8N/1aLcKFTnUNTk/sWzhIQvpIBUzU7+5LMt/M1YnGRoUG1LlbB6T1l+7aI5hC
         MvBYF4rQXzVrKOHRRN9yquy+imvkUEcFiKnnlVjZbUWMrz/+9LkUpGctM0MQuqDREQzq
         9Rh/QhKzHAjxGRq7nXLNeiwRaYEG+1i6+M9kpQ59M7GTG4lQRNYI69jPoozefsgJXldE
         1Kxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737395711; x=1738000511;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bDyt2GqSFGurqNfwl2rlRbh/usLk8EXxtiV0RaIIpPo=;
        b=GJeRmXPQNQKRTgoN24ngow9N0dWivmP9fUcHgcITxG7kWbzX7nyGLAvY59eWO7XGvV
         h0U5f8L/FpbbgWRa38P0efaElwIkNQdpYGIE9CIJh4Jqexe5X4Z4gaLFKN4OSEHpKmQA
         RulchXU4fELrNn/eqdyLJfjyrliiAcn4vDj3LSj9oYF73ixodo1roFSZFnzxEWVd9W1g
         P2tJn3RK1NL/3tP/umgFs+S7eqCQBy4WHSgiagspvn+hImXMm1mrEQldpCyx2bdRG8u8
         OubcmtEZd3f6ZFD6aw9vRuKc4L0d9NZXPGdnav6GndRq1C91gutFORMOb0owBTE1LWMw
         MHGw==
X-Forwarded-Encrypted: i=1; AJvYcCXx15U+1L2XcpUyfNMhX01dabXaWwliC18StX7ZzHa3HXrR1+DolQlyoI/4/S++E/3ztTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJE62TL3lZ+V2OxJ3L0Gq4gccEopyQtKBzL6s6tHEgzA4E/vSy
	/Av5tlq+FsNkUYpm557QnMvPGpA+/3VfpnnC6d2b2rG26rGSWCge
X-Gm-Gg: ASbGncv69ZAZEp+GLV7TEPtcyGNS8iDgdRGz02ZSa4oHQ8ojpOgczceaL/eZN8DSY1y
	00KxQlFkCaZDNMZh2Er/GI+icY5MunJEfLSS+mCO6gYJpTEe1zPQQovP8nU9cLSkBsBdXVSGqN9
	vzXRNnskIj2UxALm17ZpeViQz39olQL2NYKOgg/hHiCZM1MhINV5ZNOKs30BbTzFB8mJ+5564mq
	dXTU+l/xoJP55hxjmwIkkIGivZ1qsWgI5gl2hj+i2kAGL2fpuM80egFGnQr0ziX4geQQjaFsYIQ
	KAJcoMFnqTGRB9baewfxYg==
X-Google-Smtp-Source: AGHT+IFZO2YRIEFTkE96dIV1leAvpmGqbxnBdVGcnOHQbSZIPlCaI5831b5xhEEpA5/eVIO20Th2kg==
X-Received: by 2002:a05:6402:254a:b0:5da:9d4:ad6 with SMTP id 4fb4d7f45d1cf-5db7db0782emr14904128a12.28.1737395711066;
        Mon, 20 Jan 2025 09:55:11 -0800 (PST)
Received: from [10.125.231.39] ([217.156.233.154])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5db73670cf8sm6038483a12.19.2025.01.20.09.55.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jan 2025 09:55:10 -0800 (PST)
Message-ID: <f38cbccd-00d1-47a5-a891-817003785c7d@gmail.com>
Date: Mon, 20 Jan 2025 17:55:09 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Convert AsciiDoc files to .adoc extension
Content-Language: en-GB
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
References: <20250120015603.1980991-1-sandals@crustytoothpaste.net>
From: M Hickford <mirth.hickford@gmail.com>
In-Reply-To: <20250120015603.1980991-1-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-01-20 01:55, brian m. carlson wrote:
> As mentioned in a recent thread, our use of the .txt extension for
> AsciiDoc files prevents most editors from recognizing these files as
> AsciiDoc automatically.  There isn't an editor-independent way to
> override this, so many contributors miss out on syntax highlighting,
> linting functionality, and other editor niceties unless they manually
> override the detection when editing.
> 
> In addition, many forges produce rich (HTML) renderings of AsciiDoc and
> other text formats automatically, but this doesn't happen with plain
> .txt files.

Fantastic. New contributors often start with documentation changes. 
Let's make it as easy as we can for them.
