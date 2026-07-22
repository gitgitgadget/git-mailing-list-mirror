Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B0123C8AE
	for <git@vger.kernel.org>; Wed, 22 Jul 2026 09:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784710984; cv=pass; b=XaUwRAKgw8wjzDZog51oZBdwnTgHZGh6kre5K/gBtA//C9MVNgJkS04Z9/m6LnXX3AmBYlfWmZI98DdGaGo5CpwN2V1Q5Ac9lFNPXDeHfz7jVy+Gf8buWTIE56Ak9xUmd6z45LsvWYiNqz2DM0VWDnG0SulHCdf6UxmEdmTlMN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784710984; c=relaxed/simple;
	bh=F4uz+MQfYbFem0E0YB8G2IKDUCUX3eowA2ckqMZ9YdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SJQeH1lWfzoecjmLT2hFye+SdfGbkQDfeqP22Uk7GNRAgJkmvCF4xMz4vLogmgu5yzZVZ630LPNM8++yDUbMDH8DviSZ8q8NJTItbFpj6YwD00mXkHBqvZp2UGybmZKTb6iV9D+JrqtqjYlzOwkPnanXjlgkHF1vZOK2NBhoMAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UTC3EJC4; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTC3EJC4"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso10265383a91.2
        for <git@vger.kernel.org>; Wed, 22 Jul 2026 02:03:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784710983; cv=none;
        d=google.com; s=arc-20260327;
        b=eS7Ar+pwYme7nbs76ONjKbQWqrBa/aWAJjHP5IWMOXXZudLl7Ld44F1mCc2hpltMPn
         egfkBciev8SvWkmXA9G0KYeQJtQOO3AwIAepWy1TGqU4gHmtk4sLlScpyPck2ZOEpxPj
         SjUP2rooAKB26GGmGvUHBXNYT1w6aJ0pt9/TpN0tbc16e0J+p3H9tzV94bNNfvH9XKbT
         uSIuRQOWf3cBoZjo1PibR3NsZDBNKyfLWxaDOfyGSlpPVdrEeZtKn7rsBF1z3SDRzlmq
         I1tIE0CHRttx3R8nihGmkNMWiSIl8JPJASNA1x9hs6AS02f1kY0X/TgzuKE70iHJyWlj
         Wenw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=36Fzp970NwfRDrKlq+0Fs941wXx+Dwigl2LvXxpmmDs=;
        fh=1/3dtt18tXnIvB8syWQ2wTvDn6umrk66dlnjmb+I9bo=;
        b=UPtvmFWtLQUuk4EEBng3VX8MHS50aqjtAkk1UM57cfz2Uy5jiaY3Vp4y2JJ+RBHVVk
         5GP452yqjGjsgHwnFjSlt/U11IAZMvoJsWgKsYYbJ+RBFrAhZ8TvPx4y1Rs0lP0pdQD3
         jhW8fkXoj1A35D2X2drP8+pZdW/ftqbmdb/hW3w3YHaqqupv8VUxFYIP2a2MG5eCtlAp
         q60ePBmz2kj6yVfS8EJm0F+xl9FQ5R9dBtTvBcT0wzY34oP9xK2RaJxOneBNfXAKISNV
         xFG+nt6NU1NoAJzhmnCMrOVSj+xlgO3ZvMIlkcmtd5ukT77OI4KCGDso45RtXJKc/uFS
         MHAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784710983; x=1785315783; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=36Fzp970NwfRDrKlq+0Fs941wXx+Dwigl2LvXxpmmDs=;
        b=UTC3EJC4yuaDja/x2E9oBxelChP6aIzfY+NSiYGrUqmHfRhe3ZAb+/5D5cHJGPzZ0K
         sySx/rfIMR/KwVUDNhMG1tei+uqGUpGLm/W+buYNE4a4gFwIM7fGviOReogUMpN98Al/
         xH44imDwYYCPc8l7gt4DAgl55ofuu34iQ8c1C7aCp8zBKn0QAoq/oyEb0XxxUT8+Bipx
         G/lh09Fb4D98aQYHAia2E3vh7FY4rgk6viuyIttf9fYabsmbfZ7bW6tE1pX80dWpw6TH
         mYFEGQEFeMJHiJtSG0AFPHepcVxnzU0dYOnETI1+FjufX2p1I5z2i1pjhzBNrPLXunuW
         kkDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784710983; x=1785315783;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=36Fzp970NwfRDrKlq+0Fs941wXx+Dwigl2LvXxpmmDs=;
        b=m7sBr/JHCqVNwJQlF3l2RMd648UGzXqauz4+PIIik/EKOZarQ9yh9wPjRhqxhX8DPG
         nHrT13luBMZGWPDImnHOoqlZ1KFRi6BXcUst5HYo7UchHjnLhmGnJ1+ZxavfUXBDv0u8
         ZFP7HGXSH3Bct4YeNyTAPoXjhvUN4HEtnW+3bqPf7PsaZZCKBHcqmiRxVcq2cJQhyWuG
         Fpax495DkLElPUc3MzFA0vFizvdY/gBbnVGfLgbS76seedkKcFmY0qLzJXfh82xECmZm
         f4bViA3tM5MYXq4cgMGgvHAwnTINE8HjB693sIjnw1lj4JmVzyBo3WjWEbuL6YBGgvqH
         mfzw==
