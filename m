Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00D411F461
	for <e@80x24.org>; Fri,  5 Jul 2019 11:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbfGEL34 (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jul 2019 07:29:56 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40500 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727924AbfGEL34 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jul 2019 07:29:56 -0400
Received: by mail-wm1-f65.google.com with SMTP id v19so8986112wmj.5
        for <git@vger.kernel.org>; Fri, 05 Jul 2019 04:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=dowuW2W2kzsheqjkX7bAzx/8ar1QGCT2vmGRV5Bsp4U=;
        b=SryXh2o7CILzDn16Y+fRtF8nfJ9g5UFzNu6JxCl2I3RRwnyUU+aH6BiBkKQkhFo/pn
         L3esWHDvQIh9yuiwbmRtjmNFvIgqC6R7zut6lC/b6qC1ydkGCTW0TPTCafieTFVFLam/
         Ic5/JkstZ8E3BHH5695Jhhc6MGTptwQkAN0jdQ5sAqdNsZD3fO2KCfl3g2J4FwBCs11z
         cuctnBSfBR/jaYuPup2SswXttbwboJUAXxSVb5BEvgGm8dbKoBH4cpD2XH0FvJczesas
         mvKjpL6CO2gzrztwayGGAvmQ3x7m7V+K06omGPU2KeHrVjgN3oO0PYWY6Sqfr/im3htQ
         MdHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=dowuW2W2kzsheqjkX7bAzx/8ar1QGCT2vmGRV5Bsp4U=;
        b=MvhR6ejshnCxlgj7p+JSJpKlFf2yylLZ/uzKYOXJAIgMmobV5doLgLuyZeoYcVm0+O
         DSfxHX0yZ84XvdmLUO5LzvGjOEqIGI1pElTO7dUHXAQ6zIYnUvhhSr331VMMTqcUwurw
         g+FiEcKO806PViZPj/LljqeFqumxJkzlzQtxwnwF2ThF+8dgfJvnifpkACLuCmd7QJpP
         Y+9HafxqPWuHLX4ICXsM27W+O1GBzLbIiK1tc+n6UUItJGkPhMsuslZOEWJLQjIIThmC
         BODkEr0b1DVyp5xQ69raNtsTc6DlBsdKL6Q9JoWtJ7C/TUnlbPQnL4vsZRmHdso7c6W+
         vPGg==
X-Gm-Message-State: APjAAAXoqcQKx5uRhqbXQz8CoCfJ+0RtRJWVbWXu0p60pDHwfi00psoc
        JBmMwn5PDUOuNs70bs3w20atNMnB+cQ=
X-Google-Smtp-Source: APXvYqy1wRJrCeEfpmID7kSCLhLJEj9MKZAYqYAsAIMh60x047Ey+doy/r5BPNJWpyjMTR1JjMiDkA==
X-Received: by 2002:a05:600c:2146:: with SMTP id v6mr3106480wml.59.1562326194111;
        Fri, 05 Jul 2019 04:29:54 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (ekg120.neoplus.adsl.tpnet.pl. [83.21.174.120])
        by smtp.gmail.com with ESMTPSA id w6sm9752922wrp.67.2019.07.05.04.29.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Jul 2019 04:29:53 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Mike Hommey <mh@glandium.org>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: Surprising use of memory and time when repacking mozilla's gecko repository
References: <20190704100530.smn4rpiekwtfylhz@glandium.org>
        <20190704120411.2dlzdlsooob4dc7k@dcvr>
        <20190704131320.ksustvlayy6lby23@glandium.org>
        <20190705051412.GB25459@sigill.intra.peff.net>
        <20190705054736.6llkhnopt2fcta2k@glandium.org>
Date:   Fri, 05 Jul 2019 13:29:52 +0200
In-Reply-To: <20190705054736.6llkhnopt2fcta2k@glandium.org> (Mike Hommey's
        message of "Fri, 5 Jul 2019 14:47:36 +0900")
Message-ID: <86bly81zyn.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mike Hommey <mh@glandium.org> writes:

> On Fri, Jul 05, 2019 at 01:14:13AM -0400, Jeff King wrote:
>> On Thu, Jul 04, 2019 at 10:13:20PM +0900, Mike Hommey wrote:
[...]
>> I think I explained all of the memory-usage questions in my earlier
>> response, but just for reference: if you have access to it, valgrind's
>> "massif" tool is really good for this kind of profiling. Something like:
>>=20
>>   valgrind --tool=3Dmassif git pack-objects ...
>>   ms_print massif.out.*
>>=20
>> which shows heap usage at various times, points out the snapshot with
>> peak usage, and shows a backtrace of the main culprits at a few
>> snapshots.
>
> At the expense of time ;) A run would likely last an entire day under
> massif (by which I mean a full 24 hours, not a 9-5 day).

Valgrind, as I understand it, runs the program under emulation.  I
wonder if perf / OProfile based solution could help here (gathering
memory-based events and metrics).

There is also trace2 built-in into Git, but I don't know if it could be
used for this purpose or not.

Best,
--
Jakub Nar=EAbski
