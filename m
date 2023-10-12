Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0716CDB46E
	for <git@archiver.kernel.org>; Thu, 12 Oct 2023 06:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377518AbjJLG5Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Oct 2023 02:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347080AbjJLG5X (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2023 02:57:23 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A44A94
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 23:57:22 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40666aa674fso6687665e9.0
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 23:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697093841; x=1697698641; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wCWGuQd8NL5wdJiH4y+8lxiohdKBvk/KAw5ZD0HC3z0=;
        b=cuEOzkcfOQnZk2YCjtzosbdetot0uFYD8TTqJNGCVb8H2Yqr/+/rd5rqFc5IAj/MUZ
         iENAhSqhh8KA3sb/pTlkpEe8DBgkPT4R/W+mUp0lcWWi0mxYocfcVBpIX7UhdQmqKvZR
         cuFMq0AFPitP4EF5fKGZBnIPuG3FWknpXIa8Q9+hGLgp906PwxknnES0fYoj/c6X4jcA
         8rtFqQjQJPTS3ESmwP3ily5mt7GXBlsIIsmQEeo+FuJH+FkguuarIunrepOa7yt1EaB4
         pDUo1uJwiPCM4uxHJMffkNy6CTMXJicQS5QVeyjInG9N4sRM+Y+zmEnCxODbgOfF8J1w
         ygpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697093841; x=1697698641;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wCWGuQd8NL5wdJiH4y+8lxiohdKBvk/KAw5ZD0HC3z0=;
        b=dqeb/lMHV+lNjakkPXrXzulsGx0kbxaKH/lqsOlvnq2/I/jVKZN8HdjdKNztRWS2ZW
         kZj/0fOrWMRS3EoNFNnPByOPnOWYX2Eu6/2Jvtj+9ghWgrFO2w0eyOwlgr/R2wCSo+iT
         MWJ0JOHoSa4PGLIE7rgi0/1vwJU2rYfD43LU74QafxxsRVd419BrBbyqE8dnE5ojKg/u
         OgAP6PsZrqLoEwSlL9XgU5z/WFL1GMMRUBAAGPGVB6KL0H/Wpj72xLlrRs43eJrFBOpD
         eD5Es6yNMfps8+SmQR+bgQaOQCd7xqWTLndSF3YwLN4VagYOJm9rEgFEQl5e/mcpOsNh
         bm2g==
X-Gm-Message-State: AOJu0YyJvPpz7xzMvNpJ7y/r0mcwvdwTTH/UztBAHWFwtg6Njo1gWNES
        Dl9ouFxae4WTVOx/orp9FpK8hY6TsUFR
X-Google-Smtp-Source: AGHT+IFRvZDHVON+5V7uupEgzGsamKPNLAsWX/Xi87K18qE+eqtK5eWfV11XtxgAqWGgxtChff0eiw==
X-Received: by 2002:a1c:7212:0:b0:401:bdd7:499d with SMTP id n18-20020a1c7212000000b00401bdd7499dmr21138709wmc.25.1697093840667;
        Wed, 11 Oct 2023 23:57:20 -0700 (PDT)
Received: from dorcaslitunya-virtual-machine ([105.163.2.146])
        by smtp.gmail.com with ESMTPSA id v6-20020adff686000000b0031980294e9fsm17252497wrp.116.2023.10.11.23.57.19
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 23:57:20 -0700 (PDT)
Date:   Thu, 12 Oct 2023 09:57:17 +0300
From:   Dorcas Litunya <anonolitunya@gmail.com>
To:     git@vger.kernel.org
Subject: [Outreachy]Introduction and Problem while installing Git
Message-ID: <ZSeYzdx07Cj67lR4@dorcaslitunya-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello everyone,
My name is Dorcas Litunya. I am excited to contribute to the git
community, I am a first time contributor through the Outreachy program.
I am excited to learn and grow through this project. I am currently
installing Git and I have been faced with this error once I run the make
command:
In file included from http.c:2:
git-curl-compat.h:3:10: fatal error: curl/curl.h: No such file or directory
    3 | #include <curl/curl.h>
      |          ^~~~~~~~~~~~~
compilation terminated.
make: *** [Makefile:2718: http.o] Error 1

Any assistance on what the possible problem could be will be highly
appreciated.

Kind regards,
Dorcas
