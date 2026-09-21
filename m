Received: from mail-yx2-f28.google.com (mail-yx2-f28.google.com [74.125.224.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAF045041A
	for <git@vger.kernel.org>; Mon, 21 Sep 2026 09:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.156
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789984188; cv=pass; b=muAWf8pSTto27/8WOfHmP0uTwUWXyg6A3Idy3Cdm30iL67Mt4SHdVyXeAoD2Hb/kr5AtEzeVFV/H2qFAZs43CVCQvYGVG4Usg4gb2/W+87KJVj9WVHV0fDh6ZxKLs0FVYv1K0tEwcDR+Ad3QQnfuQ5EH97IcZPb5/dWvLW4kCdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789984188; c=relaxed/simple;
	bh=FocADL9+cv7Fvcja2Qaq0T69I4NyX/N4P39LeVXtvfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u7U4dlDG5CiX1UJ9yrMv4y3TGBPpjA8Zbo74a3SyY5jyNGX2DjsB6yBWTI1ijyoptnT64ciomnT9lfGD3PZnfdq3vUTliS/ekOQgDjfMCAlNxKvi8b6ajXa+PCfkKTWn/Bd2RKp/scHH8B97yRLWvMiPr3eqvhIIevN6ki5ys4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=h+et9bjY; arc=pass smtp.client-ip=74.125.224.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="h+et9bjY"
Received: by mail-yx2-f28.google.com with SMTP id 00721157ae682-85d43db0c16so19235847b3.1
        for <git@vger.kernel.org>; Mon, 21 Sep 2026 02:49:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789984185; cv=none;
        d=google.com; s=arc-20260327;
        b=DaGezO8aJFHcoZi35Zb4arGJBH264sEtfdP7pyeJ+Lhg59VbfzwtjctsA5B8i8KbSs
         1+6r5/8CvgmlNftT0kXn2wSRewH8Zt7mCXDSCePGa61hWQGRPAA+7ZPF9dHldUfRg1H9
         4Aepmyz+5uA8ZkuPXxfc81WInRCndZAA5h6prys16TLY3cN1PdQLrP4qM+z8Bz5HmWMl
         hSBlhqhCnYZT15EiP5XpdMhehUGHdirKyBPlP9+Kt+11H8zP6bafyQ6sawUZpBQREPM3
         zzoRn7tR8o6sJBqLhl7PNZbtio/LCtibOIv0iL8hsIjwzbI5+fnywOXHXyj6qau8S1Iy
         levw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=DNW8DrqXEtqz5NMdm78TVYgJLyOGCfgT2p6ZXhM0/60=;
        fh=mqWBCh3U3mgaYsIUuBqKjOkYsg367vgLakhdNtAThW4=;
        b=RkbtPpo0SMw72a874KlKEkK06x+dG9jdE6ybJh5wftXyKSdr4LgOonYmcBOy4zBQdV
         ofchOUqkO2YLqUsh69i5Qh6pe1wpy6eH1+gJo4t+PkYYmoXVP1FGh4DOxC7RFSNiAIqX
         nwelDO424ZHHB9DABKl5jlo9WRLlt9zjgiRcqKL29c/ERkopLj14uoQmkVo7QpMc9jfu
         fbRMPubqAIgEAg8rLE8TrA3MzojSnIcRqCdFGcYBD/h5JcBrdZgUk0pxue/pUP9r6F8I
         oomlb0zYmpOFs1ndLT1tAEWC8m7MVKksvmuCQUyyM3JMzt2svVDz21a3WQYK5jN94x1z
         fsxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1789984185; x=1790588985; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DNW8DrqXEtqz5NMdm78TVYgJLyOGCfgT2p6ZXhM0/60=;
        b=h+et9bjY+GtX40qgq2w0UMbRPf+DeQUxpi3OBNK2fnt2aGDPoSRTO/+uWWS5Gxwed+
         Vd9M+iYNmqcsMA3rzjDkmeDnOB9RddvbsFQ9RRPfDoyU05KamiQGjkW8m9iQ4iVXlhf4
         Bpx3j46G7jOSHXGsfJ8c1lBv+s2m4qFHwzZB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789984185; x=1790588985;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DNW8DrqXEtqz5NMdm78TVYgJLyOGCfgT2p6ZXhM0/60=;
        b=BBExnlqfPUDgt1p5mBQ8zz3EZ9+WXimFrahgl7Aynl6FnTwvl9FLFi6mRSiE74whpd
         Sif4+NNu2dNlm0Ymw6Su9Q33MdRm7Xembl8jy6+Whk3jHYIRWGZRS2VbDajfqWxY1aWP
         O73KgNEsqEscDvn4G0bEUsy50xS0P1UQH/p8OtBtKhZ8KmxAXBKEQHwWRTFRH9DuAYVq
         c4TSDrSiCNkhoYf7WJ3RWKVKeXy2q8G71Kuv+ru+etzQxb3E6ben2qP7D5GoQS1Oy2ai
         cRjTaTh86diMfhMzkeHDUucFHoJnHOinXDz/SB5pktUrwvdMLCypA/I3ohJJjueMjKZH
         XuEA==
X-Gm-Message-State: AFuF++lmEPSL9KJqrUHMn++K4dA+Y9Sgstekzh/kOhpbDyWjVADULAIN
	V46hJKgN6otfcsR4NZBw9HoDicRCFZf52jtI7M30PVCjFpgbcfsJEeFCbvPSUO7VgeQLcuTDjUc
	iqw2PYk/T350lXEqNo1FW0VWte5zIz3nDlKeMacAPhIFDdgfO4ILpmp7z+Q==
X-Gm-Gg: AYBFou0mBBF1hNXsCMSQwyCcCGKZ5QGxCjIXgyT3tjEKthY/rAi7lWMoIMOcnOKkK+8
	GPNHYsKBPAsKO4iKqUbj22aeUYkNPZWNGk9oNFbLDFKB7D6DIR4PIuNwTrIy5uestmZA4ehQ2Yt
	EqP0RiGRJSSKMnwry94nykxaeujloekEjYICTHEsasO/cD1gEIK9nUQLiJVKwV9BQyp4zzAasGi
	/0RgnI08gS5j7ltzvYYPYFnRH7Lv1Hxd8vP3QQMF3GCqxzz46L6YX417Caczn8jP3GnGnslMF3z
	jqbKxP85hszQS8rJVtfk71qYeANQ3cbj8o0De5p1Ya96hwnwQ8jPIw==
X-Received: by 2002:a05:690e:4511:20b0:66f:c1bc:408a with SMTP id
 956f58d0204a3-6717fdf1132mr1855826d50.77.1789984185094; Mon, 21 Sep 2026
 02:49:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <41c54b809eb1490fb467ba0fd4c5a8cf@yadro.com>
In-Reply-To: <41c54b809eb1490fb467ba0fd4c5a8cf@yadro.com>
From: Kristofer Karlsson <krka@spotify.com>
Date: Mon, 21 Sep 2026 11:49:33 +0200
X-Gm-Features: AcwNN1VmRe_hB1Qo4KmJPZAbSmlmpqHveLieS0612sMt9FpdiyLRbW9S85vYj54
Message-ID: <CAL71e4Nw+-bmc0sCOC+L9VyxYG6MwRf-XbXDDWO1grOH=WbEOw@mail.gmail.com>
Subject: Re: Bugreport: git log -L
To: Nikita Makarov <n.makarov@yadro.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 21 Sept 2026 at 09:49, Nikita Makarov <n.makarov@yadro.com> wrote:
>
> Hello, I have the found the strange behavior of "git log -L" command with python function.
> It is counting a blank line that sits after a function's last statement as part of that function.
> This happens only when the function is at the end of a file.
>
> The way to reproduce that
>
> git init repro && cd repro
> git config user.email t@t && git config user.name t
>
> printf 'def foo():\n    return 1\n\n' > bug.py
> git add bug.py && git commit -qm c1
>
> printf 'def foo():\n    return 1\n' > bug.py
> git add bug.py && git commit -qm c2
>
> Then do
>
> git log -L :'foo':bug.py
>
> And you'll see
>
> Author: t <t@t>
> Date:   Fri Sep 18 18:21:10 2026 +0300
>
>     c2
>
> diff --git a/bug.py b/bug.py
> --- a/bug.py
> +++ b/bug.py
> @@ -1,2 +1,3 @@
>  def foo():
>      return 1
> +
>
> Though I expect that commit "c2" should never appear in log, since the changes from it doesn't affect the functions body at all.

I tried to reproduce this but failed to do so. I first started
wondering if this meant the bug had been fixed in master already,
but then I also failed to reproduce it on 2.43.

I think the reproduction steps were wrong here, perhaps
you meant to put the double newline in c2 instead of in c1?
Because if I change that, I can reproduce it.

So the steps should have:

    printf 'def foo():\n    return 1\n' > bug.py
    git add bug.py && git commit -qm c1

    printf 'def foo():\n    return 1\n\n' > bug.py
    git add bug.py && git commit -qm c2

instead.

I think I should be able to submit a fix for this shortly.

Thanks,
Kristofer
