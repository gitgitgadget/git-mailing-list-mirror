Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B1F45A2BA
	for <git@vger.kernel.org>; Tue, 21 Jul 2026 21:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784667908; cv=none; b=ep3RRYlTDVfZXs4B+cgSGdwFEwRUfSPp4ucjR17ZZaaZVhQTc4tmC2YRBsfyecIS14nzca0JqmKEhnw+0R2GrJqUPKV14pgmhM0IPoVJ15v2f6nS8k5MZT5u81PW3M2mIPsKA686IMdyiWAghuOEfkJpJDOzT3w5jjf/n2J82e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784667908; c=relaxed/simple;
	bh=RIvqhtlpLpgyeiaU/tzk4H4rTXgB2EhDBDH7Nu5xwUs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hBwdSM5R9VX0zddHodjfkIdJGzfjTx5+XyxyffNzLiTi4HGgTMjiCi9X20SVQUmeBIprnnmMqg5rRNkaf7f1S+30NN2NAFO87fT8hdISGBX0LFRA/QrEAPr0MEtTlrPb4xopWrntzaukLd86ELZD3Fxkhbbnh9IThRDB6bRs97k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XYgdDe9G; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYgdDe9G"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-92eafc94c9cso920619785a.0
        for <git@vger.kernel.org>; Tue, 21 Jul 2026 14:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784667902; x=1785272702; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VNfhdoox8y0Y/yMG3U9K9z75OjaveiS8PkwKpHxzjXk=;
        b=XYgdDe9GO3QGunBIm71K632HlvRbW8O60DZ256anhAIlna3E05sf8lrKm4Zd9UxcE/
         /Y6QJlciA7TyRVI3EyvtEmZuH+jo8Z104jsguDQMshv99jWEWzwrIvWGAroegKn7eLzi
         vEdgre4XDMj52RHPWCEvvNZfaOoBdmYtsnuYhlWAhvEukjA13PsU5ItGUlBW4UXa2Rc1
         x0D3feFI7gBaSU6ECq6+c6pP2J2CzZ1752oDOhOEpl12JzqoDymrXfh9IZXxcvBYwbaB
         YXcu3Sc407ZiUiwy+4cTs6Hi5t7bsr323srlgH/NzQUg+/1JD/4Hk8NrnZXh1NrUG+g1
         kBIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784667902; x=1785272702;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=VNfhdoox8y0Y/yMG3U9K9z75OjaveiS8PkwKpHxzjXk=;
        b=sKGJQNTO3rSMonGGWOqVY+PJbmZg1N2g1SpcxiVnpB6kRHgowaG11eVQMrMz2BJtiH
         wDUGymkxVprkQlclCK9dQAbJs3V1WRcN7cCgGPHTL7k0c0DHXttxjAKhaClIVzqBTL5O
         UI+hn8avUyll2ZQdGfystFkrFokiwQyozyMOdF4q0FK/sLrt2jOoEBa/MAjui3VU5EtN
         dq7K0eAaKRKYhu49L/GkwjjKOUBPdtrQe9Nj4O4z5RcKbMxNXiR8bSCMNFPBb/WEkgph
         Du/1PW6gkulbnV8gFB/PVp+OmUvDyOkUtoYGnWfAgvpzNgmu7XoqoPZE3rVQ3C2PGiYx
         m3pg==
X-Gm-Message-State: AOJu0Yzd6ycwDG+j8NWA9J2g4P8Ht00tCOqSEwJDCqeKSgWHRdEntIoc
	zEEIoCjjZEB1zwKT8TlHomN8Kmai/xvZk7RGLvlKtuF1FOw4Ul4bj9a5
