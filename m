Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E1078C91
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 04:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748923547; cv=none; b=uD3Mp6giu5I1RHylRe6N5Oz8JEUSJZ+QuYYZD5saOKBnArHuLbG2C3oxP6lwrCYR0HnWqkvQuJfdnLkTUYudtYtKbZiW9ptalajvKt6DPy4z7Ih6jKz1hwpI8rCiOEIfbRtWL+W9Xw8zQlopJP+txwtMvnnYWcqhWDGnRxkZqQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748923547; c=relaxed/simple;
	bh=EUp0TgCmyCiPnmokQnvDeGVdTGi0ySxXNRlMAOxMX70=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i9o6JvY5dbvEx9H1yvoRZZuIaqBVPovKbXQj5DsDF1zCUqwTMREj2LxDdD8xlplSn2eBx8aSazApCMdMJNSwsmMkm1ZdB0XkquTNk56i1PdBVoTEVBC5xBqHa5ds/3diNPWnWhdZlXoh09oGOYWkuXXVQT8gpVj89tjKE56IhVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S59qI+gh; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S59qI+gh"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22e16234307so42417335ad.0
        for <git@vger.kernel.org>; Mon, 02 Jun 2025 21:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748923545; x=1749528345; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8PLpbKtadhE7bTEgCnE98uyoURO8ksMTVnFAKjEhI9M=;
        b=S59qI+ghAsYvuYazA8xYR8tnanpZ7RNGE96NlYDf3LcU53pdy6G6DxGOfyzs72Kj1c
         CU1GG9Lm5qab+WuDuebYU2bQ2eaF/mb7ecWqiEA156N146lL9zG9nyCmNvvUMEiJJwW/
         cJ1N+CnQZtI2ITv6R4Yabj62e2mVN2XTBnPI0ufCA2VZib1ZBRGy1xqsnBBkbQ97DlZD
         bGheAa+rvTadug6T9AN0WJhWTBS/NbFaSBzgX8yg/54pwusjgfQVbgrTASVG1c2zkizw
         PTRWohlrk6mDjr5GSuQJsnigiZGeEGxSaHM+SiZryD2ogcXUTDJumINxPkMzw7E4B+SD
         NyBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748923545; x=1749528345;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8PLpbKtadhE7bTEgCnE98uyoURO8ksMTVnFAKjEhI9M=;
        b=cbZIzvI2ZMBLSyQNqVgCuHgbEaxkby+G4zqRKHZnMLHh12uqy/MiidfllaEoQe/nrM
         ebLh+4XXjnCMLc4fLKWOFHN/x5QK2RPIF5+kYJQnGrzLPRJHzqO3T+KykF+awDEWTGNu
         giC1GBvd7UqtpL8eGaFDzHr/y3x8d1VFKfyjMN1nox9y9cs7yR9jKTwsxLw+GHjuVlZ8
         3fOrK/pgQNxgn5egVDd0SBN5rlNYpTHTyu01EOGmsw4as6wlz4oDPh57+sB0nNz/CHjX
         if8y1ulfE971WJhRPWp/rpwrQl1lnkNXEp72rE27xXxSrj8SbHe69i4HFYdoqga+QrHz
         PyFg==
X-Gm-Message-State: AOJu0YyyiKhfjn4Ylw3EogxaHgoQMqV3yZkDeR+N2Wg4HBhliNfyHE3L
	ZPLo7b76rOzqexKquQbFVuEIuEcDYiTNSftCtBXaiH7GTGEdC+xepVifyjdfSA==
X-Gm-Gg: ASbGncs9okSgLYHUSUwPOndHDZgsDXf4zE6po5y8+1CzjUoT0UPh0bJYDyTOnsFvk/1
	iHoiHSXmsp7Lbr3G+SR9ce6TyKIptvsRXj4liOkarrYeXT/qyoCP8ZW3t1KNW5g/H8OPhfeHHlu
	p+k40BswOmsnhygEHTUAXvG9sOAZevAwLvDlGPEs4SLW80YZOwwPlOJ6g7nBmzF6tZcTjeOfMbS
	nFjnUR3o3Cwjh4H12JPp3jO98w0iWH9SPh3oNH82ytSA27u2WIwKiIqfyxgq4jeahHuo0fciZNU
	s1LBGUCTxEChM5u7ew4+/1XsvviRvqfrdqWtz5gkGQ==
X-Google-Smtp-Source: AGHT+IH88kjGQ3xCmPZLrKXfj1s4tkreRqOu9OrciBuUaD29B0YvLHHN/bsYtd5RabYfV1rDU/x3oA==
X-Received: by 2002:a17:903:19cc:b0:215:b1e3:c051 with SMTP id d9443c01a7336-235c9d95d68mr14199495ad.11.1748923544961;
        Mon, 02 Jun 2025 21:05:44 -0700 (PDT)
Received: from fedora ([2601:646:8081:3770::9eb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506bdb4besm78476365ad.64.2025.06.02.21.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 21:05:44 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: Brad Smith <brad@comstyle.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] compat: fixes for header handling with OpenBSD / NetBSD
In-Reply-To: <47c58a78-d38b-4170-87fc-c9332618d0da@comstyle.com>
References: <87wm9ut3uo.fsf@gmail.com>
	<47c58a78-d38b-4170-87fc-c9332618d0da@comstyle.com>
Date: Mon, 02 Jun 2025 21:05:43 -0700
Message-ID: <87y0u9qxk8.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Brad Smith <brad@comstyle.com> writes:

>> Why remove this definition? I think it might be useful on some older
>> systems and seems harmless otherwise.
>
> _XOPEN_SOURCE restricts the build environment. _NETBSD_SOURCE is added
> to counteract
> _XOPEN_SOURCE. Not setting it in the first place provides everything
> by default.
>
> I was removing it as it should no longer be necessary.
>
> But as said, it is harmless. I can leave it in if desired.

In Autoconf's AC_USE_SYSTEM_EXTENSIONS it is defined with the comment:

    /* Enable general extensions on NetBSD.
       Enable NetBSD compatibility extensions on Minix.  */

I would prefer just leaving it for any old system that may need it. Or
in case git uses features from a recent standard that might still be
hidden as a NetBSD extension.

For example, POSIX.1-2024 has been released, but most functions added
there are still under _GNU_SOURCE in current glibc.

Collin
