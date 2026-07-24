Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AB35464D
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 02:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784860882; cv=pass; b=os8ojz06fj83iZICZP5DXeW74G1KVUhu39FbLhpx3ukGAhfW+e4UCA9qqhniaFATuajtfJWL9zPy3T5dldsgfeDfIdK+JspT67Dl4MfE6LcsCwMYqDQVyrQG5y7F+MDfuGbKvQ9qSEsuuF9Iok9POK4bzMNR57dFOXf96fglU5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784860882; c=relaxed/simple;
	bh=YjtlW3+z+gars/phJ3dbdP8txFZa+8TMiVVlakNQ3Ko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BhVC1Wy1pUI7RwRH4Ps5jANW22uJzxpCUz8jgp/5Vyoohte+7G84Xs1D+29pbwJcvJu0pf7VPUHl/YCOVPrhk8RWIFSkxIpYEs6LWoKZ99vA22fG2t/62BLskmz16q3PcuKtUW7wFX4JiNminlqD96hsS1xwVEXzEaO+30oNeLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net; spf=pass smtp.mailfrom=gree.net; dkim=pass (2048-bit key) header.d=gree.net header.i=@gree.net header.b=Pf+2wCnn; arc=pass smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gree.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gree.net header.i=@gree.net header.b="Pf+2wCnn"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-ca80d708489so786852a12.1
        for <git@vger.kernel.org>; Thu, 23 Jul 2026 19:41:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784860880; cv=none;
        d=google.com; s=arc-20260327;
        b=m5Q/qC+vhgq+GiTmjOPE9Dsh+ou5ZpY7JgnV820UN3UIh1mBuwr18mjlKp4dj5qat8
         n3JEjlc/yV6vdhntP59PW1Bezeegq+12g0sTpfIoLUt7XOHyMjMgTU9oZuxmFNDUnFu3
         3EYkF4kAYAdEe+QYIGBQXSxcBuKGumjEiP9bCWgdp6wmb1UMp8rIC/VXmGZjKJuTqWya
         tgXUxHRNgAakFkLpoJk60vmqgpE33xvJjBJu9Eu9QXXNwQkciAyhH5qdVvUrqzFrlFKp
         8rYcg+BimEoTeGKCnai8ngwiU4yV6uIcD4bxRQNd3pZLs0po34tSfXd/SybgqtwfYLsp
         R0NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y7/haBW6pfZuiJA1qm0kOMHbI1ziu7GVUhb/YNlHonI=;
        fh=uVYOeVwuigDlAdcRnoepTg5629/55KiQRr1OGmij7U8=;
        b=IVh6oy4aDZDDItXokPwnVgD+yNY85Y211rm4dVP7wfGXCJmdX4Sg46OtJkCoRzaGy+
         nedz5iWxLR7BDuj0rEktm1cBnvMIfqHtMPGPR86OtzHZokkxdaxfV7eaDCdeZC56DlrG
         CfcWRQw6Jzqwtb8Gwi35noeWPJdFgaky4A3mnHAGkd7EsoGAxrFR7/ZkLZhA4L6jE4Ic
         1g0ywEFiKEf92d9FNTls7mxueik2iNy/niTjflVjmlq56BEnZpp0e0uF7LrV7PHkE7Db
         YF4qxGdFCqNtQMTr+jBeP/BlzhtLvp77iGC2oTQZXyTY6Y699MlNKstGTQ6Y1UVta45C
         4++Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gree.net; s=google; t=1784860880; x=1785465680; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=y7/haBW6pfZuiJA1qm0kOMHbI1ziu7GVUhb/YNlHonI=;
        b=Pf+2wCnnh1MHi5xmHgFgQYvJCyVIWvvTO0M7g5gVHgiAGtEnEX1NBIDGlJwEsEbYhq
         EvQsfUvG15/FnsnUJl9b7PDFGks3ZLL+zuL6tKb5d61JsVVu7kd5vQAP5dx/Qt618VmU
         qcrADD6GYaYMchmicJT3VeMrmUjXGRmWPKgNfLjC/YrEeCab+Qwk5kuTQC7Vcdxq1Muv
         hXFEFtSYJ/CFlDD71+bunG5RxormdJfygwHDM2ybZ/A29CgDB38nDTsGC977pmztOVoG
         FX8xZKcrx6xOHWlfu3mw/v/LFcrW14Ph6UiZs/4vcDjn4NJVbJXANrYs8c2L4PrOllKh
         VCQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784860880; x=1785465680;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y7/haBW6pfZuiJA1qm0kOMHbI1ziu7GVUhb/YNlHonI=;
        b=cKu7m1FDOB1lP8dGfm1j5RJbmiqpAcKeS4YLhs1VpGN7QwM1y/aKLNJ7VksiXqz35G
         TckVUUtaGdmI/cAAQpi5CSNwLyyZJiSS80Lz1V7SqAh5aQwyc03s8t3Zz+QqjpUtNthg
         BvKGopoLDzZIbFD7E2YKTIJWrzHonp/Yc7BNHZ2/FIGFbmYIWOWcYWiTmt1zkTTt2QD/
         /N5ffoYswk3thhShsGucFrkBiriZY3pteLCSkTNw8yO45cleplFLwvuxu+sjmfg4hOLI
         fSev8MkG4QRixg+VcbllmEeGK65JUSz0hfsLcZAiCj0njcxkv0ciP29eGZ2qjrGCozRg
         w6Zg==
