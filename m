Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795300982;
	b=HcKZsN7wA6IGYSCp+hLTpB53fPCMlTqYtc+Azhx2/EXRrwH3T6bVIxbH95JqgcaOHuUN
	 lfg/CWHlmqmjj/T+cVezKFwIf9O8PpXaXHhJIGWaUlmKrCo1mSkrI8UJ+0CsayYU6DJEx
	 bYybpzTR5wpYKJs7rx2Dwg5CSU6grgy8FhaRlZYqb5aQ9f8Z7vd5wUAam7SnOuA6vXgD6
	 JT3mnzVYK7W+m5czKp5x6Alo2dql1sW3Ul78gIoH/i/sPvwmP5llsLbyRpQ+FnnLgvgxd
	 +OQUNv5tTuSIWhi5bV8PvApMBPz5Kbv5Mdm6n1rI9bXdq+Ap25FpfeuXj4RrKKVRVXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795300982;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9nZV1OebWXQM31W0LsExrTwgPqftOxoG+dOjATJvFB8=;
	b=dq2svIUERrP/fQ1CNwhLbl1ZUDIkPp8tkKq7oNTmyjUiHBrgdAdWPjzde4jGi2SyMvca
	 yLokuAUpMHLaAezv3OtnLf9q1I2NuP0dS7A3kA4BxOxQoMAWz02tZjYfZQD0MLPna6IbK
	 ak5ApZF3kxckTpR5mSDrgiFBOZDRN/lYRy9Jdv5D4ZQ9Oo8b7XSA6z++MRZc80YDxVFJb
	 2JwxfwOjT8TVRNPuEKJ1HnggwLNEUuTHqDLvUCWfvMYNaUZMrw3bQY9NUeUte9hbeLJ7c
	 QucbCQWLrUONFB2ScCzCGAFFQhahEvSYuKabEvg5rCZEPb/qb3ezTVAh9kr6XAgIgEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AgTGUbwv;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE379606A320
	for <git@vger.kernel.org>; Sat, 21 Nov 2026 22:43:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE379606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AgTGUbwv
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so20113105e9.2
        for <git@vger.kernel.org>; Sat, 21 Nov 2026 14:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795300980; x=1795905780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9nZV1OebWXQM31W0LsExrTwgPqftOxoG+dOjATJvFB8=;
        b=AgTGUbwvjUeOTbs6olkRnq8LrskuKkDMiTQhpRtCzzDN7NClGOxffk6Rz3XaudZrWJ
         jFl+eS12gc+0l3XFUVJ++oO90NbizIpmnK11MQBKLnoS5RQbPUf9JkAZc/tBMHHZ8N/6
         Vjy+GxRGUHJNQEqDRmgGeL03MlaUnbNRvIrs/gXhmfb5rterRUM7hTntZS+tgxqs7Zii
         tsWjW9Onulk6JigLA3ozlTC5UBVFxAipu8CNOOHCz2xbC/HRhcP5GGVj/wFyl/gtIwPw
         vpG64R57qkyvqngIVJcYhf7GER7tsCoDKSZQ3OVOX4cEYRBjiU+P3GwbvJ8JlUrrMAnB
         VNog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795300980; x=1795905780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9nZV1OebWXQM31W0LsExrTwgPqftOxoG+dOjATJvFB8=;
        b=MH/WfNhwpWNY7pxFKVusDQhWJQzlufd6WzrWU29fudJtyxe6iLMvnW5MeLjoVr+cBX
         OM27mB8kJqYaSPdLaNdtg5BGjRjXPPBKZNfVfyXHipqC0Q3qwIEoisBeNaqM9g64Lgoh
         iSYlBYdKGWdzW6NA+iQCecELwvJOW11FejCgjHaps0pT2xO/XcLxjGaOA7POw66hbLHq
         WOjpBMGepuI2qsJagE+ef+eHXNjFWkYxi3MVJvElNYFoXUdghO+G4MWP2GCGdzaxtD/g
         fCNo6BKE0qq5mHWiJOhEfkGAJaCqMyv2i8cliaWae2XAhA+HqfjJ1IDpKrXgMZ4RBSDY
         Y7Ow==
