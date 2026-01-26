Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644E526299
	for <git@vger.kernel.org>; Mon, 26 Jan 2026 23:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769469667; cv=pass; b=frJZCnkqiZ9cuD/lNBfNV08OKeYXGClKGhI7qldE9tyRebNACpAE38IAptGa57EEQNSLoMxMY5NKoKRZ8WME1BNlsE0dPQB7vjeJj8UAhgQGBAY7V9xXCRM8EwkFPdPuLkvtgNjE+EFNCXyy1TDwKygSl7UWgidtV4wVc1F+44A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769469667; c=relaxed/simple;
	bh=mP0TkfTNI3F9myrqOLj3QERte6y6ovrTIDYG2s55JBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZJU69rNYENOJo8U2Afx41wsZxC8pjybHaXhVXgCE+rFMiAr2B+Kab/O6LnK3/blBnjc5jcG71SWzInbiae82+xDZw5Yk38wTMImXvyRcucw6zA1JYcaxpqu0zBQepc9qeLdpIworA0ZA0KFJS01MidWiKpE5EEm5/+gXvvfLRWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JL2WmG0z; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JL2WmG0z"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5014b5d8551so106991cf.0
        for <git@vger.kernel.org>; Mon, 26 Jan 2026 15:21:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769469665; cv=none;
        d=google.com; s=arc-20240605;
        b=Ba9uqmAZPRW+9rgryoKoAh6TTuXV78XmxdJeD8A4F2xthACDDHWsRJZqw+Xc9/wLjn
         3Ho445mJl9c7dSr0j98HPlM19gSv3Zzai6gdQOW+ya5BAM21dMUKvPKKqkuvNDbunDIj
         lWhIZCQgXGENRuXuqMBvMX0vDYf5263mf0w+XGgoF0rOXSM2iyZslbZiaPJcIqsMfSXH
         7FoPhMluUmme/NtvpjungPNwZbXDQyedzo2tkTvAH1VNVo0WbIM7vKE0XSRmFOd7vxey
         49R+p7QDYWlnWkjDsVuCl+7kIYQK7WnHe/xsKkPrgHuPYqzGbNXzsLm7R0IzUPtiVMkD
         kM0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OMr4glMfgx1+LzQ7aWzR4wuE/lQJI1XLMnY+w0Lxq80=;
        fh=INB6v7jaN1m+DgzCYr30VT5ZPUqyw5MGy8YuRnth5CI=;
        b=LFid0Li/HMpW4rJBcoX2yyBe5tbekaOT6gmbqGbwEnH63sNTRpe9dbRBLEGK+z7UdD
         0NkgUs0qTb1KkqkBfOzlTSW6drBRuyqprtPg/efZBnQlnR/xnyJiqnLogP95cghFQWm7
         AvcmN3FLkeyAN5a1M67nnG+7POQn0v6bVLlDITSedAje0M+EWG+8ffCYsV2G87dJS6h+
         8RSZtGOnjWZH9eJIQbVZIym8UQQZdm9oqE9WkTOrCLfvG/Tcy8Y+Tw07Z+TWGgHk7S17
         D/mn2+euXqgjMMGP3nwNvEtYFfwChAJ5+sQlvUV2le+WVHIE9wVKNLqYNHgG5k/zYbio
         V2Lw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769469665; x=1770074465; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OMr4glMfgx1+LzQ7aWzR4wuE/lQJI1XLMnY+w0Lxq80=;
        b=JL2WmG0zFroESv0q4S911fcJN5qmF+SYb7QQ3QgR9oaSmR89PsQA1btFk7OEtKGHjX
         2MCQ3ePZD6U4j3nWPhj51jH5S0yAUeQwUQfQgQtU4gHJ2p3f6HO56su69EjmovBckgkK
         ZYth1OzeoLZLtNbdmnKqsKml4mRSO7/++ErC3Lkr1peOuMB0NAoqjv4dQc6d+b50G6Rq
         gHvD4gCNRtaxD5QRLl1N6ysVRONSvx3u5/PpXgiFr8mzF3tV4vjDjNzoeNT+AG/NrrcT
         z7dnBP0zwjGSpBi4HsZVgkxx91+V7+ylmvl8cn375Igvwra7p8vkl68Z29bJaDQY0kSV
         fR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769469665; x=1770074465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OMr4glMfgx1+LzQ7aWzR4wuE/lQJI1XLMnY+w0Lxq80=;
        b=koJJlbBk3+0o6kGi80VkIzsq21SGDKIu9/61PgS6cgnj/e/rBNuclNx/w7dNlr86a6
         0wEMOtucU85fLBmf2dmjqwE99DzCE5FPSiZqmJ2IoYrci70h7Tv6EwPtsLdU4MEcMCSt
         Nunrg3Htprk5enQtrj+ZBKicy7so/zK6/GQIWg/9ihzaeNA385cRd+etBo3rOpkRPteo
         KeXk++Q99tB8tqGbSzFS9ZsBj8rs9a5QLHhi3is+9SAfD0fj/z2/L4rFFUE3m9Phmswr
         5lV5fSq5D+5RRX1LAxw3WDthR4LdVYv/aG9xKG6k3y3j4e2AKS/c13rW0p4buIJJmXNh
         PXzg==
