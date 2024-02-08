Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F26B7FBA3
	for <git@vger.kernel.org>; Thu,  8 Feb 2024 17:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707413121; cv=none; b=oYgZkLqESadJrMOlHyZI7Q1axVy4S1ionLufd91ohhX01OYbhEOgIUeyxdVJbsKkkT3LseVkIYPPU9YmNESjAJJESP8TSE6tKbK4m7oZ/LhS7Xhixui+y0O5AAoQVzJr8g7DK1piiZEj/YTy00fTeZJ35mnvbm19z0lw2MMkw1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707413121; c=relaxed/simple;
	bh=/V3Y1Ck0GdqHEYcg2lR4aSus5SWlgsFFdAhvu0pEfho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Te4wAGTknKTCHrdcuPmBlN5H6Vs4X7nIo2Nxoavc1yCrhyySg0o4Yg87kQ3nObPud2sXqMKc1AHA00aJ3R5XDF8WTczzO1SsXv/kIW+kuxDLfM9w0GWa7gpRPx6A4BIFH/4cPr/6OO77SGDoYmoDbtYg6i9d3nGcTogZuVDYHOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dc6e080c1f0so1670276.2
        for <git@vger.kernel.org>; Thu, 08 Feb 2024 09:25:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707413117; x=1708017917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w0Df8SVaBMZ2DWjGk2bKPL2o/kLedQFjabP4EKER7sQ=;
        b=EeNVBg77EaPw3si7UBML0PPKecf3VPNOZHWBRhFS+e23Wt2aP1YcZQrnb1YP9OQsDI
         19RxPgQSVDfvEmODgc74L2yiC1W5uDt1Kk4ihPV40osyb/vQBnJnlU4jzm6+PZIOplhr
         bh1leHiyDHtEFdMC+j+w7lrQT4RnYev+t6S75gIrNSh2oZMHTo0ho3bZVdtBeLVeEdah
         ZhI/At+S7xapeX9yOR7XI2xnDxSBr+uuSUZov6AnAG1HfCh7DhgYp5AB7oC095KGnags
         x/JiGXX4/kW/Z6EoQ3utMoFUxPIdnVOJIgRfPNy95VXosfHmm/ZlBgrbJDug4mja6SfY
         YjkQ==
X-Gm-Message-State: AOJu0Yw6vDMy/+ElTIGT+Ag4bwgk9c/bknlyKlMq4g3kuwDPreHQgY/P
	3VTRsfg7vmvcTt0Ym2Qs644ItqQ5IipLyY6XJTIDzfRAfcwHJHZUwvDegTk38qn2mOgZYB3Z3vl
	mQpZoAyxhq6Mt7S+rsa6fgHx18i8P3BP0bXI=
X-Google-Smtp-Source: AGHT+IGtyjHN/icIxbXB2q/c2cbzMjIJ34KwOg66BxXwV1e2aOPCmnh1rsJIFgEa0oBwzoJlWIfJmJsR9X6vZcGPj9Q=
X-Received: by 2002:a25:abb0:0:b0:dc7:47a2:ecbe with SMTP id
 v45-20020a25abb0000000b00dc747a2ecbemr121145ybi.31.1707413117593; Thu, 08 Feb
 2024 09:25:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1656.git.1707411636382.gitgitgadget@gmail.com>
In-Reply-To: <pull.1656.git.1707411636382.gitgitgadget@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 8 Feb 2024 12:25:06 -0500
Message-ID: <CAPig+cRASFkTD6=YumZJKv7XJjr1asxKB-mAyBFox8tuwmNnFw@mail.gmail.com>
Subject: Re: [PATCH] prune: mark rebase autostash and orig-head as reachable
To: Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Orgad Shaneh <orgads@gmail.com>, 
	Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 12:00=E2=80=AFPM Phillip Wood via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> Rebase records the oid of HEAD before rebasing and the commit created by
> "--autostash" in files in the rebase state directory. This means that
> the autostash commit is never reachable from any ref or reflog and when
> rebasing a detached HEAD the original HEAD can become unreachable if the
> user expires HEAD's the reflog while the rebase is running. Fix this by
> reading the relevant files when marking reachable commits.
>
> Note that it is possible for the commit recorded in
> .git/rebase-merge/amend to be unreachable but pruning that object does
> not affect the operation of "git rebase --continue" as we're only
> interested in the object id, not in the object itself.
>
> Reported-by: Orgad Shaneh <orgads@gmail.com>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
> diff --git a/reachable.c b/reachable.c
> @@ -30,6 +31,53 @@ static void update_progress(struct connectivity_progre=
ss *cp)
> +static int add_one_file(const char *path, struct rev_info *revs)
> +{
> +       struct strbuf buf =3D STRBUF_INIT;
> +
> +       if (!read_oneliner(&buf, path, READ_ONELINER_SKIP_IF_EMPTY)) {
> +               strbuf_release(&buf);
> +               return 0;
> +       }
> +       strbuf_trim(&buf);
> +       if (!get_oid_hex(buf.buf, &oid)) {
> +               object =3D parse_object_or_die(&oid, buf.buf);
> +               add_pending_object(revs, object, "");
> +       }
> +       return 0;
> +}

Is this leaking the strbuf? Should the function instead end with:

    strbuf_release(&buf);
    return 0;

Also, what is the significance of the return value of this function?
All code paths seem to be returning 0 unconditionally, and the caller
ignores the return value.

> +/* Mark objects recored in rebase state files as reachable. */

s/recored/recorded/
