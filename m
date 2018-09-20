Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44F1A1F453
	for <e@80x24.org>; Thu, 20 Sep 2018 18:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388069AbeIUAep (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Sep 2018 20:34:45 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:51119 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbeIUAeo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Sep 2018 20:34:44 -0400
Received: by mail-wm1-f48.google.com with SMTP id s12-v6so590343wmc.0
        for <git@vger.kernel.org>; Thu, 20 Sep 2018 11:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=LqY6Vemh0n5IL+4TY8R/sDdHe63aMwSsicoP8s1PJVw=;
        b=GLHxgviqRb5WVbzy/NFTXMsURid7EiG2jK8WpXaYdwM7SGzSO8gayQDzj6u5Pbz0xy
         F0j1a+84CDQFgUVo/0SxoJzueAe1XyQi8fNh+eChhXZeau7xODnvnlGsSuJeJvgoKA04
         MNXsGXl4fftAorQAdyc6ptxtRrYfxeqBPyPYYvavl4U33te39ZJbXy5hDkc71gHTFo0/
         J59UOIiD5JmQ0416yvyhk7gdAbUw4ElUvpmUffMEhWPfh3P1/Irq8lhSRazg6UnY5fJD
         9/uBeni7744Y6Uh0wyPjReogQIoNUkvPSWHpbUtJ08yC74X8Qlsea5/M7x7qGMlDFRVT
         pouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=LqY6Vemh0n5IL+4TY8R/sDdHe63aMwSsicoP8s1PJVw=;
        b=LezoLO9TgJxxA0P03GvCg+gyRrjQrZJU4VhuF2HYaiQQKLMxVxNPKFLqBLcyVvV0z0
         +kzwvDZ35fi9etgzfVXR61RAMG7pOk3PXWR1fdjU106OE082vAsevYXyolWCFpKxkkWe
         xLaIlWSfIZTSwcp7bdVCOtw9rf5q8LlsyGp7aOv0fCc4tjrjdbUjeCB1VTGBiD0tNJTV
         yw9OdBYjvwfL1hGdA1VmRHoVi9GsNwzygskynAqoNTklxIFNpmcr6GQWs8XpVF+CPUzE
         AmPiyYD5P5ll923qnoTQ3z+jKn49DEDKiaq0ocB8+VG7dRnM/kFrmMgOOI5FsS9UBlj9
         +o/Q==
X-Gm-Message-State: APzg51C0883BfNbW9ow8pGVhqDKsgtmQwHpHJFlRpbS/u4ECj3EO2ql0
        6MI6s7EF7l1honWfiresCL4=
X-Google-Smtp-Source: ACcGV61QLw9UtUQrBHpIJhqg6yILMaUMyOzcwVS+9iyqKqiVNGsi0gWplHd9k797CYgQ65STVmSE4g==
X-Received: by 2002:a1c:a187:: with SMTP id k129-v6mr3956031wme.111.1537469391799;
        Thu, 20 Sep 2018 11:49:51 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id a10-v6sm3201151wrs.24.2018.09.20.11.49.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Sep 2018 11:49:51 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Jeff King <peff@peff.net>, GIT Mailing-list <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/9] Makefile: add a hdr-check target
References: <d24df21a-7ab2-84f6-8b18-83fd9c8c2b30@ramsayjones.plus.com>
        <xmqqbm8s2qjd.fsf@gitster-ct.c.googlers.com>
        <b7b9b26d-c175-05b9-7144-101bcaf592d4@ramsayjones.plus.com>
Date:   Thu, 20 Sep 2018 11:49:50 -0700
In-Reply-To: <b7b9b26d-c175-05b9-7144-101bcaf592d4@ramsayjones.plus.com>
        (Ramsay Jones's message of "Thu, 20 Sep 2018 17:03:05 +0100")
Message-ID: <xmqqpnx8ypf5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> Yes, this was one of my first concerns (I even asked Elijah what
> compiler options he used), but I was getting useful results without
> passing CFLAGS, so I just ignored that issue ... :-D
> ...
> Indeed. This bothered me as well. The 'compat' directory does not
> follow the 'usual pattern' of the main headers and is particularly
> sensitive to the lack of various -DMACROs. I had initially included
> _all_ sub-directories in the 'exclude list' (to follow what Elijah
> had done), but then removed one at a time ...
>
> I am open to suggestions for improvements. ;-)

Perhaps it is sufficient to add a mention of these two issues in log
message and an in-code comment nearby the .hco rule in Makefile, so
that people can come back later to discover what design choice we
made (i.e. "without worrying about these two issues, we are getting
useful enough results, so we decided it is OK at least for now not
to worry about them").

Thanks.
