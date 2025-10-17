Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452BB8F7D
	for <git@vger.kernel.org>; Fri, 17 Oct 2025 02:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760666811; cv=none; b=F68w0bNshK/9/o+lh9PJ4APct/gwVTsv4XHFdpINU9f4GKfSX1hZUK6YPdzNuHpXGuRjWwy/4WtEWv0/1lbpSFJUWdidg/WNTNSCSlhiM9JEKXSMjn+7Yoj3zBQ5J3OxRPxGuNidkHJF1bFhePv5reVQzrM8IOZ+/R0F7AowCbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760666811; c=relaxed/simple;
	bh=55UiBX5EPrBb5BGatI6dvM8Jvm9f8AWXjvpxERI+aHQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pacPNPVAL27/zI1HQi2NlMhIKbrKTb5kNcZCkEZsu8366ue3OCkHvQgVV8r1pFx6/n8u8ks03nAqROBZsnTs3U2L1P6v48wsGMY9KES3QE2pXLbtKuIFM4wYtuJc26jKgBCHRGj19iQ9CAE/VXGvCzCBW7wnmzpLPQKJFB4Ap04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=apimiyuB; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="apimiyuB"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-33ba2f134f1so1378520a91.2
        for <git@vger.kernel.org>; Thu, 16 Oct 2025 19:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760666806; x=1761271606; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xxGENdWKvfli7tBb6Ewo1B/scyWSw7Ukp555CHlfBio=;
        b=apimiyuBT3jQENXOJfCuD007zfnNTu9ky3Q1qoSPYqFxYnBeTcBTDyt0ep27ckqtGN
         ciAUaZGBKN9GghmlFzJ6n2nBxRwsaGCtVnPKzzEPDVMw5/ONygAWN5iqP67WVAri95ia
         zDsiNUKmmxpt8xaF7xpSiennOUQeVmA2UUA5n0p3Vu9cpym2M84YpDipn1xRPZ3a2iHg
         Ag8YwqiGeFvMMCYdAodDoiOdV/OraZhfFeLRvkQ2KAEqGdgZyfcmzWjzw5JzCWZCnPL1
         sgQKTpPVASavTDZ4Jzl5cj2UHwKuQZeVFKEHyYrXe6xA1rhsrPN29yu4/9y/PO/TLDA7
         PwWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760666806; x=1761271606;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xxGENdWKvfli7tBb6Ewo1B/scyWSw7Ukp555CHlfBio=;
        b=dGZ/9e3D6nXHIzQS3KeZJ8IXk/Zttb3fiZ0BWhj0vzMwlwj2aoHdo4rAJvUvpUJKOd
         9hKYFx1NKO6VEDP4flFJuj+a1o8REvGfOrHjAF+E1r6Pdzy6ArIPUHREOh//vHxL3t8R
         EX3B60HgPm0f1sh56L3BGFv9NKBpPztDuFmOdeIQpKARPI5Uvn55FxijX1XRbyUrbokZ
         xgWbGR6GpusQ1vl4Fo5hppASzbNXUjy4HSjqL3hg5GRQkmEsrWnzKD+kyAvcpkSSjSKN
         NlpaimuNDEgH1aFdbAyAdILw/45lSElFcPfyHzLo0JpJhJI/GyCRbrXrgPY4oOD0XIzF
         CjhQ==
X-Gm-Message-State: AOJu0YxgvJbzsVldrYsMk9CY9PlEZ98qGm5C56dwVVIZRzaDV+//4jdF
	3e5Hp2AWserK1Kpb1qu070oc+vG/7LF7yEXD5vdx2f+U3mLWFiNNteNUKD5dxfeh
X-Gm-Gg: ASbGncu1IqElg7zwhJ0ibuaOeVp272dGqtXnegGzGcix5Dy1Bx+ixnA5F/QrIjnIk1T
	tH/1UshYPFSvznwIu07GW9vZKb0LA4UyseSgplr4E6WKw9bdYZJiHT4I98DIkV2h4fh+jPTWghr
	GZBAt/lloXACPY7J1OEgPq0buekzVsW+RorY+YyOs8fvX/PQd+AJ+u7bd4Ebj2xjwJNzT1Yw5k5
	/4720QJat5QBGGRgftJKm3EwvhiXlQiEO/Iq05PrKEMco+rnUv9XPOVJQD1ChPvq5DgLOAlq//T
	Jvd0x5AcACfdUXU8Vg0E2iMF01e8yR2GezMoA+d+nfLTkYit2WAWDpZ9vLvJFycIQjeXxg4XDlV
	cpyc52p3uIDu3Iuo7Jifcx71U+li8mo3/+3IWziG0rtmH5rV+AQE5NJKrQg==
X-Google-Smtp-Source: AGHT+IFtIN/hL6/aOzHFVDFS6K2bodbKBEgLZvJRrztER7/uBGBhgPt3N9nTCIQrmB20M8KeTbAPhg==
X-Received: by 2002:a17:90b:52d0:b0:332:1edf:a694 with SMTP id 98e67ed59e1d1-33bcf8fbbd3mr1829981a91.31.1760666806501;
        Thu, 16 Oct 2025 19:06:46 -0700 (PDT)
Received: from fedora ([2601:646:8081:3770::43bc])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33bb6298651sm3547255a91.0.2025.10.16.19.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 19:06:45 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: Xi Ruoyao <xry111@xry111.site>
Cc: git@vger.kernel.org
Subject: Re: t7528-signed-commit-ssh.sh fails due to ssh-agent fails to
 start with ENAMETOOLONG
In-Reply-To: <4e2952e512afc780b621d2c153b3e6e4eb7ed89a.camel@xry111.site>
References: <4e2952e512afc780b621d2c153b3e6e4eb7ed89a.camel@xry111.site>
Date: Thu, 16 Oct 2025 19:06:44 -0700
Message-ID: <87o6q6nux7.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Xi,

Xi Ruoyao <xry111@xry111.site> writes:

> When I test git-2.51.1 I hit a test failure in t7528-signed-commit-
> ssh.sh.  Running it with -v reveals:
>
> unix_listener_tmp: path "/home/xry111/sources/12.5/git-2.51.1/t/trash directory.t7528-signed-commit-ssh/.ssh/agent/s.fTyCxA5V6V.agent.dX2yNWQUX5" too long for Unix domain socket
> main: Couldn't prepare agent socket
>
> So this seems an issue in the test harness.  Is it possible to fix it?

Unix sockets have an unfortunate historical limit of ~100 characters on
most systems. All the derivatives of 4.4BSD have a limit of 104
characters. Linux has a limit of 108 characters [1]. AIX is nice and
supports 1024 characters, but I assume you are not using that.

I guess this test can check for that error. I'll have a look.

Collin

[1] https://github.com/torvalds/linux/blob/98ac9cc4b4452ed7e714eddc8c90ac4ae5da1a09/include/uapi/linux/un.h#L7
