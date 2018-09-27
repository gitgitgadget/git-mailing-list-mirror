Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B3221F453
	for <e@80x24.org>; Thu, 27 Sep 2018 01:25:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbeI0HlH (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 03:41:07 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:53767 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726588AbeI0HlH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 03:41:07 -0400
Received: by mail-qt1-f202.google.com with SMTP id d18-v6so853621qtj.20
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 18:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1eCpGBRWo0CGldhA/Ul7x3aFgYPMP2yuDVFp8a1e2GE=;
        b=plOBpCMK39ODeVpPLdYAtH0sCJniRSZWxFc7kcpEszcMIJjGcj34jOoEKT+ZS/UUq5
         IIqezMGn4KPFtxdK2kYKdoTW7YdvukbvsyFo+o2YLqshvfnzTfnwjCs/hwPgwG5zluKV
         JYfoIlStC4okgL3Ygxwij5cF//EoTvId1p648o7ifGyx7T79xv4UwTM5Fyao6ORTL5HH
         g6XdP2xf77AwUnDi6NpWKV10KnqPj4zoWnXCZFJoibyvMF41GKiBiqmF2v8My79jmI16
         3sZrznCKZsnW23+J00Z7KwbBW3QYHWBSYrb3rC7QTCvBUCbh9Bdzs2fQejko2WGHyE4R
         +zNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1eCpGBRWo0CGldhA/Ul7x3aFgYPMP2yuDVFp8a1e2GE=;
        b=HvaJJaaMgY5pJJbYDXDKxG+Mrp8hJnh1LMP47NTXxA5SVJpZhEdymjtEBwszruXGkX
         dA9A4AqADQoJQBoyjOvijZBRyyrQ1w0zjVQomGjbsa52WQ0Fxzu5KIv8JUvVaKHMJBaH
         HHH+U7Pd+WUjb9lrU3gJoFdE4do4bEGHjs1vQX+oUyM9BA5IAB++bBeELCRpvNL2cB3b
         Bf4kZOoACAv8W2n+K+yZT/tJcNQRpK5OCg/B9kMLF2KL/2SPdZw4QxBcV4c3FxzSnbXZ
         yJPqOTd3DRCNGgVUeP6iPBWuKbtaMMJLXsM5Wrk6ewPF0yhHWN/vy7oJXTxGkUhgU0J1
         6GnQ==
X-Gm-Message-State: ABuFfogKdhAo05EO0rGqgxxU/2aUeLHxO4xEyRYj0Fsvu92Re0YiDDV0
        UjojSucM/LSkDg5qLIcdo3n8XUhESsSjmsUYMYJQ/D58SH2KE/9BI9ArrJ503Y3VKCN3+cAz3YE
        CZrULsY+GUoddEa1lDIBWr00q3U8ii6I8v3ENC06mtMQR6YFVaTyWn0/fzKzcPXs=
X-Google-Smtp-Source: ACcGV638zB/PowHsqHAZFSqR3JHq1J3wLbcyh+x8L0wms4l/WVoqyfuCScAw9nn67dCLAhDm9LdkkP/9Unhl0Q==
X-Received: by 2002:ae9:ef96:: with SMTP id d144-v6mr3430505qkg.12.1538011523418;
 Wed, 26 Sep 2018 18:25:23 -0700 (PDT)
Date:   Wed, 26 Sep 2018 18:24:51 -0700
In-Reply-To: <20180912053519.31085-1-steadmon@google.com>
Message-Id: <20180927012455.234876-1-steadmon@google.com>
Mime-Version: 1.0
References: <20180912053519.31085-1-steadmon@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH v2 0/4] Add proto v2 archive command with HTTP support
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the second version of my series to add a new protocol v2 command
for archiving, with support for HTTP(S).

NEEDSWORK: a server built with this series is not backwards-compatible
with clients that set GIT_PROTOCOL=version=2 or configure
protocol.version=2. The old client will unconditionally send "argument
..." packet lines, which breaks the server's expectations of a
"command=archive" request, while the server's capability advertisement
in turn breaks the clients expectation of either an ACK or NACK.

I've been discussing workarounds for this with Jonathan Nieder, but
please let me know if you have any suggestions for v3 of this series.


Josh Steadmon (4):
  archive: follow test standards around assertions
  archive: use packet_reader for communications
  archive: implement protocol v2 archive command
  archive: allow archive over HTTP(S) with proto v2

 Documentation/technical/protocol-v2.txt | 21 ++++++++-
 builtin/archive.c                       | 58 +++++++++++++++++++------
 builtin/upload-archive.c                | 27 ++++++++++--
 http-backend.c                          | 13 +++++-
 serve.c                                 |  7 +++
 t/t5000-tar-tree.sh                     | 33 +++++++-------
 t/t5701-git-serve.sh                    |  1 +
 transport-helper.c                      |  7 +--
 8 files changed, 130 insertions(+), 37 deletions(-)

