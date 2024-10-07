Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF27D12B64
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 04:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728274761; cv=none; b=Zu8AoQRIwrq/1E0bRoo1ucrApJZjg7Y+CbR9d+VF5iCIWVuPlu5q9zdZiOt1b40vYiLcun5m43RcT+tBRCGMOC+xFRv9vA4ktOewl5dybnSSxOoXjAuzhX6xN5YBgxkH8glxMwukBrvtQkrgkhAwT0VuIop/JJSozRpcDxvAak4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728274761; c=relaxed/simple;
	bh=XEgyuuW8ISCBBmCQr21w/ePj4T8rTUqC8D9lI7lk004=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bgvh5c9S6zVDlDwV17q7jOi/GmbaHAfG92zbVfz+L7/3wcYM18kjg3vOTepUbSqIy/d9WgKEiPn9OgekLCOMteZpvqoM2vp/r1bVRC4l6KNlNtca3TJGERfaHYAhyXeq+BmMDV9Ykf9TgvuIGHSJhCIRbB7Wpt7ySCv5FiK+Orw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i6JMH+Yl; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i6JMH+Yl"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71df2de4ed4so868160b3a.0
        for <git@vger.kernel.org>; Sun, 06 Oct 2024 21:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728274759; x=1728879559; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cg5UatGsDyikGm2/tPX7MrMDnIZaoC3uGm1K3gOLQdU=;
        b=i6JMH+YlAMsXGIKK3HJgL4eA0aMKgoxe90EmpoJHNSCp2hPKHcqiunRgM5JqEVO5Ze
         AdpMfVdGfNdK8Z8lWTNuGvv6oK+05VqcuAmaczixlO9h4iEK7pB38R/NjyE+SNHn/4t/
         IGmLd7M6ufVgXT00Ml/iT79xlYVuIPrbArw0zzKRiB36eCwIXCde5Y7eqB15YQGkdasY
         yp+Cy7JDeYcY9hPalClY0IyiUjHNXtaGxgU7AumXROGZdYXAzKY8+Y9204wKnsAbh1fG
         yGs1aJNSYd0UeisJzFrHt9S2+sDBb+xgdPIoNhHWZqErwgnPm1Fvlc8zOAyqaVjpa3BN
         vydA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728274759; x=1728879559;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cg5UatGsDyikGm2/tPX7MrMDnIZaoC3uGm1K3gOLQdU=;
        b=SQP3vOD3IItrSv3s1YalYoED5fSwm0EXGQHTk67JLyLeslri6UKsnTc4eNIj/H4rr6
         /6kgF9XACJ9Oxr77gzXxC2xnfV6wlStvFVfb2aVAaNoDaWB8tqxAKSPWPf+3K3ZL+RdI
         9zpBya42E6bZD0sCodR75uC0a1zftirvjOCUz1CZYxZJgv3j33YRbV/rS8M4D1seVOAc
         c71aquheRFemu35XzQnV9ew3Mr4LOdx9v0reCL3efNDOkrRsNCmXU0+RkSr9+hQxNe/C
         n3bdPec70uqJ2hdG8ANnSRqzI60aMTK/79LzkOUPP4JiyTixXoYI1YpMEK0sYB0Xvtpe
         LvdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIRGHuBqrwpStB9IDK4pk8Xpkl3s2P142eoKUScmdhMn+Mlc6OSJe8aEMarVTAODUuCwg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoHNZRhso0fQqpVR39wiPhoLn0yDEjPczbpAtLkB0444urAv8t
	1npqf346vPWieuE0KAcbxjPS4o2JOs89ja6WphI0kNc++BDpj5aVhp1iknH5
X-Google-Smtp-Source: AGHT+IE9xvjC8AnZkRbF3PqzoQE7+2OG5mRqo2O7ToVWh0QtcTaGOa2KnzZII5xXj5UxMN9QbdCpSg==
X-Received: by 2002:a05:6a00:1250:b0:71d:fd03:f041 with SMTP id d2e1a72fcca58-71dfd03f290mr6603225b3a.2.1728274759165;
        Sun, 06 Oct 2024 21:19:19 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f6821508sm4004932a12.31.2024.10.06.21.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 21:19:18 -0700 (PDT)
Date: Mon, 7 Oct 2024 12:19:25 +0800
From: shejialuo <shejialuo@gmail.com>
To: Caleb White <cdwhite3@pm.me>
Cc: Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 1/4] worktree: refactor infer_backlink() to use *strbuf
Message-ID: <ZwNhTdAhJb-KQBav@ArchLinux>
References: <20241006060017.171788-1-cdwhite3@pm.me>
 <20241006060017.171788-2-cdwhite3@pm.me>
 <ZwKoNg-HYGaohvCd@ArchLinux>
 <CAPig+cQC45_Pofw31h2RSydj_CjqpfajLLa5O_sR9m0AQh5OVw@mail.gmail.com>
 <ZwNb5Aabrub4tW5O@ArchLinux>
 <7HnZc9JpxZXOAZFD6AO0MdhWccomQBZJmS_IzwiA_-YpmFlQPAjeMJBvP9uBI_6s6-crP3SXWZTrErwj918xIuOAo7TmzqEZek8FV0IMhrg=@pm.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7HnZc9JpxZXOAZFD6AO0MdhWccomQBZJmS_IzwiA_-YpmFlQPAjeMJBvP9uBI_6s6-crP3SXWZTrErwj918xIuOAo7TmzqEZek8FV0IMhrg=@pm.me>

On Mon, Oct 07, 2024 at 04:01:43AM +0000, Caleb White wrote:
> On Sunday, October 6th, 2024 at 22:56, shejialuo <shejialuo@gmail.com> wrote:
> > The reason why I don't think we need to check the "err" variable is that
> > the "git_contents" and "err" is relevant. If "git_contents" is not NULL,
> > the "err" must be zero unless there are bugs in "read_gitfile_gently".
> > So, if we already check "git_contents", why do we need to check again
> > for "err"?
> 
> There are two other error conditions we check, and one of them we try
> to find the inferred backlink (so it is not a failure path):
> 
> ```
> } else if (err == READ_GITFILE_ERR_NOT_A_FILE) {
> 	fn(1, realdotgit.buf, _("unable to locate repository; .git is not a file"), cb_data);
> 	goto done;
> } else if (err == READ_GITFILE_ERR_NOT_A_REPO) {
> 	if (!infer_backlink(realdotgit.buf, &backlink)) {
> 		fn(1, realdotgit.buf, _("unable to locate repository; .git file does not reference a repository"), cb_data);
> 		goto done;
> 	}
> } else if (err) {
> 	fn(1, realdotgit.buf, _("unable to locate repository; .git file broken"), cb_data);
> 	goto done;
> }
> 
> ```

I am sorry that my words make you not clear here. I want to express that
if "git_contents" is not NULL and there is no need for us to check
"err". This means we could use the following flows:

    if (git_contents && !err) {
        ...
    } else if (err == xxx) {
        ...
    }

However, from my perspective, the way proposed by Eric where we could
use "BUG" is more robust. Because the current method assumes that
"read_gitfile_gently" works as we want.

Thanks,
Jialuo
