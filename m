Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58DE1474B8
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 20:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748983586; cv=none; b=FtiCXeDdN1QlJIFVlbTPyrYMAgKdVn6HUeJDJ8I4hfTxPYiJb72WHJLGZDQ+lKT9TCPXxKdAhG8bTTF31kUVI3OpPKQAA1/XNnJoUVgGRcwaGdA69XPkkt/r0UJ4Pv3GnvhjS8wFL8JV+7WHKHvy5p70ZQfbycS5JqPBMN1aoSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748983586; c=relaxed/simple;
	bh=eQcCBxrYrejEg5Q7XYF62r/4Q+sfYe6R2QIDB/K2UpE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MrvlPr4ZbYziSdOqgiWoxfjShNXUPjc//z09w+nU3Z1WOl2rcWKOPDT6Psi8lqQuIZT2aBAE3x5s7QVb24xfb6oYS+atZZG83KWn4JbRMqVxVEu0aKbpQloeyIjbzeA1i6ZdKwtc6o94IkTCKJ75r9kj2zrxW4owPl+BJ0+BkiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7d0a61e6c0fso62684285a.0
        for <git@vger.kernel.org>; Tue, 03 Jun 2025 13:46:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748983583; x=1749588383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C2ZBFoPN9ONSvfZ4f25HZAC155mNasXWAdwqLKSjMs8=;
        b=OGU499lcm4HMNkB7rr2ZulWVptwcslxUELCTvYxbiRiP2lRn9iwFYn705VfhLMpZ7p
         +LkaKH+7SjZh9ksQMcu0FPaOgO8UnT1Yn1zqonvXWejTq3z+s5L/1MiCMif9yK3/qunO
         UYgyseP1xAwRVk8Q3bfy4hF0mONhQQkXFkp0C3zH1HTl7pxoP838U6APi4KyXeU3PjNw
         0DjYe90+HBR0XiIDomU2B0RqJio/hDaKe3daX3ES363pdQ/t1rg04STjPsVQDScfSO0I
         /d2w1kdNrUGmeMB+JxjYI/mGUNSRxmkArYnYaQ1ySP2f+R3AwLdo8e+dzSsoOQBraA9I
         pCIA==
X-Forwarded-Encrypted: i=1; AJvYcCVnuQp4paMvHpBAtO+vpBd8gvdsKpuGQI6NIf0f3ACogrpyksPr85fd/45P5zRG8N1q/wc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVFgyMPuUIHo5cReOHHuttcxMkmuw9fNhpuhlB6X9Tl0MuB03g
	w5fm9UaKtPMt00QgTrkK/GXkOeJeSlwjcWmsEVQYReU5ZkG+A/XdIseBcvzDkuIXbZmpjatRAxU
	ZZ7ypg5W9wt3cJ78Sp6Ce+PhxoPZwgXs=
X-Gm-Gg: ASbGncsFqZ+ELAAPo3ChtV70HEAXS9krxm7km/Kcn/N3tNFrc8A30+K7pauy0dvG4F7
	U4q8ks7BeswNyyvPOyjjQE6TWV97bP02J4qKAOuWVYXiHe89L0urqy1pgfDLab350mt72gmjodG
	K7DPeu4Vc2nrUFSsRz8q1wMo5uujy2iaDl7Fu/ycAU24QuUHWXxkdDZ/FqYvvq4nR27A==
X-Google-Smtp-Source: AGHT+IHsKYNHEi8ag+OiEweWwQoBJjf93et1bHLnMnrAb2MDJBqvMWarnu0bf28VqoGeV5cmzkPK85N/+DkgfJzH+Ik=
X-Received: by 2002:ad4:5bae:0:b0:6fa:b9e4:f010 with SMTP id
 6a1803df08f44-6faf6fef88cmr982956d6.4.1748983583539; Tue, 03 Jun 2025
 13:46:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c59ae2c0c7c8420ec1c5bedb87f28c7f5b573a60.1748122397.git.code@khaugsbakk.name>
 <66e92d69-8372-47cf-a350-95365f72ca1c@gmail.com> <xmqq5xhmvuol.fsf@gitster.g> <CALnO6CDgcQCuhxcJLH-XwxB85mxqokxsf04CU4yseTy-=XUWLQ@mail.gmail.com>
In-Reply-To: <CALnO6CDgcQCuhxcJLH-XwxB85mxqokxsf04CU4yseTy-=XUWLQ@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 3 Jun 2025 16:46:12 -0400
X-Gm-Features: AX0GCFsM9Hpz_clAIMFKEX1F2hvXNYf8aKGAiXmyXYZ8LnELbGnTbYsT15_XoFc
Message-ID: <CAPig+cRTeZosWC=b=9MOjKaUwPodp7P=X2pwuXVgiRorx_+jmg@mail.gmail.com>
Subject: Re: [PATCH] notes: remove trailing whitespace from editor template
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Phillip Wood <phillip.wood123@gmail.com>, 
	kristofferhaugsbakk@fastmail.com, git@vger.kernel.org, 
	Kristoffer Haugsbakk <code@khaugsbakk.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 4:37=E2=80=AFPM D. Ben Knoble <ben.knoble@gmail.com>=
 wrote:
> On Tue, May 27, 2025 at 1:31=E2=80=AFPM Junio C Hamano <gitster@pobox.com=
> wrote:
> > In this case I am not all that sympathetic to the idea of the patch.
> > The consistently indented lines makes it more clear from which line
> > to which line came from a commit log message; running stripspace
> > would break them into paragraph pieces.  These editors that complain
> > probaly can be fixed?
>
> My editor doesn't complain, but it does highlight trailing whitespace
> at my behest, and it tends to be an eyesore (on purpose: that way I
> clean it up). Perhaps Kistoffer is coming from a similar place?
>
> > Alternatively, if it bothers users of certain editing environments
> > too much, perhaps the indent code in the output phase of "git show"
> > should lose the indents for empty lines uniformly, shoudln't it?  It
> > probably should be a fairly isolated change, like the way how the
> > expand_tabs_in_log bit is handled in pretty.c; give another bit and
> > teach pp_handle_indent to return when that bit is set and the
> > payload it was asked to show with indentation is empty, or something
> > like that.
>
> I think this suggestion would also help folks who "git commit -v,"
> which IIRC is also indented in the template.

For what it's worth, there was a previous attempt at something along
these lines after which a discussion ensued.

https://lore.kernel.org/git/20210830072118.91921-4-sunshine@sunshineco.com/=
T/
