Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 495281F404
	for <e@80x24.org>; Wed, 28 Feb 2018 00:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751795AbeB1ALB (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 19:11:01 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:51961 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751628AbeB1ALA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 19:11:00 -0500
Received: by mail-wm0-f41.google.com with SMTP id h21so1795376wmd.1
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 16:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=gU66JSbhsiEvo5bS4Vd1GKbtF/IK94Xp2bhxs6V7xPw=;
        b=msthUfXvo4PuoT+OzAIzLNJU3ORoJCj9DlvP8xkPlbidhalba0uvKQ+dO2g7rROL4O
         1TsZdY0Omf6uz96FU3eZ6Mxy7rQRNyAQ3AUUaiANZpOxnxBk6YzXDpeYWz8b+8eGoNkq
         NqF7cHJqOwbhbSrZv70TXxbbeVZIN21jQTVtk3TOuanklOUmuBRKXxp5YQP/CeDGYd+j
         I5+z5qdZCtZ5gXKIaR2cu22nazxMkKIg/645/DT++K0PTlReqSqPjHmP7VoEZF5iF0rD
         6CZ8lgVK5If9zJUFipiwTef+r+ApYtr4RFfXH9iygCJJwtxz536fx1GwNn2mx4TejN+u
         oBZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=gU66JSbhsiEvo5bS4Vd1GKbtF/IK94Xp2bhxs6V7xPw=;
        b=Uzf51N3K6D6OtEG3pzEN11Wc4cbzSdbCmejL91wwdTPNy9zNzSUbI+OZtsNNad71GG
         JepgRom2kAgkeKOtSCelP4Oz3cid89FFMb+9TCxo9traeGMGYDsqR96I+JEi/HFakYR5
         QWk2Kl2p3s7xMQR+pWueed5hYI8hs/UJjw1qfpZBSAcwuK0Q93tfeqsvk88ghgaVyx6D
         b5ua/qpht8Um+wjmXBxVySEvQyyXa4QrGgek8/CKzo4tmTdw38eDzQunLBGCML7kJVCM
         ugo9zOPi5mvy9K5Ep4XRyt1EXJInRTfOiHcR8chLuBVlYq0QsT2bEwm+9eoSja9OsLkW
         cZpA==
X-Gm-Message-State: APf1xPBwgCFevEmWJ6yWGb7sqiavMKE0sXqrO+cNm8nN8m1aw4pBm98K
        k+Z9r4Zoef1exZNpkYhoxY8=
X-Google-Smtp-Source: AG47ELurZaB8v1OJGH2C6HCwtcTahfLPmyFiSV8P6RX6whpahVIKFSlb++YNldteOzD8YuAuVcif7g==
X-Received: by 10.28.145.136 with SMTP id t130mr12318062wmd.36.1519776658672;
        Tue, 27 Feb 2018 16:10:58 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 69sm777087wmw.32.2018.02.27.16.10.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Feb 2018 16:10:58 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Sergey Organov <sorganov@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution (Road Clear)
References: <87y3jtqdyg.fsf@javad.com>
        <bbe64321-4d3a-d3fe-8bb9-58b600fabf35@gmail.com>
        <nycvar.QRO.7.76.6.1802270051470.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <CA+P7+xq8UUcLWomUi=PS_hTKfJd3dMAxMmhioDS1bixwcmKAqw@mail.gmail.com>
        <nycvar.QRO.7.76.6.1802271718090.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <4d7f3406-b206-cc22-87df-85700d6a03d9@gmail.com>
        <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com>
        <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com>
Date:   Tue, 27 Feb 2018 16:10:57 -0800
In-Reply-To: <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com> (Igor
        Djordjevic's message of "Wed, 28 Feb 2018 00:40:31 +0100")
Message-ID: <xmqqwoyym0ry.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Igor Djordjevic <igor.d.djordjevic@gmail.com> writes:

> On 27/02/2018 20:59, Igor Djordjevic wrote:
>> 
>> (3) ---X1---o---o---o---o---o---X2
>>        |\                       |\
>>        | A1---A2---A3---U1      | A1'--A2'--A3'--U1'
>>        |             \          |
>>        |              M         |
>>        |             /          |
>>        \-B1---B2---B3---U2      \-B1'--B2'--B3'--U2'
>> 
>
> Meh, I hope I`m rushing it now, but for example, if we had decided to 
> drop commit A2 during an interactive rebase (so losing A2' from 
> diagram above), wouldn`t U2' still introduce those changes back, once 
> U1' and U2' are merged, being incorrect/unwanted behavior...? :/
>
> p.s. Looks like Johannes already elaborated on this in the meantime, 
> let`s see... (goes reading that other e-mail[1])

As long as we are talking about rebase that allows us users to
adjust and make changes ("rebase -i" being the prime and most
flexible example), it is easy to imagine that A1'--A3' and B1'--B3'
have almost no relation to their original counterparts.  After all,
mechanical merge won't be able to guess the intention of the change
humans make, so depending on what happend during X1 and X2 that
happend outside of these two topics, what's required to bring series
A and B to series A' and B' can be unlimited.  So from that alone,
it should be clear that replaying difference between M and A3 (and M
and B3) on top of U1' and U2' is hopeless as a general solution.

It is acceptable as long as a solution fails loudly when it does the
wrong thing, but I do not think the apporach can produce incorrect
result silently, as your example shows above.

What you _COULD_ learn from an old merge is to compute:

    - a trial and mechanical merge between A3 and B3; call that pre-M

    - diff to bring pre-M to M (call that patch evil-M); which is
      what the person who made M did to resolve the textual and
      semantic conflicts necessary to merge these two topics.

Then when merging A3' and B3', you could try to mechanically merge
them (call that pre-M'), and apply evil-M, which may apply cleanly
on top of pre-M', or it may not.  When there aren't so huge a
difference between series A and A' (and series B and B'), the result
would probably be a moral equivalent of Sergay's "replay" (so this
approach will also silently produce a wrong result without human
supervision).  One edge the evil-M approach has over Sergey's "dual
cherry pick" is that it separates and highlights non-mechanical
conflict resolution out of mechanical merges in a human readable
form (i.e. the patch evil-M).





