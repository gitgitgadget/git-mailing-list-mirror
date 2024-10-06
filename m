Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238A0EC5
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 05:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728191101; cv=none; b=f2upSiFqes5YavzBfyF5DnoSMkuv3dOH9XzowHNy+bvZGo+dPoZKxSw1VzYcffiDLFpvO5/3fGiXoRNGmxbS6JYE7S8ysDTI/tkSeiyhBKXWBSxBSG0+9hViPvGqzwBdHppyPGgRUPw831cjP/mimvlM6u3maCBA7H9Xttxzd5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728191101; c=relaxed/simple;
	bh=9LQZ/U++ZcnMejNHfN3M1C336G+DFbnq2EG2l+WcKrQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DTzkefWmY9SH33uugv3244tmOWgWjYEYL9h0HQpEFuID6Es31vbgI3P+zic31aHL+633nmo2freMyp2IXcs68Y95vEqMLfL5E9AynVQxeT3oo9wnmxjmybm+hUkfe5pqo6M91vhnANjrI/8Cuw0bDGfPe6cVRloz8Z7bbQdJ10k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6cb48e77b16so5268546d6.0
        for <git@vger.kernel.org>; Sat, 05 Oct 2024 22:04:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728191098; x=1728795898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PuPkcvFeyCeXmw+UMChuVkyeuvpwO7vbT74SswjyxeQ=;
        b=lPBRK6F7TLbk324vjg4JMRD77i49SJ/RxFf4+oDpD3NJLxOnodnSxyI34BintLhMg1
         39EDVjVU2tAEKZ55ylOp+Fw9fM9Hkkus25LLXXWV2KvMPIJFhUErPTQWXMxcfWYtywvC
         PoA0D0Idd2Bg1v/P1psbizLcd8W4XyYZ17Obkmt7kTUzhXJr75cqWBKEDXL1mbgEw8D5
         wvbJeNX0o2FSaRJPYampVmxlz1fcEZqyOYiOAnruv55qBMWyi0mgYgRsnWMZSpTFYOj0
         oFEIgrlZpyxaVMAwvaGL+WAxAtB+IJmgfJxNSFVVkdyDYyJfZhMz+nIXEKIGVlCf+wOI
         wB9Q==
X-Gm-Message-State: AOJu0Yw3vjbtP9+E+HeApIsZ1cEhiHYJTCMFrNIX9pR8/u+MXumupHhH
	/t6yl/vbSvYVUAAacZEBn9j7XQ00VofbUt7Fsgx0okFlYDGDTHGFXYlYmz7/2S6xsTfvjpubgvO
	GrW7D2jit5Hv70oZkAVj5fGiiMlKZBqR9
X-Google-Smtp-Source: AGHT+IFC8+/F1WzBpcEJvXOipBwduA690HJeoaSK1a2KOtOgfWv6SbOn6PbA8SyT1hO3J/bVy35CrI3MEIIci6AoWpc=
X-Received: by 2002:a05:6214:dc8:b0:6c3:589b:7ab4 with SMTP id
 6a1803df08f44-6cb9a4556bfmr60730236d6.5.1728191097930; Sat, 05 Oct 2024
 22:04:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241006045847.159937-1-cdwhite3@pm.me>
In-Reply-To: <20241006045847.159937-1-cdwhite3@pm.me>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 6 Oct 2024 01:04:46 -0400
Message-ID: <CAPig+cTB-sA-g4cdhfEjWwY1mnbWJ41e=bOCNwp=Y8JKvpmpRg@mail.gmail.com>
Subject: Re: [PATCH 0/4] Link worktrees with relative paths
To: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 6, 2024 at 12:59=E2=80=AFAM Caleb White <cdwhite3@pm.me> wrote:
> This patch series modifies Git's handling of worktree linking to use
> relative paths instead of absolute paths. The motivation behind this
> change is to enhance the robustness of worktree links when the main
> repository is moved, or when used in environments like containerized
> development where absolute paths differ across systems.
> [...]
> Caleb White (4):
>   worktree: refactor infer_backlink() to use *strbuf
>   worktree: link worktrees with relative paths
>   worktree: sync worktree paths after gitdir move
>   worktree: prevent null pointer dereference

Unfortunately, these patches are whitespace-damaged. Can you please
resubmit using either `git send-email` or GitGitGadget[1]?

[1]: https://gitgitgadget.github.io/
