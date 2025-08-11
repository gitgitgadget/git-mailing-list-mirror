Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA86E1E515
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 22:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754952412; cv=none; b=n5FG4lscQHRpXXKJ1iWdOs8mxSxB/IB89kkDlDrNO4XlLXW5kyfdondb1OV5MkgDh1bo73cW/MpcsEJ1f5q0gfavzwS4VZ/5xU5GV33mv6a/oZvgTNz16zW7bWwF0Qpc7JrThrtsssKAmEwO+X1s/brnoYVRcmtJ89mzdZ22tes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754952412; c=relaxed/simple;
	bh=ePcea6RBgbBHIb2YIRVCOLweFMwXYYVYMZTmussMYWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R76KufB6mXt+0nh7Dx8eVcrzfw/1FwuK8x3mxbmGnfOX2tls+yUZLuiRIGUxx0KVxWJZ0z9ZcpLRJcxaExNQCZ9rzFqEvXpKH51elnJzg9MVKE36qxCAapOb6wHb7l/+ubLVmqBW7oTQnPr0/q4Vlf/utKFiLAKLUxmDebz5qdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-707564a46caso2397856d6.2
        for <git@vger.kernel.org>; Mon, 11 Aug 2025 15:46:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754952410; x=1755557210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rDhq/tau5CHLKJuAZNlXSPOXmD+TUzyhspfKLMmqeDM=;
        b=bGuWSePeT2Kf6PFOe48BwYA4zGgWeTBqXMhdJSHbDaDS6Hl297dRC3mstswBgkzBdB
         8Uq/zY+xTI5FIKpt/VqLaMSI88aqhaa9IwiH/WeTNx5xSzfL6JyMM4N2Qwuha9PeeQNy
         3+cRkDY9s/BdkBrl60g3nOoO9vTQei1qWlRU2rnA0jhZ8RFD7HXbc5AmrUai5vqkQbHC
         lZH+4YydsY3ywDk1iOIR88BWlNDXl0BVYoPcKBHcKXDE8y7yjZ2czscT7GWMJhf0YhRE
         ro0wWz5yYTlOKAxw7NP5xSHDyb2wWplCUihkteb4bAPkTDzzosDlqmqLplsLnZj5JMXf
         Vhhw==
X-Gm-Message-State: AOJu0YyqIgEuXDJnFzoreQO/abJieByGatqq90I+RBTjxV0zH5805Bf8
	dsakujfllxLuYSDkNycF4WuSBMcrmB3di4bzHNqew7P7PUT4sbOHUyDEvi8bYBg/qCz+cuocMsy
	UafwzPs0KCqMLTp5ofpW7X2OzZBUj0iU=
X-Gm-Gg: ASbGncs24NJ/tq53WMMvMyHm76p6bxXNsEeGjFK+7k+AcvZWeKei7oA3gJ25duJEBQ3
	MQLr8+fGrcENh1cgDQQ76IPa/Sgtd/bFbrUl7zAt9PCtU+eDvGZzkLUblzJbzm7eut2u60PG70j
	yJSMrvbAoCkCFUDAai9k3Dx+JFt7k3pabBf8LvR1y1rus4qyrDQVWtv6nwpul6FxY6F5mwiNMbW
	m3fPTqFGs1JLeJU2E5gkvj6LPNe9DWPMTHjRrqv
X-Google-Smtp-Source: AGHT+IFo1VjqSPzX7vr9UGsO4JC/j+eGFvJuqA5lpgXq32MEFdwO66zfAWl+Fuexy6kyhm4oQ8kaDSqwuNAMERlwWWM=
X-Received: by 2002:ad4:5f45:0:b0:709:8dee:52bb with SMTP id
 6a1803df08f44-709ac2fda81mr66322146d6.7.1754952409788; Mon, 11 Aug 2025
 15:46:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250810160323.49372-1-ben.knoble+github@gmail.com> <20250811221706.67168-5-ben.knoble+github@gmail.com>
In-Reply-To: <20250811221706.67168-5-ben.knoble+github@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 11 Aug 2025 18:46:38 -0400
X-Gm-Features: Ac12FXyIhnquf_EfmVGvai6E1jmHQsFG8HSCCE9Lp3KXylhy8UtRJiHwqXvKBFQ
Message-ID: <CAPig+cTXuTaMd1+sbSSDNbGKxxciyxAT3LMk44aSaimPco8XTQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] editor: use standard strvec API to receive
 environment for external editors
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, 
	Phillip Wood <phillip.wood123@gmail.com>, 
	Johannes Schindelin <johannes.schindelin@gmx.de>, Elijah Newren <newren@gmail.com>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 6:17=E2=80=AFPM D. Ben Knoble
<ben.knoble+github@gmail.com> wrote:
> Going back to the introduction of the env parameter for the editor in
> 8babab95af (builtin-commit.c: export GIT_INDEX_FILE for launch_editor as
> well., 2007-11-26), we pass a constant array of strings: as the
> surrounding APIs evolved to use strvecs (see 8d7aa4ba6a
> (builtin/commit.c: remove the PATH_MAX limitation via dynamic
> allocation, 2017-01-13) and later 46b225f153 (Merge branch 'jk/strvec',
> 2020-08-10)), the editor code did not.
>
> There is only one caller of all 3 editor APIs that does not pass a NULL
> environment (the same caller for which this parameter was added), and
> it already has a strvec available to use.

I'm confused as to *why* we want to make this change, and the commit
message doesn't seem to explain the motivation or why doing so is
beneficial.

> Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
> ---
> diff --git a/editor.h b/editor.h
> @@ -3,6 +3,7 @@
>  int launch_editor(const char *path, struct strbuf *buffer,
> -                 const char *const *env);
> +                 const struct strvec *env);

Typically, we would want to have the API accept the narrowest type in
order to remain as general as possible, but this change makes it a
requirement that a caller must have the much wider `strvec` type at
hand, which seems counterproductive.
