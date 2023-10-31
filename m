Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C69112E75
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 23:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWjd/GZP"
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7513C9
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 16:07:23 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-507f1c29f25so8585387e87.1
        for <git@vger.kernel.org>; Tue, 31 Oct 2023 16:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698793642; x=1699398442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SMMpKi6bFwAs1wm8Pp40yO6HdVXWR52McYLFwkw5zgU=;
        b=KWjd/GZPwhG2oy18e9Z+qGfKFaSV2shF8L25eCVIci7b6oRgWRQ8MCrND+p1CC2zTB
         ON5RcskS+L4OuS3uR9A8c/VmeY8C1oFu57v8LZ05jRareQ58scL1XrplfPn/m84L78wq
         98zcy1jOempYfucz7k/nFF7WPCLoY57u7fYeifBy6OGa9P+1+8cizzYcKLSZNM2hqYiz
         bene6FIprlQdj2/KFPV3nkt5i+aX17uPCFq/+oquzLN+Dm0foYN5Ur9zkFnoDprE4/PJ
         9h66hEIIbYdi48fuNUNjKr0iS+ox9G/wA366mJKe6wAF0bQ6Nf+KtD6fq9wjtpe5qsIV
         p5aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698793642; x=1699398442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SMMpKi6bFwAs1wm8Pp40yO6HdVXWR52McYLFwkw5zgU=;
        b=CI235sA+1t8WFJmQNEVS+JHdKauFKoCthCfYnUh6QNzmqjDLoO+E7Q/65boWAGwkw+
         Nm5rav9FNaXSK92newOyq7PLJ8fx5xd0fc+heDSsAxNGiWt6eNeSDPWBkyM8RcTq34hw
         7cp29FbJtkHGpszvCvaXtaB2ZqT3a7dDTvzk5kehmti0czVxrpSkeC7SN5zgZtNRLNOa
         CfiwTm04J3VVhjzktQlO4lK8KIat3SgIJDRWzMI+6A4VuxuDghlx/U8sid+XDilV0l9Z
         MjYS4HbF1jl+90Z+aX8bOdmwGutrHESRjnNmwsAosbGNqUPZ10N1XyvmG5rrZblPr0fC
         DVGg==
X-Gm-Message-State: AOJu0YwK49ElFLyHqqHODvumty3XdxcJ21ZHBwxmBwfkf513thO64a32
	e5O2Pid8T8u/A/oQPrX+zMYOm/JCK3iKTZbY+Pw=
X-Google-Smtp-Source: AGHT+IGTWPyu8XstD7aw2h//YIes/jHzL0y2aElvS/B1LKBqpY4xkN3TiWYgVL0Mm27i3ilZJvxyo/gN4xaOhmnvmOA=
X-Received: by 2002:ac2:5185:0:b0:503:7dd:7ebd with SMTP id
 u5-20020ac25185000000b0050307dd7ebdmr8990977lfi.24.1698793641734; Tue, 31 Oct
 2023 16:07:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOh4nmk2KZBTuW9qn_ZgDY3yLRZ6NgGOWuBMLRRm1sU=pdmRoQ@mail.gmail.com>
 <CAOh4nmm9fTm8fa=1Hyi8t3R-VMnf30-0xe0vcst57dvY-FrL+w@mail.gmail.com> <20231031190959.GA875658@coredump.intra.peff.net>
In-Reply-To: <20231031190959.GA875658@coredump.intra.peff.net>
From: Jeremy Hetzler <jeremyhetzler@gmail.com>
Date: Tue, 31 Oct 2023 19:06:53 -0400
Message-ID: <CAOh4nmmxjS177FhdvaEfqkomxe3Q51AbDQrn0RGz+7GXiqaMFA@mail.gmail.com>
Subject: Re: [bug] 2.39.0: error in help for ls-remote
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2023 at 3:10=E2=80=AFPM Jeff King <peff@peff.net> wrote:
>
> It does work as documented with an argument, like:
>
>   git ls-remote -h <remote>
>
> Yes, this is somewhat weird, but is a balance between consistency and
> backwards compatibility. See:
>
>   https://lore.kernel.org/git/YU4QxcORBBR01iV8@coredump.intra.peff.net/
>
> as a starting point for past discussions.
>
> The manpage (or "--help") describes the behavior correctly; it may be
> that the "-h" output could do so as well, but it's sometimes hard to
> communicate such subtleties in such a terse format. So there may be room
> for a patch to make things more clear there, but I think it may be
> difficult to do well.
>
> -Peff

I see.

I would still find it clearer if there were a fuller explanation in
the "-h" output, but it's not a big deal. At least I'm not the only
one who's been confused :)

Thanks,
Jeremy
