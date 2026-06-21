Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8A2156661
	for <git@vger.kernel.org>; Sun, 21 Jun 2026 06:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782024150; cv=pass; b=uEo8U6UckemGUNkZD6+BII0BRspQwZ1FBYrXlohiEW/NE2mGbIo5Npt4pdjnn0M63FKACkQeYmmhOo6eQiXdha9+YA65jqkmPS1Pyc03BnasyhpTDTjW0Ki03Nu55GxnO6yOIPWiV87b0ezxTsa/pPjvHhY9TGL7b7GvhkCdEuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782024150; c=relaxed/simple;
	bh=0q09/6pK6UQ2EJoihkOrnjHyOMNH+Qx97XfnYUsy8xM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RwAVe1EKq1TE8SkkK0kLEpKSpFvJ+apmqpPSiEugh5G57NQkGKqc9OBQRhnMW6ty/glIP74udbR3AWvxVWlxF3Ao4WvGFSHRTpS57QzFrDcz4HZ10+lLMCA8x4S3fEJkHn4e6Ky1/268Jp8dXvdvTMqqog5508BYf8hiInXrSGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SuRSq/JT; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SuRSq/JT"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-696bf0e7c9cso4847564a12.1
        for <git@vger.kernel.org>; Sat, 20 Jun 2026 23:42:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782024147; cv=none;
        d=google.com; s=arc-20240605;
        b=jt2VActEBP45KMxgK4FbAurpD0Q099q77GkdjGUrFUyUlsvQL6+IuDlAggD5T/32JQ
         5ASjF8U6jpfJXK/tMVzzcvbJkDfG9Lfk/dMC6DymYWBuAHu+C+esJKZ8FrXvJ/2OMiOT
         Vd/dcSTIb9wA+/zl1NCnLFxlQZCjATavrU3PD4ZUSg40Fl9zoxnm7dgnmXWp2gyU4AVz
         B6wSycDRQ9h6qlNxKHfHI7yKqExOBk2kTneyFV+DtzE2Ke2nfPiFieqf9z0Hu6D0D8r8
         pn0JDsBRqdsR0+ybDM/oMNgxaMn2N20DzgG2dHMRpwOLi/lyl2sUefpDgXsfW1NiMF20
         cr6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=aXfITImNQvRdseG0u24ofj7jQGtl2Z0OX+TCZvKZSQo=;
        fh=cvic4k7aVH1e0bs3VFU+Ys+POMUrr0zEQ5t4qNO1G6I=;
        b=lgFtYr0zN7/bJW5ZFTf6IAAsNWxTCEGXWyjYorTc0lTubdGNgGIpZv3yboetBcdyXC
         s9qbN9Mx5un2FysxjOZqZop97NB3qFz7POJjDah/qUDv6R0X2dbwDot6u1RssKlYZFkb
         Kbdy3LoPMHMUCZDkugzVT541Yzb1LWMMjbtqOA6dyTj2SymXTHq+Q69znsj0mE45jSTF
         zWTZ1oWq45tstFMIshxhDYZDRVS4Yonq9UG5ci3w2k+5vrN0n1j2dSacgBRzb1RjoTH4
         lkwxxpBoo1oObQOr4cvYxpp5SCxkCbDTytMJlUaXMCWSoMlRgcsiYU2feASBLA3V0YAc
         Q/kg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782024147; x=1782628947; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aXfITImNQvRdseG0u24ofj7jQGtl2Z0OX+TCZvKZSQo=;
        b=SuRSq/JTKw5v7l41gEd3SvksiMSkInyyIwV7wkpSuE6RDLk+PZ5flW2NzhYG2okl0H
         TVLDP0ZIUACKHuiAsiY18fGULfS5g2oc66soi8nr6N5f9Z7s54IuvnxuI3//9xy95x15
         0g6TAi+hhp9hOnWxu9GlFErD5qjoHpMbjAi8AmaszusCYgrP65K0ybOi6FTxGf/s8tZi
         59Pqv3h+DnKzh/fONxB50HyUQTzIb1uxkiCLyQGYzJPigFjHttHIpip9wVliIvVVFoFr
         xacXo3ibBz7vQwQFa0kz02BwoD+qPzPHsLk+PPyELaSCW+llUdL6/Mq/Npk3kRCEz3A2
         ftTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782024147; x=1782628947;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aXfITImNQvRdseG0u24ofj7jQGtl2Z0OX+TCZvKZSQo=;
        b=fay6iZPIFaN9Pxdan2XP9r8KS+UZb030MmL69Cps92zznacSMBiC/9odtD9FbhN44e
         9zOrkIiJkB9UFb/8oknP86nuYXAgG27hMwoBKeyzbAmJEkLk7BzYdiu2ioeP3mkzmmns
         f5tHAMUfA35W5lFMyyj/g5BXZoPVOvamOCiAP/6LkYVTyVW8GS/W/y3Pt13nkQEaOOXP
         pgySx0n5HIbtVNoQEZPlpqW2kdRXpXGbO3Coz5W8oOXY2E9zqYrE6VkX9vvu15fwgxYQ
         3FScrM1uNTinjP5U0WNgrsdIMLd3ow/9I+nAdMuOW4mmywcBJx/qYN0l9kUgnYwGAjAh
         gB7g==
