Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793822003;
	b=45zZv2jGNZDPDXuxKiYvUpbMraxyr64xBrIxT2gDbc965iuxVGriH5/rdCMHWuMsQvSI
	 bMbh0d5A0UT0PlM/EdgVPa5ZLSmUilYlsfpDkCFxsgQ2hu6W/2SUaKRK3S2n3eONp0aPV
	 E/lyqU9ePX0FFFX1URbyx30aidqQf4By6E2RosrohMD2MKR/HzT8hUkr2E+psp8Av8bmd
	 obEVVkzF1OnQeggdWQvkGLwVSI+J/RR7/UqdvaemB+GHgwbo8ACbsLE3i35ETR42q/JFx
	 Xt/oRwbhuiub917HeJTga8cY73i0lxvJD+cJhT2ldLX5tnVveXkTK/vLcGub5PcgEoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793822003;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:In-Reply-To:References:To:Cc:X-Mailer;
	bh=Cem9dF+FnQarrJeyoqf6WVpBDEAFIxmWWNzqBKO08BE=;
	b=05lDF4YDRw0eqV7MOWuOBmVvA/ofFLVIyq76JXtBmAgLnzXmPigCIts5BElapmSis667
	 gKjaI6hyFI6yx+gQKycOA3U1+++RqSjrCUQ9Fftrm61qVhk5t0IJ5XREsTQIk8s4kJdwQ
	 GJLKq/i0celpOQRxGJMDddQc1yZIYn4NkInDYhzsgWW/Q94lRfddkDoN1ezPXWx/XJkuu
	 ORVXsRJRFNQdaK32nUVtdbDVSzkajADjU8u/HXBESGIIm3ObUvhsnqJ6T57dM3G259ysR
	 1NBIOmJrgJnHQEUQr2G/WSc1NJJyxyUakaRmof1Sxmq/Dj5tDS0NqiUP0GK5xpQQuXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H3gMGAbK;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D1B6097332
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 19:53:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97D1B6097332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H3gMGAbK
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-36661f953e4so1532233eec.1
        for <git@vger.kernel.org>; Wed, 04 Nov 2026 11:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793822002; x=1794426802; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:content-type
         :mime-version:message-id:date:subject:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Cem9dF+FnQarrJeyoqf6WVpBDEAFIxmWWNzqBKO08BE=;
        b=H3gMGAbKt1G+E7Uvmop453BsR9dFj18ar6sInnwC9AckH5lH9Mtnl5T7xk2mMAEmUQ
         S5yVMMLHZXt1rQF45SOvKnbSvoGXhhOKAAgajyw5fsbopmlRFEwJfM5Vx3W1WmjSQ3I0
         SqUFZxsasnISXOIuJolUvwAFdmUJUflgFsWf3vl3dVMnoxuL0Zv14AS7kzCpF8qoMWRP
         7KcdSqk7OSRDPwEIKN7SgjUWueGKViQz7Ndg/j4bmpueoUFyAUhwNvyUvw+9BBp9tAdT
         qAxrwE3gs1iff2N6hNi8BtfIcTc/xs12oxBPDyp7d09b84T8EXy//KoaNObr1kj0cU9v
         G60w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793822002; x=1794426802;
        h=cc:to:references:in-reply-to:content-transfer-encoding:content-type
         :mime-version:message-id:date:subject:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cem9dF+FnQarrJeyoqf6WVpBDEAFIxmWWNzqBKO08BE=;
        b=a40hLtqoIDXqIwRuD7P33O52VTMfPmOv0wBatiVhOfw/gd4s8DBQyPDIXl3oh4Wgmx
         Y4CESZd9Mkeo9uI2ISfcPRYZMxYrUmI04hp0Ei+erggI0Q6RcBDbdk9hK6iHEnXdB/pi
         vqUkvMG8Zs1yH2AQdEGVs1pylsrNRdCMKqICORAfvHKSMKVCt8DEE/ek3FWgLO6vSZ/G
         QGwXL5MIHvjLJwlkbv7vhCzouvJYhqKuwt7kwo57QCLtr/5aFGHWkbilZS8yKgrFXIGC
         rME4eWvwaqkYFqmLpQPTWWyLDKbAZsFEWINVcF28kZTS//nJr4O/ZiXtIoGov8YyJFWq
         d0+Q==
X-Gm-Message-State: APuU4Z8dXZZ211CaN9XaUPH3mJjV4JmP3s5Y7HzTan5dtbuQrE97HXUk
	WrtoYN6QiXMLbWb+VruKWxOTO9DPAx2fY/WvKNbIzxXmHdIQlCiUNTX1
