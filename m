Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46CD29993F
	for <git@vger.kernel.org>; Mon, 13 Oct 2025 16:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760374430; cv=none; b=hwJXGaCf6+DwXPdffYc9mFPq1HcqCjjoLF2KABeQ5txj63UvCprUU/h0o0Ftfn11ByYYvL3gIMuMZetewBw55vgt+3simNL5MuauAtUZ/uVEpY3szvu08PvESKE6Wr8Wv903ycJYiExsWvxY0fCsHdc6Z3HHDjkCpidroOcTMmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760374430; c=relaxed/simple;
	bh=WfIB3deuj7CN1hS81MUf+42W1FbFcKVS2bBLq4L95SM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ENmmDWRRbijtw5ouXKfxBZ1J9E8cbCWUWSsOxM+gd8FQCy10OS6bkG2EAKniOCrKzHeIo84oM18NTMj1f9nCZd/6bgEx9MRKW5Er+H4jrzkikxG4TzeDszRSJQpHY3qdmySQqCLwR6JGffaDRTxP6Gce4pYJeE6eBU5aFgNHRCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8501ba779a9so2674206d6.2
        for <git@vger.kernel.org>; Mon, 13 Oct 2025 09:53:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760374427; x=1760979227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pW8zfBI3SfT26AglGj4TYui4NvQWbnPNZAOsJG3dbEA=;
        b=T/wJCmtaPl+kORVXAteQEfclYtYu5eyJBHlEJzPlW3qIyZF2OYWA4ojbutM+xROV/Y
         SElE4sroW7OAxTdVLIzwl6nCZy6fP5vQdPPiPV6+Dt0jhfOo4Q3dEEqueha4OZo5/f7T
         pKXNm30+ss3mN9vK3no7sd4varCo1djTtrzUeZ6mRuZyE3rGOjA0z70GjBqTmX1STc2t
         RS8MCSUvpEk9bUy7AzB0ipRNYxyKfR89r+YzBks2H7yCb880Mu6SlDoq1jVNa4f7kbQn
         3/FSTbVyET0vqUsfyAhRAhLUrrQIV6APhYnL6XIOXUldEIL36KaYXgs1xyHk7VhbpmOQ
         7juQ==
X-Gm-Message-State: AOJu0YzKLBzubO9mG+bIVHH1AHO4FQhTjvE9RzUlW40ZpuNYjdVBFzX1
	xK2ZDiX2LoROJHMQxkrPg+7j/ANisxacue9a138um2i/EQiF0wZBbSU44ZNhBrTZvVufOnjbH8K
	FoqRIGYP5SITLqvUUHxJeh+x4u9YiBus=
X-Gm-Gg: ASbGncuKVnHLKITqXtt5JMcypKFBN5EjtjUmPVYvPOkokhJArHwcYVcyMDQSxayl4wb
	doOXqWLRUg0c9/YHviOQ/CX4erdGSMyPRZUyBQ8x5AKveITAVv84VSSp1Hyw939bg6PKa8gjikN
	iHA5dHF+S7EaaizT8rT6sccQPEb6H3vJCJlYQsP3AlxXsia4AXskGl/HDKOOMaSxScwnQx8HHJL
	Y5PndMlmjm+JwC33nVF0YVROFrhWovyvuklqpJQAvi1W6Ci/12cIwgZr6xFNWmQNx95
X-Google-Smtp-Source: AGHT+IFMHDaiUajqJNNmLaroWs06eqs/epBn0Qs1xvp3lRridIC0kE0LQPn/MxPHXuzmImAcxw/JNR+tj6RkeS04MaY=
X-Received: by 2002:a05:6214:4102:b0:773:84c1:396 with SMTP id
 6a1803df08f44-87b20ff9b56mr208781226d6.1.1760374427422; Mon, 13 Oct 2025
 09:53:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <978261e3be4.1760043036.git.code@khaugsbakk.name> <v2-38645ea253c.1760369708.git.code@khaugsbakk.name>
In-Reply-To: <v2-38645ea253c.1760369708.git.code@khaugsbakk.name>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 13 Oct 2025 12:53:36 -0400
X-Gm-Features: AS18NWA_XxH0Aca4TnxVl8uKeW6tY-cpjTp_WFUjFeeb3O1A1zg0IekAg7fw1X0
Message-ID: <CAPig+cSQB0HbhY2L1Y4mkbaCMiZTH72AtQ+qRg=Z0U9_ggkcug@mail.gmail.com>
Subject: Re: [PATCH v2] doc: patch-id: convert to the modern synopsis style
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>, 
	=?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>, 
	Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 12:28=E2=80=AFPM <kristofferhaugsbakk@fastmail.com>=
 wrote:
> Convert this command documentation to the modern synopsis style based on
> similar work.[1] Concretely: [...]
>
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---
> diff --git a/Documentation/git-patch-id.adoc b/Documentation/git-patch-id=
.adoc
> @@ -7,8 +7,8 @@ git-patch-id - Compute unique ID for a patch
> ---unstable::
> +`--unstable`::
>         Use an "unstable" hash as the patch ID. With this option,
>         the result produced is compatible with the patch-id value produce=
d
>         by git 1.9 and older and whitespace is ignored.  Users with pre-e=
xisting

Is the mix of "patch ID" and "patch-id" intentional? If so, should
"patch-id" be wrapped in backticks?
