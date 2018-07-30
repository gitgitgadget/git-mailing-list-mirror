Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEAFE1F597
	for <e@80x24.org>; Mon, 30 Jul 2018 15:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbeG3RRf (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 13:17:35 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44773 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbeG3RRe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 13:17:34 -0400
Received: by mail-wr1-f67.google.com with SMTP id r16-v6so13387425wrt.11
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 08:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=DsPL4yhCEA/fo04PAN7W2QAz3jwK4VmkYVo5qeOjjo4=;
        b=Fv12DI5/ILzkx1Dreefs2Us8v77mlILWZMJjkC+mTKivPvsSSiTTIWZJ4O+RhFwhEp
         VSSZV75njmnK5DnzxZequ2uHtnOg0Bx+OifklIHTRFDzMsce74gKNGDfUeuhdCmWOF/4
         ewkmN3WWEU3LRY+fZE+sfbxuNYuzmJjWoT1keuU3ceOI2+tm/Tn6mvbKU3ZEDr/sbJpb
         dir826JP2ZWJFbd5udq+AFRNci9+80hfQaEmNDVXB0o5wd9FZ4ReUvt1Ip/8LXX0leG1
         K0l5ptn1KigmFp6JAOj2BVcowWhUS3NZSyLpgqZMLJuIFY1fhnbz39hPe6KfXoH+ZG+O
         xiHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=DsPL4yhCEA/fo04PAN7W2QAz3jwK4VmkYVo5qeOjjo4=;
        b=eY+EUm9+XLvezwQhaelm4oRNwQJ78Ee3zXylv/LQRYXuwv0BakKa9RQKRqTEPbQ2oX
         oYT9IBQz1Uwba8O1mg5mK6sQ152cholYLDcy0zI8AfiHFwQHPB9+ngSKwGSlJARWgzOX
         UjLGuTcFIK0WpQqCXCwYmDF1lBU0K3RBzIBBtPl+rfbNHlvdetfrbnRJfTWd74YC9alo
         VA5dt+2M4m4Lsy8xxfOe7FpGwnsPyXjfY2XiRVR0rqxYaRLEe+CvXQhnuIwVvC8tNUZC
         J4QqKSs3VU5hU2DIIzXZ+LKOX1m6W9g5Na5uxdT8GNpnaHzdoP4qY8BTPNVZ1Jg0vLU5
         Fyfg==
X-Gm-Message-State: AOUpUlGfQmxRx5XgHxCVoPuJufoJTNvvdyqioqNffrt12/ThLRQl7eGD
        gPWJRRdN/hvTc4sxhRiaxbg=
X-Google-Smtp-Source: AAOMgpeVBtt+3nfEKFb7amGx7KojzfXbhxwJP/gDa1hncgvrzjUElfgmAy86Af4eiWWs1k3F5GLCkw==
X-Received: by 2002:adf:9954:: with SMTP id x78-v6mr18959799wrb.178.1532965320689;
        Mon, 30 Jul 2018 08:42:00 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id u7-v6sm10325112wmd.46.2018.07.30.08.41.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 08:41:59 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: range-diff, was Re: What's cooking in git.git (Jul 2018, #03; Wed, 25)
References: <xmqqd0vbt14e.fsf@gitster-ct.c.googlers.com>
        <87fu0469d1.fsf@evledraar.gmail.com>
        <xmqqd0v8oaf5.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1807301510370.10478@tvgsbejvaqbjf.bet>
Date:   Mon, 30 Jul 2018 08:41:59 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1807301510370.10478@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Mon, 30 Jul 2018 15:16:12 +0200
        (DST)")
Message-ID: <xmqqwotcivco.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> FWIW I picked up your Asciidoc-underline fix, and I also fixed a typo in a
> commit message (you may want to pick that up, too, unless you want me to
> send a full new iteration, I don't care either way):

Meaning that if you send a full new iteration it would match what we
have on 'pu' plus the one-liner below?  I think we can do without
such a resend, because everybody has seen all there is to see if
that is the case.

> -- snipsnap --
> 11:  bf0a5879361 ! 11:  0c1f5db5d01 range-diff: add tests
>     @@ -3,7 +3,7 @@
>          range-diff: add tests
>      
>          These are essentially lifted from https://github.com/trast/tbdiff, with
>     -    light touch-ups to account for the command now being names `git
>     +    light touch-ups to account for the command now being named `git
>          range-diff`.
>      
>          Apart from renaming `tbdiff` to `range-diff`, only one test case needed

I'll need to remember to rebuild es/format-patch-rangediff after
amending bf0a587936 with this, but I think I should be able to push
out the result in today's round.

If any other issue arises, I do not mind taking an update, either,
but I think at this point the topic is reaching the point of
diminishing returns and should switch to incremental.
