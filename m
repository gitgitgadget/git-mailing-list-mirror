Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AC51BC2A
	for <git@vger.kernel.org>; Wed, 25 Sep 2024 20:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727296990; cv=none; b=dz5or32Y38BvOegDzGUTQlp1VMY8E4PWHAAkBS/wM/m9k9/BxrVRJGfPD6tEz1QO+2YyZlJQCX2/NqWPSp3g5dfKeFsJvxhu5MxPMoEazmcUqHo6jOqMFgCcUpBbs6y4nyLsdwlvEorVZi0s38gY3AkRff6/X60IXK5zvN/kWfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727296990; c=relaxed/simple;
	bh=pGQZ+g7J6ADlc3OrewvhI8j/2FY5pPFjGvxkOSyYeg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rv9Z6EZHk5jUldmVMkuOWNnz9Q9D+tqaxYlaZiR6KOFMXo7A0axwPS7UlLZRBjazuF5+FeYuGSswsb1aFd0KU45c2r6LxvEshl+CAIyguLfw3u6ySZrbwoHG3tUoW/s+H6Pcw9qKr8fHUw0jKGhBJIi2JABjQQNt2JeNEFbLemY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LweWiZle; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LweWiZle"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e1a74ee4c75so284454276.3
        for <git@vger.kernel.org>; Wed, 25 Sep 2024 13:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727296988; x=1727901788; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gw3L+z7sMIYQYYJCmjO/0qKfKgsqmd5ctBB6QXb5kcA=;
        b=LweWiZles3uArgY4YkF3NWcT6ZZMH7AMi5By1gkD2ANytuJbja5zkDvlwf7Q7+SHQB
         zHUN4vcjgqPZUIhG78BQXGDOhVHX2zaZfeKCMyLEaJw8PgZLiZgPbtmfhUJROjCW+e0e
         T/UZgO/QWbaLGCSEgZwSd4evVq3odkqDrb1rhrPY99nyop2QQ9yYSJpXJ2lMisWG0l+U
         ld3I9mWSTyp1hf939TfJnNkMGfieMMPQObk6A08u6swR4hkB4iKu+OVk4k0loaIa8B/n
         OtmmqPzjncR1Bw5AZ7vTY+XoYjiX+yq2linoJyG+H5OoDbRaqTaRN2VHYyfXffmdT2Yu
         p8Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727296988; x=1727901788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gw3L+z7sMIYQYYJCmjO/0qKfKgsqmd5ctBB6QXb5kcA=;
        b=C6GJOmRKhoYCJdpuh1ZJONrTT35jt/jrBbhBxoYojIfiZRyp/uW6u6uKsENinZi+1a
         CqkMfWF7enGTy2HYTpCa3plPT7FTRQ/FTOp7lSXsC4iX9Bwo50L3hEZ+QjepTvBBUkjc
         OC9DHE6esDjma/SF8Mbw+sT3OQ2R/5xsRr/iOhWoY57edgYwBydPYtL8MapEhGKuMkKM
         YTMQPXQZb9Wh4omW2dVhKczw0I6pXkjimX8NGRPr+IBu08Ea9RIq9tW+1pfvJ9Mf0UEt
         adQM+z1KjcDnBWVrkiNCKXuFPoVqkNK7obRd3ObJz2cv7Ehkdd3mfjsaDoEDqIEIlFko
         C7fw==
X-Forwarded-Encrypted: i=1; AJvYcCWCPxK8C7AvtlNuDfBA9h2VhG28U94kZpiYWVS14tyr0NE06urTt09Rr3WTXDX05NkOoHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YymQaUfBaN9wHTFG7ZbpFEZQvr1Z0NlkJrEvSOI3jQL+wVQ3LWL
	9u2BZxBRdvnDXJRWBWp+KaqzCdgQXSnigUzl3kNCH6VIz+lBqwVy9o/y0azcefkCenMMGI8mBV9
	TGiTSyV/ShqOKVOkqnKui8hgjuX4=
X-Google-Smtp-Source: AGHT+IGDj2F3HgFHMnREnFLTPLBASs02Hnj3E/C4x+cf6jUdAW6d+7WkaDP0wYCji9gb03dt5Z8YBE2P0kdxjewscfw=
X-Received: by 2002:a05:6902:c12:b0:e16:1ebf:293d with SMTP id
 3f1490d57ef6-e24d7ee7ec6mr3137105276.20.1727296988098; Wed, 25 Sep 2024
 13:43:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20240720034337.57125-1-eric.peijian@gmail.com> <20240720034337.57125-2-eric.peijian@gmail.com>
 <CAP8UFD1J4JdR-QP9em=_0q8CQZLf9nE7PLE2=kkvxY218fa-ig@mail.gmail.com>
In-Reply-To: <CAP8UFD1J4JdR-QP9em=_0q8CQZLf9nE7PLE2=kkvxY218fa-ig@mail.gmail.com>
From: Peijian Ju <eric.peijian@gmail.com>
Date: Wed, 25 Sep 2024 16:42:57 -0400
Message-ID: <CAN2LT1DvrXwAZsjwgEh1waBAVgTNf3UHztsKgY0aGz6Lt3Dfhw@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] fetch-pack: refactor packet writing
To: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Cc: calvinwan@google.com, jonathantanmy@google.com, chriscool@tuxfamily.org, 
	karthik.188@gmail.com, toon@iotcl.com, jltobler@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 7:45=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Sat, Jul 20, 2024 at 5:43=E2=80=AFAM Eric Ju <eric.peijian@gmail.com> =
wrote:
> >
> > From: Calvin Wan <calvinwan@google.com>
> >
> > A subsequent patch needs to write capabilities for another command.
> > Refactor write_fetch_command_and_capabilities() to be a more general
> > purpose function write_command_and_capabilities(), so that it can be
> > used by both fetch and future command.
> >
> > Here "command" means the "operations" supported by Git=E2=80=99s wire p=
rotocol
> > https://git-scm.com/docs/protocol-v2. An example would be a
> > git's subcommand, such as git-fetch(1); or an operation supported by
> > the server side such as "object-info" implemented in "a2ba162cda
> > (object-info: support for retrieving object info, 2021-04-20)".
>
> I agree that reusing or refactoring the new
> write_command_and_capabilities() function for more commands can be
> done in a separate series that could perhaps also move the new
> function to  Maybe this could be added to the commit message
> though.
>

Thank you, I am adding this to the commit message,
"In a future separate series, we can move
write_command_and_capabilities() to a higher-level file, such as
connect.c, so that it becomes accessible to other commands."

> [...]
>
> > -static void write_fetch_command_and_capabilities(struct strbuf *req_bu=
f,
> > -                                                const struct string_li=
st *server_options)
> > +static void write_command_and_capabilities(struct strbuf *req_buf,
> > +                                                const struct string_li=
st *server_options, const char* command)
>
> In https://lore.kernel.org/git/xmqqfsn0qsi4.fsf@gitster.g/ Junio
> suggested swaping the "command" and "server_options" arguments as well
> as sticking the "*" to "command" instead of "char", so:
>
> static void write_command_and_capabilities(struct strbuf *req_buf,
>
> const char *command,
>
> const struct string_list *server_options)
>
> The rest of the patch looks good.

Thank you. The format is changed in V3.
