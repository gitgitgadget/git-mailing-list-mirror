Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC09B1E50B
	for <git@vger.kernel.org>; Sat,  2 Mar 2024 18:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709402604; cv=none; b=pJvTx01RreT9NWh6+LTqFj3ieNoqXartIhWzChjv1B9qRPvCYntVhmny3YGCkSdFbkFQyfIoynmgPFogq5X0cmZf6o9YpA1ufpmSdlvzEzhMBznFvg3YfqnS+iP+gY9/dngSNZUtSDBZ27JVWZfTN+eMzgyjgSwI8JAH38bhPY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709402604; c=relaxed/simple;
	bh=qMVMW0ZkMR+lDXWv6IXRJXio6HbqzEvH94rZ7j3HRhI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u+tbyZ6p9mVJtk/nayt7TnJCEj57t3bfoVLp/VGULQ+oXhkBNs00VVf7SmohG8i7AfQwAQI9OaQ+oA0oeqgOmzSLTl3wMypzDoIvFDyPWSlJQgw6TXRLBviXtEbDlXabVVArgCmM/uNa+ZMgD61JtVbiMgn7hG0CVSeDKsyjzO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CxlK6//s; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxlK6//s"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3c19dd9ade5so1905488b6e.3
        for <git@vger.kernel.org>; Sat, 02 Mar 2024 10:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709402602; x=1710007402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wbkxumO+vLpypX71dCFg+fXAS6ABM77HSggG61uI6hI=;
        b=CxlK6//s1wnulI/xY8bhSd+I5+WwdsEzUdVZjBxfUQjRpZscLplKr9/SAo7SgQUUV4
         Y7S9l+BRDUP94e6dJXhI9JclJXgriN9IAbdMGOid3cfeDE7kbVmTq8Q2duyX8dkjunul
         cQCMEFWYEvJ8SYzaUv67wE4F0q2o1dY7qaRzEz4UgsS9q+qUP5Cg8Wa9kovWsjv871ZF
         7O9GlP2MOK1jBMqMC7OnP3gGWmRID589Y783pFypKD4qA3qt9vR8ydMcVL9sdSXtoDu0
         +Nrah03LJPiZSvmZywrqViYXK6ekuPnk+x5+ir6pTdjsgC7/B9G8El2mMv93f9nPyxaM
         ynEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709402602; x=1710007402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wbkxumO+vLpypX71dCFg+fXAS6ABM77HSggG61uI6hI=;
        b=LWRUABjQ+J4TfA6Q+SpmXkAsomG7IIusFHY3JVHdCjfpg5QvSgmfm5T75NCY7JYdFU
         jqVfokxyeIKi7gbtyNz2s5Fr1dhVm+BVTItZ2g/n5q7H43TnmpjseuW2AZyQXwucxayS
         3F9JnC01LFdiTCSDuliaQvims/5mfhqqcaZqwXfaw8oJI217bU2RhyiREgse1Xlj2gSx
         l9pGWhZmY7OPfI9OrgtNmLuATWRuZOZNf/Gkv4m23OtbbOtxMocg0LeW6kF7fg7ak5SL
         /zVO5zItbHq1cGysos8V/xNSsVDM6V2ZFF2pE/0No3DwVwRHFaeKK5h7lXhwARsIOfR2
         t7nA==
X-Forwarded-Encrypted: i=1; AJvYcCVY0Jh6IQYO4lWQgb+22DezKKa+J31dg51JVbbTUqO8L3yYXFuTrgivb3q+n6VquQ3mCj5dwqTQk5526Sd0F2NqhBTm
X-Gm-Message-State: AOJu0YyepWE27FWeuyB9igFvfoQuZ95rdkOf+6ep2yJeVnkaKB0p1Hpd
	0cR9exW4wFwOj97yjgH8Rhc9ITaZsxjEb6sX7LdpjXvRzKvnpaNyd1INNLdNBjoPK6Ky9OLOzvZ
	7/BRQeoR0K35dGQ+1040oQO5xnW+1cbsY1ks=
X-Google-Smtp-Source: AGHT+IHBDFV0LeR4ndrbLO95VaYG01f0SoYKASsRwMEXAcxdQIC1kOfwW+sxzWefveBKzY75ExJIXH5fIa3ey1KpH7U=
X-Received: by 2002:a05:6871:492:b0:21f:9f09:b0de with SMTP id
 f18-20020a056871049200b0021f9f09b0demr5401388oaj.41.1709402601780; Sat, 02
 Mar 2024 10:03:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a7be415d-5005-4fa7-9b2e-1974b7439a81@schinagl.nl>
 <20240302095751.123138-1-karthik.188@gmail.com> <20240302095751.123138-3-karthik.188@gmail.com>
 <CAPig+cRXtk0f=gMSkRka8mCFfT2=PKSBXMQGGhA3J_t=O_rpAA@mail.gmail.com>
In-Reply-To: <CAPig+cRXtk0f=gMSkRka8mCFfT2=PKSBXMQGGhA3J_t=O_rpAA@mail.gmail.com>
From: Karthik Nayak <karthik.188@gmail.com>
Date: Sat, 2 Mar 2024 19:02:55 +0100
Message-ID: <CAOLa=ZRsCaqT34JsAzaDrqF+gVQ1ZsLRQb3AbyU=qPgYAGO3WQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] diff: add 'diff.wordDiff' config option
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: oliver@schinagl.nl, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 2, 2024 at 11:25=E2=80=AFAM Eric Sunshine <sunshine@sunshineco.=
com> wrote:
>
> On Sat, Mar 2, 2024 at 4:58=E2=80=AFAM Karthik Nayak <karthik.188@gmail.c=
om> wrote:
> > The git-diff(1) command supports the `--word-diff` which allows the
> > users to specify how to delimit word diffs. Provide this option also as
> > a config param 'diff.wordDiff'.
> >
> > Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> > ---
> > diff --git a/diff.c b/diff.c
> > @@ -209,6 +210,23 @@ int git_config_rename(const char *var, const char =
*value)
> > +static int parse_word_diff_value(const char *value)
> > +{
> > +       if (!value)
> > +               return -1;
> > +       else if (!strcmp(value, "plain"))
> > +               return DIFF_WORDS_PLAIN;
> > +       else if (!strcmp(value, "color")) {
> > +               return DIFF_WORDS_COLOR;
> > +       }
> > +       else if (!strcmp(value, "porcelain"))
> > +               return DIFF_WORDS_PORCELAIN;
> > +       else if (!strcmp(value, "none"))
> > +               return DIFF_WORDS_NONE;
> > +
> > +       return -1;
> > +}
>
> Why is one arm surrounded by curly braces when none of the others are?

Seems like I missed that one, if the patch series is being taken
forward, I will fix
it. Thanks
