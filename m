Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4E4E1F461
	for <e@80x24.org>; Wed, 28 Aug 2019 08:16:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfH1IQC (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Aug 2019 04:16:02 -0400
Received: from mail-ed1-f47.google.com ([209.85.208.47]:41404 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbfH1IQB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Aug 2019 04:16:01 -0400
Received: by mail-ed1-f47.google.com with SMTP id w5so1977670edl.8
        for <git@vger.kernel.org>; Wed, 28 Aug 2019 01:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=PbH7LjrCYqhUzSaq88+AQAxC+TyGVzqRXsXAeq0rJXE=;
        b=MVVbIA9DwbEo2g6DKp50/Uxruxae7KvUJXcU/7+KeivW0t2uQIDOov768fFzz6cCfd
         39GNZzNxxEzGY9cgNmhrDWbta88kr5+LlQQa/DkOq+FygogMQysTSk3Xi2rzt8ds1taQ
         bL7VhExfpXDXqHGllZBiLxLO3RSgb7WNCcfU/vSipEhQjdUOaV9sjQviLF/UpAOCQf2t
         DtAYObUr6y4Xfe2e/+JoCd4xcL0srbRRQc/RdQnwZJCFMDAVhpHGIEXdTMiPd+R7TVJZ
         GMKCjBYDziQ438xG0iUfgfwZmjfrG1rsEZUAXP0SnQ4LbiHpmtWmErP5MdoScuR0Gl5c
         g4kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=PbH7LjrCYqhUzSaq88+AQAxC+TyGVzqRXsXAeq0rJXE=;
        b=VLTUBSgRmA1nfkfecBaD8VtAWBTWx2VQWPMBGxYRkAiyitgaxSzQMDX0R+LsT3uEwt
         3Yvmc8SdvIjL0wX4dSCt8mx/5hSn/SYa3hztWN7A+RJGbiMXBMndmgIwPXNNrq7HWSqr
         ayW42KWMe5t3SZxquD83SlSDjxwLR7ohbJCO3CM6K80/jz3Hms74MIRuoaqowqfKg7UI
         PphtLWqRlAQXVFI1aBDZG4jyw2b21jiUVOEHLMuOoKL5fb//WKmoWJ5ftxf2HP6CY9Jx
         ZMSEACHQHEeGcgKCtzeCjrAuz+hHx1969ZzTh4vQcBPaJrFzA+tzPMG3ok5H3C79e2Vc
         uKRA==
X-Gm-Message-State: APjAAAUOqUShKmEtGHmk/FHiAuE2n40c9Z0EUgwk1DEOWZH0IhreUawq
        U2aqrHmalnr5sq6/m+rQ56Y=
X-Google-Smtp-Source: APXvYqy9IH7f4Bu+eMH1+ojQePDYPZIkMDmhOyJw7hT1Y6PPG/kl8g7n6ThiAMr0snvYg9R+o05k1g==
X-Received: by 2002:a50:a7c2:: with SMTP id i60mr2637052edc.215.1566980159575;
        Wed, 28 Aug 2019 01:15:59 -0700 (PDT)
Received: from instance-template-2.europe-west6-a.c.vaulted-journal-250706.internal (1.133.65.34.bc.googleusercontent.com. [34.65.133.1])
        by smtp.gmail.com with ESMTPSA id w3sm308402edq.12.2019.08.28.01.15.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Aug 2019 01:15:58 -0700 (PDT)
From:   "Giuseppe Crino'" <giuscri@gmail.com>
X-Google-Original-From: Giuseppe Crino' <giuscri>
Date:   Wed, 28 Aug 2019 08:15:57 +0000
To:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Cc:     Giuseppe Crino' <giuscri@gmail.com>, git@vger.kernel.org
Subject: Re: How to build to debug with gdb?
Message-ID: <20190828081557.GA18785@instance-template-2.europe-west6-a.c.vaulted-journal-250706.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1d44d8d6-6c6f-591e-dd2c-5102c9fd7d11@kdbg.org>
 <20190827183640.GC8571@szeder.dev>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 27, 2019 at 08:36:40PM +0200, SZEDER Gábor wrote:
> Try using the same build flags for the install, i.e.:
> 
>   make prefix=/usr/local DEVELOPER=1 CFLAGS="-O0 -g" install

Yes, now it works thanks!

On Tue, Aug 27, 2019 at 08:34:23PM +0200, Johannes Sixt wrote:
> That is because the command sequence above does not do what you think it
> does. Didn't you notice that everything was recompiled during `sudo make
> install`?

Shouldn't be this documented somewhere?

To my knowledge `make install` is expected to copy artifacts of the
build under prefix. It's unusual to me that `install` has the `all`
target as prerequisite.
