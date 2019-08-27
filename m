Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9EF91F461
	for <e@80x24.org>; Tue, 27 Aug 2019 10:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbfH0Kg6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 06:36:58 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:51769 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727578AbfH0Kg5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 06:36:57 -0400
Received: by mail-wm1-f46.google.com with SMTP id k1so2545997wmi.1
        for <git@vger.kernel.org>; Tue, 27 Aug 2019 03:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pXXM0IcfiDcHWoPRjqjEz5ilhfAt1uTcVVaU9WNTAus=;
        b=AkwPRQgMAdBFJoVW4frZh0MHrkGNWLD5YcLob9EUE24mjkrI76Ob34A+7OqY0L0jBB
         ZnrkrCefSW+YPzniIb69/GtUQ6OxlvDGWGXGr/liOIrzwcw93dOjBupDSiAS9xMCBHqh
         ZHXlA6y9JihFxcB3XKElhpEj75FnBfGYaoUuhqt25IUhPQDcgFhccl0euM+HDgHvVGG9
         W0j/16ZZtH/NJHoEieZ85p3qHkDPdERXmTSHHouKjQ4mZhOGGc8PWjiuU7OqxRXrerkq
         dBl+zQvVUKjyjfkRJX/08bdoPO0cgwWXxnlfytP9xhawAWdg436jwwvciXd579hZG0hb
         RGhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pXXM0IcfiDcHWoPRjqjEz5ilhfAt1uTcVVaU9WNTAus=;
        b=EX+mz/SlkKNNxI+BQZUoXXxd+m86hoT3YgKUko28kkhNeKbDeeG0ibVrqkKCAVtuBT
         N+K8hyDYz+eIEVfC63M7PU510HAqY1qU3ch2LnGoAsAAECruM8j5dxlpu+A29z/OiPig
         WksQeei9ohDUPr3gnt1THeKrufsEoNeSR0ck7h9mJi/w1CgzHJ9ncqJw7rjqRXtfbHKJ
         XCMcCNaXxZUYjLFVbd+FhymFUmcCwlRYXGFhJftmmUTWPllOkeTLe/uRgaDBMfUNgFLC
         eHgtXPy2nzTW7PFiGTPOyWh+ns9xtGb7F5plJHj4HPwzcw8bH550lf5vJwRl8MPkY5Cj
         CIAw==
X-Gm-Message-State: APjAAAX87chJX1xNwC7Zv5mrQqAfyMtWsDkOOSft/Pqhi+IGH7q7Oqa4
        5SfcbSQOAz2UJiTNnKwV03wYd3Tl
X-Google-Smtp-Source: APXvYqwQ/1K4fhidN2ohuYvmXc0l8sMnncmNJnP62atfd5ecVM0kewkD4WdmXZb+SyN05ZqFmsZ7aQ==
X-Received: by 2002:a1c:1f41:: with SMTP id f62mr28281905wmf.176.1566902215806;
        Tue, 27 Aug 2019 03:36:55 -0700 (PDT)
Received: from szeder.dev (x4db46f61.dyn.telefonica.de. [77.180.111.97])
        by smtp.gmail.com with ESMTPSA id f6sm37210467wrh.30.2019.08.27.03.36.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2019 03:36:55 -0700 (PDT)
Date:   Tue, 27 Aug 2019 12:36:53 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Konstantin <kostix87@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: How to split file with its history?
Message-ID: <20190827103653.GB8571@szeder.dev>
References: <CAObSod2jhDjq=Fw2JtNMsK53HxXSf3n6K5XacHQBH00L49mNpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAObSod2jhDjq=Fw2JtNMsK53HxXSf3n6K5XacHQBH00L49mNpQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 27, 2019 at 01:10:02PM +0300, Konstantin wrote:
> currently we have one code file with deep history.
> As code file grown it is necessary to split it.
> but this action will drop history for the new extracted file.
> how can i split one big code file to small files and save its history
> for the "blame" action?

'git blame -C' can detect lines moved between files.

https://git-scm.com/docs/git-blame#Documentation/git-blame.txt--Cltnumgt

