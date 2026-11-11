Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794385929;
	b=NpMGaQ+fmhq8gRZLLUpzX22ob7yWcjpSfSfXdnxOmNIxCSGAkwfT2ZlGue99YZatZHeF
	 eIgvJyi+F6QXALyYceeGAjiHxNL43NWIQbcw1+Nn5iwS2ZUiZuhCWXC5LIcOZgQyG/GFW
	 qUO+SdZCAgMRk+Wm8Wes/m7D7Ymp38leLozlndtuyFSpa/B1PqBaDmWEIPIWdogB42pfx
	 vUph+rY4a7KGAjgALKEb2/SAo5zgeMHhik9qvsLrQeOvn+pc4z23LErNRAwx6lYBlew3z
	 UwODqk0QIKg5hdIWhFdS9cZxLQyA0QM1OI2/NgYwDEH46AUlQcDW1M3XRDW+/g8Atsw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794385929;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=ZhUfwIC3KUY6jRrDEI0ImeK2PDtEy+5HAOX5OdoDoJw=;
	b=NZGg6b+ssoPaSgoeMBd8KiLQDRraSYUU19hnhVnq03LQYx7o0d2A7/URCtY1pQBg3rWn
	 Fp8FCMhIHu0Ljc/9mk3TowwHRb2dm5oLynazFejjhRZ4jf6yKmCtA/O0FBZMSFI5613G3
	 UI9Nqz5/Tsfv8YOG8XInE9tiFXtBbxYHWZvy+btOfmQ01P419esqZU1fz7OZ9cIH2Lg32
	 83hDwC5fVxn31//Ij2yOUcjMA2FVNWADxh+ZTyPN4CHW4/pNMN+iaBjwiqdsQfepk3NHL
	 3gm7lZZQN5yk1uAGKhRPuAnhYISxGAKPopJIuAeKJbUm+AGgQ6/+EGJ0hB6mBsgAP0w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q3TJ6QLR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.44
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7DA606A321
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 08:32:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF7DA606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q3TJ6QLR
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c50604721c8so167236966b.3
        for <git@vger.kernel.org>; Wed, 11 Nov 2026 00:32:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794385927; cv=none;
        d=google.com; s=arc-20260327;
        b=M8bD0DSTltjpb/EgjrJbLnZI1EzN99MmzsyW8qvOokKbpDUSwWIcsotfknGzq7F6LI
         VmNGJRQXre9dPYQxAAbvESYvGeCl+NkJ2kRYnA0Wljlwk1s+Rvt7Fk/T0EdMUBkjk0Du
         bpOCYvWCvtJ90IqLPSUfTbbWgVs/nIHjuZ19vWPyRA5XahT5/r7wylBNhjpECLoBSVaE
         XPp4UxesfKkRfGnicLZlocc8RrTGOYmKKB5+RSz8iF7a+cXbowQfryNukN6TJp76yA9A
         HQkY7mkb26uepRbi0ZefEYy7wGEzWCXBj2LlHH0imbCGLOLZjckJlEqlAaq519ESGsFM
         X/HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ZhUfwIC3KUY6jRrDEI0ImeK2PDtEy+5HAOX5OdoDoJw=;
        fh=F6JraozJT63bWUQfBlcE0UkCJ6hLjBTt6s0PqcRPgcY=;
        b=cpmGKSfslalIFa379y7WLO7m2gfB1ngCz18VXu3F5spnBbW3Q28+foG1+gXnKsD8k0
         ehcMK8WblTGooT/xIebh245Dt17Ftr+qIJWCfNM799dPr7WmtNMqJCA+FBS0Qvgr9+Za
         UQ/B6CvmyQWcNKkIQaJEuP03dll5G84on0SoMdqBjRTGIBiLfMbtONH8dgRdJgUNympv
         nUv8uGAQ6Whjwh0iClBdwplctqe2xD5W1IMyvDIVTONCCgwYbb6KN5B1eBiH2MguGduE
         4xwtE8TH2yi5tYTs2NKt2s5WHIsHtV29X4ThUbJnAJBBK3bv5thKCMPuK6cqBk5qx7C5
         2a9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794385927; x=1794990727; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZhUfwIC3KUY6jRrDEI0ImeK2PDtEy+5HAOX5OdoDoJw=;
        b=q3TJ6QLR9i+ySJc6mzlD+rjBQ38jWyTU1PR7ulP4oiKy9+X0XmobwMsFAraAebnklY
         7OInSzaAL1V5e8Qe6MmbH940QPh3CmKA+9oUxLpZLXTzRmYYBRBkga0XGyeSP3FbqV4V
         5qB5KgWEPXJ1bi5GU735Rg+W3VjcRimwGIJ9BgQJXMIjNHUTiSWmoUtwRLNAHQpaHVg3
         tpVZmoqibG4mrwjkm0g04C31+XAgtQaaztnDU9CBG+SRPAXAI90fYl66qkZVtQKb8xgf
         ZWkUJ3MyJgxSD9JiwLl+m6Slh6LhMkvZZT+Cs2jewBJTNyZ/s/cgVfsa1aRTLR28Jkc9
         WRew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794385927; x=1794990727;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZhUfwIC3KUY6jRrDEI0ImeK2PDtEy+5HAOX5OdoDoJw=;
        b=wnotCe0x59o+CyB0Suo7OqCYA1exfeGxwhckVkWXI9sZ9KLNvnVdAG69QqTNsh03Fv
         vc8UnH4WefcnNu2nqub56PBGmL7DHS5Q2OsQquhl2LgcjgYRNyOAH3IJKBM+dWrcD25/
         7nWlAV6lk5rjsf6h4ItRPvAYabZlF4Z0AeO4dopdvrWDdiKH4ojMLSlsVPazlstVktB0
         JlEpWuZLJ6Pnz5rS70ua8SdCK7/CwAXQCoUrWf9/vduex3RpgDDHT9nSkKtOZSfgFykN
         OUW3CW0dOr1M2sluOlKx2iAixUy3cISSexnuWfPZhdxN4yxcFouqEPJy5FwLX5R8OD1A
         FZag==
