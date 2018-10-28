Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3293E1F453
	for <e@80x24.org>; Sun, 28 Oct 2018 12:15:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbeJ1U7u (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Oct 2018 16:59:50 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:55420 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbeJ1U7u (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Oct 2018 16:59:50 -0400
Received: by mail-wm1-f43.google.com with SMTP id s10-v6so5488640wmc.5
        for <git@vger.kernel.org>; Sun, 28 Oct 2018 05:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tz+18dqvF6YXwBx8dNswi2LfZSCbBv4IJk/QiZaOZeU=;
        b=UoWu2khRpFgCZLrVLpS8vrEZCkXTW9XSGgXA0vXTX07kesShBIxM+JzbKe17nhtwZG
         C77yIBuXcBMIZ1ZyF8gym2pmN5vNlJvb0T5eCICYIirsCeN5BSz2VMHzWyKfsTFnPQWE
         WSPx3/trLvIITHyw5w8aXdIr1hX0lPweL9LLn8GKSpV8hvMDmwIfFksRT5434yAly0Af
         YeWsppmsVnPyCTiaxr2LmDPpgooznaySQpyvh1itf+eymXvGCmG1t6smyUnRTEN1ytn7
         n6+6bifKEJ6bEesr7njI+c6a6OUnIZY21Mi9kuRXH9QesnRg9FltTUMgc8S2L6b1fHCR
         ifGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tz+18dqvF6YXwBx8dNswi2LfZSCbBv4IJk/QiZaOZeU=;
        b=N6eF1h8ZLjrSBOnFGGLA2N7Ayydy80u7RlJ12n9HsNClQBkOw+zDvY/+SLmXgmqWEl
         t8ZaG56C5eF5oeWh3Vm8V+upJNNd8RW/IEo15AIGf64kPDON1NQMQBpnAh7ouNs0mXVr
         fNKD+UqcnkclocZ+qHlgQLTEBpCgX1M+Gim2gaxde1uZlwsrgNxnHc+7/gadXo9wvd1T
         MgmjAeSyQUVQZDehiprBit/00YxZrVDIGcVImnwTdA/ajnmM6SYSQodhV/WQUBbwOotu
         PwZs5a9XcWF6GoVJW4MyX5aRX0On713qQ1fbhoJK+spyH+Q6KbXMOmav4kyVAGnxcGlF
         scTA==
X-Gm-Message-State: AGRZ1gJOKv4mzHkFQYraeVdFuYqwdUSQ+xphDWrqXw/jz2C7Eg+bLvEs
        5TYco5V0oKxgqKmAiICQQnY=
X-Google-Smtp-Source: AJdET5cuJkPTVavvYzuk3wTEtoxWqTKr2R6jcw9sHduUEit0U2QzOEJjM1UUPE9zmNy/cB9xYY8hSw==
X-Received: by 2002:a1c:950a:: with SMTP id x10-v6mr4269133wmd.43.1540728920431;
        Sun, 28 Oct 2018 05:15:20 -0700 (PDT)
Received: from szeder.dev (x4d0c4c20.dyn.telefonica.de. [77.12.76.32])
        by smtp.gmail.com with ESMTPSA id q77-v6sm13685919wmd.33.2018.10.28.05.15.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Oct 2018 05:15:19 -0700 (PDT)
Date:   Sun, 28 Oct 2018 13:15:17 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: t7405.17 breakage vanishes with GETTEXT_POISON=1
Message-ID: <20181028121517.GO30222@szeder.dev>
References: <CACsJy8B=gxVMrZnr-BNp=VCHea8wpx+GCE4N76=vSGMnX2rSbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8B=gxVMrZnr-BNp=VCHea8wpx+GCE4N76=vSGMnX2rSbA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 28, 2018 at 06:41:06AM +0100, Duy Nguyen wrote:
> Something fishy is going on but I don't think I'll spend time hunting
> it down so I post here in case somebody else is interested. It might
> also indicate a problem with poison gettext, not the test case too.

I haven't actually run the test under GETTEXT_POISON, but I stongly
suspect it's the test, or more accurately the helper function
'test_i18ngrep'.

The test in question runs

  test_i18ngrep ! "refusing to lose untracked file at" err

which fails in normal test runs, because 'grep' does find the
undesired string; that's the known breakage.  Under GETTEXT_POISION,
however, 'test_i18ngrep' always succeeds because of this condition:

  if test -n "$GETTEXT_POISON"
  then
          # pretend success
          return 0
  fi

and then in turn the whole test succeeds.
