Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC93614E2DA
	for <git@vger.kernel.org>; Fri, 12 Apr 2024 18:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712947562; cv=none; b=k3+FTq8rzxtaMaJBu+KTmwosDtO47TsS8taPRSgYm8hDM15HIJ6VA/FLIHaKJS2piOumk3wKndqGeMpEAykVUhxou0sYxTs2Z8ZY3C4ZMz+4vS0z6ykGmffkz5vCwG3C5QaKHHWdsx6tjtS2aeBrwS8Sux2ieQ31y62IuJn3mzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712947562; c=relaxed/simple;
	bh=2acZI5wtWryks+gqsUANtqfzLg1MHjjzyDHgz8+D5PA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iWfhUczOx4KZXAYKO7R7zpCLXVgL+FrTM+wA7ADrgKjQyGC5RpbMRc/mUY4xIm94S7yA3yN+ZvqGn/71Ghti1YuLpqcJl5os3fOW68JP4SSpFQyh6sadowezXumPNH9xADlesI0xigmH6MBRpoCF/OPweibUIA/p5iWbaKGS4fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-69b0f08a877so5532226d6.0
        for <git@vger.kernel.org>; Fri, 12 Apr 2024 11:46:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712947560; x=1713552360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cr8ZlnpQ53HvYCok8msXTpgSizkSDED6okYnUaj8YEM=;
        b=cjhLEu0k/cma/J5NlHrwLbAunne3oQGdmWCaN6BdwokjTCNme6MkaAZIbbLW4DIMS/
         M59Tq8npsqQmI8ExFtTC9eNDOR3V9qNOns1HqmLSw+xOBUFqVvgEPnfyQ8pCgNlh+s9R
         waaEBzalIfl/1TkR9LF1vmlYRpyqL/FME++W7yRpYz2/4Sdztd05OZtwOqO4HlvTe0pz
         OqK8CZBBW5W/vf9LVEAEr8oMbATqJOKvgrP+3Zd+S3lIcdKMDM0f3VlF/tSUtnPqYMT5
         8r6zPFOiWSmfJV2IgP4ME8F8AGjV7vD5ymT1xQyZHtRPhUwIJFEZJZp0lOYatYDXJ7w4
         8upg==
X-Forwarded-Encrypted: i=1; AJvYcCVZVCn9+FcdMQ3MSXB6MvRdAR5uAYmGQXoOnq9z7CWh91nukcuMYLegiXegxtryeLQr41maLSaob35mQ9Wr5PzKf+4+
X-Gm-Message-State: AOJu0YyvpYRh9ue4FDTVQnJu8ZfC6PG3NH4sGXvjs3XqbOsEetdXTkMP
	DsDOMhXisRKWgCttF5cw1r87Jz8SEkTkhNU2MmAL5b1p+DHGqZSVwSHKonBnXO+Rj+l/+ROVd1U
	PfTdCGZNNd9+T34cnbkwHCykNQQ0=
X-Google-Smtp-Source: AGHT+IHVCJYvqQ0t/ixyz7vpzazw8rjfO9uNkYrxrYzi1vn45JLgA5wfvq1FwP9YRSebsMHBRkLa6OxHPTAb+y0xbjU=
X-Received: by 2002:a0c:ea92:0:b0:69b:1943:9a6 with SMTP id
 d18-20020a0cea92000000b0069b194309a6mr3686502qvp.23.1712947559752; Fri, 12
 Apr 2024 11:45:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1704.v3.git.1712699815.gitgitgadget@gmail.com>
 <pull.1704.v4.git.1712878339.gitgitgadget@gmail.com> <c43de19d867cb5e63fe6689b2b7d645dc4741950.1712878339.git.gitgitgadget@gmail.com>
 <xmqqsezqmrtd.fsf@gitster.g>
In-Reply-To: <xmqqsezqmrtd.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 12 Apr 2024 14:45:48 -0400
Message-ID: <CAPig+cT4Jc-wvpZxoe_ZLBZ01-C7LTnbe968_33hwaEGeN+vtQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/8] SubmittingPatches: clarify 'git-contacts' location
To: Junio C Hamano <gitster@pobox.com>
Cc: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Jonathan Tan <jonathantanmy@google.com>, 
	Emily Shaffer <nasamuffin@google.com>, Patrick Steinhardt <ps@pks.im>, Matthieu Moy <git@matthieu-moy.fr>, 
	Kipras Melnikovas <kipras@kipras.org>, Linus Arver <linusa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 1:09=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > Use a dash ("git-contacts", not "git contacts") because the script
> > is not a core builtin command that is compiled into the `git` binary.
>
> Pedantic, but "git mergetool" is how it is spelled even though it is
> not a core builtin command and is not compiled into the binary.  The
> reason why "git-contacts" is better is because we do not install it
> to be usable by user's "git".
>
>     ... because the script is not installed as part of "git"
>     toolset.
>
> An obvious alternative of course is to promote "contacts" out of
> "contrib/" and install it as part of the standard toolset.  I gave a
> brief scan of the script and did not find anything (other than "only
> the recent 5 years worth of history matters") that is too specific
> to our project and I suspect it should do a reasonable job when run
> in any repository/working tree of a git-managed project.
>
> But it is outside the scope of this series.  I'd still welcome the
> thought to do that after the dust settles, though.

An alternative would be to deprecate and/or remove `git-contacts` from
"contrib" and instead point people at Felipe's `git-related`[1], which
is the direct parent[2] of `git-contacts`, as well as a more
functional drop-in replacement for `git-contacts`.

[1]: https://github.com/felipec/git-related
[2]: https://lore.kernel.org/git/1372590512-21341-1-git-send-email-sunshine=
@sunshineco.com/
