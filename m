Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCDEB203E3
	for <e@80x24.org>; Tue, 26 Jul 2016 15:04:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755949AbcGZPEs (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 11:04:48 -0400
Received: from mail-it0-f46.google.com ([209.85.214.46]:38796 "EHLO
	mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752785AbcGZPEq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 11:04:46 -0400
Received: by mail-it0-f46.google.com with SMTP id j124so15874428ith.1
        for <git@vger.kernel.org>; Tue, 26 Jul 2016 08:04:46 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KmMlT7rsA18+zDIXa5m0s+nPQoSBYXd2VtfG8VEDr70=;
        b=L/c8t+6uK+VC7+iVAsb7rvqhLlGJt8dQUB5pcu0wF3Nx9YiqDDGfeQ3ugZ6VUP8n/6
         mQCO9wI+XWR9uCE7hClW0mGNada/wNMMHNM75p5PKeF5XnLqZU4SAfoMk80ZflUdUm1G
         iUxiyBm63DLK49PpMnabd0M9PgFJJJDk/KDxPAdJTRbWER6YPwF+hc/JBlzPBTt5Q5b9
         uDHCyBdKn/eJLKDe5U+BMuYqJYh/sX18GFUrPOUAMyP+7oGOSDeDBoEdMXXoOuNPZPA6
         87jEz8UPwnxW85czlmD4uFcBWP7HZpNdUALQ+Vn9v+lcSBLI6gZQf3LW4wA8vbBbTqg7
         tK3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KmMlT7rsA18+zDIXa5m0s+nPQoSBYXd2VtfG8VEDr70=;
        b=i66sDg6B9R7E2JTvI/A0vfrL5eH0peqnd5oDy0KYI6WiKY1wjKVBD2qnaaSF2Hy3hY
         iDRfVRpqALhWUJezZRSgswxaNSSDnkihep4UytVVqr/dADZBcfF6OhUqXQwZUNoRg4eL
         je01BqaYcFb2cBKubDYYTo5aQ/yATW3BPSpm10HdR69+wsxBm9IukmbY3lC/r9xsRIO5
         /iQwKPu2MLFSUogarc5L/UNvqRaTf6l430VczhvsFZttlZKp3UqisqbE0DjNqJDLnPcC
         mPKVsFjjea4W2QJz7ftsaKSH5Ndefr4A7hyxVGu3IZHbUOYwJ4T3sB6yJUoWVUiBl7GV
         Qd3g==
X-Gm-Message-State: AEkoouuV5HWv/tf1L4rwJ7I3aLcVplWeB7cgUkMr+NAz5kQTNZ4rFUmyUHqzz9BGF+AsYHd5I6vDCUjQ/orlHg==
X-Received: by 10.36.91.134 with SMTP id g128mr27635870itb.42.1469545485196;
 Tue, 26 Jul 2016 08:04:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Tue, 26 Jul 2016 08:04:12 -0700 (PDT)
In-Reply-To: <CAGZ79kYET=z-b+U-JN+H5jkRTGHR0oMdTfUZPMRJx50aH-idbw@mail.gmail.com>
References: <CACsJy8ADRWNL3FR2TtWShviT4Lc4m1xaY8VOPP26Foyq+_A-3g@mail.gmail.com>
 <20160720172419.25473-1-pclouds@gmail.com> <20160720172419.25473-2-pclouds@gmail.com>
 <CAGZ79kYET=z-b+U-JN+H5jkRTGHR0oMdTfUZPMRJx50aH-idbw@mail.gmail.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Tue, 26 Jul 2016 17:04:12 +0200
Message-ID: <CACsJy8CUxLG5KL-u6hxCjVaydi=bXZ8Qr8RZwKPW16o_cfWVcA@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] worktree: add per-worktree config files
To:	Stefan Beller <sbeller@google.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	Max Kirillov <max@max630.net>,
	Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Lars Schneider <larsxschneider@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jul 26, 2016 at 2:59 AM, Stefan Beller <sbeller@google.com> wrote:
> I like the user facing design, but how am I supposed to use it internally?
>
> Say I want to read a value preferably from the worktree I'd do a
>     /*
>      * maybe I don't even have to set it to 1 as
>      * the user is supposed to do that?
>      */
>     repository_format_worktree_config = 1;
>     git_config_get_{string,bool,int} (... as usual ...)
>
> and if I want to read the value globally I would set the variable to 0
> and read? (I would need to restore it, so I'll have a temporary variable
> to keep the original value of repository_format_worktree_config)

I would understand if you need an api to write to worktree config or
the shared one. But choosing to _read_ from a specific source sounds
wrong. The common rule should apply everywhere: read from worktree
first, if not found, read again from shared config. Why do you need
this?
-- 
Duy
