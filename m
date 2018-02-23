Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 265171F404
	for <e@80x24.org>; Fri, 23 Feb 2018 18:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751907AbeBWSAU (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 13:00:20 -0500
Received: from mail-wr0-f171.google.com ([209.85.128.171]:45456 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751897AbeBWSAT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 13:00:19 -0500
Received: by mail-wr0-f171.google.com with SMTP id p104so14938269wrc.12
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 10:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=3XB9Ut4PcC4zkhiV6DZcBw0zlPKiZAFX0WvCCz/7M54=;
        b=e/L47fj5q+Kk10T8ESw7kYfHueIs1wh5co0Nbt616442En4bPrap4cQV4/Fjf/VMUE
         eYrBAAyTS+TAprgtWaWFeM9uiJK+wHr/+rlBKhOrOf8dv/bVofWsJCQYRu43mVW+TyDJ
         Csz8lEhBoJK+qBd5iuWjuWtRCa912gUJGa64tTt//1io3se6xFy0pLRnMU494qWOg69c
         v95OCE7n2qMiQyhfTuTXBTn/LRc4jEbW6ny+cXBju03+f2OKa298qP/bUpFqQEk+Nlcj
         YvZ1hSjW+IqpGpwRcaqXHK08QWrFIYM9YkhF1oUZZgZNRXfHfFABW/XONIqB7qj/wdhM
         z+JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=3XB9Ut4PcC4zkhiV6DZcBw0zlPKiZAFX0WvCCz/7M54=;
        b=TjXnMRTGlrpzo0B6KO8HkoUUnBKhUO1UHtbrPqfbMftdiTbOHkQ1eLrKZ9+2sb5q0W
         BtRPRjgGGlAkvYNlftkk3KEuV9NzRrBiU6199gEXhLpsacqzivVJFft9+T7t1aYE3PRl
         m39YzP2DvZzHfFjnlQDLjsDSy2IlYkY9YINz6snqono9g3XVBVM5qTgQuVEbG4g4cB2L
         Z+K7rQprX/3uZ7enE+FMOdDj4rBDn6+gNyh5+9v+jhR3e7Of+JppOJyxWHMX6omiyuPV
         2r4224K4+CqSb7q+sDz9IzTyeIhu3SikphiMy9X0urKuVIfNHX1lObNTVm+Zg/HoyW4d
         ijFw==
X-Gm-Message-State: APf1xPBwApVjoD/P+n7WDVt7+KiBdmX6YueVkKdUnCKjViIH17qe/Zxk
        KwUwn8CX1edXWIghYAkRXUg=
X-Google-Smtp-Source: AH8x227841mc0jgOFp/ECficS3T+1QymDY3y0GN4BVeT+zZPO2O8dDpe9LklZJGRI8fMvMq1IsAG/g==
X-Received: by 10.223.134.193 with SMTP id 1mr2252597wry.245.1519408817416;
        Fri, 23 Feb 2018 10:00:17 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id d63sm2529082wmh.16.2018.02.23.10.00.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Feb 2018 10:00:16 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] am: support --quit
References: <20180214111606.4257-1-pclouds@gmail.com>
        <xmqqy3jvmkyn.fsf@gitster-ct.c.googlers.com>
        <CACsJy8CUmpXNZDR6jvXP=hQkuTmCqzYYqitXJyYYR31Yw7DXXw@mail.gmail.com>
Date:   Fri, 23 Feb 2018 10:00:15 -0800
In-Reply-To: <CACsJy8CUmpXNZDR6jvXP=hQkuTmCqzYYqitXJyYYR31Yw7DXXw@mail.gmail.com>
        (Duy Nguyen's message of "Fri, 23 Feb 2018 17:24:34 +0700")
Message-ID: <xmqq606nvb68.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

>> The internal implementation detail of am_abort() is leaking out
>> here, by saying "rerere-clear" is the only special thing other than
>> recovering the HEAD and working tree state when abort happens.  It
>> makes readers wonder if am_rerere_clear() should become part of
>> am_destroy().  I dunno.
>
> I think the original design is am_destroy takes care of
> $GIT_DIR/rebase-apply and nothing else. --abort has to clean up things
> outside (index, HEAD, rerere) while a successful operation should not
> leave anything else to clean up (except rebase-apply dir).

Yes, and that is why I think the code would have been nicer to
understand if the update to add 'reset' had turned the existing
am_abort() into a helper that is one level higher in the abstraction
(perhaps even by renaming the function) that the caller can tell
which part to clear (i.e. e.g. am_finish(&state, AM_CLEAR_ALL) vs
am_finish(&state, AM_CLEAR_STEP_ONLY)).  Stepping back even further,
perhaps the call made to am_destroy() in the normal exit case at the
end of am_run() could have been using the same helper.



