Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61F761F405
	for <e@80x24.org>; Thu, 20 Dec 2018 21:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732828AbeLTV6M (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 16:58:12 -0500
Received: from mail-it1-f202.google.com ([209.85.166.202]:35504 "EHLO
        mail-it1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730241AbeLTV6M (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 16:58:12 -0500
Received: by mail-it1-f202.google.com with SMTP id c128so3053040itc.0
        for <git@vger.kernel.org>; Thu, 20 Dec 2018 13:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to;
        bh=J6apux/r8SEYzMO3B4/TWnmcZEMke4VXlJmszSVuYOk=;
        b=UoFVmMoNQPKzAu1b/eOGLrwa2bG3qpTrurq0tVW8INQYY2wU8EYLNUqu3P2Pnc88GA
         P8eQu1Ca68Cijx0Rnxm8bh8wmX8EqJ0emszvzGxJbu1YcUJSR5nvvZK1ZUlb6qkDh0bh
         5EWy+NIFYMPK6UQCm0wKeNUQbl4HCx5Z1qcPxxmhhaQF9E5Fumjs65tcNB9h7jB63dYD
         XtvdWqvGzEOn59in6Tae/X9hIoraN64OCH8dDmTCw2u3zCvoq50ittpvgpN6A2DysSVK
         W4U7jxeVX1/sl+ubg8N7Bz34UgSm+CaLvp5SfNt935OZgpccWhHoqQhNh+zIXOo+/vvu
         owsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=J6apux/r8SEYzMO3B4/TWnmcZEMke4VXlJmszSVuYOk=;
        b=I/NX5H2ycrV9NWj9FSKmc5iSQYuXCXCjrXS4nxoC+Cbdc+t65uroi5fWuOOcua0aIT
         Z9J+tv92aUg9iizfJPE9wDXsniH8ij5ICVCvkNp0+f0d5JRfCKH3eEnLlCupQnAV4tOp
         zf4yd5cTSO8+cegM5MX7Kg6XqAh///6OxVur1mgMcE09e4nDKt5J5uQQUhdkLDj6XOpm
         K7yUM06BsoK5K5VN2cUDGfuyJaiWDUgWCDOtu8Ec2mePRUjj6PZxZlySM2f6JP1Ehbit
         Ce42oSe3KnIqfbHhtDgF5KL9I6Dug5oIe54VsGlCyxB7F+FADXF/kozEMNzFPBnpp4h9
         3Qlw==
X-Gm-Message-State: AJcUukcS8qXcD2imH9R6NuKkTHISoCC06bFRgcqGC/MrfAvsZo1ZsMzo
        LDvX1ZpOPTm8M/9Vp7kUMSC58GMfedv74sr3r028rj2NqVPgnFOgDdLG5a0MZAwiQ4SlNaj2CZR
        mHelqnK6fMQc+3nik0v+6wO2fCfVV9UeVlKaFW6wujJ8dhgw35aq+UWKc3zRCiRE=
X-Google-Smtp-Source: ALg8bN7+3apnjUVQiZUzwm1v4pzvyFCwiH815hnCUELZEGaXyOykDznHz7OEqHDEGPCcc80kbJgl4HU85ORZKg==
X-Received: by 2002:a24:ed8c:: with SMTP id r134mr316790ith.30.1545343090945;
 Thu, 20 Dec 2018 13:58:10 -0800 (PST)
Date:   Thu, 20 Dec 2018 13:58:07 -0800
In-Reply-To: <cover.1538516853.git.steadmon@google.com>
Message-Id: <cover.1545342797.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1538516853.git.steadmon@google.com>
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
Subject: [PATCH v6 0/1] Advertise multiple supported proto versions
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a registry of supported wire protocol versions that individual
commands can use to declare supported versions before contacting a
server. The client will then advertise all supported versions, while the
server will choose the first allowed version from the advertised
list.

Every command that acts as a client or server must now register its
supported protocol versions.

Changes since V4: remove special cases around advertising version=0.

Changes since V5: no code changes, but corrected and clarified commit
  message regarding changes around advertising version=0.

Josh Steadmon (1):
  protocol: advertise multiple supported versions

 builtin/archive.c           |   3 +
 builtin/clone.c             |   4 ++
 builtin/fetch-pack.c        |   4 ++
 builtin/fetch.c             |   5 ++
 builtin/ls-remote.c         |   5 ++
 builtin/pull.c              |   5 ++
 builtin/push.c              |   4 ++
 builtin/receive-pack.c      |   3 +
 builtin/send-pack.c         |   3 +
 builtin/upload-archive.c    |   3 +
 builtin/upload-pack.c       |   4 ++
 connect.c                   |  52 +++++++--------
 protocol.c                  | 122 +++++++++++++++++++++++++++++++++---
 protocol.h                  |  23 ++++++-
 remote-curl.c               |  27 +++++---
 t/t5551-http-fetch-smart.sh |   1 +
 t/t5570-git-daemon.sh       |   2 +-
 t/t5601-clone.sh            |  38 +++++------
 t/t5700-protocol-v1.sh      |   8 +--
 t/t5702-protocol-v2.sh      |  16 +++--
 transport-helper.c          |   6 ++
 21 files changed, 256 insertions(+), 82 deletions(-)

Range-diff against v5:
1:  60f6f2fbd8 ! 1:  10039ca163 protocol: advertise multiple supported versions
    @@ -22,10 +22,12 @@
         select the first allowed version from this advertisement.
     
         Additionally, remove special cases around advertising version=0.
    -    Previously we avoided adding version negotiation fields in server
    -    responses if it looked like the client wanted v0. However, including
    -    these fields does not change behavior, so it's better to have simpler
    -    code.
    +    Previously we avoided adding version advertisements to the client's
    +    initial connection request if the client wanted version=0. However,
    +    including these advertisements does not change the version negotiation
    +    behavior, so it's better to have simpler code. As a side effect, this
    +    means that client operations over SSH will always include a
    +    "SendEnv=GIT_PROTOCOL" option on the SSH command line.
     
         While we're at it, remove unnecessary externs from function declarations
         in protocol.h.
-- 
2.20.1.415.g653613c723-goog