X-Gm-Message-State: APuU4Z//x/yD46Op+Sh0e7I5DtNYJvwF737dBJpejGlMvgh6MawrlGTp
	ClSXyz6E8ZHgy+Fnwkli9h7apl4/XjgLLjCZB0OJu2tXQPU34509Ux9mm4kC/WOG/yZT/qs0gbb
	xkZFpkzOyCnKIXhmHOxfXiBzwLe9SF4g=
X-Gm-Gg: AYBFou2fiRI/Jy6/Fu8BFBOYq5A/a8JZ0Oag2sIvD3zFKuo9XADFQTsLB/45VhdAich
	eNP+dqhVtM2sYjSi+ORFU0bseWnGkVRqab3EKP9I9MRW9WeT3nJzxcRNT4n2xrad0Q1w85orCow
	QMkechw6Url5w0hFWMw1kR6qGCqF5dsnk/3/+c4bYOmv+56ipcJjeLS3MGuOLw5/P2y8thw+uaT
	mvUPqWVCsVwCgYW9R+5nfxo+6aKqHVXBrZI08dgcbeX0y9spvdbtLhBtlT9pff0bYLpp7jKqBjM
	Ub8TUL8oUqIrex5QwQbf/24y5SZ+h8gcjOVt0Mnhh6qXdBm2teHXY67o+aeEY1f70yT8Lt5/8MB
	nvesIZBj5GazOYe0/LUZr/tnlgtwZ2NWcf62m
X-Received: by 2002:a17:907:9485:b0:c25:504a:1e25 with SMTP id
 a640c23a62f3a-c5066a832c7mr115620166b.13.1794385927262; Wed, 11 Nov 2026
 00:32:07 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com> <pull.2412.v13.git.git.1793357550.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.v13.git.git.1793357550.gitgitgadget@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Wed, 11 Nov 2026 09:31:29 +0100
X-Gm-Features: AclHuK8sNGpCLZRiRDYfij2_3i5VCo4SCdF-0zK3CyEtR2S7IT-Y8B4-clRHjaY
Message-ID: <CAHwyqnVJ3eUQ9tkQE3rhQ8jFZjaD0tFUv41unE-NQ1WRiyfjBA@mail.gmail.com>
Subject: Re: [PATCH v13 0/6] fetch: avoid fetching every branch of a new
 remote in a shallow repo
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>, 
	"D. Ben Knoble" <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi, could I get some (hopefully final) reviews here?



Harald