X-Gm-Message-State: AOJu0YxA1rxFfkegUhLt7z0pm6i8bQ2CMeCpVnW00V1ztgqBJBGO8uPG
	g+dBmZzkM8IAvFq9pM7paOCXKtpFgoKTvxsU4EPOmENr7TIIyg5KxOiGDADbMOPGu5OdVEQv6XX
	os/GFNmKQSl1HFmjoqKr+RfhIp6PxwGiGWQh3wO32
X-Gm-Gg: AZuq6aKILIPkabpWyvUL6gOR6upWymZDZJOps7+Y80NPmSE4iITe7kBLGLDUcDfaS2E
	Y0AeWYH/hSMgA+RFgvMNr6HhgKJXPjvwZcOCKfHdcgksYxfBUjjPL1ikSS1QwjoQRIy1Rnw0j3F
	640QT9dBkoGjOyym4Ijflkwq17SLBiFhPsMsI0bKMA7DNNpkxAKNWQKK+dWbXuA3WQGyjYNAD1F
	/nTvP2joNSpK3bXnJmL5nkU8LZblg6iQBd+8nqPbz8FRiEqemtYdmUV5e8hd9zPDUcApSgDtdLU
	nCrj8N3XiDzReEwKZhYJJlNY7r5W7A==
X-Received: by 2002:ac8:5ac7:0:b0:502:f58b:49bb with SMTP id
 d75a77b69052e-50314355482mr5473631cf.9.1769469664955; Mon, 26 Jan 2026
 15:21:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20260121215436.1473800-1-adrian.ratiu@collabora.com> <20260121215436.1473800-11-adrian.ratiu@collabora.com>
In-Reply-To: <20260121215436.1473800-11-adrian.ratiu@collabora.com>
From: Emily Shaffer <nasamuffin@google.com>
Date: Mon, 26 Jan 2026 15:20:53 -0800
X-Gm-Features: AZwV_QibthehxUl92PHthOH8HI7YsnN0u06iHyGJjwBNvdloz9EwOUZhn2BcC7c
Message-ID: <CAJoAoZn9Y1xqtc1hWDvM+_rmcANkGUtfSA1HGTaHjtw0DuXyAw@mail.gmail.com>
Subject: Re: [PATCH v7 10/12] run-command: poll child stdin in addition to stdout
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
	Patrick Steinhardt <ps@pks.im>, Josh Steadmon <steadmon@google.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2026 at 1:55=E2=80=AFPM Adrian Ratiu <adrian.ratiu@collabor=
