Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5AAA1F404
	for <e@80x24.org>; Tue, 28 Aug 2018 16:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbeH1Uui (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 16:50:38 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:44652 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbeH1Uui (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 16:50:38 -0400
Received: by mail-wr1-f49.google.com with SMTP id v16-v6so2228364wro.11
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 09:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=/oYayDifbllWoMyYF3ePKZOI8imJ87cJe52LgnMhlOo=;
        b=Z28JoP4TYvU/DPXtXNlGnNuIiAIRRrwEwFzFhlu6peibAHARp9g9cUc+aqBDIVjr75
         oMsTLMk6T7iQ0fGjJCDGlK0+zfB4kfpd9gkUaKz0/LelZJEwqjqEN8cI5KC7aj5p/y7y
         PBUT62EVNcXLrzY5tWS4kvhIuoLuGsfWerUdiXPcFeK40NobHOGFAgRaKFIReNY/Zjbd
         K7auu7Up4mQPfkIIiwISfNTKcVVqzM33jdyj0BW3hGQ2jpgruTnqTUgCnsFsALjGVuCp
         ujVrwZl7fZyZvq0T+TU5JpKQgRjD2QlgaE/3afU4wavM6TtRvCtEN+Zs5FwpzOmdIUBK
         rC+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=/oYayDifbllWoMyYF3ePKZOI8imJ87cJe52LgnMhlOo=;
        b=GpkpTXW8KOlm69zgJkGh3v5ETDeaGH76dCUU+A2jZcKEm0GEl5e+U6lfp3iXd4e/sT
         rMK1nAeK+/3kJEURj6BaVyWtGQpArdIc7FhK9r44Cl7pKTo2wQl6L649voQydc4oraJ1
         QK1OOJSc4g57dlVCEfYtpWMU9j0uVPRuYFtVWOMEpebMeNxUzb0x5nGbXbYa0lV62n52
         JBr/a3lTiCrerXJm8nRbk+HFIpKyqhnaTm+EWxUH5JAqqiYXVS+T42PQ668g1McKvopd
         F+q9wdrCBrpDcrvQrGd3dJolwszAf8qXdOF2dHmHCFzMrpDFXAmepf1shEwTf3H1SilM
         EAHg==
X-Gm-Message-State: APzg51Bw8TYhNj2TqYmuOZVDqRk/xlUN6oZVMxtjwUOQqICoCgrEr06M
        mhhjfe9BrD4C+Io9XSvl5ds=
X-Google-Smtp-Source: ANB0VdZaZajcQ73IqowjhE1vOCOoKFdTh8W1JiDA45SKmtWE6fP+JvbwiTj71RGUJPF0SOMDf6HMpw==
X-Received: by 2002:adf:b609:: with SMTP id f9-v6mr1689275wre.14.1535475483996;
        Tue, 28 Aug 2018 09:58:03 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id g129-v6sm2758627wmf.42.2018.08.28.09.58.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 09:58:03 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= 
        <avarab@gmail.com>, corrmage@gmail.com,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Subject: Re: A rebase regression in Git 2.18.0
References: <679370A8-E477-450D-96E5-6B1869D27576@gmail.com>
        <87in3ueiks.fsf@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.1808281532220.16620@tvgsbejvaqbjf.bet>
        <CABPp-BENB=mqfFU4FGb2OS9VDV=9VdT71HhFLZwtyxD8MpdTMQ@mail.gmail.com>
Date:   Tue, 28 Aug 2018 09:58:02 -0700
In-Reply-To: <CABPp-BENB=mqfFU4FGb2OS9VDV=9VdT71HhFLZwtyxD8MpdTMQ@mail.gmail.com>
        (Elijah Newren's message of "Tue, 28 Aug 2018 08:35:03 -0700")
Message-ID: <xmqqh8jeh1id.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>   - Add a flag to turn off directory rename detection, and set the
> flag for every call from am.c in order to avoid problems like this.

I'd say this is the only practical solution, before you deprecate
the "pipe format-patch output to am -3" style of "git rebase" (and
optionally replace with something else).

The whole point of "am -3" is to do _better_ than just "patch" with
minimum amount of information available on the pre- and post- image
blobs, without knowing the remainder of the tree that the patch did
not touch.  It is not surprising that the heuristics that look at
the unchanging part of the tree to infer renames that may or may not
exist guesses incorrectly, either with false positive or negative.
In the context of "rebase", we always have all the trees that are
involved.  We should be able to do better than "am -3".