X-Gm-Gg: AfdE7clHFlRR6qFC3YNQKFtsuU05cECaZ7M88ikknoohXWZZXByqp0HLkXr/uZ3nwJY
	Qwi6BWDUOIQdQO8/p9Dj58ykcevemcBFBvDSu/ONdsfofFGgxPBfmzdHbJ+ULbMbFeUVlOBJZHL
	PKOa5nxEPQNDQ8h0GioMvAGCTw+JgHiGNwwFHAPQcyx7ak+dxN6oAZkH/6Bo0phuIu7x758LXqz
	X/9K1VHO6RTfzEAJhjEPdpQnEi11ksrlRYhGXvojUkTVrIeKKfc7ksynX8wedVBgk+yLii7oTYI
	uAXT2sQFDXkC8/5DqJMkXZPvwgv1xoVZpRFnHqfQz7OS+hfOwt+fYTu9nJYBWdrN/eAGvOEZlSg
	KuoO1Zgh3AHiMoCKP8xW7gPYp7oFgz1Ipu2J4/GqvqnXSrc8w7U7BKl/dC6PHMDhmC3GyhgxbFp
	qWg9G7de7l+5JlJZQyNg7VGIuHB3AtAwz/k0iMGLCqv2zJhGcDC1wHaxwJxz5+Km6KDV/VIAWXc
	AZvArOyTTnIc6CErhjgrhHIDLra8A+lkW2itci2W7yuOA+jWlHVyocsW3KDBJNaA8FCjia6Fsxo
	BPnYGDNfCxBqlMFUxnCP0YBPmFJN7rk=
X-Received: by 2002:a05:620a:25d1:b0:92e:45e0:2588 with SMTP id af79cd13be357-930b416d13fmr2132795785a.55.1784667902254;
        Tue, 21 Jul 2026 14:05:02 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([208.80.35.36])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b549629dsm1190918785a.47.2026.07.21.14.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 14:05:01 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 21 Jul 2026 17:04:56 -0400
Subject: [PATCH] fsmonitor: flush pending FSEvents before cookie wait
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-fsmonitor-darwin-cookie-flush-v1-1-357dc5e32040@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMSw7CIBAA0Ks0s3YSSgQTr2JcIAx2/ICZabVJ0
 7sXdfk2bwElYVI4dgsIvVm5loZ+10EcQrkScmoGa6w3B9tj1mctPFbBFOTDBWOtdybMj0kHNNk
 kT87tg/PQjpdQ5vn3n85/63S5URy/KazrBiiICNWBAAAA
X-Change-ID: 20260721-fsmonitor-darwin-cookie-flush-0f0d6e554a56
To: git@vger.kernel.org
Cc: Jeff Hostetler <jeffhost@microsoft.com>, 
 Paul Tarjan <github@paulisageek.com>, Patrick Steinhardt <ps@pks.im>, 
 Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 Taylor Blau <me@ttaylorr.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Koji Nakamaru <koji.nakamaru@gree.net>, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1784667901; l=5170;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=RIvqhtlpLpgyeiaU/tzk4H4rTXgB2EhDBDH7Nu5xwUs=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QBLoP49Si8p2/DzXtoq7ks34DChYwjZOh1kab72K6MOYMpZLeKIM1w2DNBRZWt9bN4ciR7Tzpv4
 /fsLAw5YtiAg=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

56cef9cb1a (fsmonitor: use pthread_cond_timedwait for cookie wait,
2026-04-15) limits the cookie wait to one second so that a filesystem
which never delivers events cannot hang fsmonitor clients. A client that
times out receives a trivial response and scans the entire index.

FSEvents can defer delivery while it batches notifications and does not
guarantee that its queue is drained in one latency interval. A loaded
macOS system can therefore time out even though the event stream is
working.

On an Apple M4 Max (16 cores, 128 GiB RAM) running macOS 26.5.2, two
worktrees with a 1,001,178-entry index timed out 484 of 545 and 297 of
365 fsmonitor requests. One status call performed 934,519 lstat() calls
during a 47-second preload and took 52 seconds overall.

