Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 499DC20248
	for <e@80x24.org>; Sat, 23 Feb 2019 23:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbfBWXjF (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Feb 2019 18:39:05 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:34581 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbfBWXjF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Feb 2019 18:39:05 -0500
Received: by mail-pl1-f201.google.com with SMTP id s16so4443374plr.1
        for <git@vger.kernel.org>; Sat, 23 Feb 2019 15:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=QZz1zDYwaY8FzSXezD4hGcTeCBDXw2PvDHXk7hNU/dY=;
        b=LDkHB77TaRAcixXlpNBGnfr6BWfgXbroskn0zXWV2nanhl1RNVpruo2uL2cJn4HNRU
         0ocC4k/TrxRcTT6vlNVdhngsRprv6sBBOMkiG7lJAQeSppV6HdmCk0IlW2u4S1Xt+KIj
         tl8jkGKZiBc2Yea4wwr8WUOXPVce6CIO1L+UU2BCfYBRLuHYOPnCBf7h/doTxXe00feq
         gsnehQc/b/sSZPXm5FDpnZUbUIqqwJ7q/UmG5xQ4q/Y++oeoah4PwQWRm8WrGXsi+NtG
         scjz9X2mA5S+Gbh+OsWimfJZHZj7OykszMmfRRNmv7YU6QBcLG0Zzx4kxitqLLJ3xSwX
         YKDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=QZz1zDYwaY8FzSXezD4hGcTeCBDXw2PvDHXk7hNU/dY=;
        b=kF7W4M9pqRpeZDP4ABlCU34JyCbABpj9WCx0nqSNvyoPg3o3gHsUp+S0Ze32RZmBCv
         rgNnKoHiVn+FYoVB8lI/LWC/q1xY4P/zUH7XW6jJMZvLvu/1Oaroq9B8xNxF9EfA/hI+
         uzpt/YNtsjMQa3oIleK/DLRy0kS4/RKkECTGjSIcIOtbZH1oWH/Y475+OpGU55OTN9+I
         Ow4FI8KoItwWQdyoZzWd/o34MuOzKWHGCFhFVYT9PcFJkcflolnKDGGqnmuP0mlVqDC1
         +nhBcoYvteYmGGe0y0P8o6DZyjOIRWXYcYZaEF33z/slPyKGYQ3l5u2nKz6FMzGagqLo
         BpRg==
X-Gm-Message-State: AHQUAubrubqsquwjQlE7geG6JMDTQnOiPc2dBTkUwEIxnng0I1WD8vRA
        yiPJhWdbw/K2RlGfOWXDHB9Wg43x5kk7L6HSgr6kCq7X1C/KCSnB50YU0eoJqm8i5I3dzeDlUu1
        keo+1c3gKq0lCRKBIUikAZc0ICE27xzx8XmFGW07juGX82QsgZiQ3etckAW1riueB7YZZN447YL
        4o
X-Google-Smtp-Source: AHgI3IYtSyM2O5dXcRQrdjHlqlh115fmQBMdOi1a8Zy5/JUW8JhZFNKykkvNYMr8msundEz88aHrOAgeklBg/Xt/rRi0
X-Received: by 2002:a17:902:7b87:: with SMTP id w7mr3435868pll.43.1550965144209;
 Sat, 23 Feb 2019 15:39:04 -0800 (PST)
Date:   Sat, 23 Feb 2019 15:38:54 -0800
Message-Id: <cover.1550963965.git.jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [WIP 0/7] CDN offloading of fetch response
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        peff@peff.net, christian.couder@gmail.com, avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's been a while, so here is an updated version of what I previously
sent [1]. The main difference is that fetch-pack now actually downloads
whatever the server tells it to. The second main difference is that
we no longer buffer progress messages and suspend keepalives - we
no longer need to, because the sideband-all patches have been merged.

I think I've address all the technical comments in [1], except one
comment of Junio's [2] that I still don't understand:

> And the "fix" I was alluding to was to update that "else" clause to
> make it a no-op that keeps os->used non-zero, which would not call
> send-client-data.
>
> When that fix happens, the part that early in the function this
> patch added "now we know we will call send-client-data, so let's say
> 'here comes packdata' unless we have already said that" is making
> the decision too early.  Depending on the value of os->used when we
> enter the code and the number of bytes xread() reads from the
> upstream, we might not call send-client-data yet (namely, when we
> have no buffered data and we happened to get only one byte).

With or without this fix, I don't think there is ever a time when we
say "here comes packdata" without calling send-client-data - we say
"here comes packdata" only when we see the string "PACK", which forms
part of the packfile, and thus we should have no problem sending any
client data. Having said that, maybe this is a moot point - Junio says
that this only happens when the fix is implemented, and the fix is not
implemented.

There are probably some more design discussions to be had:

 - Requirement that all pointed-to CDNs support byte ranges for
   resumability, and to guarantee that the packfiles will be there
   permanently. After some thought, it is a good idea for CDNs to
   support that, but I think that we should support CDNs that can only
   give temporal guarantees (e.g. if/when we start implementing
   resumption, we could read the Cache headers). I didn't add any
   mention of this issue in the documentation.

 - Client-side whitelist of protocol and hostnames. I've implemented
   whitelist of protocol, but not hostnames.

 - Any sort of follow-up fetch - for example, if the download from the
   CDN fails or if we allow the server to tell us of best-effort
   packfiles (but the client still must check and formulate the correct
   request to the server to fetch the rest). This protocol seems like a
   prerequisite to all those, and is independently useful, so maybe all
   of those can be future work.

Please take a look. Feel free to comment on anything, but I prefer
comments on the major things first (e.g. my usage of a separate process
(http-fetch) to fetch packfiles, since as far as I know, Git doesn't
link to libcurl; any of the design decisions I described above). I know
that there are some implementation details that could be improved (e.g.
parallelization of the CDN downloads, starting CDN downloads *after*
closing the first HTTP request, holding on to the .keep locks until
after the refs are set), but will work on those once the overall design
is more or less finalized.

Note that the first patch is exactly the same as one I've previously
sent [3].

[1] https://public-inbox.org/git/cover.1543879256.git.jonathantanmy@google.com/
[2] https://public-inbox.org/git/xmqqmupi89ub.fsf@gitster-ct.c.googlers.com/
[3] https://public-inbox.org/git/20190221001447.124088-1-jonathantanmy@google.com/

Jonathan Tan (7):
  http: use --stdin and --keep when downloading pack
  http: improve documentation of http_pack_request
  http-fetch: support fetching packfiles by URL
  Documentation: order protocol v2 sections
  Documentation: add Packfile URIs design doc
  upload-pack: refactor reading of pack-objects out
  upload-pack: send part of packfile response as uri

 Documentation/git-http-fetch.txt         |   7 +-
 Documentation/technical/packfile-uri.txt |  79 ++++++++++++
 Documentation/technical/protocol-v2.txt  |  22 ++--
 builtin/pack-objects.c                   |  63 +++++++++
 fetch-pack.c                             |  58 +++++++++
 http-fetch.c                             |  65 ++++++++--
 http-push.c                              |   7 +-
 http-walker.c                            |   5 +-
 http.c                                   |  83 +++++++-----
 http.h                                   |  26 +++-
 t/t5550-http-fetch-dumb.sh               |  18 +++
 t/t5702-protocol-v2.sh                   |  54 ++++++++
 upload-pack.c                            | 155 +++++++++++++++++------
 13 files changed, 542 insertions(+), 100 deletions(-)
 create mode 100644 Documentation/technical/packfile-uri.txt

-- 
2.19.0.271.gfe8321ec05.dirty

