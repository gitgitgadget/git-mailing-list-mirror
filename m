Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3739E1F404
	for <e@80x24.org>; Thu, 14 Dec 2017 17:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753932AbdLNRzk (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Dec 2017 12:55:40 -0500
Received: from mail-wr0-f176.google.com ([209.85.128.176]:39432 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753859AbdLNRzi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Dec 2017 12:55:38 -0500
Received: by mail-wr0-f176.google.com with SMTP id a41so5855431wra.6
        for <git@vger.kernel.org>; Thu, 14 Dec 2017 09:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=5VIsxAaHVKa2+9tS/rP6k8Zbys8sI0fDrmqlHiHbbMQ=;
        b=QkY+KyeDbDGeYGD4RdqIiI9sTHHSNSMrZKdjCD6/vlwrGc0RhL3LMf37V2H4YO5J0p
         OIdEZVbdff9Yb0zlms2Zf5T7Z+1uXuvF9aJ2sCIzVGDavYcLZwbX9TDs8Bhuwlt/SteD
         uWvjl1FvCh967DKMV5Oj4gg4pMNfC3zsltjSJ2xkKOpNtl5QdSzOThJe4G3tYPaKr9Su
         UEz/un5pESO7W2MJA0rfWsfHM+62KVnimv+MFghZsVVcmWEnjwZnct9WiCR18hD0+C0C
         ZG/eOxUUqpzNVPU2KbMcRn8OL8pAt/cfz4eH1lkB1b7VJcncb12xgNR8NMkCUD+p7JSV
         q2TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=5VIsxAaHVKa2+9tS/rP6k8Zbys8sI0fDrmqlHiHbbMQ=;
        b=Nq6dNKEOs8n3V4IktliGtg7KmjmGSVopJnVNx1EExYsplpy/GzKNTBMqjfHm4PfDVB
         ZhNfv9HIfug83GcjOsoxIbhdrfm9AVmfuQt4Em1AROyw+KgrX/2GS6Mk9i/Ij+P8l1vr
         ovLIyP3GMgLqgQcXBHVrAzTXacyIcdA7vaaMWluuS9ZgLcbTL4xTYZYMgjyRrKgpJZ6T
         i7qv666MeAABFTkdvHzuXocIXTtiRFy20b92nAuFPLsVqc+m1fuzyxcXjXO8ybuCq55V
         ul2VaRYUsKCE1DhXj22RjGdFq0QIY78Apo3Z7j4WdfRpwjn3qBOl5FsEikUkauz0MoR5
         l+vw==
X-Gm-Message-State: AKGB3mJOw4xVP1oKjdRZmlqUloI/QmPP+4+YZqQsLCQIepoIDjN+2/t1
        adPVrmWCNH7Jlyvb6TNlf+U=
X-Google-Smtp-Source: ACJfBou+RpsqpmKjpghqXM3iThwXP9DA6JAkKBnhlK883buSZbnTBi25yulDRG/vEr9v+Zzz7SSlpg==
X-Received: by 10.223.133.68 with SMTP id 62mr7366886wrh.243.1513274137695;
        Thu, 14 Dec 2017 09:55:37 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id n32sm8625185wrb.62.2017.12.14.09.55.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Dec 2017 09:55:35 -0800 (PST)
Received: from avar by evledraar with local (Exim 4.89)
        (envelope-from <avarab@gmail.com>)
        id 1ePXjK-0006Dp-UJ; Thu, 14 Dec 2017 18:55:34 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "David A. Wheeler" <dwheeler@dwheeler.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] doc: Modify git-add doc to say "staging area"
References: <E1eOwqn-0005Bd-OB@rmmprod05.runbox> <CA+P7+xrWFE+6t-Z8cGQX5WtZP1_EQSa+J7vF65dLDSOnLfFxXQ@mail.gmail.com> <01075529-4B7B-4C05-927F-0504315F2B3F@dwheeler.com> <CACBZZX5XDKwwXWtH8V9QD5v-4i+nHPuZ8x2n_Z3zuexQmg2mgw@mail.gmail.com> <662C691D-7263-4469-87F4-4BA8A50CC4E8@dwheeler.com>
User-agent: Debian GNU/Linux 9.2 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <662C691D-7263-4469-87F4-4BA8A50CC4E8@dwheeler.com>
Date:   Thu, 14 Dec 2017 18:55:34 +0100
Message-ID: <87wp1pb3e1.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Dec 14 2017, David A. Wheeler jotted:

> On December 13, 2017 7:54:04 AM EST, "Ævar Arnfjörð Bjarmason" <avarab@gmail.com> wrote:
>>After your patch the majority of the docs will still talk about
>>"index", is this part of some larger series, perhaps it would be good
>>to see it all at once...
>
> Yes, this would be part of a larger series.
>
> I'm happy to do the work, but I don't want to do it if it's just going to be rejected.
>
> The work is very straightforward, in almost all cases you simply replace the word index with the phrase staging area.  The change is similar for the word cache.  So I'm not sure what seeing it all at once would do for anybody.
>
> Are there one or two other files that you would like to see transformed to see as an example?  If you're just looking for a sense of it, that should be enough.

No I get the idea, I'm just wondering if you'll continue to work on
this, because if not mentioning "staging area" in more places without
continuing to eradicate "index" isn't going to improve things much, and
possibly make it worse. I like the direction of this series.
