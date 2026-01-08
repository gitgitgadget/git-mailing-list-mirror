Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124D02E0412
	for <git@vger.kernel.org>; Thu,  8 Jan 2026 17:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767892896; cv=none; b=pDlvV3AXVtcCF+BLLaKiUNHLnIJNySrnQoNiZ24gcXTX7LTqn23NN2S1Tj1BLMQghR5ljljLL+Sp8XSlewpWs/gEup/SZ8AaJbDg2IJ7upQQjy0qDhgeUUyRN9wWvrnlwKlsWiGHmgVboVyPVjaHbR46UueiTv/jUJz9qPct6KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767892896; c=relaxed/simple;
	bh=btHdcUWrBy2YNZGxvZjIpmNi+aBaVqvzjSOhC4JfiXs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bD3C4ozyQ3tjwwzdRKH03Us/WUG5T49fabbZDRwIQ+q1JRVNJ45eZFEvlUWTtegZ1BqK2pgMFBY43jxRQ7DEdEoU4kR5M8++189i03aZOsi9zwNAcErYvpsz6xAoIEZxPtOFlU3xpEbmzr+pmSUpzfnJoz/YVSLzLXTTQ+QHN6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TGA+XjgT; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGA+XjgT"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-477a219dbcaso28567855e9.3
        for <git@vger.kernel.org>; Thu, 08 Jan 2026 09:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767892893; x=1768497693; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=23J5HmjcNKEsosU0XaIY66JDfTghrVkvX/rxgrlHoxg=;
        b=TGA+XjgT1qR/+z2p1uGNIcCUHMfmiuzCWUsAZeoqlJi6rlrld7xvAne6Fueyromhdn
         WWhoBijRn6oNGSsL+bpD7tJjboY7kVjqo+RwkVwg5T4L8QC9t0gevceTV1VPB1SewasK
         5jMaPMbi/OptrwbSj5QBTyNSznjIh0s8aTvVmoXB6KeFLZ7fqcOMzMGpMThWF2VWlRTX
         x3J1vUM6++MzlGS+Rdq93ira/Z5mbkeOMoeB5ZpTEr35IBM2+VfHfdaMB0QvEA9Z7sFq
         9ald3Zieib0qadc/4QIhCSjuOqB5izVslum1MOrn9XSAWlIqfeZLuNU3kj8KIhsTFAl/
         lpKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767892893; x=1768497693;
        h=mime-version:message-id:date:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=23J5HmjcNKEsosU0XaIY66JDfTghrVkvX/rxgrlHoxg=;
        b=WqIVcolK9xtJnuWvcZ7lU3DLwFAemZdg242bWNTSGg+Wk5+/xFi6NoCwxD2ac4MR4s
         BFfYsRj1U2q8MzkT/+TKuMQmaq98E8G8t2zUwOJxD0AWrlcadK9Hwzx+ci+nO9fRTJSN
         O7OtOtez/EfFHkWtiwXQAC5NINvqnUu7a5hDRhOLuXUglvsyU/pmxLIghO3+18bBPjd2
         EgFJWYrhEkCGlGua9PymtBEywpK0rlUiE289tHbaLL8vqYV0ABUnRAb8gJse2qdjxeaY
         dZqMgmr7pn0g48hTpT6trODR1qoIwjKI+GuiSsxK4LYaoBR5oTsPFeYaEWRaped3YoGF
         MFvA==
X-Gm-Message-State: AOJu0Yyziw4gNik5DNrb2FdXs1/v4bOpesG6Ny6PSfJLK2q/6iopO/3y
	FG+5go0rMcT1vE9/cecM/8mtjJ4dhd0LByZ0+zzCI8UHuj5S1bSm/p971nFF1g==
X-Gm-Gg: AY/fxX5kUeVu+SREmhYm+WGmFBahB/iwNRUldQOyQpEWgxbJzEXJ6Cnux9g+d6+ouF1
	RXxq/YhZXL7XEzaw6g8Gg6svGYXoGSn01mh6SOX/SSQ3uiBm3iVQUg7UKtBhJA7QAwG7VEbX2YT
	UlIfIG8ZjFTY+MzKBM5eIHNYxSX/mrFDho3G6Ob1z/mr4S5ptDEUlTHJSEVVnyd3+1/GBfDu2mF
	MzHXAtuxmCl3ahKxqSKkgBFp8XyBQlhkk+HEnXXRXUD0puIdlza6xrCYG/PvzngMDpusTkS8YQE
	ocSeZ6STDqm7b1tJTZyXr0L0p4trejyahF2MTly07DWQTrLg1ZZvS55qwtxveoqSV1DD4Dz4nvl
	48Y01bvvWoGY7md9zrbaXUrs5XshxYHfxNouVAmC7aiatvSt5A1fLKjUHtV3in36QAfafmJ8UCA
	1UDUBPp4tb/YwHUnbjHZ/cuFHTRqC91+6wmDT2ETif
X-Google-Smtp-Source: AGHT+IFjFP22HThANkVZ7FGRtQeNbSoIMka7Qsu0tXgy0ouwf0zh4xgZe4CqpAOy3vCPLQX0SeXMRQ==
X-Received: by 2002:a05:600c:4747:b0:47b:da85:b9ef with SMTP id 5b1f17b1804b1-47d84b18a7dmr100549985e9.16.1767892893335;
        Thu, 08 Jan 2026 09:21:33 -0800 (PST)
Received: from localhost (222.241.108.93.rev.vodafone.pt. [93.108.241.222])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d870dd5b1sm46350715e9.4.2026.01.08.09.21.32
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 09:21:32 -0800 (PST)
From: David Miguel Susano Pinto <carandraug@gmail.com>
To: git@vger.kernel.org
Subject: git init with specified user.email
Date: Thu, 08 Jan 2026 17:21:31 +0000
Message-ID: <875x9cvx44.fsf@word>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

git checkout has a --config option so one can do:

    git clone --config 'user.email=email-for-this-clone' ...

which I find nice to setup as git alias:

    clone-work = clone --config 'user.email=my-work-email'

(while leaving the default clone for my personal projects; or an alias
for clone-personal with the work email as the clone default).

I would like something similar for git init.  However, git init does not
have a `--config` option.  I tried to use

    git -c 'user.email=my-work-email' init

but that's not working (I'm guessing it only picks up configurations
mentioned on the man page for git-init).

I am currently working around this with a template for work but would
prefer to init with `-c` (or similar) or at least understand why this is
not possible.

--
David
