Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49EB61F404
	for <e@80x24.org>; Wed, 28 Feb 2018 20:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934341AbeB1UZS (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 15:25:18 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39522 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934119AbeB1UZR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 15:25:17 -0500
Received: by mail-wm0-f67.google.com with SMTP id i3so6094271wmi.4
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 12:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sey5Kta1ROE841e9LD1nEo91OoudLj5BPzHKX/OLRnk=;
        b=VgtBXo25Prpu+lQiyCWPoapyUu5bSzTejbEk3J2kbxIBBXOoASUQkYOL131GzceMgT
         iH+cAExSobcQtjx4R3D+evIBk1G8w4AY48MiOB9GqRiWfTJnn94VIGGZydijBSX+b9PG
         Y6YKGpJWkbGRy7B/c36lwngF6JIkRF9GkYMJZ/173ZwBkgTqpGRC+xsLmp4dtfSwOqHR
         nIuKBC9wlEIy2uCUMqK6VdfinkCa4Edjq+z7+A0Q+DY7C8zWRkbOTDkEKQ1pcE0pCK7X
         peXaBnuVSc8I3ijOKpVB65wzhlJzOKKX5R5at0MS3yjc8LsailSyPX9lZAZZLwp3lMWU
         6MJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sey5Kta1ROE841e9LD1nEo91OoudLj5BPzHKX/OLRnk=;
        b=rLDrdmzMVBFdIs0VOpVWfKdQMb4A1MLxy5H0yw6JBE18ywN3rMcP42k7sQNGJY12Zv
         SS6iOqiAMkYmDwMZLfcIdY3P1Xfb1XbwpHUa9XvsxpkR/T1n5bdIbLjRKTVrY0eotre/
         zOf2HHyWpEE9CFUCAQVQiKS2NOGjckbHBar/Y0O4QW0AG3ptTlPBtEisoC6Kt+AINEYq
         wIQODsrXR3xpe1xTvia/d6D8b577J8uQpIKnyPkPRg//W2s8sSXGRflAcyeUU0H6Ro2J
         euN6rBcZ53rsHUuruxu5rCyuuKlYViPJMs1tHxGtFgz8DJM3Pqp3BRh3aCbP+Zzg+Ojj
         H0IA==
X-Gm-Message-State: APf1xPDAocclJ3tb1PPA1GEPH92gLUFYHYLklatFjzjJS5A2IRCmWM/h
        /O7eTyPJJibNYW9QxnG7wgg=
X-Google-Smtp-Source: AG47ELvNLDqoLKlOfKFOWVAiUwQbWQdUO0YfriDGlHPhSCIPFTPiy0oiY+voqfEVxrbsO4F9scmyJw==
X-Received: by 10.28.1.208 with SMTP id 199mr15046277wmb.26.1519849515507;
        Wed, 28 Feb 2018 12:25:15 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id q9sm1390559wrf.11.2018.02.28.12.25.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Feb 2018 12:25:14 -0800 (PST)
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution (Road
 Clear)
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
References: <87y3jtqdyg.fsf@javad.com>
 <bbe64321-4d3a-d3fe-8bb9-58b600fabf35@gmail.com>
 <nycvar.QRO.7.76.6.1802270051470.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <CA+P7+xq8UUcLWomUi=PS_hTKfJd3dMAxMmhioDS1bixwcmKAqw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1802271718090.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <4d7f3406-b206-cc22-87df-85700d6a03d9@gmail.com>
 <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com>
 <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com> <87606hoflx.fsf@javad.com>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <0ac3a3fd-4053-e32e-75ed-8829f22c2e1f@gmail.com>
Date:   Wed, 28 Feb 2018 21:25:07 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <87606hoflx.fsf@javad.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sergey,

On 28/02/2018 06:19, Sergey Organov wrote:
> 
> > > (3) ---X1---o---o---o---o---o---X2
> > >        |\                       |\
> > >        | A1---A2---A3---U1      | A1'--A2'--A3'--U1'
> > >        |             \          |
> > >        |              M         |
> > >        |             /          |
> > >        \-B1---B2---B3---U2      \-B1'--B2'--B3'--U2'
> > >
> >
> > Meh, I hope I`m rushing it now, but for example, if we had decided to 
> > drop commit A2 during an interactive rebase (so losing A2' from 
> > diagram above), wouldn`t U2' still introduce those changes back, once 
> > U1' and U2' are merged, being incorrect/unwanted behavior...? :/
> 
> I think the method will handle this nicely.

That`s what I thought as well. And then I made a test. And then the 
test broke... Now, might be the test was flawed in the first place, 
but thinking about it a bit more, it does seem to make sense not to 
handle this case nicely :/

> When you "drop" A2, will A3' change, or stay intact?

When you "drop" commit A2 from rebasing, patch (diff) A3' does stay 
the same - but resulting tree (snapshot) after applying it does not.

By removing commit A2 from your rebase, you`re saying that changes 
introduced in that commit shouldn`t ever happen in the rebased tree, 
so trees/snapshots of all rebased commits coming after dropped A2 
will have these changes missing, in comparison to trees of original 
commits they`re being rebased from.

> If it changes, say, to A3'', the U1' will change to U1'', and the method
> will propagate the change automatically.
> 
> If it A3' doesn't change, then there are no changes to take.

All true, but note what I wrote in the original message - the issue 
of dropping A2 is not U1, but U2, and that one doesn`t change.

In this case, U1' will correctly represent U1 rebased on top of A3' 
(where A2 is now missing), no problem there.

But on the other end, as U2 holds changes between original merge and 
B3 (being A1, A2, A3 and evil-merge M), it will also still hold 
changes introduced by original A2.

Rebasing it onto B3' brings all these changes along, and once merged 
with U1' to produce "rebased" merge it unexpectedly introduces 
supposedly dropped commit A2 changes in their full glory.

Yes, considering this situation a conflict, as originally proposed, 
by simply noticing that U1' and U2' differ, helps this to fail 
loudly without doing the wrong thing.

But U1' and U2' are really to be expected to stay the same in 
non-interactive rebase case only, where it doesn`t help interactive 
rebase case at all if it is to fail most of the time (where U1' and 
U2' don`t have to be, but should be expected to possibly be different).

So while your original proposal currently seems like it could be 
working nicely for non-interactive rebase (and might be some simpler 
interactive ones), now hitting/acknowledging its first real use 
limit, my additional quick attempt[1] just tries to aid pretty 
interesting case of complicated interactive rebase, too, where we 
might be able to do better as well, still using you original proposal 
as a base idea :)

Regards, Buga

[1] https://public-inbox.org/git/8829c395-fb84-2db0-9288-f7b28fa0d0d1@gmail.com/
