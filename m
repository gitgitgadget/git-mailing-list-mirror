Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B304A39151E
	for <git@vger.kernel.org>; Wed, 18 Mar 2026 10:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773830730; cv=pass; b=EgGIW8Xk/eDO7MGOGP5pCMWYGQYTFUqJ3Sm6qWjcENLn+15Tia+wrhB2gtSSDuCu/7P3YTLDOjWDTR1iveqjwyRUe9mmk29KeQgUG5snJU1EFAt4cMKHzpO/0O/unMusSbUK//oKfvqsTvRzLgfVxT/CtwtJefnrE77R0fkP9l4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773830730; c=relaxed/simple;
	bh=+rd8+xQc7I3qffIFkOfCKW8SNwp3HO1y1O+J53ll+M4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kmaUTATU86n6s/ADs+E/vzHb3xwB2ysjXkz3sFLS0SbeauTxG4Gbrxw+kei/k5hbEsy6EjzLlunXPoaXYn7WpocsyHrkc9kHD1aoCR8C4C0Tqc0taFdsunGSoj0bHnFI/qTgoB3VHVr2scJSFqlgfh/sGCFB28sFOs1bNm6Wv14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=genPYxWy; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="genPYxWy"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7991db3dc98so64990207b3.0
        for <git@vger.kernel.org>; Wed, 18 Mar 2026 03:45:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773830728; cv=none;
        d=google.com; s=arc-20240605;
        b=JpOQRPv6Y9Brn0yFqnn22FHcudyT5zLuDh5TPVF69j/JT8Cb/1dBcm2MxPBJ8XVMHB
         y/e6tADNGzNGpZiOe97F+mHM2DbHw5rH+duAgzmu2zDv/nnM6KhS1hmdm+k+/RZ9Qlgx
         NjSU4/GeV4SWpS+StWDcpEdR+AOtA4F/Sjzy262hpZMLOecrOOChGMVcJEnI22cfjsXA
         2Ga3Om82avaUBKrhQpqXclL0aWVia8xojaDrIimvzDn15bD3xeuCZX3cnNF6nFTYn+F5
         p8h41EjXDubSvbS0+50OzoG+N0FlLbpcaspuMQBvyGTqghMRQxg3/hAplsOZHyAppjdP
         Ehiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+rd8+xQc7I3qffIFkOfCKW8SNwp3HO1y1O+J53ll+M4=;
        fh=MTo5IudGTllV7vNSs4W3ihtcUy/MfWXufd7rF2OxLCw=;
        b=FOcMFvpoXbh8b35Xsux9yKXAQFCi+ctrnKkCHtSsysoRbcE/yVbtgb6uumdMfOdI3p
         1879bE3OrTgSYJF9FcJFwJWfyYCf6T/dx9scwXol+GTsFruumEeJDjK8x9aEsrxK55fh
         F/nqTDes6cKtUXHKX5qjQs2WjeVGP8dCUW1YRpZnSMG6b7DzNXpv8rL0s5ChFvnUPkrG
         9WK7gKBEbBZ19cCW4cWND+H79VSmtj4nni+of0LieJ5AsdoUyr226kO69ORouvkHW/tW
         YfB62iMOmJlMWsZvIPY5Bg/1Ih+Utx9feTT72N/NwUOdp1Y4LhL9ZrVvA0eWVIq5x5Sm
         xhAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773830728; x=1774435528; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+rd8+xQc7I3qffIFkOfCKW8SNwp3HO1y1O+J53ll+M4=;
        b=genPYxWyvaAEifGLrEVKP7IJnraWyr6Stqe4wuL7dT1wcC5QPzn57v2BadTFYdI502
         T8pCv26BESImfRPwlOGy8L8IszphHVquOQa4Glm6Ndl0fPNjDoPh9JnVPYdxVmbVWyFm
         Wz+AMAHnK+C2oh628wj4/FJDNhRWhf8KxM3M1XKZvUQrO3+1N9OPipK73fVPeWgMybZu
         Oqei0Izlnqo0ihCY542xEeP3j78y1bADMNRtat0rkvy4jVPol+PGn1AZ8IXWMdBuHYOS
         9iZFWFauuMGoKSI3BhlfMtbDr0YIcuZv7F23lPkJ9TaFIASUhkEpD0Rvw4jkEgnRlnSF
         q9qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773830728; x=1774435528;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+rd8+xQc7I3qffIFkOfCKW8SNwp3HO1y1O+J53ll+M4=;
        b=BMxYtLo0Ljn7ohDoSd/aa1H4e7TeoB3cIYwcDGUfKQX5Y8zSW4NmkqDWpg3QdTlyZh
         ydc6s1B1WriQvlZvU+UX1304y5KRrrgbcM1hRyxpwng61IlNvpqdlMFjjU80Qo3lI+mq
         Ui7kA2XDYxFlGAdG+X0utOGq+mdaMElB8xyE9OcmhmDLF3WskOWO6e1liAbDA1ouRjqi
         Nppq0qbh5N85ZBUcvbITa16u1tbbMmR7nkODqA7lIX0vQtTVRlc4WVs0Z1Xo7nD9DnTy
         GlnLmlaCjgLlspkvxe/KsNjhRcSIR2iIpw841WLfWhMy9zjcWdm7fyDlNj40FgcU4iUV
         w66Q==