a.com> wrote:
>
> Child input feeding might hit the 100ms output poll timeout as a
> side-effect of the ungroup=3D0 design when feeding multiple children
> in parallel and buffering their outputs.
>
> This throttles the write throughtput as reported by Kristoffer.
>
> Peff also noted that the parent might block if the write pipe is full
> and cause a deadlock if both parent + child wait for one another.
>
> Thus we refactor the run-command I/O loop so it polls on both child
> input and output fds to eliminate the risk of artificial 100ms
> latencies and unnecessarily blocking the main process.
>
> This ensures that parallel hooks are fed data ASAP while maintaining
> responsiveness for (sideband) output.
>
> It's worth noting that in our current design, sequential execution
> is not affected by this because it still uses the ungroup=3D1 behavior.
>
> Reported-by: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
> Suggested-by: Jeff King <peff@peff.net>
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> ---
>  run-command.c | 61 ++++++++++++++++++++++++++++++++++++---------------
>  1 file changed, 43 insertions(+), 18 deletions(-)
>
> diff --git a/run-command.c b/run-command.c
> index aaf0e4ecee..dfd2aeda07 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -1562,7 +1562,7 @@ static void pp_init(struct parallel_processes *pp,
>
>         CALLOC_ARRAY(pp->children, n);
>         if (!opts->ungroup)
> -               CALLOC_ARRAY(pp->pfd, n);
> +               CALLOC_ARRAY(pp->pfd, n * 2);
>
>         for (size_t i =3D 0; i < n; i++) {
>                 strbuf_init(&pp->children[i].err, 0);
> @@ -1707,21 +1707,52 @@ static void pp_buffer_stdin(struct parallel_proce=
sses *pp,
>         }
>  }
>
> -static void pp_buffer_stderr(struct parallel_processes *pp,
> -                            const struct run_process_parallel_opts *opts=
,
> -                            int output_timeout)
> +static void pp_buffer_io(struct parallel_processes *pp,
> +                        const struct run_process_parallel_opts *opts,
> +                        int timeout)
>  {
> -       while (poll(pp->pfd, opts->processes, output_timeout) < 0) {
> +       /* for each potential child slot, prepare two pollfd entries */
> +       for (size_t i =3D 0; i < opts->processes; i++) {
> +               if (child_is_working(&pp->children[i]) &&
> +                   pp->children[i].process.err > 0) {

I only had the one tiny nit on this patch, which was to wonder if
checking for pp->children[i].process.err is something that should also
be behind a conveniently-named helper like child_is_working().

> +                       pp->pfd[2*i].fd =3D pp->children[i].process.err;
> +                       pp->pfd[2*i].events =3D POLLIN | POLLHUP;
> +               } else {
> +                       pp->pfd[2*i].fd =3D -1;
> +               }
> +
> +               if (child_is_receiving_input(&pp->children[i])) {
> +                       pp->pfd[2*i+1].fd =3D pp->children[i].process.in;
> +                       pp->pfd[2*i+1].events =3D POLLOUT;
> +               } else {
> +                       pp->pfd[2*i+1].fd =3D -1;
> +               }
> +       }
> +
> +       while (poll(pp->pfd, opts->processes * 2, timeout) < 0) {
>                 if (errno =3D=3D EINTR)
>                         continue;
>                 pp_cleanup(pp, opts);
>                 die_errno("poll");
>         }
>
> -       /* Buffer output from all pipes. */
>         for (size_t i =3D 0; i < opts->processes; i++) {
> +               /* Handle input feeding (stdin) */
> +               if (pp->pfd[2*i+1].revents & (POLLOUT | POLLHUP | POLLERR=
)) {
> +                       int ret =3D opts->feed_pipe(pp->children[i].proce=
ss.in,
> +                                                 opts->data,
> +                                                 pp->children[i].data);
> +                       if (ret < 0)
> +                               die_errno("feed_pipe");
> +                       if (ret) {
> +                               close(pp->children[i].process.in);
> +                               pp->children[i].process.in =3D 0;
> +                       }
> +               }
> +
> +               /* Handle output reading (stderr) */
>                 if (child_is_working(&pp->children[i]) &&
> -                   pp->pfd[i].revents & (POLLIN | POLLHUP)) {
> +                   pp->pfd[2*i].revents & (POLLIN | POLLHUP)) {
>                         int n =3D strbuf_read_once(&pp->children[i].err,
>                                                  pp->children[i].process.=
err, 0);
>                         if (n =3D=3D 0) {
> @@ -1814,21 +1845,15 @@ static int pp_collect_finished(struct parallel_pr=
ocesses *pp,
>
>  static void pp_handle_child_IO(struct parallel_processes *pp,
>                                 const struct run_process_parallel_opts *o=
pts,
> -                               int output_timeout)
> +                               int timeout)
>  {
> -       /*
> -        * First push input, if any (it might no-op), to child tasks to a=
void them blocking
> -        * after input. This also prevents deadlocks when ungrouping belo=
w, if a child blocks
> -        * while the parent also waits for them to finish.
> -        */
> -       pp_buffer_stdin(pp, opts);
> -
>         if (opts->ungroup) {
> +               pp_buffer_stdin(pp, opts);
>                 for (size_t i =3D 0; i < opts->processes; i++)
>                         if (child_is_ready_for_cleanup(&pp->children[i]))
>                                 pp->children[i].state =3D GIT_CP_WAIT_CLE=
ANUP;
>         } else {
> -               pp_buffer_stderr(pp, opts, output_timeout);
> +               pp_buffer_io(pp, opts, timeout);
>                 pp_output(pp);
>         }
>  }
> @@ -1836,7 +1861,7 @@ static void pp_handle_child_IO(struct parallel_proc=
esses *pp,
>  void run_processes_parallel(const struct run_process_parallel_opts *opts=
)
>  {
>         int i, code;
> -       int output_timeout =3D 100;
> +       int timeout =3D 100;
>         int spawn_cap =3D 4;
>         struct parallel_processes_for_signal pp_sig;
>         struct parallel_processes pp =3D {
> @@ -1876,7 +1901,7 @@ void run_processes_parallel(const struct run_proces=
s_parallel_opts *opts)
>                 }
>                 if (!pp.nr_processes)
>                         break;
> -               pp_handle_child_IO(&pp, opts, output_timeout);
> +               pp_handle_child_IO(&pp, opts, timeout);
>                 code =3D pp_collect_finished(&pp, opts);
>                 if (code) {
>                         pp.shutdown =3D 1;
> --
> 2.52.0.732.gb351b5166d.dirty
>
