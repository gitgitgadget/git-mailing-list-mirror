Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C44551F463
	for <e@80x24.org>; Mon, 23 Sep 2019 09:24:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732054AbfIWJYV (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Sep 2019 05:24:21 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:35003 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfIWJYV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Sep 2019 05:24:21 -0400
Received: by mail-wr1-f45.google.com with SMTP id v8so13093068wrt.2
        for <git@vger.kernel.org>; Mon, 23 Sep 2019 02:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QA71FtpTV2vz8k9svRqthjQZcxi9R/WQ6cWArgdBlyo=;
        b=KWcZYnIicnI8noHbW1RkTn+SWRE6gMJFy9VSvROswPjEWIb4ghYzUfDQfDWHysMehH
         ByTnGs8IFw6iuIElqYYZ1hkHFJBk8DsyNi1Y7cfW2cKAMLkkVBQ2LXcDBoMRU7RJPRia
         61E77AV7Fc7O4/3D+j1gxtnl6Agu1Hfx4ynQUgcbwQDMNZzgQaNhhOlAcoiT3BKnl0Fh
         jaNbJy6sRC5+Ezdclt3qDsksDHYngCmy0edXxH02T6ZUXOmUXKdUAUUTqoyc3Ct2Cgbh
         koqwlIrcQPyX1iN9q+71wDNE1pvl/lbhxJKbK+eYu4WNh2++rs7FE4sa/ef1tZuzOQAV
         hf/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QA71FtpTV2vz8k9svRqthjQZcxi9R/WQ6cWArgdBlyo=;
        b=eJFun0xum0KsalBqPVERwOoCQRV3hvOwv8bqW5GRvBXx+hW5tvpFeu5ZzT396Jw++M
         8DDvpTry7oaA7mZJJRzdHz+qAlvlKDbPHibEqKplns4YlkGnvx0as5t6BIyTwxmqTxZe
         CG7tErecFX6kIDLY+f4+C/HjPdMy3php2h7rvyQepR0Znf+i4pybkLtLVgQACB3MQQOZ
         ReHu1GtZa1IS6RzfjYnags7b4gWKipCC9C+3qOFFTIEh6p38t8fU2IwMjACVeJk/aojf
         M1rULKVKtu1zWPYl4g5QgzIQQOKSRH+EdHpMolToq2gtx9w5kIcmzbDY29GvV6tskQfe
         bV6A==
X-Gm-Message-State: APjAAAXNFcg82XLf/LRAK+zjYokV+SPpwZ+OAIp14mc7pMWPnZR6WeW8
        Y8h30n2zfBIR5tg5RspwVJs=
X-Google-Smtp-Source: APXvYqzI79V3eyVA2x8gO8vYoKUyd071nlf8uRAwEx1ioc+jra5bIGOuDjhQHM8dfYJpNpeB8NoMog==
X-Received: by 2002:a5d:4647:: with SMTP id j7mr7604221wrs.106.1569230659678;
        Mon, 23 Sep 2019 02:24:19 -0700 (PDT)
Received: from szeder.dev (x4db53381.dyn.telefonica.de. [77.181.51.129])
        by smtp.gmail.com with ESMTPSA id v8sm20055828wra.79.2019.09.23.02.24.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Sep 2019 02:24:18 -0700 (PDT)
Date:   Mon, 23 Sep 2019 11:24:17 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: How to see command line arguments passed to program in
 core.sshcommand?
Message-ID: <20190923092417.GF10866@szeder.dev>
References: <CAH8yC8nVBcBntJVZ6eV+YxoBpZRx+ecC2JxGuunhxNbY2cGyFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAH8yC8nVBcBntJVZ6eV+YxoBpZRx+ecC2JxGuunhxNbY2cGyFQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 22, 2019 at 11:17:59PM -0400, Jeffrey Walton wrote:
> I need to spy the command line arguments being passed around, but I
> have not been able to do so. 'git clone -verbose' is ineffective, and
> -vvv is rejected as an unknown option.
> 
> How do I see command line arguments passed to the program in core.sshcommand?

Try

  GIT_TRACE=1 git <rest of the command>

and, among other things, you'll see something like

  11:20:12.013785 run-command.c:663       trace: run_command: unset GIT_PREFIX; ssh git@github.com 'git-receive-pack '\''/szeder/git'\'''

in its output (this was for a 'git push').

See 'man git' for possible values for GIT_TRACE.

