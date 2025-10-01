Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE382D77EA
	for <git@vger.kernel.org>; Wed,  1 Oct 2025 22:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759357765; cv=none; b=Sj9Tl0htBZW2va5/RIkilzi1mzSx7P6H5pkVzzDDsnExmh5CdYn928B6NCp0wmH2rTQfqDlehXelwFFHtH7vzILAIutQvE4XN+MfAPvuS2ZKVvcHMYbCSzbzOmRzW5xzoobcUBi3fpzrc2/D1eY/x04wd17jQqzQBBQDSEqz2CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759357765; c=relaxed/simple;
	bh=MaJhSvNOatH5pAOz4y3YM+WmSCvtU5+zRcYPknbcqYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=boQ8srq/hyMtiWxyM9FLkZ4cB75/A2eJQ6SH6uTxM1GzvJjsfFbwiy5JOsJsVOJvx8TQFL6slGUk9UN5bn7rg5jRTxfkiNlQBGkFN9ro7TLj/5Yc0EGywdQdCOq1Qa6vczg913ECbSiNGSoS80d6uGSmVNPhDLdlhIrQzHBjwcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kF+B1XLu; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kF+B1XLu"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b3c2c748bc8so57028466b.2
        for <git@vger.kernel.org>; Wed, 01 Oct 2025 15:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759357762; x=1759962562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RRE5ZiVkggKVLwHbPY1oIFGcqL/+A/L2CLuJuNqLth0=;
        b=kF+B1XLu/rzo3h12C0CgvITiz33ZB7w0GlvTjYUtcTvcHasoj5MLg9NyUAUk5SXgmJ
         S5eQxdPnIHtOmnsYFjh7vqnaNODR8phfFH22u+qixFpXONVJrUQLLJLL+d8ll3x5Q4Y6
         a32KzZemLU6fSunzqRZdRDr5L9A3nyxDLbV8mXI6DFl2F67dM1nkPGT2dvhFOmRwoI1m
         Md/YbZROKXSSE1jq/dqtqLMpOsloxcQEl3BiYlTCgbhW9ECYzLZBvLVxbYWZVaL/5KCJ
         K/RNKLXbCNxOc2RCb45p9EzI//mcnfeDgomihUv4IsYo4XF/pIO4LpD4DumwsM1i93zW
         PwOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759357762; x=1759962562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RRE5ZiVkggKVLwHbPY1oIFGcqL/+A/L2CLuJuNqLth0=;
        b=XUXOGn2osbl2uBSYLMbPr6OKvG0Q3XtyvT1yrrPM9HYt1KQJ5JLy2Kp2abmpk4GGhN
         aO6s8Saaj/uqd8DlRlljlhm5NiY+0UWx9bd9mbsGal5IL7gsIPUMn7KoYmYxWVcBmPGa
         Ej4EABM1HaGI2ABckWMJqaWLBREQIccJ84QW4jC8cYUpHL4fRcgB8rvwhXKBYcQGc0gL
         6NCYiouDZEyTvBoc8OUp/koQ5DkCF+XnI5DjdB64lEOhogyuAnlfxuxUGDeNU+0D4jDd
         yGnwNIbtqDcWWdYpnlnPel6EPrLridC0c+yAcYyMkK70haTCSL8Jfac2aAKmKPRl4vmZ
         9dFg==
X-Gm-Message-State: AOJu0YwsIIYUDrfIRom49dxi9TGSRiO29VyF9e7j8OTw+bw5gWqaQtvR
	aeYaCwAPi8Urd11xbroxM42+MZBV2ZYC5BjjDzMguxVVcGezySI9ApaJUct/kfrVBrKDSU/nC2E
	RXffrSjRDkTjmWFFV3XPS9CK71fLZZ/w=
X-Gm-Gg: ASbGnctBnVqK+7mwV733j2xtxCJroVi1sHhFnC+KF4JrBsNlc+wV8DGhmiIOBJuPzPE
	FIsLrQLGJTD/GiFbyXBcEKQvPQh+ufokOwCCvufOF4AtTEro9B12J/JrSaSmRhITyUPolYfL5WH
	XtIlsm9x8ju5TwzZDERUUPWqrjMimqWUcfn13WsxbdrbQbEOOQjEPrjltKIWfdaGVc8c8ErJwdL
	iVwvQIsDHNHDS2p0N4Mg4mysO2NA5crhGHXeON90yPdGsRLrMTz6g5wonRnV93HTg==
X-Google-Smtp-Source: AGHT+IG3C41QFl/KRoYzw/3ypfP1Eam4o+hUEDodZVP4JWUua+v+IZl/BMp8pQcEP0bxVfNJA6C4Zp6+6e/dxrM6gL4=
X-Received: by 2002:a17:907:1c84:b0:b3e:dbbc:4e16 with SMTP id
 a640c23a62f3a-b46e88953abmr651084966b.41.1759357762156; Wed, 01 Oct 2025
 15:29:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1964.v3.git.1758649472.gitgitgadget@gmail.com>
 <pull.1964.v4.git.1759262314.gitgitgadget@gmail.com> <9435f0ce8db946b6b3462ef9923503ed359b3379.1759262314.git.gitgitgadget@gmail.com>
In-Reply-To: <9435f0ce8db946b6b3462ef9923503ed359b3379.1759262314.git.gitgitgadget@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Wed, 1 Oct 2025 18:29:11 -0400
X-Gm-Features: AS18NWASvmBfHoH2caiRaef-0SFJAX6DL4fRGwO2fIRdWefKM1IHfrc7TGl8hx4
Message-ID: <CALnO6CALtO_5Na-TyfuVK6p9A7Ufn7bVVMcizcxv+8hWmL=Mrg@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] doc: git-push: Add explanation of `git push origin main`
To: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Julia Evans <julia@jvns.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 3:58=E2=80=AFPM Julia Evans via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Julia Evans <julia@jvns.ca>
>
> What happens if you run `git push` without any arguments is actually
> extremely complex to explain, as discussed in the previous commit.
>
> But it's very easy to explain what `git push <remote> <branch>` does, so
> start the man page by explaining what that does.
>
> The hope is that someone could just stop reading the man page here and
> never learn anything else about `git push`, and that would be fine.
>
> Signed-off-by: Julia Evans <julia@jvns.ca>
> ---
>  Documentation/git-push.adoc | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/git-push.adoc b/Documentation/git-push.adoc
> index 2848cf2e1f..c0e743d4a8 100644
> --- a/Documentation/git-push.adoc
> +++ b/Documentation/git-push.adoc
> @@ -23,6 +23,10 @@ Updates one or more branches, tags, or other reference=
s in a remote
>  repository from your local repository, and sends all necessary data
>  that isn't already on the remote.
>
> +The simplest way to push is `git push <remote> <branch>`.
> +`git push origin main` will push the local `main` branch to the `main`
> +branch on the remote named `origin`.

Perhaps "For example," to avoid starting with punctuation/commands?
I'm not sure if that kind of thing is actually confusing for readers
or not, though. If not, I'll stop recommending such changes.

--=20
D. Ben Knoble
