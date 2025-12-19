Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E1F33BBBD
	for <git@vger.kernel.org>; Fri, 19 Dec 2025 11:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766144899; cv=none; b=WnRt6dW4/WH7lCBezFygmTtWjnhKUi2Qm2hU1H6IQmzZYyk5rEIpAaeQUldj/7DErDOJQaCNQpg/4ayoKr4/WKJertJsUmqrb67raP9n8DPgE1I+Qx0pTSPQup2OCs9M9QdZYkN+hyrAAqF2dQyFRtFnm8si1LXpc5utOThbPQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766144899; c=relaxed/simple;
	bh=WWKLD9vNljvAv9BWVoCVDzZZQAqC6gH2ZnQfnitXBOA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y6m+kWsb7GUux5k3Ou7AcNd2soBpd/IfDRe3FzQFAjqbBQXppB2hTRRKAfSP8f7AZKyl55C/De7scGjWWliETmVm5ikebohoCVjSAZbvd9lQ446+Oe9jmqJmEE9UuRrzQVZX5LdV8tDdBrM+O4caB4wfP/CqTm2YwBfa1ZL9/Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HdxuzoYk; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HdxuzoYk"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-594285c6509so1786072e87.0
        for <git@vger.kernel.org>; Fri, 19 Dec 2025 03:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766144896; x=1766749696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WWKLD9vNljvAv9BWVoCVDzZZQAqC6gH2ZnQfnitXBOA=;
        b=HdxuzoYkfaC4Itgf/6gVCZgFnCPypoYOLX91DYnoX4PqHXbMEJXPOBl41iWveKG9LF
         J8YS00cWB8ifZxsGUCjH5rR37xVFVS/mwZ8KiDXtAkDslM4+OfV3F1gqfD5ZeA0IIDOe
         GtC060hKZJIWpIZ7WATxoEhxhVbzpXBdpAEo6+XmL2OXSHpnCqXmPsx3/czGQ8DCl4Fa
         9OzgbrMlK4NcSlGzt1pkpmmWUSLlNe86cPFGnZnkR31YarrtYod66KvoujhS01S8Jktc
         fQ/HrSjJ8IhLeapV6OFjqGg1UNLbnp+hHdEeK8P2q9o8vRlQzRGmT36JUx4AfCDmeV7n
         GPEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766144896; x=1766749696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WWKLD9vNljvAv9BWVoCVDzZZQAqC6gH2ZnQfnitXBOA=;
        b=Q6dPJ2g2yFq+CRtOVCGgfZogmOaXMBHv8F1865f/9DNHHn8dZILialTOS8rZg287dF
         b0RA/N7N6TxjaZdCuYnXcYvlJBe+vI2N4ycyo44/1+k0J41RtpymBp4F1EyRswOG9Ujt
         hP+mFOZSI9FWJOjByCwplrYDmREHGWQIy529WpWnaZtyDYMfARv2+1e+ty1nPdYInAqN
         u25BlVka3U+sHiIgRLpZ9LgazD/uy91n7nw44V9/h8CsuDBiDK/HWwYTXk/MceHr30DA
         u/UcBVMkBsFwjV2gbvIn0XJqwDInYXK6MOgXHMs2FP+BO2tHnPNlBrlupgfPQ2tFSxik
         qPQw==
X-Gm-Message-State: AOJu0Yxg3TD8ityXPFZnozat5o6FKfXC81XA6dy3qrcFCqx1TGnFAm03
	VPjTmT0QKe7JtyTpw13yyPSAKywOyS8iHdqP0fQuDguHlQmZFRbmLeTGIDcFFQ==
X-Gm-Gg: AY/fxX5TSpvbIqMbQKB92Z1IVOhBccjnW1b7wBLmOKDiUlooLn9FaPbk5bCs233onc0
	G54V+JQ5FsZE4XY6PSn2w9zpEWeiUYhAOp1TtRoaiWtfsaCbOKR4GroLm7DCUO76KJc84s9N7nq
	oOKEgIg8S1LUhxx4SZRd7RZJuUZ8n+Mq+hTmu3vZ2lo6178QO9yJfcdpQfQEEimU7MxK9yIieEC
	VXV4epNW9cstmrUt5ZpIFN/7R9hVKYu2RexvQKH+Q4CCoS7p3McbVX/JDjK90hOizyPr1zmucCx
	aMsqomzPEsyXtGBeAMuQI/dv9IECv9oYtRA6Jw28KkiabiH+BkwHPZdQdPZjh6MqhHA6Oq++8Xw
	UODp3IVIY+1Wnu85HTBtO1nBgaRhDVXD2pm5miLI1wSB5q4nqg2bEYDAJjh+zBOQoz0lqZacvud
	yv43RegIpYMaNiJJobvahfehqJ8U52A1keQSrE+tAc2B4g88e5Fq6cgXKqm/renoU+EAHEAj3Kx
	mAjCHGnMQ==
X-Google-Smtp-Source: AGHT+IGrDxdbhasBunR0b0iaHkFfgdTpQTVNRvvm4ebFFp2mmmtl+ujPOri0KlSWl6OPTS49/sv/jw==
X-Received: by 2002:a05:6512:b05:b0:595:7e9c:ce00 with SMTP id 2adb3069b0e04-59a17d3db96mr860889e87.25.1766144895634;
        Fri, 19 Dec 2025 03:48:15 -0800 (PST)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a185dd90esm652328e87.31.2025.12.19.03.48.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 19 Dec 2025 03:48:14 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: collin.funk1@gmail.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com
Subject: Re: [PATCH] diff: add --no-indicators option
Date: Fri, 19 Dec 2025 12:48:14 +0100
Message-Id: <20251219114814.98846-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <87qzsqaly3.fsf@gmail.com>
References: <87qzsqaly3.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Collin!

Surely, "git diff --output-indicator-old=' ' --output-indicator-new=' '"
exists for a reason, to allow users to customize the workflow for
themselves. So this is adding a better short-hand instead of that, which
feels a bit clunky. Sed workaround would likely work, but nicer to have it
native inside git instead?

I use Git from the CLI 99.99% of the time, and find myself often copy-
pasting to recover some code from and old commit, so then this helps to
save me pasting in and the manually removing the +/- signs. Not a huge
deal, but makes the awesome Git CLI even better.

Harald

