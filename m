Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9C41547E7
	for <git@vger.kernel.org>; Tue, 22 Oct 2024 07:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729583688; cv=none; b=tJSOF61HoJY+MmlOjWr5AiT0TWtT4YnNaOH1XLNRoIE4Y4SxYu4bfF1aO++fJG2r8Jd/YHXRxZLzTb4r25d2GtQq9WotBiRxkXXTAWfWkDgIJDMy8gIMlYaevrTIOfb3KizfUPFkWhxdcGoJm4SLZMTYIJLhdX3UzGRew3WAB7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729583688; c=relaxed/simple;
	bh=u02GQgvTZ4j4F44XJ3gd1frl0HTfd1o+O4szlI34HjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oJ8DBBBp8V+sf97E+p9nRRs/H6lnxODb93txGU3vRQMiN0jhGfQwkk8KzP0Ee4p0+iysRrYk0XY48/O3cgmisfGe69zstIuXWc+PQh/A1NtnNhG+uROvJWUu0QlwhAp/vYvvHrAKTO/3Ou5HgSUczTmN7NEDSEqHTUik6wiHK7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6cbc46f8b3bso6765246d6.0
        for <git@vger.kernel.org>; Tue, 22 Oct 2024 00:54:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729583685; x=1730188485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u02GQgvTZ4j4F44XJ3gd1frl0HTfd1o+O4szlI34HjA=;
        b=eyVsBkOdmg2eJ3u4rNF6lazYIhjYmoBbjkHZnPtrvpfqOFTRWUc0qVG4E4SNHFVD1Q
         PsL++C8m3lan/N9C6rtsf/a2RuP6yV3kwSrl+SgpQFPm5r/gU9OcNFAfF1FlxtG/e9c1
         8JZKXCuSZlSABpIgJP8osRONToJFj6ND5VTU2UPLSYEeZB1pOr9zxiQzuTz6KXn9sU/G
         sANX43W61/lQgG2743IvMIIWg+2qTLcNgGzZgCNudlywUtsHFatBVzWptyNPNbDjEWah
         +j7cvAOZRTkZCHzNU3YIl/GWOPivVoytaI8KHmnevUJdoLMOg/2nHkRbj0Uk1DGBfzIW
         TRkw==
X-Forwarded-Encrypted: i=1; AJvYcCU35NU9DTh6Sf0zshdACe+gR27oGMTZ0CxmsGpKDBcahW0utgbXGMaqoTvLDiXbJgIm/SU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKwcE5VwU+GJRM9YFfrnNlaybBAXfOT6M13PFmzHqt9skkeh5m
	7Te842vORIUR23twAl6RlZVRn54Vi45DgU6xlOn2+BIEz9zdYkxUrUB7KGG6dNwVacHeQ6Md/3L
	l60Fd+JQIb2JdjVpVr4QGs7vuPqdhdclx
X-Google-Smtp-Source: AGHT+IFJ8Pw0ff2PA5tlE9QCcXZxN+XIB7CfxMfLli85moOWCPpjWx+SMir84ywnpV2XbTf8i0Uqk+6l5NEwwqZ2pK0=
X-Received: by 2002:a05:6214:1c44:b0:6cb:fabd:b12 with SMTP id
 6a1803df08f44-6cde117b005mr91968836d6.0.1729583685229; Tue, 22 Oct 2024
 00:54:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1809.git.1728370892696.gitgitgadget@gmail.com>
 <pull.1809.v2.git.1728707867.gitgitgadget@gmail.com> <4ed930cab1b7f5e9738e73c7b9374d927a8acd94.1728707867.git.gitgitgadget@gmail.com>
 <0ac9d9a1-cb91-4b1c-bba1-022ecc485684@gmail.com> <CAAirc3hkiQ95kzniP4Ws_op8nWuY4tdNrCjrPXMDShq3KX_h+g@mail.gmail.com>
 <CAAirc3gAFqa5Ox=Hp26zBXuKwE5OmHDE+j-4MnKysrgfD8u2pg@mail.gmail.com>
In-Reply-To: <CAAirc3gAFqa5Ox=Hp26zBXuKwE5OmHDE+j-4MnKysrgfD8u2pg@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 22 Oct 2024 03:54:34 -0400
Message-ID: <CAPig+cTVjUvE-P1RPHehV6uN3f+wMWmpUpiD8JNqzUQDoNuHhA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] blame: respect .git-blame-ignore-revs automatically
To: Abhijeetsingh Meena <abhijeetsingh.github@gmail.com>
Cc: phillip.wood@dunelm.org.uk, Kristoffer Haugsbakk <code@khaugsbakk.name>, 
	"me@ttaylorr.com" <me@ttaylorr.com>, Abhijeetsingh Meena <abhijeet040403@gmail.com>, git@vger.kernel.org, 
	Abhijeetsingh Meena via GitGitGadget <gitgitgadget@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 2:49=E2=80=AFAM Abhijeetsingh Meena
<abhijeetsingh.github@gmail.com> wrote:
> Hi Eric, Kristoffer, and Phillip,
>
> A few days ago, I sent a detailed email addressing each of your
> questions and suggestions individually. Before proceeding with v3,
> I=E2=80=99d like to consolidate my thoughts on the next possible approach
> to respect '.git-blame-ignore-revs' based on Kristoffer's conceptual
> explanation.

Although I asked several questions (which popped into my head) during
my review of the patch, I don't have much to add to the discussion
since I don't use this feature and either wasn't aware of it or forgot
about it until your patch arrived.

Phillip is off-list through the end of the month, so it is unlikely
that he will respond before then.

The general idea of implementing this new behavior via config-list may
indeed be a reasonable way to make it more well-integrated with the
existing methods of specifying ignore-revs. However, that's also an
implementation detail which seems less important presently than these
possible open concerns (unless they've been answered elsewhere), all
of which have to do with forward and backward compatibility...

* Will automatic reading of top-level .git-blame-ignore-revs cause any
unexpected behaviors for existing users who (presumably) are using it
via configuration? It seems unlikely, but the implementation ought to
be careful to process .git-blame-ignore-revs only once.

* Will automatic reading of .git-blame-ignore-revs cause unexpected
behavior for people who have not set up the configuration? In other
words, maybe some projects have a .git-blame-ignore-revs but some
users don't want it consulted by default, thus avoid setting the
configuration.

* It sounds like you want to punt on the idea of cumulatively
processing .git-blame-ignore-revs files from the current subdirectory
up to the project root (as .gitignore works), but can this be done in
such a way that we don't break user's expectations or automations if
such behavior is eventually implemented?
