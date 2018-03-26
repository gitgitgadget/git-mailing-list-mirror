Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF5751F404
	for <e@80x24.org>; Mon, 26 Mar 2018 14:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751824AbeCZOIc (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 10:08:32 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:35971 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751127AbeCZOIb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 10:08:31 -0400
Received: by mail-wm0-f48.google.com with SMTP id x82so15713001wmg.1
        for <git@vger.kernel.org>; Mon, 26 Mar 2018 07:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=lINFTNvSGqmGayuc83bjvrACbWyL7lD1ybYRmWwK/m4=;
        b=dkCq0puGZ7xGYapKQdpjCy1tB83shSuJ/h/lP1xxhflFvuiznFpFkICyDpip2mJli0
         zXot7ma0c4nSlWFF2IjZrZVrs490c+3t/2MFFUjQmHG4PA3wZok9prKzTsO09OBAMyg3
         w+bUDl+3+75RSo6w9MX967ko5IqgTqkGuVcAnoXDbBqcQqYc01aTnzuNkuFd2t8kbkGZ
         FZ5ipyACryEnWbDdbBrzErZDNxGjXV2XzdQu/AuybZub3szs0+GjO62h6gxR+cvtdt37
         TB0qxujhZUtTY9s5PgZw9ArpmuLNy9n6pgbNWfPS6aT0mnrruaOXDTkj4uVxF4o9yNOq
         ThrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=lINFTNvSGqmGayuc83bjvrACbWyL7lD1ybYRmWwK/m4=;
        b=luJ7CStd08CpGE7MKBvWI95rx3EtVRPqAKQdR0tkmUZbUC8JgQ4j6MypsmJcw/Bu5H
         xMVdXoGIBp4Dy/NmUMfTVZslAYJSj7/CaPAPoKC7+TtAn72tqIgY8Rv7n3PwSWtF1rVd
         MgiqULDFTQ2EY/2eeKKN7eGFELvlMRSKflI+zn6F6si9HBavCITml8SX5EkazyMb6uHc
         FK51wNhocVo+g1soI/W6sCXv8qOodYFIwLF4LTM7b9C8um9vOi3/lawiwfo+xrPOK+oK
         +dFUWCIZpN7rf9kH/Ktjt3NiNDF0iIcgh1xIkLh4qUIgC7aGQiGKhPLgUd56SIOIALrz
         ZJ/g==
X-Gm-Message-State: AElRT7HZOxLXRIFtAojHJmJ4pf8gNRaP0QF1oVktn8W4VSu40LLrOdIq
        1Ff0VG7bynCNmPBSZAhEYeI=
X-Google-Smtp-Source: AG47ELvaw6Tf0TFsXb7iN4vVbC0TSBDe/5bFSOfnShi165pHL6egMcwdESD5wVmJo1UghDqId8kBlQ==
X-Received: by 10.80.222.205 with SMTP id d13mr18470829edl.76.1522073310694;
        Mon, 26 Mar 2018 07:08:30 -0700 (PDT)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id d89sm10088649edc.75.2018.03.26.07.08.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Mar 2018 07:08:28 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Daniel Jacques <dnj@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v7 0/3] RUNTIME_PREFIX relocatable Git
References: <20180325205120.17730-1-dnj@google.com> <877epzyi0b.fsf@evledraar.gmail.com> <CAD1RUU-EoitBdoXL_JQoP+Q9BuA_6Fq65Ra-f+Atz8YNOV3Cig@mail.gmail.com>
User-agent: Debian GNU/Linux 9.4 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <CAD1RUU-EoitBdoXL_JQoP+Q9BuA_6Fq65Ra-f+Atz8YNOV3Cig@mail.gmail.com>
Date:   Mon, 26 Mar 2018 16:08:28 +0200
Message-ID: <87zi2vvsir.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 26 2018, Daniel Jacques wrote:

> On Sun, Mar 25, 2018 at 5:15 PM Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> wrote:
>
>> This looks good to me this time around, couple of small nits (maybe
>> Junio can amend while queuing):
>
>>   * You add a dependnecy typo in 2/3 but fix it again in 3/3. Should be
>>     squashed.
>
> d'oh, I'll fix that in my local copy so that if I do end up needing to
> upload a new version, it's available.

\o/

>>   * s/\Q${gitexecdir_relative}\E$// in 2/3 can be done less verbosely as
>>     s/\Q$gitexecdir_relative\E$//. Discussed before in
>
> https://public-inbox.org/git/CAD1RUU-3Q_SYvJorU+vEY2-0CPMZ1eL-41Z6eL7Sq4USiJ0U+w@mail.gmail.com/
>>     seems like something you just forgot about.
>
> Oh sorry, I must have missed that. I have a personal preference for adding
> brackets for clarity; it leaked into this patch set. I did implement most
> of the suggestion, which was to use the escaped Q/E instead of equals.
>
> Stylistically I still prefer the braces, but I'll defer to you and remove
> them in my pending patch set in case I'm asked to submit another version.

If you prefer it that way just keep your version. It's your code and
it's just a trivial style difference.

I just mentioned it because in the previous discussion you said "I agree
it's cleaner" so I inferred that you'd just forgotten about it but meant
to change it. It's also fine if later you just thought "you know what,
I'm doing it my way" :)
