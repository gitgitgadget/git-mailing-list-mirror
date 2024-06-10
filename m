Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F31911717
	for <git@vger.kernel.org>; Mon, 10 Jun 2024 06:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717999314; cv=none; b=iK4d7F+ADwvLRpUzzXobsXqHvc2OOfsC0BRklXhT/DYfY0dPwyOu0YAVFSRs4NN+MLeEw3d2nCCwQ1tVmpu8yixjJRfady/F5wKJX1BwLVAv+QH0GfJLkMJrMVpJUP4w1AiOfEkEzWGgaXlWJAwJSMLCi7oJRBF8Z9g09L3Yo50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717999314; c=relaxed/simple;
	bh=fJ6gSEsOHhHJxacKjdmo2gOEeMIhpPWMIDPz29UgmxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y2t/8Nl7x7KvXGy1eVeVYjYCCwQpiegdqC6yYB7wy7AF2ZQHgcsW2mf4H76iip8f4hkQOg67gbs9nGwb6AJXTJe3BaTJkFkTcKtwnVd9wGxMkStnsgFADtjGmAlIzPcAXIOODz31J2kRhziygFxjTwM8r/5yYX6TMnHY8zZFrCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KGUqKXIh; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KGUqKXIh"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a6f1cf00b3aso106292666b.0
        for <git@vger.kernel.org>; Sun, 09 Jun 2024 23:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717999311; x=1718604111; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fJ6gSEsOHhHJxacKjdmo2gOEeMIhpPWMIDPz29UgmxE=;
        b=KGUqKXIhAyUAKV/hEUjma4Wu5BwynVaDODpX53St1u5KM+mFIFirKCo7wT99VYcssn
         HMODKPDj+Aa3nAJAEpVijH2qElYTumk8J9LJRUceYP5f60o/nn2k5LNHc+xpTYgLcgcz
         s+s+rZBAZVx7EajexFIfMJnIJPsegOMc1+vT93DC0gHROK7WXDHhvLR9AH0J/QJ8rx9U
         QSTeVBtjT+UduoE5yFJzC/GCkKFngQV/bzy+jJgNVPYDTd/HToGgnEAYyuJUut0xnSFy
         VhdEdzvc6da2MEXtl4vm7IgKGC5R7SM2ezBq++YHAVCZtms0AotQJsL++oUrWZSnqb//
         XQEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717999311; x=1718604111;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fJ6gSEsOHhHJxacKjdmo2gOEeMIhpPWMIDPz29UgmxE=;
        b=lnX5Tf8PN9dzu1dv+Mx9ukJntY7uR1K6FUdbGkUsDM3DmIK3vLsq34hOwmG5y4UAML
         1CyXyT4Fxuz2wkn0J9/iqqHLZKTpoBwlkCWUdpicYKp4PN9NEn5HRnPbz8LEXUBnSO0f
         6T1woe8zmKMksRCp/eqbECvuq/yej9kwq7lJ+bwZdxu3bcKfSLKyUs9Hcr8ERL4CuRp7
         zl0hdbwYai6Hwjy8ICT5x5pWgsl2rDyluB7htqnxga651DiQ/lUQwIvfPcSzRb4tqmnf
         g6uBXW5qkMHTR0h6DvIlaLrMrX77TroOSMGl8DQzds40B5J4OYgvDyZjuAWVbdEM4eYf
         +RTw==
X-Gm-Message-State: AOJu0YzhEMMy0WyRuHy9GmA6bnD/mWkEdtK+oIf5dbxIdMFOZJAdeJty
	oC9yodrevmjDsPnecQ2UxOpVgUYPXplGecdmP2Oa3ssw5Qy0HaPW+iXhYqfS3biQ+QfI2acBHLc
	4O8/qaQWhpT7CgGNOeQC1lP6+4ymJHu4FovdECw==
X-Google-Smtp-Source: AGHT+IFbmUPP/tJtXvgC2xJaljrPfVt6JsVQJ39yf/d8jgAJp1wyCHVTMJ9rBYF81jHGeHV8Dxp2arUM9vczc8+Kd1w=
X-Received: by 2002:a17:906:c114:b0:a6f:20e0:1d1a with SMTP id
 a640c23a62f3a-a6f20e01e50mr89176866b.33.1717999310307; Sun, 09 Jun 2024
 23:01:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+J6zkRxnvnybM3vnPXX2YwpW1k-as03+A8kxiJoA8GrA4FSMg@mail.gmail.com>
In-Reply-To: <CA+J6zkRxnvnybM3vnPXX2YwpW1k-as03+A8kxiJoA8GrA4FSMg@mail.gmail.com>
From: Chandra Pratap <chandrapratap3519@gmail.com>
Date: Mon, 10 Jun 2024 11:31:38 +0530
Message-ID: <CA+J6zkQaV9o7eUaD2bshH7zEmF115BbYv_uCFctySQNMgGQc+g@mail.gmail.com>
Subject: Re: [GSoC] Blog: move and improve reftable tests in the unit testing framework
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"

Hello everyone, here is my blog post for the second week of GSoC's
official Coding period:
https://chand-ra.github.io/2024/06/02/Coding-Period-Week-2.html
Please let me know if you have any sort of feedback.
Posts for the rest of the weeks can be found here: https://chand-ra.github.io/
