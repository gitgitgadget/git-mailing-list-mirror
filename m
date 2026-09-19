Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62168314A90
	for <git@vger.kernel.org>; Sat, 19 Sep 2026 21:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789853581; cv=pass; b=gIr1yz103sIY1y2fC50evgYazBdQHyjyvdFPDt15/I40bP5yHIcJO6rhp0cHaTHat6q32rHkwUxVveZlIGjL8OJJWQTBM0Nq9re2Bfp3OhUejdZeOh+2Nei4d63CMu1iJjGJon1QB0jC7jn8KQhXZTQsrapr+mvUheBKJdtC1xg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789853581; c=relaxed/simple;
	bh=12BcwZn8Tao/Al5xogEYEStWwXTWR+pskV5IlyRljQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JaEVyDavEK75a8hSFoTcHn7dlBbw/Wdr3qyRYgfaQKfy/kMKUdBEuxvajXZLpecGaSSpQBZCZnZ4ACfWlBQbqqpYad7aCClANzO6MSRtoSbLVme9I7LhjqFJOfgtrtJpWdOyMWZEAYbjeT75fs8vdlILRnKyy27vr6/XFgT/qns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ETfuJTWJ; arc=pass smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETfuJTWJ"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-66e4aa8d882so1991202d50.0
        for <git@vger.kernel.org>; Sat, 19 Sep 2026 14:33:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789853579; cv=none;
        d=google.com; s=arc-20260327;
        b=rHqi3WXFayKcGjG9usnnO26wXGwBF3hZGt8YNUfZA2x1BJphrh7eN/CRYrqXV1IGCP
         nCpQMauMvVXrXJx8X6ctNUMDSWiOZ5C7M+Q8Z9wRTr/iIjvYQN4/IW/itwNIw6t43AT5
         3cpejA5cqEFeLWbAZ7JqM2UaieP2FWaWXx6XQcnwiS0StJeUDQS/huA1Sw+45D+YVT8L
         HKLs7YaNgTm0pwtCMfj0bXTW4hiyawtcVDovYbxNLOf6JprwupuDHfg8qp5m8jV0lGLA
         Yr+haZMffpTnL5UbiLvkY7dgoqRjH4ZOuBc46LN9aZlnP0OxZWYqNSBupgV9owqw1Fok
         F97g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=12BcwZn8Tao/Al5xogEYEStWwXTWR+pskV5IlyRljQY=;
        fh=HocxaikbsIg0V+R4115ckTrQyh4ct+YYMH/x/0xjsIk=;
        b=UOPUCClQVMnzP8PJTYptv3IAdcyDgKZMQz7DmGiVVDAxgVGQwL5d/rsGlxx8f0XBuG
         QGdU3NeDmIaNXM+QdeMkD8EUZwyvuH1ggWeyStju8YWTBSiOug+IZqehedHPXsuZ4HDs
         Z0O/eLLa4Pq24/e+ydbtRgzRL0BTDlEV0+U+LVL7duKO+nQqKMg32k6beo1keW4V/2NE
         of0EBhVt7yozcgqJG2bQ++fiww00kcizu66ldZDV/ElYj6p1qR+5nVndB5ZgbD7233eh
         oWEFp7BrP38N2BWNuZuul9YRXtbMEELjdr6JxIFgnI024U8NWSc3qStxmVjROkDzPE+v
         g+uA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789853579; x=1790458379; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=12BcwZn8Tao/Al5xogEYEStWwXTWR+pskV5IlyRljQY=;
        b=ETfuJTWJeS1NPQlPN6oWIBlldFAk1BLv4/t5F1aF5IMNcTXWPSYDa8ilj569AuOWIh
         fLwU2s7HUGJxSqvXaAw6ay5JYN6CfJLsAmgRkfVjSNY95Zh80PcBAK1YayXppGN2nCSD
         aSSE/rWvDdZo1V2s8dI2sGbwjtBlzoEqftqmW9RAA29XvP5chUxaW06chokeJjNXIPGJ
         /3tzIUXCz+EC9rp56O5AXV9t/YARbTTraNeay5+nuSQuZD9ww9jIkjHMb4UmDHG0IEbd
         2zPQI3RWjL4bwz7ID0pfBENFoTsLNbEOo0dBL45eZrmzwxfzuKbZpC2lJUbOCRBZDhHq
         QTCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789853579; x=1790458379;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=12BcwZn8Tao/Al5xogEYEStWwXTWR+pskV5IlyRljQY=;
        b=cb7S0hdedYb/PccoqkAjH3Uy1zv7HoZwOXiDAoMe9RYlVlTm+9e6i2sjvKK/HHU5e7
         6WeLZ3nifuH9cO2YywXcygvC4mvy+oJHhdrCEdoZwA8gTpzLXVVcF/JVgFVm5zIPRAV/
         EB29VPWb95VFOTaFMdcjpAiiKiny2W1YYOaupdb+cqDx/ne35xkeHy58YhaQqez3l6Bf
         4KoYjWSOVlIJVGsXVQDFEdUyhK10+lXmssuxWglRXLyGUqjfoScpMTnlAoaFEYxBthEo
         Yumw6VJHNu8bmJZVmup8AvGdabOaay/msKco9yV+Nq6icz3d2vJDXiRnPsTo5rcpvuij
         SjTg==
