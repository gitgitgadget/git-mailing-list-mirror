Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38EE3200B9
	for <e@80x24.org>; Tue,  8 May 2018 03:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754015AbeEHDTF (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 23:19:05 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:47093 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753771AbeEHDTD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 23:19:03 -0400
Received: by mail-wr0-f193.google.com with SMTP id o2-v6so27771804wrj.13
        for <git@vger.kernel.org>; Mon, 07 May 2018 20:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=zCcPPWZlMyrqqhsHoXwXwu3zlX8tnAkwBIseejb+Xko=;
        b=UjbbysiX8r+Puyn90HHxejDEmrtkHyRGxLy6M6cv35zZgMW8h1wY7dMlHpj9MU3jPT
         QFUpEDXfQ/xzVww5EyyutJmynwMOLVvzxvO2Nq6GQySzovBFGZZ1Iaqff6KnlUxH9+N7
         o7g2msXPwSwq6XDpuQDAQOZGtBeYWI/DlRiGoqDE/vRMmy4B8CpBNnCEh8demw4olyK8
         SC8hddLaf3UHwLWMLDfxbWbyU9DOFSY0x05HvRZCcQtwC77Vn+yw5NTbn1NrDfaH/mUk
         sdYqXSbb4WXChYDq93MlFipWSgmt/F9w39/RhIWxZ1tHe6L2YQxT81nRPu4aiOBa7zKp
         9pBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=zCcPPWZlMyrqqhsHoXwXwu3zlX8tnAkwBIseejb+Xko=;
        b=grRGwpSslxyYYu/T4PJjXX/rRwEgLAnGjHKz6wJ+4m59Umbd2zT/dBLL1Y37KERHbv
         Kic0ZEkmaV3jG6kSECUuFnvq1e+x7dIMaOkHnVA7bY7wwXN3h8FnNgKEn9fE9TZKTdhw
         UXoJCw3qpzPPag+v7bugJ16Z6/r/P024naWg8hHW0P3D/JX43S4XD3E7iNeccNxUlfvC
         joAgmcF+EvD4Fona6BWJ7/UglrzTCe4UTg7sdvNVswiocaj+Yhf7ESIK4pXT7aKEyvhV
         ftn+bekBmqQu0FytrZC5h5bfOWOgH87LcIpzEWucot8vaNDQAJimFzYq7pgWeoae/LIh
         NpRw==
X-Gm-Message-State: ALQs6tCnlC5h5wH0t/OvDyB998W6LqbXsanjObA+ujR4WkdbJXhUmPyU
        Q9JH8PHXpEEPrCwkVX+yK2k=
X-Google-Smtp-Source: AB8JxZqBHl4QXw7Eld0XF/iE1pD7YDIuo2x5xDw0/BGDMzMxr99UHiY2gpWouJyddFi+5C8Dg4wylg==
X-Received: by 2002:adf:a58a:: with SMTP id g10-v6mr8894021wrc.233.1525749542070;
        Mon, 07 May 2018 20:19:02 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id b57-v6sm37972899wra.9.2018.05.07.20.19.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 May 2018 20:19:01 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Wink Saville <wink@saville.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Bryan Turner <bturner@atlassian.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/8] push tests: add more testing for forced tag pushing
References: <20180429202100.32353-1-avarab@gmail.com>
        <CACBZZX7HFnEMD8PKWj0c7VWqv=yeYCXYJjy-5YPZnF_pJAy0jw@mail.gmail.com>
        <20180429202100.32353-4-avarab@gmail.com>
        <xmqq8t8uoovn.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 08 May 2018 12:19:00 +0900
In-Reply-To: <xmqq8t8uoovn.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 08 May 2018 11:35:56 +0900")
Message-ID: <xmqq4ljiomvv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I couldn't quite get what you meant by "(but not the other way
> around)".  Did you mean
>
> 	$ git push --force ../child2 refs/tags/*:refs/tags/*
>
> should not become non-forcing version because of the (lack of)
> prefix on the refspec does not trump the --force command line
> option?  If so, making
>
> 	$ git push --no-force ../child2 +refs/tags/*:refs/tags/*
>
> not to force would make things more consistent, I suspect, i.e. we
> can simply declare that presence or absense of '+' prefix in the
> refspec determines the forced-ness of the push/fetch when there is
> no command line option to decide it, but an explicit command line
> option will always override it.  
>
> Am I missing something obvious?

And of course I am missing the fact that --force and --no-force
controls a single boolean.  If it controled a tristate (unspecified,
false, true), then what I wrote above makes tons of sense, but that
is not the reality.  "git push --no-force" is saying the the same as
"git push", and its primarily reason for being there is to countermand
a "--force" that appears earlier on the command line for whatever
reason, e.g.

	$ alias push='git push --force'
	$ push --no-force ../child2 ...

So what you said in this patch 100%  makes sense.