X-Gm-Message-State: AOJu0YxEBdE39lK7h5ZscEQj7fvg/EursNWx4fQ0xUQxgeDbeXUtLLqE
	zmgY7D8wDn0RIZc/JC1R3L+nkPdpa87F00s9ihR8uS+XDR9/TvsUQUPwEh9gp2J2QpDFijVYhX6
	6OIPcE3Tss7YGgHySwcW4heqSKmpO4wAaa8uX376Fx9x/od1jTbmTcXOTNnyKjx6fAzrkjztiVi
	W64YhKTXhk4FXsawJEI/UruL9QEi9IvCeqBrxdg9dgePWEnODuxSBS0iR2TijQ5jnLBbEa6sIkZ
	JRgY2aTzTfh0LWkkT7m63VXK/7ScLKQVhBx4ERTw1ix2JjCmzlJ5I9F50gmqd2SdHXKnGyi2aee
	aumREM+QpPn06ME=
X-Gm-Gg: AR+sD13TXrc0SlRo3B3umcVWC9r4ltp2hNXgrNQsenFHXqsr71zNYIPQQTWnUFwExYs
	Ps1AqHZFRvG1b3ULAtKQmctO4rfCpodaYAdiG+aE+qe/cXl2FDyyK9mTyNf8EQPH7cZSadwHfhZ
	7LCXtPJq5eI9yr96volKl5+z1LB07BSDspssaRoQ+nGtDpDok9KwJ3prAziBHHjW5UrJYg1IiGK
	woPSK9E3IH2xfv9JChyg8XTxHJ1jIV2+pGLhTVX/3aoBHTnPAQiWHHiVFZq0iew43r2jiAu1MxS
	3Eg9OZGO
X-Received: by 2002:a05:6a21:2d43:b0:3c3:6e84:ace8 with SMTP id
 adf61e73a8af0-3c44caf0a32mr6017095637.23.1784860879695; Thu, 23 Jul 2026
 19:41:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721-fsmonitor-darwin-cookie-flush-v1-1-357dc5e32040@gmail.com>
