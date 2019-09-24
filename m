Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58BB51F463
	for <e@80x24.org>; Tue, 24 Sep 2019 20:16:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410454AbfIXUQB (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Sep 2019 16:16:01 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43296 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410403AbfIXUQB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Sep 2019 16:16:01 -0400
Received: by mail-wr1-f67.google.com with SMTP id q17so3463775wrx.10
        for <git@vger.kernel.org>; Tue, 24 Sep 2019 13:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EbX9Jp3R8uINO9tYGzBMSpkF8UXR/gx/21TRoCsdF6o=;
        b=Xx4r+F0yUa6pdbumK7jnZBNmX+JpzehxlDwO0xkHrnvTor0EpcCOdoejMfPVm+LzoG
         z/t3pbs7xC2aTnDQGvVIWzdZMfpZSDoLBSMXWd11pZuisKkOYkLtM21fP5jOUv3YvvDq
         5HOir9QHRVrkrSh86wmACm0qAqQ54O7PUDEF8pj+p5qP89rv1MewPuVeXw8L+aZRPDoW
         xU0KyPo3+U1USKTV8QCrq1j1WCw09Ey/33tQLb/x/ehDdJc8Qr652W60D3h+13cLGC9Z
         0PzOWEPTtGIHe/iuzUEMlwrUVC7VYjqZ4yELLShj9lBueCOR2DtEaf8LABvZyAhuPCvn
         5M9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EbX9Jp3R8uINO9tYGzBMSpkF8UXR/gx/21TRoCsdF6o=;
        b=CRKJVzdzaBMk4HcjDoRTLrZWbqO8QEmoIA/bB/TuUrG0xHIHmK020rZGDrJQsvEJBb
         i5MAhB0Jml8L7TL3zMAWTdQ2xw86hMUnoYy4Z/82+Y0nvAefWb4x7gHLucyzWIs1t9bz
         OX064pnD8MF1vDsXD4P8b+Zg+kggbIXO4EkqTG0jwsXxKDFRT+3tkeL8xQzIVA6GtZ6/
         d/P6ElOuMHW6PC/26CcDuJyymSViK7tjmDugbiKJcUogX/Xf3j3ilDrzc8uu2lIzHYT5
         PWajV3OCmCBv2OIWIR3lZb6Kut5aw3V7LRaad+dnhQ0JqxmLGsbbIUUOnIQsHBh8VbED
         OsDg==
X-Gm-Message-State: APjAAAWy3DMQ6DcaMsitXKE9/8Ln4f2VJW3JHFcu+a+cWJJsZ4aSrjKQ
        HQPROzqKNfoLD2Bc/rwAsSk=
X-Google-Smtp-Source: APXvYqzWBsGuIiw7V9/z2sGgrjjo0erTV6R3yEC9A1zco/oN7dVuv6xwKxi8jhm5TKoqB7IiZgbaMQ==
X-Received: by 2002:a05:6000:a:: with SMTP id h10mr4465815wrx.226.1569356157193;
        Tue, 24 Sep 2019 13:15:57 -0700 (PDT)
Received: from [192.168.0.104] (atoulouse-658-1-81-250.w90-5.abo.wanadoo.fr. [90.5.214.250])
        by smtp.gmail.com with ESMTPSA id b3sm1754911wrw.4.2019.09.24.13.15.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2019 13:15:56 -0700 (PDT)
Subject: Re: [RFC PATCH 0/9] rebase -i: extend rebase.missingCommitsCheck to
 `--edit-todo' and co.
To:     phillip.wood@dunelm.org.uk, git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <20190717143918.7406-1-alban.gruin@gmail.com>
 <ce6bdffd-0a04-803c-4a1e-0959342db01f@gmail.com>
 <69ceed35-ced4-51e7-d724-1818ae45e9a6@gmail.com>
 <8214207e-fa35-44c4-4135-45bd90209e18@gmail.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <5dc165ae-8d56-04e1-911e-06836af30cde@gmail.com>
Date:   Tue, 24 Sep 2019 22:15:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <8214207e-fa35-44c4-4135-45bd90209e18@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

This has been a long time since I have not given an update on this --
sorry about that.  I think it’s time to do it.

Le 29/07/2019 à 11:38, Phillip Wood a écrit :
> Hi Alban
> 
> -%<-
> 
> That's an interesting point about `--continue`. Perhaps if `--edit-todo`
> detects deleted lines in error mode it should write a file to stop
> `--continue` continuing rather than having to validate the entire list
> each time we continue a rebase. Alternatively we could annotate the todo
> list with a message the dropped commits commented out and reopen the
> editor for the user to fix the problem, but that would cause scripted
> editors to enter a infinite loop as they're unlikely to fix the problem
> the second time round. A third possibility is to keep your code
> validating the list each time we run continue, but update the backup
> file with each edit so it detects added commits that are deleted in a
> later edit. This would also provide some protection for users who edit
> git-rebase-todo directly, though if they are using a script that deletes
> lines in git-rebase-todo directly it will suddenly stop working with
> this change if they have rebase.missingCommitsCheck set to error.
> 
> Having said all that we could decide that the existing error message is
> enough and allow the user to skip re-editing the list if they really did
> mean to remove those lines. It would be annoying to have to re-edit the
> list when one had intended to delete those lines.
> 

If we do not check the todo list after `exec' commands, patches 3 to 6
should be useless in this series and could be sent separately (I’m still
interested in reducing useless round trips to the disk).  I found a
cleaner way to do that, without touching to sequencer_continue().

For the main feature of this series, I need to write tests for it, and
then I’ll send it as a WIP series, once again.

Cheers,
Alban