X-Gm-Message-State: AFuF++mV6MvtR5U3mH5/U1RdRvmsijg+A8OIN6rGghy2Xu2/VVy5Ikoa
	DNtjSy7wR5ZRyeVWK1HhqSd1797plQnts3RQQnSILegdd4QhcZp10gQB8l+lRNXG9OVkT7GfSgA
	LVLyTTKYVowL7CWXZZP+WmaKiuBbdHVq3u7sb
X-Gm-Gg: AYBFou2tz3Y3/1LtMIrmiEdzG5tGl3omEQqRDQKTQJC/6vBMbnDpBA4DlUlbhOAx3JV
	3a6dduPbd8D7Wlb4TcxRGm95baCZNhrDLoy6mUhApJthk+qDslqqNV6IoML5RlwWwDfp3sBr4Ue
	8blCtkuM0dHfS2T2+RxW5M4gZW+uAq3kF81sTaw4jFe4D1EBUy9d61JZviWz6VI8Iv1piVse/Wa
	ofOO4f8cg5YF/UsaQ0nkj2CFUtfQ/Vt/C+ussVjsHUwIgzu3ZtXRT1BSi0OTCAH3dsGeH0TOAT6
	oxFJmXJ9EBd14rp5RQeffYrGtPl8xEjOAdlNgX+dlYrPdf5RDJ5gzcthcS39xg6Du+tczzyxgyY
	9slV4faQmnwvogfQgvI8IiHzQpkFnTj/8lVlioymmI54fkOXIwwbA3663ATbQbYwa55Cut3ifVx
	TcENu29qI=
X-Received: by 2002:a05:690e:4553:20b0:671:6fba:f231 with SMTP id
 956f58d0204a3-6717fdf3363mr1470687d50.80.1789853579316; Sat, 19 Sep 2026
 14:32:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1789853192.git.ben.knoble@gmail.com>
In-Reply-To: <cover.1789853192.git.ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sat, 19 Sep 2026 17:32:46 -0400
X-Gm-Features: AcwNN1XGkVggz_r-cUJtGj3iVM4FxNbiJnrIi8PR0GVnveENiAEFXjvZ3IuR8Ug
Message-ID: <CALnO6CDnm3pGp5+gyJeZZbg1EmxWrXkkwka2-EXJPYHNM=e9nQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Hi all,
To: git@vger.kernel.org
Cc: Eli Barzilay <eli@barzilay.org>, Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"

My apologies for the strange subject; a little mishap when editing the
branch description (I forgot the first line was special).
