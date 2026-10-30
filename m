Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793372904;
	b=24COilkvuaTsJft+1te6GgeZMcAXQ3DlmfqV4U1tCvauIQ46ZirXdWBfYremAWPs0kAa
	 waLTLk21GaSWnhDbZs8/CG9vHkPfRvOT35KWVtQmJ0iaRzrtw4pO/lI+dpOqXR+8BpjCC
	 wbMdl5BudzHtn1LZYvIHVOvTY5qg45PLlm05wSpvJFIT7sxEuJFS5S9DpZA4hME8nFsz3
	 6WoZ2Pnxl6uowagwFNWjNdFb4nHERAfeQKoy/a1c+ORR1k5bQTAcu8kO2tz5VSw3io8O5
	 T37xWr85T64/EnS9kSZxI5nrUBwtj1YqSlM9ojc1uqnWr6YTcWsZrs8NjBBX4QPJjIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793372904;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6OapNeeBcRKFFF+KaPaa6LHndNzv+RsOOgh1kNdPKb8=;
	b=2Oo8YmM8b/KCO4+SEOa13SQcerZNn48W6VkZpTSeJgnGDGpY94IsTkQjCsyP4Tq4KlVO
	 la0P3XHQFFTuzCHGWcEvOVYxxYTcNcHMYW6PwCgDJKTlxdIxOigtq2soc0648Gv/re1WP
	 F0mC8vD4RWnAR4sR/1JOwgjm0TGMc8kf1aEstJgyatFfRXMKEEI/IyOu28KcsTMU5/ygz
	 YCe8t/SrPYsYgzBlMMIbKlDIAKa+Hw+4YUXAFRKGMuO1k/pWBhgFaKbguBDBkii6FT3Yb
	 gauMjn0PSngGJGaVjrdnX+O/USHkPd0qpwI0dFn5/0XSfX01bzErFK3mAPuGvr/Lo5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="oftwk/IX";
	arc=none smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C0F606A31A
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 15:08:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92C0F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oftwk/IX
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b4b7dee316so808100a12.0
        for <git@vger.kernel.org>; Fri, 30 Oct 2026 08:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793372903; x=1793977703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6OapNeeBcRKFFF+KaPaa6LHndNzv+RsOOgh1kNdPKb8=;
        b=oftwk/IXIAuo7g2xPDuU6yZUfWMFFhMexZgGUPBlzzvFaUZ03EtCUoiMNEe1nJ3roq
         bbnoY0jHJ/85UsciHDB3p+/ax2KNEnW7AFp+nR3T1TswHELlkC+lKi7g/DappgJRCrGo
         ZBLbuwFnZ0qt2db15xBBj67f7w1OCvGqu7TULb8qDn4Z9Kye0otOcAf5jfN4azYAfIEC
         n0y6VDInBLWs46PPc3L+9wrzCY59mrCibxHUJmkFIP2gQhPYo0N/mS4C4tzefiX5hWvd
         0Vb7okIKKJ0p/olQ9pbj9yKCkjbz7kQdd41Z2gD6EZMyHjXoH3YN6MFf9rFkBLovChNI
         iI9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793372903; x=1793977703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6OapNeeBcRKFFF+KaPaa6LHndNzv+RsOOgh1kNdPKb8=;
        b=MbMp4Ny1m8OKNc7CRI+xpTqfEb9RVozRAm4W2dGAZLNarDdYn6AIkoul6OYW9h73tx
         XEJ/fFNh4IOOSP9zjECZDN6Hkud/xXX9l+uRbm6uAj2UpMHJzid8/bWcVdJHsDJ2kuYf
         NZyBp64Q7HClzJa9K5pX6gnNSDWPKYdYjzgynd8SCKIWRQRQOp5tP/ejIVoElQGZBv39
         98QE5/8hU8ixhC7E3wCoM7I8N7nqB/7dM20ChmyB5ZJVxMeUKpTw3xUTTMhq7TQEYuuX
         XCHD1kBuFgouEQpoHDoK6fX6cd7LrAMZ9KJcKjjYkfgsVXAqayY5A+GvYucu0IgfAkXe
         2Etg==