In-Reply-To: <20260721-fsmonitor-darwin-cookie-flush-v1-1-357dc5e32040@gmail.com>
From: Koji Nakamaru <koji.nakamaru@gree.net>
Date: Fri, 24 Jul 2026 11:41:08 +0900
X-Gm-Features: AUfX_mytwNjQ55p4SE8CvXU1iU9G9Uq_uUoPxH5jrhSb2wsbimmX4M2HrlKVtCQ
Message-ID: <CAOTNsDy4pKbPHdK1T688Ax6Mgz15K-qfZR-8fAvTk48z3E43Rg@mail.gmail.com>
Subject: Re: [PATCH] fsmonitor: flush pending FSEvents before cookie wait
To: Tamir Duberstein <tamird@gmail.com>
Cc: git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>, 
	Paul Tarjan <github@paulisageek.com>, Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, 
	Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 6:05=E2=80=AFAM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> 56cef9cb1a (fsmonitor: use pthread_cond_timedwait for cookie wait,
> 2026-04-15) limits the cookie wait to one second so that a filesystem
> which never delivers events cannot hang fsmonitor clients. A client that
> times out receives a trivial response and scans the entire index.
>
> FSEvents can defer delivery while it batches notifications and does not
> guarantee that its queue is drained in one latency interval. A loaded
> macOS system can therefore time out even though the event stream is
> working.
>
> On an Apple M4 Max (16 cores, 128 GiB RAM) running macOS 26.5.2, two
> worktrees with a 1,001,178-entry index timed out 484 of 545 and 297 of
> 365 fsmonitor requests. One status call performed 934,519 lstat() calls
> during a 47-second preload and took 52 seconds overall.
>
> Ask FSEvents to flush pending notifications after creating the cookie
> and before starting the timed wait. Use the asynchronous form because
> the client handler holds main_lock, which the listener callback also
> acquires. Keep the timeout and the behavior of the other backends
> unchanged.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>  builtin/fsmonitor--daemon.c          | 3 +++
>  compat/fsmonitor/fsm-darwin-gcc.h    | 1 +
>  compat/fsmonitor/fsm-listen-darwin.c | 5 +++++
>  compat/fsmonitor/fsm-listen-linux.c  | 4 ++++
>  compat/fsmonitor/fsm-listen-win32.c  | 4 ++++
>  compat/fsmonitor/fsm-listen.h        | 6 ++++++
>  6 files changed, 23 insertions(+)
>
> diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
> index 4161dd8282..8e32b5ae5e 100644
> --- a/builtin/fsmonitor--daemon.c
> +++ b/builtin/fsmonitor--daemon.c
> @@ -206,6 +206,9 @@ static enum fsmonitor_cookie_item_result with_lock__w=
ait_for_cookie(
>         close(fd);
>         unlink(cookie_pathname.buf);
>
> +       /* The listener callback takes main_lock, so this must not block.=
 */
> +       fsm_listen__flush_async(state);
> +
>         /*
>          * Wait for the listener thread to observe the cookie file.
>          * Time out after a short interval so that the client
> diff --git a/compat/fsmonitor/fsm-darwin-gcc.h b/compat/fsmonitor/fsm-dar=
win-gcc.h
> index 3496e29b3a..c209dc2f68 100644
> --- a/compat/fsmonitor/fsm-darwin-gcc.h
> +++ b/compat/fsmonitor/fsm-darwin-gcc.h
> @@ -82,6 +82,7 @@ CFRunLoopRef CFRunLoopGetCurrent(void);
>  extern CFStringRef kCFRunLoopDefaultMode;
>  void FSEventStreamSetDispatchQueue(FSEventStreamRef stream, dispatch_que=
ue_t q);
>  unsigned char FSEventStreamStart(FSEventStreamRef stream);
> +FSEventStreamEventId FSEventStreamFlushAsync(FSEventStreamRef stream);
>  void FSEventStreamStop(FSEventStreamRef stream);
>  void FSEventStreamInvalidate(FSEventStreamRef stream);
>  void FSEventStreamRelease(FSEventStreamRef stream);
> diff --git a/compat/fsmonitor/fsm-listen-darwin.c b/compat/fsmonitor/fsm-=
listen-darwin.c
> index 43c3a915a0..64bee248d2 100644
> --- a/compat/fsmonitor/fsm-listen-darwin.c
> +++ b/compat/fsmonitor/fsm-listen-darwin.c
> @@ -496,6 +496,11 @@ void fsm_listen__stop_async(struct fsmonitor_daemon_=
state *state)
>         pthread_mutex_unlock(&data->dq_lock);
>  }
>
> +void fsm_listen__flush_async(struct fsmonitor_daemon_state *state)
> +{
> +       FSEventStreamFlushAsync(state->listen_data->stream);
> +}
> +
>  void fsm_listen__loop(struct fsmonitor_daemon_state *state)
>  {
>         struct fsm_listen_data *data;
> diff --git a/compat/fsmonitor/fsm-listen-linux.c b/compat/fsmonitor/fsm-l=
isten-linux.c
> index e3dca14b62..7aae29ea22 100644
> --- a/compat/fsmonitor/fsm-listen-linux.c
> +++ b/compat/fsmonitor/fsm-listen-linux.c
> @@ -493,6 +493,10 @@ void fsm_listen__stop_async(struct fsmonitor_daemon_=
state *state)
>                 state->listen_data->shutdown =3D SHUTDOWN_STOP;
>  }
>
> +void fsm_listen__flush_async(struct fsmonitor_daemon_state *state UNUSED=
)
> +{
> +}
> +
>  /*
>   * Process a single inotify event and queue for publication.
>   */
> diff --git a/compat/fsmonitor/fsm-listen-win32.c b/compat/fsmonitor/fsm-l=
isten-win32.c
> index 9a6efc9bea..039d797000 100644
> --- a/compat/fsmonitor/fsm-listen-win32.c
> +++ b/compat/fsmonitor/fsm-listen-win32.c
> @@ -290,6 +290,10 @@ void fsm_listen__stop_async(struct fsmonitor_daemon_=
state *state)
>         SetEvent(state->listen_data->hListener[LISTENER_SHUTDOWN]);
>  }
>
> +void fsm_listen__flush_async(struct fsmonitor_daemon_state *state UNUSED=
)
> +{
> +}
> +
>  static struct one_watch *create_watch(const char *path)
>  {
>         struct one_watch *watch =3D NULL;
> diff --git a/compat/fsmonitor/fsm-listen.h b/compat/fsmonitor/fsm-listen.=
h
> index 41650bf897..cfeca1f4b6 100644
> --- a/compat/fsmonitor/fsm-listen.h
> +++ b/compat/fsmonitor/fsm-listen.h
> @@ -38,6 +38,12 @@ void fsm_listen__dtor(struct fsmonitor_daemon_state *s=
tate);
>   */
>  void fsm_listen__loop(struct fsmonitor_daemon_state *state);
>
> +/*
> + * Prompt the listener to deliver queued filesystem events, if supported=
.
> + * This does not wait for the events to be processed.
> + */
> +void fsm_listen__flush_async(struct fsmonitor_daemon_state *state);
> +
>  /*
>   * Gently request that the fsmonitor listener thread shutdown.
>   * It does not wait for it to stop.  The caller should do a JOIN
>
> ---
> base-commit: 5d2e7709234afea1b6ddb25cd4f60d3d5fb3c200
> change-id: 20260721-fsmonitor-darwin-cookie-flush-0f0d6e554a56
>

This patch is carefully designed to minimize any risks. To drain events,
we could also call FSEventStreamFlushSync before acquiring main_lock in
do_handle_client(), but this patch should be sufficient if it mitigates
the issue. The commit message would be much more convincing if you also
included benchmark results showing how many timeouts were reduced.

--
Koji Nakamaru
