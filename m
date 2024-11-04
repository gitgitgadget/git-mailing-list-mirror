Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332B61AAE27
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 22:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730758341; cv=none; b=lEw0JXgb/DbOQNOa4IQzKKcLQwArnpn2VywEfhRkYYBNCZ2+rWhFnXKYmLJUJzb2cvkWqAXFGcxdsSgapXcK4zTomVvI+7YeQkfkRPb3y0j/eSx/kpJBELgJOoJnIdsobXWshRL+JR7ca2DFhJgd8QhoRyjEfwcWbr6wYtzwl7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730758341; c=relaxed/simple;
	bh=Og5Giib6m5opFQKzsLdwiQSwqeoLu7+pbEZTyhDUqmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BUBhbdTHjIQc+EA95sc82lhdc7liXBlfYy8juubIKDUHJUkuojJpt/zJdTuQXhW13Bbw+Y4Hdp8FtYHVNG+XZhhXrkzz3b6YRyYqh2X50ovwq53dSU3Va6ieup1HEWvVuNeC+ZUh9QJDLZGrrCfxueINX5kNAPMA6C8B/HhLA+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c2jf5n6a; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2jf5n6a"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-718186b5c4eso2052240a34.2
        for <git@vger.kernel.org>; Mon, 04 Nov 2024 14:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730758338; x=1731363138; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+78J/BjcHGgL40C1LEGE9L0mT6dxJYof6I7G3AAgjUY=;
        b=c2jf5n6a4JhCQYpulGnnr4P9I0kQNndQT2qicN5734dcwle8+K2qIJLvBII6fU7jYY
         8Ft0eG60A8PIlFj889zinp56dpAoXMhC5/YhO1JI9rdWqxi1WdBKuwBWWSd6TMJQtwjd
         Xbs7whigp52dJ29onp2RrMx4n553bIKFqkYv4yWn+IkodTf6iMJF+eQsb0AZ6eDaq2Tk
         3Nc4yLYYmNN9V87H0akQD+I03pOfZuOWah9QfN/5rxBKSD5ccRTUETtwXx65dmN+iQpL
         qOAhRjxyTXFPBcHdd4YJ5wEsQphb/ik5nLLmrvkfzrPiMngO0LfxL9RP62oDWmDRfKij
         sovA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730758338; x=1731363138;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+78J/BjcHGgL40C1LEGE9L0mT6dxJYof6I7G3AAgjUY=;
        b=TpcCtgJjzQ3JfQVMruaZmwRl/Lsu6GP+pdRW22DkHZcN8H+2M4TN8bSAymfjsmaP2c
         78ZhgLOGDnZLjZ7MDiEsCrhTJT0uIt9wISU62wU65fkrb2DRbdhQgCVFnU6Eu42oT4UU
         RrgFK2Dp04n5CYRcnGVqNhsCTGT5XSFwlMhN+ETmNRDixsFoGaX/vYpdh+nK/gOxP5lh
         ASQ2W9aFzxM7cRqzwzfCtug4p3UX5O/mqb5WiSGhp0dQHTS+awBK7zF9tdpDiP9d6Rij
         XjxeiyIbjXbCCs3fSqvhjA9Z3mtfWKbTEbNwS5tT7lJPVktValki2SGWlKERc82Y6oWT
         yMZQ==
X-Gm-Message-State: AOJu0Yz0vbza+kaO4hpnNam8X7Cv/b2egGn2oFuDwcph8IazwIWN02cz
	EOwEOBGn7Vng1gbJX5YaV1w2LnON0hfPwYm6Z8CwHPuc5pVsUQBT
X-Google-Smtp-Source: AGHT+IGgTLEAPVIo5YRh9Zn28P5rxQlyo6CkbzJOl9RgsKyAY6gH+meGvtVxLF5FWVTjISF+nAFyKA==
X-Received: by 2002:a05:6871:7810:b0:288:64a4:fbea with SMTP id 586e51a60fabf-294846a6bb3mr14843812fac.42.1730758338176;
        Mon, 04 Nov 2024 14:12:18 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29487717013sm3231102fac.43.2024.11.04.14.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 14:12:17 -0800 (PST)
Date: Mon, 4 Nov 2024 16:10:37 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>, 
	Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH v2 01/22] builtin/ls-remote: plug leaking server options
Message-ID: <qxtstkkch5toz6t7jdknwkdzrlkfu3b7gtw3wpg2iuqsmliqlq@w2qz65ujwj4r>
References: <cover.1728624670.git.ps@pks.im>
 <cover.1729502823.git.ps@pks.im>
 <89b66411354437a1e3a97751f185889dffb84126.1729502824.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89b66411354437a1e3a97751f185889dffb84126.1729502824.git.ps@pks.im>

On 24/10/21 11:28AM, Patrick Steinhardt wrote:
> The server options populated via `OPT_STRING_LIST()` is never cleared,

s/is/are/

> causing a memory leak. Plug it.
> 
> This leak is exposed by t5702, but plugging it alone does not make the
> whole test suite pass.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