X-Forwarded-Encrypted: i=1; AJvYcCVdP8i0UEftGk3WWdlUHs4Jb5AKfZRUvevFJeNEupRkG+SeF022S/oUHpYyT8kMhswBHxc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWG77d2ZgXe61ojTH6c7ZVCDutFKIloUBv7+qoOMVdTi/iIuGZ
	tOpFV4QiS7Jr4tBSY8y1QwSuKwyVXbcmO/aE0V1ZCcS2A/fBxy5/Al2LYOefuxw7Mg8DJMqGPJf
	FKGxjdeA1iQ9zWaSPs8TOPpF8rocbxeQ=
X-Gm-Gg: ATEYQzwF+YoPYTkZW/gk1AHrzIo2xDDRNso/rzsVFzL2NbFc2YIyj2xI0L3HcsRJYxc
	D3PpsS0Okd1XDj0F3dh/BeH+JXJXTguvh4ZH0sdZJFHXMCvs0jBZJQL3sFxHeXdRdaemc6thBLq
	hPEUdh1owdRn7/pklqHRb8ArwP0eUhP9sYKaadO5rywpa0mR9O3WRKrDdPvhptVq8ca82vXZc8v
	taQN7i/212k0ZJ0BzVUJa3uqTimnFMxvwVU6hIWpi3P1EG7uw4L2SY8ciaiuQLbXbvR0xGrctw/
	lm6/VdABbPdzCAqURjGprNdiFHuEq0A8sYVNuntjgRwox/q6ClAjvQD7iVU1I1u9hytp/ezP9UI
	AgD8LcaevJdbrmUBjSJYHNmX8oytFdVYYkw==
X-Received: by 2002:a05:690c:6891:b0:79a:56bc:246e with SMTP id
 00721157ae682-79a71c2b543mr26508477b3.43.1773830727657; Wed, 18 Mar 2026
 03:45:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN5EUNQKv-LCkbY+5scn6pk6fL8kpmjNR=66rjeY=NqKbqRkhA@mail.gmail.com>
 <CA+J6zkROsbkr6mWQrEhnswtb4sOh+UMO+bt3P-5XDiAjhtcsMg@mail.gmail.com>
 <CAN5EUNQdNtPq1mEBUXOjRJ_t2n=cSUS9dz+HUfqbFjrjZVoGLQ@mail.gmail.com> <CAOLa=ZREJsZ_p9Hfi_+XePW8c1n7xd-UjEuMSh=AHrQC8X75Tw@mail.gmail.com>
In-Reply-To: <CAOLa=ZREJsZ_p9Hfi_+XePW8c1n7xd-UjEuMSh=AHrQC8X75Tw@mail.gmail.com>
From: Pablo <pabloosabaterr@gmail.com>
Date: Wed, 18 Mar 2026 11:45:12 +0100
X-Gm-Features: AaiRm52Gbz18duyJOWArzbeBWtcBDEiKlqAFKgb4V2ji00-oVKjnFlNyxLpheTA
Message-ID: <CAN5EUNQtFY=TpwddqGOSHva7RmunWGLzfHU+4c=OvdqipA1ptA@mail.gmail.com>
Subject: Re: [GSoC] Proposal: Complete and extend the remote-object-info
 command for git cat-file
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Chandra Pratap <chandrapratap3519@gmail.com>, git@vger.kernel.org, 
	christian.couder@gmail.com, jltobler@gmail.com, 
	Ayush Chandekar <ayu.chandekar@gmail.com>, Siddharth Asthana <siddharthasthana31@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Karthik Nayak (<karthik.188@gmail.com>) writes:

> Perhaps a diff would be a good addition for next time? :)

Yes, I'll add a diff from now on.

> It's been a while, so this is expected. I guess the first week[s] would
> mostly be getting this series up-to date.

Yes, it's mentioned in The Solution section, but I'll make it more clear
adding it explicitly to the Timeline that it will be the first thing to do.

> You might want to look 'git-backfill(1)', I recall there was some
> thoughts on extending that command to do something similar. But I don't
> remember on the top of my head.

Thanks, I didn't know about that, from what I've found the 'git-backfill'
extension that Stolee is working on [1], it's similar but (correct me
if i'm wrong)
'git-backfill' fetches the branch/path. This idea would only bring the
metadata asked on a
format string e.g.:"%(objectname) %(objectsize) %(objecttype)" leveraging
on what has been done on Goal 1 and Goal 2. I'll add a clarification on the
proposal about this.

This would get along with 'git-backfill' extension by, querying the metadata
from a branch first and then fetching it with 'git-backfill'

Thanks for the feedback and compliments,
Pablo

[1]: https://lore.kernel.org/git/pull.2070.git.1773707361.gitgitgadget@gmail.com/
"Stolee 'git-backfill' extension"