X-Gm-Message-State: AOJu0Yy9yur4OIBkNRf5mK8NOTXVEsdU49lUGE9loaWGTvgoE1zXpn9t
	RXj4GXjbt4LysOxoUu1lIY0EsK5yivjkwWk7dZsjKswv0VUD7IYSw4J4X0yHj8eEtqHj01tX+ez
	Nz3P92Cf2jvuwRYhLGQ2Qlbtw8Q91x3GP7oycj5XkpQ==
X-Gm-Gg: AR+sD111N0dlNdQWL+mkf2zwmHSdiTi/DUSle8iaWpbCF7IEHcO3YvA0q9GLUuOrS5L
	2swvMKZXJN7IR7NYSzOmDOUdZHjt3mq9kxRMK71yjKYBEhC9eIcoberDgpaFfBCnIs4qg8RU9LZ
	UxMifAMORgsgBEs6CwFIY4fjr5a6ABlhrBNDcuzK2zantm/Ei+seUGBTJI0yf1+lElu9NqswEPq
	OB560EOzMs2kZqkKmhhlu/RE6BHNssNkhPhUobcUCPpmpFmdR0eJDEeadUYHTNmrpZnF5ZGZEoL
	RVv/F5pmGfygfJby1MUfeHdWftH+lxIlWMVJtJBbGCWZhMsrjQ==
X-Received: by 2002:a17:90b:52ce:b0:38e:655c:6516 with SMTP id
 98e67ed59e1d1-38e655c657emr12513694a91.0.1784710982950; Wed, 22 Jul 2026
 02:03:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqbjc19j9k.fsf@gitster.g>
In-Reply-To: <xmqqbjc19j9k.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 22 Jul 2026 11:02:52 +0200
X-Gm-Features: AUfX_mx1qFjUxVKXweUbyFMwYFpe3GHqRTkkklmjoYMnTQAV4l-F2lN4oOTt2y0
Message-ID: <CAP8UFD3qTPak-RGtJ6cG7JkvX3_NZGHUB9N+rQk8ea2S_MDssA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jul 2026, #09)
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> * cc/fast-import-usage (2026-07-16) 7 commits
>  - fast-import: use struct option for usage string
>  - fast-import: move command state globals into 'struct fast_import_state'
>  - fast-import: introduce 'struct fast_import_state'
>  - fast-import: localize 'i' into the 'for' loops using it
>  - api-parse-options.adoc: document hidden and OPT_*_F option macros
>  - api-parse-options.adoc: document per-option flags
>  - parse-options: introduce OPT_HIDDEN_GROUP
>
>  The usage string of 'git fast-import' has been updated to use the
>  'parse_options' API for displaying help, and its SYNOPSIS in the
>  documentation has been standardized to match.
>
>  Waiting for response.
>  cf. <xmqq4ihyehyb.fsf@gitster.g>
>  source: <20260716165517.433849-1-christian.couder@gmail.com>

I am having a vacation, so I will likely not be able to reply soon.
Feel free to discard in the meantime.

Thanks.
