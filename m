Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FB51DED57
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 16:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729182705; cv=none; b=MwM9k0Il8jd14BIY06yEg+kbHUo8EEDePC4X+JYlJ5eG20nW5CBsNG1x7fWiblw3nzhIwkrRnIYRsX3fzgeKnf0ft3HKj49jsE8GUEujZfUgpplqk2umd+6kWglQDYGk9UCAzKVKbPpQXBzgtW9x9GeQBJ6Fvy7YVWaxTdD7YRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729182705; c=relaxed/simple;
	bh=kFYGAw+GkvSH20rOvUfzHWCegLe0U+D2DIoQFPTW39A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C9k+XBPCP3xpRugKb3wjQiVX7mnCimS+GrG0Dh5Bw/i971hWWz0symWbxZZzBQuzWNqRvrKamlTSiwRzlHWEZXJ3rrjt+vo9w3cYZDL5+0oeEWQdJbI8PjSaYvyuRzUYGDd9vjwWdruo33ZX0cKzEqYwr36KlgKxozvVRMR/ayM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6cbdd42bdf3so962316d6.1
        for <git@vger.kernel.org>; Thu, 17 Oct 2024 09:31:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729182699; x=1729787499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0VwFOfaEG/Wxhyv7p/KwavrqmTAKMafX712XDeZbCZY=;
        b=qfE9z1KGVGlvvN37iwcK3rpY/OWTZH3ByYHlGdp7zDTtxa9eqZczWIlF8zqtzf262A
         UJA9vbQpvJuEYkh4cG48pt/qv3k/b6d3Yh0l29Q5x0z1h0BjruTMO1SH8wjgk+xp3yAL
         vZ3Bytq/TXoHMhxZMNodT5vKxYxKKabpx8I3GKcp6u7LCxVIZov2A68t5fC0NpSwM+5s
         LyXVAZRLMlDwm8lo7bzn+3V75jna2tt0/11esfH4FbWTTMUqUKPddsu+c8iG6fexgzRo
         GDFTzVFkYZ7+sr/YBuuIhLVcHMGvdrlUd/jmdOwhE1VwAWFZgszoUBYV+pmvtwEUKVgN
         ORSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrBb8v0kXhspDZ5Kc+E0BkzL7LOVgJrjr7S2YoS8y0olalUi43REpVzA1eY+MigKjhQkY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxv+JLyj6bt098Rl/gvWxCiciZRZeNcQQO+zy0UxgLBDIdcEdV
	G1LBWJWzfxCeKFd8uYA48RGxYRK8WQvfQ6hLyfBR/BhnPvZsM1i99tNAM2UagkDWPWMB2GrvnKV
	g4hvl9QvRTQZc8sO2bHyI2yx9Z84=
X-Google-Smtp-Source: AGHT+IEOTYyyq+kkajt6s3R9B3k/5Otufh9tApcZLSs8kdGB6Ek47avkU9xKb9ahyIkIInxWbi5NqltAIsFNFZ/ywtw=
X-Received: by 2002:a05:6214:1bcb:b0:6c3:5dbd:449c with SMTP id
 6a1803df08f44-6cc37a2fae0mr23618366d6.1.1729182698983; Thu, 17 Oct 2024
 09:31:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOLa=ZQJy1ZkQqBoWwJJvL0f+NCP=3SAfyeSNuztgApzNH1mGg@mail.gmail.com>
 <cover.1729017728.git.code@khaugsbakk.name> <ad9ee00a2a971522968f95dd413deae24839ef71.1729017728.git.code@khaugsbakk.name>
 <ZxAmBsZzwBuEGN3N@nand.local> <CAPig+cSuQwu4YeZ5cs-g0oAnhCf1LMS1SSywyPc_vBExh85ahw@mail.gmail.com>
 <ZxA5ni7McD1c1yuf@nand.local> <24297144-c08f-4bc4-89dc-c3d8c12523de@app.fastmail.com>
In-Reply-To: <24297144-c08f-4bc4-89dc-c3d8c12523de@app.fastmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 17 Oct 2024 12:31:26 -0400
Message-ID: <CAPig+cTPyFXYxm-YO7xTqmeL1KZKT0vApvaD633Y4=q8=k-2rQ@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAxLzZdIGRvYzogdXBkYXRlLXJlZjogZHJvcCDigJxmbGFn4oCd?=
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood@dunelm.org.uk>, Junio C Hamano <gitster@pobox.com>, 
	Bence Ferdinandy <bence@ferdinandy.com>, Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 11:30=E2=80=AFAM Kristoffer Haugsbakk
<kristofferhaugsbakk@fastmail.com> wrote:
> On Thu, Oct 17, 2024, at 00:09, Taylor Blau wrote:
> > On Wed, Oct 16, 2024 at 06:08:05PM -0400, Eric Sunshine wrote:
> >> I think we typically avoid rewrapping after minor edits like this
> >> since rewrapping introduces unnecessary noise which makes it more
> >> difficult for reviewers to identify the important (actual) change.
>
> I was skeptical at first.  But I saw that this line is only 55
> characters long.  So I think (like Taylor) that rewrap is in order.
>
> What if I make a commit with just that word drop and then an immediate
> fixup! commit which wraps the paragraph?  That way the review is still
> straightforward.  And hopefully the integration part is not complicated
> further.

Don't bother. That's even more work for yourself, for reviewers, and
for the integrator, and it increases the cognitive load for everyone.

There are far fewer reviewers than there are people submitting patches
to this project, so it is helpful for submitters to do what they can
to make life easier for reviewers, and foregoing re-wrapping of lines,
in general, is one such way to do so. However, this is such a minor
change that it isn't going to matter one way or the other, especially
if Taylor, as interim maintainer, is willing to accept the extra noise
caused by re-wrapping.
