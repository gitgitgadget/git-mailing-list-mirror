Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1B291FAF4
	for <e@80x24.org>; Tue, 14 Feb 2017 20:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751941AbdBNUkk (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 15:40:40 -0500
Received: from mail-ot0-f193.google.com ([74.125.82.193]:34975 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751600AbdBNUki (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 15:40:38 -0500
Received: by mail-ot0-f193.google.com with SMTP id 65so18895091otq.2
        for <git@vger.kernel.org>; Tue, 14 Feb 2017 12:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=K4eOeqzWEEXLcvAFr/7ukP02/aMoyrGBmsCNEHO47YU=;
        b=PsV6liH+zsbg1yP1Y6X+czeCCC7wSML8TU8bQHC4P0hHUUoOmBUTIweDqAT6Bm+Iei
         UkE9dD6p7tBJOFWR5zaOLYRB2nCgDJROJH55gj9Ct2blQS8GPMcc+MvjzO7UB2wpwFTV
         yksTEdyIWJoUe1EeynSAaXadf1dmcnbUHlLC52cS7zNBQS1TWp+PzbKDiDhrRRec6lUr
         b1AyD686O+JPirNQ5m4GdDQrjZN1zISSSo4hRyVD54a+zd35g4BY4U4znUNsYkR7saRS
         oGk3e98nKqt8BX4Ff3bwf3sVQSd4QY2ErWtXpgmjFstngKPi/W7vaRH2YEjchp99IeXW
         bbcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=K4eOeqzWEEXLcvAFr/7ukP02/aMoyrGBmsCNEHO47YU=;
        b=NvG2Ddf5X9O2IqANpSDFdefWACvELhd77xHOx+Hb/wyC2++bt6ebag/IBJejAQYo/p
         W6D9c8c2piBFrI7MnoTxJoCmgAvkA50tphFGEU64XcTpzLmDTqUVbAxk00ffN/U8Z3iO
         2OJsfFwTSCA/vgwy3IBi7gbqov8AkRHiw4S5EuUrEvMEQj2dc5zzLf0Rju3aJ3e8WgTN
         8blHuHsUPQCr4JDaZowxkrg6JMY7p47nfEKpugRvWXNRuwqAFfs1gGkTyIvuKxoK7BPf
         0rXBYdoUg/mHXZFE7IY46/VSMfoerb8jkJMSOHjwsM6CIk2s7qpRYzoLEzw8HGbAi6/C
         /0Qg==
X-Gm-Message-State: AMke39kfnE97jh7PID5otZXTfYtcJ86xXiBdi9yjpvQcuRSb2jmMPeIqqhPcKHAI+KjkhA==
X-Received: by 10.98.149.218 with SMTP id c87mr33170529pfk.88.1487104837858;
        Tue, 14 Feb 2017 12:40:37 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:2447:f72c:8fdf:75c6])
        by smtp.gmail.com with ESMTPSA id e129sm2971969pfe.8.2017.02.14.12.40.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Feb 2017 12:40:37 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Olaf Hering <olaf@aepfle.de>
Cc:     git@vger.kernel.org
Subject: Re: missing handling of "No newline at end of file" in git am
References: <20170214201104.GA26407@aepfle.de>
Date:   Tue, 14 Feb 2017 12:40:36 -0800
In-Reply-To: <20170214201104.GA26407@aepfle.de> (Olaf Hering's message of
        "Tue, 14 Feb 2017 21:11:04 +0100")
Message-ID: <xmqqh93w8q0r.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Olaf Hering <olaf@aepfle.de> writes:

> How is git send-email and git am supposed to handle a text file which
> lacks a newline at the very end? This is about git 2.11.0.

I think this has always worked, though.

    $ cd /var/tmp/x
    $ git init am-incomplete-line
    $ cd am-incomplete-line/
    $ echo one line >file
    $ git add file
    $ git commit -a -m initial
    [master (root-commit) 27b4668] initial
     1 file changed, 1 insertion(+)
     create mode 100644 file
    $ echo -n an incomplete line >>file
    $ git diff file
    diff --git a/file b/file
    index e3c0674..f2ec9f0 100644
    --- a/file
    +++ b/file
    @@ -1 +1,2 @@
     one line
    +an incomplete line
    \ No newline at end of file
    $ git commit -a -m 'incomplete second'
    [master 57075ab] incomplete second
     1 file changed, 1 insertion(+)
    $ git format-patch -1
    0001-incomplete-second.txt
    $ cat 0001-incomplete-second.txt
    From 57075ab402e2d3714ebc9e2e9d4efd8dbfd74d5a Mon Sep 17 00:00:00 2001
    From: Junio C Hamano <gitster@pobox.com>
    Date: Tue, 14 Feb 2017 12:35:50 -0800
    Subject: [PATCH] incomplete second

    ---
     file | 1 +
     1 file changed, 1 insertion(+)

    diff --git a/file b/file
    index e3c0674..f2ec9f0 100644
    --- a/file
    +++ b/file
    @@ -1 +1,2 @@
     one line
    +an incomplete line
    \ No newline at end of file
    -- 
    2.12.0-rc1-235-g2fb706ef99
    $ git checkout HEAD^
    $ git am ./0001-incomplete-second.txt
    Applying: incomplete second
    $ git diff master
    $ exit