Range-diff against v1:
-:  ---------- > 1:  c2e371ad24 archive: follow test standards around assertions
1:  b514184273 ! 2:  a65f73f627 archive: use packet_reader for communications
    @@ -6,7 +6,10 @@
         handling, which will make implementation of protocol v2 support in
         git-archive easier.
     
    +    This refactoring does not change the behavior of "git archive".
    +
         Signed-off-by: Josh Steadmon <steadmon@google.com>
    +    Reviewed-by: Stefan Beller <sbeller@google.com>
     
      diff --git a/builtin/archive.c b/builtin/archive.c
    @@ -42,24 +45,24 @@
     -	if (!buf)
     +	status = packet_reader_read(&reader);
     +
    -+	if (status == PACKET_READ_FLUSH)
    ++	if (status != PACKET_READ_NORMAL || reader.pktlen <= 0)
      		die(_("git archive: expected ACK/NAK, got a flush packet"));
     -	if (strcmp(buf, "ACK")) {
     -		if (starts_with(buf, "NACK "))
     -			die(_("git archive: NACK %s"), buf + 5);
     -		if (starts_with(buf, "ERR "))
     -			die(_("remote error: %s"), buf + 4);
    -+	if (strcmp(reader.buffer, "ACK")) {
    -+		if (starts_with(reader.buffer, "NACK "))
    -+			die(_("git archive: NACK %s"), reader.buffer + 5);
    -+		if (starts_with(reader.buffer, "ERR "))
    -+			die(_("remote error: %s"), reader.buffer + 4);
    ++	if (strcmp(reader.line, "ACK")) {
    ++		if (starts_with(reader.line, "NACK "))
    ++			die(_("git archive: NACK %s"), reader.line + 5);
    ++		if (starts_with(reader.line, "ERR "))
    ++			die(_("remote error: %s"), reader.line + 4);
      		die(_("git archive: protocol error"));
      	}
      
     -	if (packet_read_line(fd[0], NULL))
     +	status = packet_reader_read(&reader);
    -+	if (status != PACKET_READ_FLUSH)
    ++	if (status == PACKET_READ_NORMAL && reader.pktlen > 0)
      		die(_("git archive: expected a flush"));
      
      	/* Now, start reading from fd[0] and spit it out to stdout */
2:  1518c15dc1 < -:  ---------- archive: implement protocol v2 archive command
-:  ---------- > 3:  0a8cc5e331 archive: implement protocol v2 archive command
3:  1b7ad8d8f6 ! 4:  97a1424f32 archive: allow archive over HTTP(S) with proto v2
    @@ -10,16 +10,20 @@
      +++ b/builtin/archive.c
     @@
      		status = packet_reader_read(&reader);
    - 		if (status != PACKET_READ_FLUSH)
    + 		if (status == PACKET_READ_NORMAL && reader.pktlen > 0)
      			die(_("git archive: expected a flush"));
     -	}
     +	} else if (version == protocol_v2 &&
    -+		   starts_with(transport->url, "http"))
    ++		   (starts_with(transport->url, "http://") ||
    ++		    starts_with(transport->url, "https://")))
     +		/*
     +		 * Commands over HTTP require two requests, so there's an
    -+		 * additional server response to parse.
    ++		 * additional server response to parse. We do only basic sanity
    ++		 * checking here that the versions presented match across
    ++		 * requests.
     +		 */
    -+		discover_version(&reader);
    ++		if (version != discover_version(&reader))
    ++			die(_("git archive: received different protocol versions in subsequent requests"));
      
      	/* Now, start reading from fd[0] and spit it out to stdout */
      	rv = recv_sideband("archive", fd[0], 1);
    @@ -40,7 +44,10 @@
      	struct strbuf buf = STRBUF_INIT;
      
     +	if (!strcmp(service_name, "git-upload-archive")) {
    -+		/* git-upload-archive doesn't need --stateless-rpc */
    ++		/*
    ++		 * git-upload-archive doesn't need --stateless-rpc, because it
    ++		 * always handles only a single request.
    ++		 */
     +		argv[1] = ".";
     +		argv[2] = NULL;
     +	}
    @@ -63,10 +70,12 @@
      --- a/transport-helper.c
      +++ b/transport-helper.c
     @@
    + 		strbuf_addf(&cmdbuf, "connect %s\n", name);
      		ret = run_connect(transport, &cmdbuf);
      	} else if (data->stateless_connect &&
    - 		   (get_protocol_version_config() == protocol_v2) &&
    +-		   (get_protocol_version_config() == protocol_v2) &&
     -		   !strcmp("git-upload-pack", name)) {
    ++		   get_protocol_version_config() == protocol_v2 &&
     +		   (!strcmp("git-upload-pack", name) ||
     +		    !strcmp("git-upload-archive", name))) {
      		strbuf_addf(&cmdbuf, "stateless-connect %s\n", name);
-- 
2.19.0.605.g01d371f741-goog