X-Gm-Message-State: APuU4Z8rozE/OobOoKQDVGcil4VonayapqzMRoWdupg6l84pnaYvxi9D
	hVOxd0ZiOJHssRK8kJty455pKKl0ditI6cGPNraZXRtGNJRKDFmg1FSFzVe3BVGqy28=
X-Gm-Gg: AZFdTZdhKIH2tmrz+WU24+vROuiJetMdlXQfWv2JkhYCNsJosW7iBwPsddH0eKa2+Cy
	+iMOK+o4mhbPF1KOsaCU88i59x5Z2suSrnnOtnEzOrEdw8r1PE/galyLjq7uox/A3/T8jxjPwAP
	ghRKIRS1cijSPJgs8FgcK/hpcFWgLjnXFXm8cFQlnPCMJuqVgDSn+ddW+mWyisWXK8512ahUZjn
	lFjzVuEoITbU0I0XAg/Y4YvTMbnxKeDSAAknJlmtg/1d0puLlyN08i6s3413xJbRwtndXwvTGiO
	NRz98vGMLz1dHWdQyco3twBNSJCW0US0Qxf1hwfqNmqgU/YJgRWNMNnJFB/cn+WQF0cw4GZaxOJ
	fQumsSCWkAiIFN7usTUc/fNSnnDI7y1NUX9C+BslapKB+RQULY7mp+0e7Toe+d6S8kfD9ABe+aW
	Ygki9op/YwWVRDfwBf0A+9LMHBdK6Rai8mX/8r572Gwj8S28lQNjy8EAm3qcgiRQxiat88yFxBb
	gL91HjVG8C0ttF8PtCHxvFIMkBg7GeIp7AnkFSjzAcWfzIbDTUoNaFT9RfAHrscClmOouAflGqA
	5ViS0UsFIHI4F3n3l+m/1qKQ58h64qXV0jMU2GcdV9MTdwf40Xf9J0E6kL2gvAzs85COIekje59
	YPbwi8noqdWXHyv2rEafrQCBP/UQLoDokjCX2Bxt75IzGUXJ2Y+2ISrI=
X-Received: by 2002:a05:600c:34c9:b0:4a3:5d64:df91 with SMTP id 5b1f17b1804b1-4bb88810d28mr166619125e9.18.1795300980083;
        Sat, 21 Nov 2026 14:43:00 -0800 (PST)
Received: from HP ([102.0.122.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab69bf685asm13029377f8f.20.2026.11.21.14.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 14:42:59 -0800 (PST)
From: Tanga Joris <tangajoris@gmail.com>
To: andy.koppe@gmail.com
Cc: git@vger.kernel.org,
	l.s.r@web.de,
	Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v2] pretty: fix lost indent after newline in %w()
Date: Sun, 22 Nov 2026 01:42:39 +0300
Message-ID: <20261121224239.161239-1-tangajoris@gmail.com>
X-Mailer: git-send-email 2.56.0.388.g09a996e1ff
In-Reply-To: <20261017081150.2295695-1-andy.koppe@gmail.com>
References: <20261017081150.2295695-1-andy.koppe@gmail.com>
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

Hello Andy,

Thanks for the patch. I tried it and "- foo" followed by an indented
line now keeps both spaces.

> +						space++;
>  						goto new_line;

When I took this space++ out, no test failed, but a paragraph after a
blank line then starts with an extra space: "%w(20)aa%n%nbb" gives
" bb" instead of "bb". Maybe a test like this would help:

	test_expect_success 'format %w keeps a paragraph break' '
		printf "aa\n\nbb\n" >expect &&
		git log -1 --format="%w(20)aa%n%nbb" >actual &&
		test_cmp expect actual
	'

> +	    Newlines that are followed by an ASCII letter or digit are replaced
> +	    by spaces to reflow paragraphs. Existing indentation is kept.

This only happens when wrapping is on. With a width of 0, like
%w(0,2,2), the newlines are kept as they are. Maybe "When wrapping,
newlines that are followed by ..."?

Otherwise it looks good to me.

Thanks,
Tanga
