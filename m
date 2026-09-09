Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F7738239B
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 18:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788978663; cv=none; b=FqGUXsQiTP+cEmfomcQtwbVZGDC8r0ZJobylS9nrTUUvixknWAwONZBEnApBRSvkfyjnJfCf61LWQIRYkEqE5cCBw4h0wQgZmeugVwAwBEJV4/PeQd1TAcjyzrAPgKO57/2/ugNQn/YK3zJywhCCFIbo8mx5fyPGHns/InaVr0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788978663; c=relaxed/simple;
	bh=ohslOpYt9GT+UOqkU+ldxcYlt6wc7fZSYsGlSRbR1Xs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N708b9pc264B7B7juxQKoJF3i0IVYbkxGUDa0mvXy3hvUtIyJ/RdywBgi0TfaHXEx3GZjN72NL+BMlvJnSfsmftw3iNOG+TmULn1rJ9NPVgswFvcUhxWh3v+IYAIox2TS0As42/IkW6gpVDW2O9onoo2hOYfmrVS18roViq2+n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pG3iRviE; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pG3iRviE"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6b1b3d7f10eso4299084eaf.3
        for <git@vger.kernel.org>; Wed, 09 Sep 2026 11:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788978661; x=1789583461; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cQ8yKPTjw+gSHp/YZTEgHgIkFrjWv++7n2g2fLJ7/SQ=;
        b=pG3iRviEXpQFwAQFChskG9QS/URmt4wSxOwq4b/LbDYAiVr7aoK46gauRc+lqe391H
         bqi5mPQzdVmbVwh09+kHryk2cC91oM93ar/xiQ15DsJWolvxv+UDFaThn0EKo00ATTO6
         s5bIAgB+UqwUykvnJLJpsur7oj71YpGUp6GQhbZZPWjwg5mh3sknVURKe30VDSo7+FzE
         Xq9M8y6FU9HV4JhoefBmw9sHrQa6OX1ZyN9vNjExrnlIuKZStb+O5SFAExDGzhcOAr6g
         cD/GNEj+Ln1bZeccBEs9pSmrTNZlFSD+nWlyOMJCdZrlRM7MizV4o3lBJB/vb5uISms6
         DCTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788978661; x=1789583461;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cQ8yKPTjw+gSHp/YZTEgHgIkFrjWv++7n2g2fLJ7/SQ=;
        b=Y7mIyTlnfgTdbNd7Hf3XLT9c18sCWeAEsRbHZnYzVo1pLY8C8KOtIYkLaKtsblKpZ0
         epmzBnDOVviWHHoVWHufC3ruONnthThsG8IE1zkM5Dk6IjjJmFv5Kn8S/MCUeEkurp8t
         iLXjhCRg4+KQyZY9onl5JrGenJ/BWX0oFOH5aAwp0V6kYZ/nQlPhBQhcFV7ejo+5TQ1r
         JJxNFKQiIOzo9wBqJMycNrRjQtitRHDVUA81QRm0WEhzXl3CV4SsP1s9hHZZ7DY5jw4C
         IAKLaAkSwN358xjhbeTVEJy1MbSEX1Qgyml29KxetNOpTM1mgbborNrv3j3rXqSgnlL/
         aBJw==
X-Gm-Message-State: AFuF++ndDRJCnlB+o0+jdFQdRXi0ZatMLQTOkmMo2zMmR19R0/9bFNlc
	eyA2sU5YK5W+lqXQsY30sMUIaGo1hTinlRjjGNcjLp8ih30fPy6yhSLMN7FQ1w==
X-Gm-Gg: AYBFou1+U8cwgohEi4WlUJ1PZCqvMHJBHKXjGujjbYClDRVZ3cpHHTDzx8hoElBR2e1
	eSQVK00rajEtDS3FTGvWsN+ie5FUtdo+H8hB7hi2BSlu/0sgm9cbMuQMmkIMwVm9cf6xSJE7QWf
	/J9qErRyymt982K442cMvVrD9cB3P/UvdARi7thet0quiiz/yfUh5L1EwikQY3/l01EoTiyidth
	tV3spaXIWbvBEs5HJ83CxnrOttFPzwuTMR9EJTs7Ho+An2dFM3YEsQkiPxYMix9XEeCbtjTdWYP
	2TlWkP4M6pURBjOUQQlftO1DAjfC3+/EQJpk4Q2bjaYbbjnc3RN+BSC8bJcRCF/4PVEQibyy7/J
	DahTA89iAbFMAqf0bEPF84yUA/g+FMeSLI9ZxK19qlfQXPAGRpkpSQEhNhvL5ligj1Zu81BvsU2
	7xhtJcJ5scgZpVwsM33fqwjXTicV2/NFd8MSWMTKOafRpQqOZxQUoRf2P7LskcsewEx+/nrjlsL
	X00hl+nKVwvsD98tSoZxC7n
X-Received: by 2002:a05:6820:1786:b0:6b7:8415:d78b with SMTP id 006d021491bc7-6b7841619c3mr18866813eaf.54.1788978660820;
        Wed, 09 Sep 2026 11:31:00 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b6dce7b751sm20176120eaf.9.2026.09.09.11.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 11:30:50 -0700 (PDT)
Date: Wed, 9 Sep 2026 13:30:49 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Toon Claes <toon@iotcl.com>, 
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 0/9] odb: write alternates at creation time
Message-ID: <aqGlryiYlgfDtCHr@denethor>
References: <20260825-pks-odb-write-alternates-at-creation-time-v1-0-911513ba95c3@pks.im>
 <20260909-pks-odb-write-alternates-at-creation-time-v4-0-d8a78ffc32e4@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909-pks-odb-write-alternates-at-creation-time-v4-0-d8a78ffc32e4@pks.im>

On 26/09/09 07:48AM, Patrick Steinhardt wrote:
> Changes in v4:
>   - Add documentation for the different functions that play a role in
>     creating repositories.

Thanks. This version looks good to me.

-Justin
