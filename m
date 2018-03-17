Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF7831F404
	for <e@80x24.org>; Sat, 17 Mar 2018 19:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753702AbeCQTrk (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 15:47:40 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:44719 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753490AbeCQTrj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 15:47:39 -0400
Received: by mail-wr0-f174.google.com with SMTP id u46so758180wrc.11
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 12:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=rFu64FmB5PBwh8MAVr6sk+QZ4uhoPW+7jJfbKLBKh9E=;
        b=V4B7qeFOpIBFDo2hbW5Z4pJMHGn/yp4ueT1Xj813QAU75oKlOyPPzXJwz6pZnWAnqG
         EFJqNadyXsSOJVd4XfNgW0luBXhUKjYCR1/hh5awW8bq36HcbrjNA0SWG3+W2qjtgpNB
         zRVyEjOew4phSo+oJMEswFp+hTs5sG2l++0UqtoHu4Z4Wx3r2WCg94+OOl7iOIr8bsTK
         sij5jHFvkv+yUv9rIfQmHFWdV34PA3AKGclrKoHRptwD1Yma1svtr6O7wet4awf0Ls4R
         i9oIT5yv8+onbqsFyuj2jB50Vusv/jPKJRk/sCeWnJuJOoNBtjBpXAKmEXRXkXEKefZu
         miKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=rFu64FmB5PBwh8MAVr6sk+QZ4uhoPW+7jJfbKLBKh9E=;
        b=lmeMOpLpnTRhlnB1uZaHJ1E676x0k7WoAV7ceea6yOepSj2Z8hpx5JCtvu1r5yGQfm
         512WKA9gV98n2Y7dc2qpzsVpF3xR59KjxGOOsaawhgXF8zeZO/fXfy8egCNQjohQR56w
         gL0jbNWPVWtes5V6VXdntbV4jdH60UW31SgHl2XUVVtZ5r/UQYXYJu/gdtUDnVjBOkyy
         I26pALG8gQ2gwc2be/LJ2nE3HQvpidlcxNiGo4m+hue3hjXPpalSU6Yok1F0W9nH0tYd
         aTb6LgCovhj+sD77PdY8e4YPJ4OK0nTB8l4P6xbpxx9e81mmm92U+PvexVaNmrX1fPIN
         biXQ==
X-Gm-Message-State: AElRT7HaQYlSJ2AKt17Y83b026ByquqcvhvcEdKpm1b35M0sdkgLkqwE
        8UgYNYqNYQVJf8QhNFLP2/U=
X-Google-Smtp-Source: AG47ELtKsC/ulaJzNaEAzOiwfd2uUfljaSnId+N856QLujhcQ8zadQ5slwC9Gbp2VNtYvZr7DFB67g==
X-Received: by 10.223.184.234 with SMTP id c39mr4903186wrg.67.1521316058614;
        Sat, 17 Mar 2018 12:47:38 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id 62sm9734388wrf.24.2018.03.17.12.47.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 17 Mar 2018 12:47:37 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     e@80x24.org, git@vger.kernel.org, gitster@pobox.com, peff@peff.net
Subject: Re: [PATCH v5 00/11] nd/pack-objects-pack-struct updates
References: <20180316183200.31014-1-pclouds@gmail.com> <20180317141033.21545-1-pclouds@gmail.com> <87po42cwql.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <87po42cwql.fsf@evledraar.gmail.com>
Date:   Sat, 17 Mar 2018 20:47:36 +0100
Message-ID: <87o9jmcwmf.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Mar 17 2018, Ævar Arnfjörð Bjarmason jotted:

> [...]I.e. on git.git we end up with just over a a 8.5% reduction, and[...]

Urgh, sorry, this should say "on linux.git...". None of these numbers
came from testing git.git.