X-Gm-Gg: AYBFou0RrMsMS5OKHx7jBiQJJKV/5Jzrdlw/eSJ9vhk8jd6wfq31Bfm5LlgpAe7U40u
	QHpbsyKfG3B8BijKrMOTb7bsb7LPSzc9q35G8DUmFmjpWWKlvGCx0Qtr8qy9CTMbYcx9zvXJ/cE
	Y2PzHITonHU4li4b0fH6vkzLI15dOQVjmT+eqsz3ZMeYV8YZFbhMWus+xMKO5KWUf6qKzb3ZxBC
	VCrqi5iHZDK/EAlrIpxb3teZ3S5z/VYZ5ACZ/GyQlBmoU2u/oYH0AWVSvGh1k52vhStqEgnc+WK
	LUlCndG+/yiDLyP1nM6zk0/RQ6AvkWWgolO9ZIXoeKvscFCgEXDFfsRvF/0QbH2ujGosHd59La0
	C5FYCxaqIUK2pJKo3CfdHOBpU9z8hEesdzJm93g5rTqh0l6EcMZ41UL9Ll90DLa+N2HSZa0jAlG
	x3/+fzSsW8qDJBq5gNMx06a/Evq7yLegfXvkD9i0x1qqqFhuZ1kruFlJsqpE7zHfkNR1SEy/DiO
	4RfvpKY26yb7NF/HFX4/MqDa/9jAJbihe76Hm+cKKhPguHNNhR3HW4HxpE6+FiMsWke9gU5ExD9
	sMJHaXS6G7jJihyvjAlxa7PS0TIiVsfQ9OQ=
X-Received: by 2002:a05:7301:4702:b0:359:3460:bc1c with SMTP id 5a478bee46e88-36a42330c65mr23356600eec.12.1793822001437;
        Wed, 04 Nov 2026 11:53:21 -0800 (PST)
Received: from [127.0.0.2] ([73.222.46.22])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca3788bffsm9598670eec.1.2026.11.04.11.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 11:53:20 -0800 (PST)
From: Farid Zakaria <farid.m.zakaria@gmail.com>
Subject: [PATCH v2 0/3] credential-cache: fix two races when daemons start
 at once
Date: Wed, 04 Nov 2026 11:53:13 -0800
Message-Id: <20261104-fz-credential-cache-race-v2-0-ddccd0831eba@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NSw6CQBAFr0J6bZvpCRDjynsYFkPTQBs+ZgaIS
 ri7A17AZSX16q0QxKsEuCYreFk06DhEsKcEuHVDI6hVZLDG5kSGsP4ge6lkmNR1yI5bQe9YMM1
 MGg3OU8ogzp9ean0d6Xvx4zCXD+Fp7+1Gq2Ea/fv4Xmj3/rhZCA3aS21KxxkJ0a3pnXZnHnsot
 m37Amg9i83SAAAA
X-Change-ID: 20261101-fz-credential-cache-race-4504110c6415
In-Reply-To: <20261101-fz-credential-cache-race-v1-0-28f0bac51e11@gmail.com>
References: <20261101-fz-credential-cache-race-v1-0-28f0bac51e11@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 Patrick Steinhardt <ps@pks.im>, M Hickford <mirth.hickford@gmail.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Jeff Hostetler <jeffhostetler@github.com>, 
 Farid Zakaria <farid.m.zakaria@gmail.com>
X-Mailer: b4 0.15.2

When no credential-cache daemon is running, two "git credential-cache
store" which run at the same time each try to start a daemon.

The second daemon unlinks the first one's socket and binds its own,
which means any credential stored by the first one is lost.

By products of this race:
  - "git credential-cache get" does not return that credential;
  - "git credential-cache exit" stops only the second daemon, and the
   first keeps the password in memory until it expires;
  - when the first daemon exits, its tempfile handler removes
   the socket of the second daemon, whose credentials are then lost
   too.

This can happen whenever two git commands store a password at the
same moment, for example parallel submodule fetches over HTTPS.

I found this with Rewind [1], a deterministic VM I am building that
replays a program under many thread schedules until one fails. 

Context from some history spelunking with an AI:
  Jeff noted in 2021 that the daemon's socket setup is racy [2], and
  expected the worst case to be a daemon that waits 30 seconds for data
  before it exits. That holds only if the losing daemon gets no
  credential, but its own client stores one right after it starts.

[1] https://rewindvm.dev/
[2] https://lore.kernel.org/git/YCK5K%2FnK4tGnTvou@coredump.intra.peff.net/

---
Changes in v2:
- New patch 1: create the socket's leading directories with
  safe_create_leading_directories_no_share_const(), so that
  "core.sharedRepository" does not apply to them (Patrick).
