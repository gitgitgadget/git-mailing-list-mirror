Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D51F1F4F8
	for <e@80x24.org>; Fri, 14 Oct 2016 15:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752257AbcJNPMq (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 11:12:46 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:34586 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750717AbcJNPMp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2016 11:12:45 -0400
Received: by mail-it0-f68.google.com with SMTP id e203so938566itc.1
        for <git@vger.kernel.org>; Fri, 14 Oct 2016 08:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OQeTlpm8qye8ChiO9hR4ZL/jynum6/ldIUbK+4U7I5M=;
        b=eGaDi7dggFF568JH0xcXG7L/lavxOyhK1u4+UEQ7k0KfpEfGVzDXr2UquQRip7hOnz
         GOJmG3MoDKqZJhgxGbhjvf31kvBQRMLy9ek6N7blnH2pGjV8qtoNmA+BmZH18a3iehur
         qhKl22B8X2CHIo/gAwShes5o9+P+ZSc0NOQ09yNjRxodoYWm2pxIeKoHIdKDbRIRBpEM
         fJrFAuKshL3v3nS8RVRz7UPDwkDJ7wo3SnWgYOdKn8a0eDfo5cElbH5CWo9+VjghGMPG
         q8hTMOfQ2Ko/Ge7gQGeYt+v3AE/QZWyFo0/dVWQhZFiSpW7SJw+yKHbNr6QzxbGMtRa1
         ZArQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OQeTlpm8qye8ChiO9hR4ZL/jynum6/ldIUbK+4U7I5M=;
        b=LHtieJ0oG148OPHDXrfgCoERQjFZIUBxz+Cuq2bdlwcRJ6A9+SWJaWBfr8qK2nq8KU
         mZwc6TB3VYlB6z3l2w9HfMAyG2q6Yavt3yDZEnpswwOcOFJju0xa1U4QBqAQoBn304bQ
         k/IJYbhBTEcc5Iial25wtnC0YRaxRE15M92bRZrxfm2a88ec8VdikJuQ6HRZAHYVucVZ
         NQQ6f24Jl4WP/UE7m/GmkC88sEg8cJKwdrBREy7GW4e7fCgRzrEBlTg/8zfeFehTR0u3
         8ISKLfS3CxqRvhWV1wT+sF2dbcFXfV+nYlSQD6hlGvM2WPL9JAhNBFCdjLU5AhB86R4r
         0JrQ==
X-Gm-Message-State: AA6/9Rkp2EWpMCXjAYhiKHADMP4iWKf4KY4ynS/Y6FJbigcdybNX8XtJOYJrJKDWgH0muc1XhRiYW5YnbL5DDw==
X-Received: by 10.36.202.131 with SMTP id k125mr2426924itg.100.1476457964174;
 Fri, 14 Oct 2016 08:12:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.38.215 with HTTP; Fri, 14 Oct 2016 08:12:43 -0700 (PDT)
In-Reply-To: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
References: <01020156b73fe5b4-5dc768ab-b73b-4a21-ab92-018e2a7aa6f7-000000@eu-west-1.amazonses.com>
 <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Fri, 14 Oct 2016 20:42:43 +0530
Message-ID: <CAFZEwPOjK25m84BgTF7AL72DL_K1dHf7OrYoX=_vky9r3GayNw@mail.gmail.com>
Subject: Re: [PATCH v15 01/27] bisect--helper: use OPT_CMDMODE instead of OPT_BOOL
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey everyone,

It took me some time to get to the next version as I was a bit
preoccupied with my assignments and exams. The diff between the v14[1]
and v15[2] can be found here[3] because gmail web client will wrap the
lines. Thanks Junio for the reviews in v14. I have tried to solves
every issue raised in the previous round.

The major changes in this series are:
 * Use the char * instead of struct strbuf in struct bisect_terms.
 * Use goto mechanism for error handling.
 * Use get_sha1_committish() instead of just get_oid() because there
is also ^{commit} at the end of the call from shell.
 * Use skip_prefix() where ever required.
 * Use return error() instead of die() where ever possible.
 * Restructure a part in bisect_start() to make it more readable.
 * Change the comments in bisect.c to use return instead of exit
because the code does it.
 * Introduce a test to check for cleanups in after bad merge base to
make the patch 15/28 more understood.
 * Also keeping comments in bisect.c to show at which places there
would be cleanups and where not.
 * Restructure bisect_replay() and get_next_word().


[1]: http://public-inbox.org/git/01020156b73fe5b4-5dc768ab-b73b-4a21-ab92-018e2a7aa6f7-000000@eu-west-1.amazonses.com/T/#m7c26060fcf95abbd19f93742d7317eef87b915a1
[2]: http://public-inbox.org/git/01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com/T/#u
[3]: http://paste.ubuntu.com/23323581/

Regards,
Pranit Bauva