X-Gm-Message-State: AOJu0YxcM5jFSwWgPQycSV44gPz4s4J0iB1E/YYnWQhqZV8bjVXD2gVf
	3cY2PScgUrbEQq7RRzJMxIOED1GZbMc+E1g4NU9rIu9n4FDXLgCXkXNJwF6TBahskhWnGjv2T/s
	NmDmYgSgKDJdJSnKdzYlJ0OaDedWppxd7aw==
X-Gm-Gg: AfdE7ckjUL8sEh+f2rEW9bV7VcZGOZxiQz0xA5hpBXF4w2VlpTklS0OXdj9MnlRBdym
	J26CSFOwkccVLKwoKxwx225DZqeNJJ4iyTHbiJxAkhRLnosLWOG3tqYJrCH5B5ho0DGY+ELWTJh
	CG0SGYGEKvz36OrpToVB+WtzhkQJpkJV7HxUpRSoMOlzdIA7BBBFDvxEBaf5TATbODr9ORkyxUb
	/yQh/nquePiNTJyg7OwnYzz7dc6y09e1HBpuu7x8WtVPUFpkTbK2xsQpk4yA/cnDdT8BPwjfUFA
	EpuMRIXGx/HremkAJez2AYYUux62J7uX9B+jf2uWQKt0hC3OasClzdjh16GXZIQ3RdQcJIkYegD
	fSGZNiDyVlg==
X-Received: by 2002:aa7:c74a:0:b0:697:645b:90e5 with SMTP id
 4fb4d7f45d1cf-697645b9235mr2289374a12.4.1782024147047; Sat, 20 Jun 2026
 23:42:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260613-ps-pre-commit-indent-v5-0-8d308efea63d@gmail.com>
 <20260620-ps-pre-commit-indent-v6-0-cdc6d8fd5fbc@gmail.com> <20260620-ps-pre-commit-indent-v6-2-cdc6d8fd5fbc@gmail.com>
In-Reply-To: <20260620-ps-pre-commit-indent-v6-2-cdc6d8fd5fbc@gmail.com>
From: Chandra Pratap <chandrapratap3519@gmail.com>
Date: Sun, 21 Jun 2026 12:12:00 +0530
X-Gm-Features: AVVi8CcjuRzsROV4lGZYNxz5GPKIjs0xkYgRipYoz4nETUzsYp8B1qVVlDyeRXo
Message-ID: <CA+J6zkRbtYu+f52W0+OjgikRGEgcS_nzzeGbdOzUCHZQ3ME-FA@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] revision: add peek functions for lookahead
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org, krka@spotify.com, ayu.chandekar@gmail.com, 
	christian.couder@gmail.com, gitster@pobox.com, jltobler@gmail.com, 
	karthik.188@gmail.com, peff@peff.net, phillip.wood@dunelm.org.uk, 
	siddharthasthana31@gmail.com, Kristofer Karlsson <stoansen@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> +int revision_has_commits_after (struct rev_info *revs, int n)
> +{
> +       struct topo_walk_info *info = revs->topo_walk_info;
> +
> +       if (info) {
> +               int visible = 0;
> +               for (size_t i = 0; i < info->topo_queue.nr && visible < n; i++) {
> +                       struct commit *c = info->topo_queue.array[i].data;
> +                       if (get_commit_action(revs, c) == commit_show)
> +                               visible++;
> +               }
> +               return visible > n-1;

Nit: I think 'return visible >= n' will be more readable here. As in,
more in-line with this function's description (below).

> +       if (revs->commits) {
> +               struct commit_list *cl;
> +               int visible = 0;
> +               for (cl = revs->commits; cl && visible < n; cl = cl->next) {
> +                       if (get_commit_action(revs, cl->item) == commit_show)
> +                               visible++;
> +               }
> +               return visible > n-1;

Same here.

> +       }
> +
> +       return 0;
> +}
> +
>  static void trace2_topo_walk_statistics_atexit(void)
>  {
>         struct json_writer jw = JSON_WRITER_INIT;
> diff --git a/revision.h b/revision.h
> index 00c392be37..a10c6b0940 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -572,4 +572,14 @@ int rewrite_parents(struct rev_info *revs,
>   */
>  struct commit_list *get_saved_parents(struct rev_info *revs, const struct commit *commit);
>
> +/*
> + * Peek into revision's next commit without consuming it.
> + */
> +struct commit *revision_peek_next_commit(struct rev_info *revs);
> +
> +/*
> + * Check if there are n more commits to be shown yet.

Shouldn't this be "n or more"?


> +int revision_has_commits_after(struct rev_info *revs, int n);
> +
>  #endif
>
> --
> 2.54.0