- Patch 2: explain in the commit message why a directory created by
  another daemon can be trusted (Peff).
- Patch 3: explain in a comment why a daemon that finds another one
  listening still prints "ok", and exit(0) there (Patrick, Peff).
  Drop comments that only restated the code (Patrick).
- Reword commit messages in the imperative mood (Patrick).
- Not changed: the socket is still removed at exit through the
  tempfile API, which unlinks it without the unix_ss_was_stolen().
  There was a discussion with Junio about this. I can do that if it's
  a requirement in a V3.
- Link to v1: https://patch.msgid.link/20261101-fz-credential-cache-race-v1-0-28f0bac51e11@gmail.com

---
Farid Zakaria (3):
      credential-cache--daemon: do not apply core.sharedRepository
      credential-cache--daemon: allow a concurrently created socket dir
      credential-cache--daemon: do not take over a running daemon's socket

 builtin/credential-cache--daemon.c | 44 ++++++++++++++++++++++++++++----------
 t/t0301-credential-cache.sh        | 23 ++++++++++++++++++++
 2 files changed, 56 insertions(+), 11 deletions(-)

Range-diff versus v1:

-:  ---------- > 1:  b2b02dd510 credential-cache--daemon: do not apply core.sharedRepository
1:  5137f72936 ! 2:  e2310083cd credential-cache--daemon: allow a concurrently created socket dir
    @@ Commit message
     
         That client then fails with "cache daemon did not start".
     
    -    The fix is to ignore EEXIST from mkdir(), and check the directory's
    -    permissions the same way as for one that already existed.
    +    Fix this by ignoring EEXIST from mkdir(), and checking the directory's
    +    permissions the same way as for one that already existed. We create
    +    the directory with mode 0700 instead of fixing it up with chmod()
    +    afterwards to avoid a race where another user enters it before the
    +    chmod(). A directory created by another daemon was made the same way,
    +    so trusting it once its permissions check out is as safe as trusting
    +    one that existed before we started.
     
         Signed-off-by: Farid Zakaria <farid.m.zakaria@gmail.com>
     
      ## builtin/credential-cache--daemon.c ##
     @@ builtin/credential-cache--daemon.c: static void init_socket_directory(const char *path)
      		 */
    - 		if (safe_create_leading_directories_const(the_repository, dir) < 0)
    + 		if (safe_create_leading_directories_no_share_const(dir) < 0)
      			die_errno("unable to create directories for '%s'", dir);
     -		if (mkdir(dir, 0700) < 0)
     -			die_errno("unable to mkdir '%s'", dir);
2:  0e13ea044c ! 3:  54bc9bd3df credential-cache--daemon: do not take over a running daemon's socket
    @@ Commit message
          - when it does exit, it removes the socket of the daemon that is
            still running, losing that daemon's credentials too.
     
    -    The fix is to create the socket with unix_ss_create(), which the
    +    Fix this by creating the socket with unix_ss_create(), which the
         simple-ipc server already uses. It takes a lock and binds only if no
    -    other server is listening on the socket. A daemon that finds one prints
    -    "ok" and exits, and its client talks to the running daemon. Register
    -    the socket for removal only after binding it, so a daemon that loses
    -    never removes the other one's socket.
    +    other server is listening on the socket. The lock is held only while
    +    binding, so a stale lockfile left behind by a crashed daemon is
    +    unlikely to need manual cleanup.
     
         Signed-off-by: Farid Zakaria <farid.m.zakaria@gmail.com>
     
    @@ builtin/credential-cache--daemon.c: static int serve_cache_loop(int fd)
      
     -	fd = unix_stream_listen(socket_path, &opts);
     -	if (fd < 0)
    -+	/*
    -+	 * Two clients may each start a daemon at the same time. Bind only
    -+	 * if no other daemon is listening yet; otherwise leave the socket
    -+	 * to that one, and our client will talk to it.
    -+	 */
     +	ret = unix_ss_create(socket_path, &opts, -1, &server_socket);
     +	if (ret == -2) {
    ++		/*
    ++		 * Another daemon is already listening on the socket. "ok"
    ++		 * tells our client that a daemon is ready, after which the
    ++		 * client connects to the socket and talks to that daemon.
    ++		 */
     +		printf("ok\n");
    -+		return;
    ++		exit(0);
     +	}
     +	if (ret < 0)
      		die_errno("unable to bind to '%s'", socket_path);
      
    -+	/* Remove the socket at exit only now that it is ours. */
     +	socket_file = register_tempfile(socket_path);
     +
      	printf("ok\n");

---
base-commit: 50fe5cc63f9cd6e89b87a2c9ccf96a444f4cfdb7
change-id: 20261101-fz-credential-cache-race-4504110c6415