X-Gm-Message-State: AFq9FYIeXvTCDcznf/ZkDYsvtILZE58DYvdzPfLvblpvsEdQ6nrUYiC6
	lXhKaRI/KLf20DOIckluTp6Gh0RcjOpAVLOw21ug6Oc8vIWCj36XfmO0N9ECUgmwKAc=
X-Gm-Gg: AYBFou12W1zF8DX7Y4By7tVpKAw8ik7dvGGLJqyKpFoACRYFWpfBsq97XHX0DfaiU6k
	eN7srRRS6Cku7S6FI5lXsl+6m6y3/8U/2cTZ+c7pAOdlYQSCSA8znVPDOZ13Z7wKBqb14g7fUT/
	LLckM2XTvL6vP7/rJ+jqLOqoIka3A2GgNf+oir3sQxg9OAOUHpzg1hHx+Mji3wTuUQJ154VbNoD
	QHuFxUUf2oYqz2eT0qjjG0pml0PNCyhXvR1zxkVC69Qa81Kg4Kbw7wS5qkr362WvuAk44VZ7/ur
	2YArGnBqFM6GQgWve01APTPvbNmhgl+C7Ze6fj7JYN8XZQLH4wHtFc5h1gjGMfT0LcXBzhqE0Jq
	uDJ2ANgeShg7KotXAtu87iO+LKMPxa/HNFML1MIzeYj7QMUGwxI2W052MV0Qc0806+9bkp3ozDb
	EAR+XCMEDOJDPPOTiMVXS216vPsxbPxaK4+2BWokpIgs/S/uyiwpKrIXGvoi62hdfSDq6U46EP+
	qTnCj7LGyDOo6OadOOPTup+foiuRefcW5glxFq4VPCjfYKP8JYCujA3Z81Oq7NbQW28k54q42jy
	h9/bMluaqLxvoLZTPOLd8wah7Es=
X-Received: by 2002:a05:6402:223c:b0:6b4:2806:b057 with SMTP id 4fb4d7f45d1cf-6b4d4d80570mr1273009a12.35.1793372902947;
        Fri, 30 Oct 2026 08:08:22 -0700 (PDT)
Received: from flare5 ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b4ec9a7d4dsm48558a12.4.2026.10.30.08.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 08:08:22 -0700 (PDT)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
To: jacob.keller@gmail.com
Cc: git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>,
	Adrian Ratiu <adrian.ratiu@collabora.com>,
	Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] submodule: make '^/' work like '../' but with an absolute path
Date: Fri, 30 Oct 2026 15:08:06 +0000
Message-ID: <20261030150806.3856050-1-lightofmysoul@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CA+P7+xo8J_+3QECoGHnN1AxXPpjaKaHp3VoN9EEcyhZ+Q1fzew@mail.gmail.com>
References: <20260929185122.3127574-1-lightofmysoul@gmail.com> <CA+P7+xoSd2rsHpw+n5vCrcqXRibG6zH+SKCsVXA0OW-VZN_+=g@mail.gmail.com> <20261025212517.479922-1-lightofmysoul@gmail.com> <CA+P7+xo8J_+3QECoGHnN1AxXPpjaKaHp3VoN9EEcyhZ+Q1fzew@mail.gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, Oct 25, 2026 at 4:11 PM Jacob Keller
<jacob.keller@gmail.com> wrote:
> Yep, that lays out the full reasoning for why you'd want this. Forking
> the main repository could end up with broken submodule URLs unless you
> *also* fork the submodules. Depending on your project you may (or may
> not) want to do that, so having the option to use ^/ is good. Of
> course using "^/" would mean that forking both super and subproject
> would potentially break, until/unless you update your fork to point to
> the new fork URL. I guess that is more semantically correct, your fork
> of a super project woudl only change once you officially tell it to
> move to the appropriate fork.

Yes, that's intended. "^/" is for a submodule that stays where it is.
If both are forked together, "../lib.git" still does the right thing.

Thanks for the review!
