Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1243BB11A
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 20:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786479003; cv=none; b=QoOPIK3NpLJAPgApoemjuYpC9JW4xRIq4QEk91wOCvVYCiLz3TH5DtQ3NsmbtXDzNLuAaYQFGXaWYoa9hweIihFGSU9DgiY+0m7f523De4OPMVcxKyJCgonMiqwCHccSwiph+9NJKT3tEG2PgPbnAfR4yQra2UlqWSgmLVdy6Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786479003; c=relaxed/simple;
	bh=L4kGor+CwV3LlqYu/bhsUMdDC1qtFzgsU1EZUc64Zmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bquemHV3zVilQSTKadG+rs0O4IvkDmoFSJNyMnKaegUK8Jk1Yh4CxhAzgjFlNxtyfd09t7Rixy3+OeZ1HZ+XVWzGaNqraHjW18LgeaDPxGlVXYlPGBQLhZ8erUriXvOx3qTjW3DQwqzlaDvr42Cjx4O2jEVt07dtCgpEax58vcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SpsgE9fP; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SpsgE9fP"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6ae9b721927so196695eaf.0
        for <git@vger.kernel.org>; Tue, 11 Aug 2026 13:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786479001; x=1787083801; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FEdVKSsKECdF0cbkg6CSu3uDGx0eo8pPXlNp9BPskIQ=;
        b=SpsgE9fPOrSZKZvCCEjx0GW9nnCA9XMmrzyGDkgfAO9yZ9D6ArsQMXlK4STSk6l6+b
         XaDyI2Io0reDPTuL4tTq+6jxZ85WKvWRgmh01zAzi+LQobjDqKSzW5hGdNFmyhQCIggH
         8L3BvE3Et0N86U7w7aYC8gC/4g+77hJmD9S7ciWycTnAy3DolriHBqqtTWB6ISlyUSwa
         BilzJKyPLiUGUNF1AzSqCek8jdnqCBQwGpr6iGfWVnG8a3b7YTKsS8+2ROBs+JoWVr/+
         CAOf1fzEL+gTkumavbkDuYB6TN0wE8mXaAwoNkKtsQTKY3M2z22bfIM7Sax+n9xz3n4/
         Rx/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786479001; x=1787083801;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FEdVKSsKECdF0cbkg6CSu3uDGx0eo8pPXlNp9BPskIQ=;
        b=KY06iYCFcgPGcyU78snxe4pWerujabrTZsQOrjR3A4leVXFzP1Ta71hWNRviv4qQuu
         4evhtUtB9UG/ZGRsWu7iQZ4jZdGf4h1qowRIFgSDG1KMNTQX0AvA7hqR3AVmQtc2bLu5
         2XgbTM1stkn8xl6vDwEi5cUnXOj77ANIRE2EQOojJPFHEHCcx/Pu5z2IanLHcNl56L99
         xLP7Yl7txhk5jOdTH5WruBJRl//GRDTX5HQaX9dnK0hX37dgdZI8RivthsXm76218jP6
         /dGeFYaT0OkVVUX7MEQu90pHLdtY0aovari9Pm6cQRKh9dXePN4kQBzQXE2J0TbozPJp
         ejrw==
X-Gm-Message-State: AOJu0YxPvK/7Vh4OqtQV8dY3XSX7mfFGfCbxSCtnfQJnDkG1/JnufK9V
	j4CLN+Wfy7+N9hmGIdw3ckhl/EgNUPh1IwrmwwIiIRR8X0X7niNboXyf
X-Gm-Gg: AR+sD13neGCEewwbB/qZpIQA9Es/FnZSxZHd1rm7O58woYC7Ias0sDgyVSoJ3emMwas
	Pb7UwP4PRYBU9JisSuaOdg8vq2Iwiw+TZer06tWCkoJNn6gEE/Dyn4s0/1ARjABeLtOyuq3l34Y
	t3vOWNlPlNv1vIrJ+MRHhjEYFjLU1Wx6Ev5NLVVREYQlW9BDB59AKdiGZi8xGKtRnNSe3WEqT3i
	2KwziW4pQhhVew6HCpD4gFIvxSP48gOy3VVlmi9umfu5WVP0Kt2kamtlEtwHgCg9K4Syrd34Oti
	b/mPdy2g7tYe3Xz9o5qv2QCdD632B6QtY9SGztBHIFdNU/PgWOhE3YA/Vbx12Ndj767zdlrEP7Z
	mwN3WcD5pQkAszbjOqkJ93JF0Heyq35P530etoDszfFE4S2zFInT74Jy/YpL9LPNFuDdqO2YRib
	3ewlOSftAxosLUydFuj4KtM17LM2LKVLIWQbiWyJt28difjTGlMIrHzw==
X-Received: by 2002:a05:6820:4c14:b0:6ae:871c:e3f2 with SMTP id 006d021491bc7-6b0a330fbbemr4252219eaf.29.1786479001351;
        Tue, 11 Aug 2026 13:10:01 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b0ad671bc2sm595885eaf.11.2026.08.11.13.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 13:10:00 -0700 (PDT)
Date: Tue, 11 Aug 2026 15:09:57 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/8] odb: unify read and write streams
Message-ID: <anuBdm29ye_qV_Rq@denethor>
References: <20260804-pks-odb-stream-unification-v1-0-86d70e82345e@pks.im>
 <20260805-pks-odb-stream-unification-v2-0-b8c369564641@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805-pks-odb-stream-unification-v2-0-b8c369564641@pks.im>

On 26/08/05 09:44AM, Patrick Steinhardt wrote:
> Changes in v2:
>   - Use the correct object type when hashing in-memory objects.
>   - Remove a stale comment.
>   - Adapt a commit message to mention that renames will follow in
>     subsequent commits.
>   - Add another commit to rename `struct input_zstream_data`.
>   - Link to v1: https://patch.msgid.link/20260804-pks-odb-stream-unification-v1-0-86d70e82345e@pks.im

This version of the series addresses all my previous feedback and looks
good to me. Thanks.

-Justin
