Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E54A29
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 05:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728193867; cv=none; b=MRorYIAuQCbbnrF0j28kBFBWTu4v1+CJ5vG7YZdheDbXF+37dKkqoPcI9elFHEodDDgO6YMQ0DXnG8kywBWoJog5LEzpSaXluVr1FtyOskq6jfdGkNjlAf8OmjvEZRyzfEbSVWlEWTDw34gLy/GzlAWHVyN5eW2t939XDGLbo54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728193867; c=relaxed/simple;
	bh=grEIeMQ4BnqqPuerHJ4i6qpnfu5MRL1RwhWflXw02f4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nBS9lGyyI39ez9osgvDeE1uGNeCzde+uVx/LTgPRK/ryTZpwsS4Lo9dB16X/KmgFFuPXgneDUTTjba6+RwwyjuFUTbcQ/8kkh8c1pLkAyWKkzW3hn6HAwhlFJ7arUVScKJxKUK2wuVUDfb5hzeiD9Sv3LuKlRKTbixrBmB8iLvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6cb316db199so4957306d6.2
        for <git@vger.kernel.org>; Sat, 05 Oct 2024 22:51:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728193865; x=1728798665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bWrJXJNDI4YUkwvKrbwC6VBWEzOsWIcTxmWY4Go5dpw=;
        b=xDlj9COJJpposWjcviwvQVyVrftIfaLV4m8CRCQ67U5wBgEeWed5YZBwe2f49/3TlX
         lV3poXeMzfe4Tg5lmR9KlrSqCQNbz6UXEnDPkjV4PtOMePk39pOMyzAGuMFlT0Mt+vjU
         PakunToLw8GR2jGbLsJ0DzxKp/IWJutlmOmlrttmGidl77DQMqdxjtyMc7I5BZjztIYz
         1oQwpfl1TfUUXmNeWcDnlTI1CRTEP8oqS0elawXqlQZ4SNiO5FBjeLy5uMqM9tAhW+Ns
         8y1pyVzmxhInn+Ji6g6yf3Id65iGRe7YPz6HZzm0dfCuhQwadEPPk2esLZ1ueFeLr3+E
         rKXg==
X-Gm-Message-State: AOJu0YwaYXsCYFkVbCn4fMl7daIcfdN5uPoBf+Bi996FZclSgMn3oiI3
	1V441qmXw3u7TNnS3ysvc1mOkR83V614V5oTsTGG2WHSRr8WRsZBFwBLWYnbil0IclSq34PDChV
	fjreuDjKXfLdtdboluk+QVHuVtew=
X-Google-Smtp-Source: AGHT+IEc1Zd4oRBTNxgha3fFJmuacvmg1ZjczxMlLMqf30bBAomj3QCG9JuPt+AA7BvkP3OL3oa+jznWbMqfjoVvmmA=
X-Received: by 2002:a05:6214:242f:b0:6cb:3dde:fde2 with SMTP id
 6a1803df08f44-6cb9a2f5a2amr56922326d6.1.1728193865250; Sat, 05 Oct 2024
 22:51:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241006045847.159937-1-cdwhite3@pm.me> <CAPig+cTB-sA-g4cdhfEjWwY1mnbWJ41e=bOCNwp=Y8JKvpmpRg@mail.gmail.com>
 <zKUnWY8u1SJNeS4oLK85znjacgYJJeN8HefenwaJ9B9Q1YrQAumpAxWos4svaawkTfQZ_HaS3yp6WrOQQI7yt3ZO0UMCfkM0lJDDnMD-Lno=@pm.me>
 <CAPig+cT6LALKjEappB7QkB7oc88NyMcr40T_qJGL2mPA77K7XQ@mail.gmail.com>
 <CAPig+cT7CEnb6cQmAOMbD82wxkg=7T0MMW=QNUSPU62a0rEGLA@mail.gmail.com>
 <TEfKiit-RYyr0ZuiQszaKaM64iSonfaQwWRqExOgXyPR1tVWyAzR3kVKmCd3aREZwDGuS5VXcHjCvneY-gCg2OuZyv2N2EkfARlZu4AVSsU=@pm.me>
 <CAPig+cTE0gaD=7dwSqY4S+7AqRoU9yOrS4sdBoybj0Pfyk9vxA@mail.gmail.com> <K1lpl_AWj4xpiHLG9AloFDP7hkJ7Ysf-LA5H-OeP6suaBcES3WS6NTYZGX96oQuNQ3x36eEOxGdqlj3fG3ybrn5y3LRPfCNqC7yqTyvqVrk=@pm.me>
In-Reply-To: <K1lpl_AWj4xpiHLG9AloFDP7hkJ7Ysf-LA5H-OeP6suaBcES3WS6NTYZGX96oQuNQ3x36eEOxGdqlj3fG3ybrn5y3LRPfCNqC7yqTyvqVrk=@pm.me>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 6 Oct 2024 01:50:54 -0400
Message-ID: <CAPig+cQE0RNLhktuja-BbF8WwZmKC3cox_GUC-o4w87PadDpgw@mail.gmail.com>
Subject: Re: [PATCH 0/4] Link worktrees with relative paths
To: Caleb White <cdwhite3@pm.me>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 6, 2024 at 1:41=E2=80=AFAM Caleb White <cdwhite3@pm.me> wrote:
> On Sunday, October 6th, 2024 at 00:32, Eric Sunshine <sunshine@sunshineco=
.com> wrote:
> > It's broken in the Git mailing list archive, as well. If you search
> > for "mbox.gz" at [], you can download this email thread. The patches
> > in that mbox file have the same damage as I'm seeing.
>
> That's interesting...what's the best way to try and resubmit? As
> a new thread or as a v2?

For continuity in the archive, probably best to submit it as v2 as a
reply to the original cover letter:

    git send-email -v2 --reply-to=3D'20241006045847.159937-1-cdwhite3@pm.me=
' ...