Ask FSEvents to flush pending notifications after creating the cookie
and before starting the timed wait. Use the asynchronous form because
the client handler holds main_lock, which the listener callback also
acquires. Keep the timeout and the behavior of the other backends
unchanged.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 builtin/fsmonitor--daemon.c          | 3 +++
 compat/fsmonitor/fsm-darwin-gcc.h    | 1 +
 compat/fsmonitor/fsm-listen-darwin.c | 5 +++++
 compat/fsmonitor/fsm-listen-linux.c  | 4 ++++
 compat/fsmonitor/fsm-listen-win32.c  | 4 ++++
 compat/fsmonitor/fsm-listen.h        | 6 ++++++
 6 files changed, 23 insertions(+)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 4161dd8282..8e32b5ae5e 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -206,6 +206,9 @@ static enum fsmonitor_cookie_item_result with_lock__wait_for_cookie(
 	close(fd);
 	unlink(cookie_pathname.buf);
 
+	/* The listener callback takes main_lock, so this must not block. */
+	fsm_listen__flush_async(state);
+
 	/*
 	 * Wait for the listener thread to observe the cookie file.
 	 * Time out after a short interval so that the client
diff --git a/compat/fsmonitor/fsm-darwin-gcc.h b/compat/fsmonitor/fsm-darwin-gcc.h
index 3496e29b3a..c209dc2f68 100644
--- a/compat/fsmonitor/fsm-darwin-gcc.h
+++ b/compat/fsmonitor/fsm-darwin-gcc.h
@@ -82,6 +82,7 @@ CFRunLoopRef CFRunLoopGetCurrent(void);
 extern CFStringRef kCFRunLoopDefaultMode;
 void FSEventStreamSetDispatchQueue(FSEventStreamRef stream, dispatch_queue_t q);
 unsigned char FSEventStreamStart(FSEventStreamRef stream);
+FSEventStreamEventId FSEventStreamFlushAsync(FSEventStreamRef stream);
 void FSEventStreamStop(FSEventStreamRef stream);
 void FSEventStreamInvalidate(FSEventStreamRef stream);
 void FSEventStreamRelease(FSEventStreamRef stream);
diff --git a/compat/fsmonitor/fsm-listen-darwin.c b/compat/fsmonitor/fsm-listen-darwin.c
index 43c3a915a0..64bee248d2 100644
--- a/compat/fsmonitor/fsm-listen-darwin.c
+++ b/compat/fsmonitor/fsm-listen-darwin.c
@@ -496,6 +496,11 @@ void fsm_listen__stop_async(struct fsmonitor_daemon_state *state)
 	pthread_mutex_unlock(&data->dq_lock);
 }
 
+void fsm_listen__flush_async(struct fsmonitor_daemon_state *state)
+{
+	FSEventStreamFlushAsync(state->listen_data->stream);
+}
+
 void fsm_listen__loop(struct fsmonitor_daemon_state *state)
 {
 	struct fsm_listen_data *data;
diff --git a/compat/fsmonitor/fsm-listen-linux.c b/compat/fsmonitor/fsm-listen-linux.c
index e3dca14b62..7aae29ea22 100644
--- a/compat/fsmonitor/fsm-listen-linux.c
+++ b/compat/fsmonitor/fsm-listen-linux.c
@@ -493,6 +493,10 @@ void fsm_listen__stop_async(struct fsmonitor_daemon_state *state)
 		state->listen_data->shutdown = SHUTDOWN_STOP;
 }
 
+void fsm_listen__flush_async(struct fsmonitor_daemon_state *state UNUSED)
+{
+}
+
 /*
  * Process a single inotify event and queue for publication.
  */
diff --git a/compat/fsmonitor/fsm-listen-win32.c b/compat/fsmonitor/fsm-listen-win32.c
index 9a6efc9bea..039d797000 100644
--- a/compat/fsmonitor/fsm-listen-win32.c
+++ b/compat/fsmonitor/fsm-listen-win32.c
@@ -290,6 +290,10 @@ void fsm_listen__stop_async(struct fsmonitor_daemon_state *state)
 	SetEvent(state->listen_data->hListener[LISTENER_SHUTDOWN]);
 }
 
+void fsm_listen__flush_async(struct fsmonitor_daemon_state *state UNUSED)
+{
+}
+
 static struct one_watch *create_watch(const char *path)
 {
 	struct one_watch *watch = NULL;
diff --git a/compat/fsmonitor/fsm-listen.h b/compat/fsmonitor/fsm-listen.h
index 41650bf897..cfeca1f4b6 100644
--- a/compat/fsmonitor/fsm-listen.h
+++ b/compat/fsmonitor/fsm-listen.h
@@ -38,6 +38,12 @@ void fsm_listen__dtor(struct fsmonitor_daemon_state *state);
  */
 void fsm_listen__loop(struct fsmonitor_daemon_state *state);
 
+/*
+ * Prompt the listener to deliver queued filesystem events, if supported.
+ * This does not wait for the events to be processed.
+ */
+void fsm_listen__flush_async(struct fsmonitor_daemon_state *state);
+
 /*
  * Gently request that the fsmonitor listener thread shutdown.
  * It does not wait for it to stop.  The caller should do a JOIN

---
base-commit: 5d2e7709234afea1b6ddb25cd4f60d3d5fb3c200
change-id: 20260721-fsmonitor-darwin-cookie-flush-0f0d6e554a56

