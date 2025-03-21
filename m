Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C158380C02
	for <git@vger.kernel.org>; Fri, 21 Mar 2025 14:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742567585; cv=none; b=iTpPCl1t8ipDGTa3hLoi9sMuH51lEMtJx42LgJARsSYEpEXTYVVlFXXGs/WES1G8L5GeqAjH+CJDkkDsWceylJun/zcBpu5zIzJ3NBAr87Rl1hiWjsFSB+o2ex1dQ98KVQNVZNR3fCT8KS++6Y28280s5T8qYECsWm53axpYFtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742567585; c=relaxed/simple;
	bh=rcPUQl9lP+Rg0a2YDUfaCQ28rcMZxjP/4XTmU8ZwpfI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZVFb2zZ1vMQar4s8oq81gii1CTvxhTk48cRGjYtCvgW2QB1pthiEPkeneejFMYxHyqmwXnPQzcOmfnxCAlc1b005j8lYMLOV24sD09iAh7yNEvUzHfRQhsd+IdY+kN1BqCoj4ctdE7uijkfQi09FX2gJJtkhw1edeKvi3ZbNIGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CfeDREAW; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CfeDREAW"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-476a304a8edso18519711cf.3
        for <git@vger.kernel.org>; Fri, 21 Mar 2025 07:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742567582; x=1743172382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8qNv4FM6W8CZZpPqTVibi8HULd8Qtp4wmKff7iNNr0Q=;
        b=CfeDREAWusyKRJExKveMz2qy7kF+TUJpbpcWubC9IzdTvkmFM91LmMMp//hb4dIEbA
         iUN9BqPxt2+VJ+y3Ru6+cQIt/SXjCXLH939yLHuJAYpy9iBOArI/+j/OzpGwepOBdCZv
         I7rpplwdvl44FDCjQHN3quDXlLC7qzBEDjIkQkkdW5GQyf3xZdAGGdfI4/LlhjWgfVHC
         jg+rHwvOYuqpinwr0Uzb/YJ7K8F3+98yisu4eax1ZZNkHpwODftfRxbHAGIXjHu2r3Fb
         cK0RfrXXNK6dMHk2yd5RH4XHQawW3DfMLW15z6PkHzgZk7g3Z3kZ0bUowI3ORm7z8ftO
         9gWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742567582; x=1743172382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8qNv4FM6W8CZZpPqTVibi8HULd8Qtp4wmKff7iNNr0Q=;
        b=kHfoxggqGLaUri8O+BJj5dOYLLpl4vfRMMb+tCxVPjsERJLHKrhOLXXE05SJBbQoDI
         eax61b2Fj0TXUziQtFvaC62iqFU/Z2K1xMOZfPjkL4oTIw9Mb10PxpMWL+8+uMdhCNhy
         9jPQIqpfIB0VjzGBKcJGG1EVsqFWn5MK2A0slNd1lDF291/E5wQ+0wdlAiSl/IFVW5eI
         G0FzbPpH3Axh/TPqFkSkJa0zJg+FS8+LM1ZdaKSrKXxoJ0U9Z+31PotUq9IMR+iP6Yu7
         4Ss1t/StUUYkLSfTzqCor77S6oRXb//BRMxSQoe0yHw60al8aOYZ80R1TA/V6b79mo7e
         TxFA==
X-Gm-Message-State: AOJu0YyvoSEmU6iPW79YcC3NgsVQuG/U1oNzZPDrSeKtpiKpsRY+bcTX
	RmvoF0d5WhCVRSYFr5xNPfinXf/h3WBsIXtWkl/w2cb9LX8ys/xJSfnVtzV2y8U1KKEML2TMs0I
	fVa3/1q0GsriLcC9Y+IfZ1u9fNSs=
X-Gm-Gg: ASbGncuO3u7I+Y7HsKktxyKqZUauSqXKKdVf1LuBvxYs7pXRj5YZ5L3P5QcEPZdA2qJ
	NZY3VhC3nE1q1Y9HZhZ8kawzlUR9wYvBWHIUfo/NG+k4MUvwsbMLZxLNFAIWV+qjyoC3faNoVhd
	7Kl2oJ9IFpy9ZEQeGwSyccuNLvAvGpSfBhHsB0b8ml92vk8DBjb/UJT48SemE=
X-Google-Smtp-Source: AGHT+IG7grZiIRKyLewy/B/hnI5eF6U3qb70De5GVvghe6vq/eJrLjw7m3cfXxBXw4jnFmMOK1nmd5S7edhWVVBPKa8=
X-Received: by 2002:a05:622a:5c08:b0:476:9295:d4a3 with SMTP id
 d75a77b69052e-4771de11607mr46685491cf.35.1742567582409; Fri, 21 Mar 2025
 07:33:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqa59j8gml.fsf@gitster.g> <20250319170244.32912-1-jayatheerthkulkarni2005@gmail.com>
 <xmqqa59evffd.fsf@gitster.g>
In-Reply-To: <xmqqa59evffd.fsf@gitster.g>
From: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Date: Fri, 21 Mar 2025 20:02:50 +0530
X-Gm-Features: AQ5f1JpRv3Eh2VdfvF1dGORimHxp8bjII7ru3i88E-p2sekZlfzQh8AeYyViJiM
Message-ID: <CA+rGoLeYJEbpC6=mUPuOr=i6pE9w20OeJSOzG0SQPVpBWDbTgQ@mail.gmail.com>
Subject: Re: [GSOC][PATCH v2] Remove outdated mentoring mailing list reference
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ben.knoble@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 4:06=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:
>
> > Subject: Re: [GSOC][PATCH v2] Remove outdated mentoring mailing list re=
ference
>
> [Documentation/SubmittingPatches]
>
>     The first line of the commit message should be a short description (5=
0
>     characters is the soft limit, see DISCUSSION in linkgit:git-commit[1]=
),
>     and should skip the full stop.  It is also conventional in most cases=
 to
>     prefix the first line with "area: " where the area is a filename or
>     identifier for the general area of the code being modified, e.g.
>

Went through the discussion

>     * doc: clarify distinction between sign-off and pgp-signing
>     * githooks.txt: improve the intro section
>
>     If in doubt which identifier to use, run `git log --no-merges` on the
>     files you are modifying to see the current conventions.
>
> > and clarify tutorial prerequisites
>
> Do not do this.  What you have on the e-mail "Subject:" line is the
> first paragraph (whose definition is block of text delineated by
> blank lines) of the commit log message, and the first paratraph in
> the body of a patch e-mail is the second paragraph.  You do not
> start your second paragraph at half-sentence, as if it were a
> continuation of an incomplete previous sentence.
>
Thank you for the feedback, I will make sure not to repeat them in the
further patches

-Jay
