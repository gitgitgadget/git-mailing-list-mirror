Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A55A1F404
	for <e@80x24.org>; Fri, 16 Mar 2018 22:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752359AbeCPWTZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 18:19:25 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:40345 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750915AbeCPWTY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 18:19:24 -0400
Received: by mail-wr0-f193.google.com with SMTP id z8so3300814wrh.7;
        Fri, 16 Mar 2018 15:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=vBtaAMkNZG5/xwqTJSWDQtwqpVAVZCHCT6cQ/zch37I=;
        b=pz178+q6qPR0uLeD0eWn3uq+h1gFfeLFFQD+ZmaWfIp4p/GNgNpqmVqV+WnLa/3oDL
         2khgD3u1gtD7IDncy97L00PxdY3euqYw4i6FH2N8qA8tGCTOPhPpWdw+o4mzWyidE2i8
         DtPDM7ev1gYeAjn5AYKOKT2fwKVohWgyHyz4srWBho0Elb1e+O9RjUaG2ofcus6W2Caq
         cZzLj1f6p232mbgpJtEnUH0bRhfNed7OSV2dTjxffBY92QOeDgVNYShEwE221URUXFar
         5Cv8j1Ihg/vXK4qRPVQNpZZ7P8iHMAotQzh8CCpDfsUuO+zOOMQmsW4SC0XtvplpyXAK
         fgdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=vBtaAMkNZG5/xwqTJSWDQtwqpVAVZCHCT6cQ/zch37I=;
        b=HadivqegMuWRtE0W1EtcKgVPdkYWqeWbgQRFSN9a5cWyh/dJaugc0vD6MsHsl/MLnf
         RVPk++W2xmF0bVN5Q/+IQdIYF7IxJ5pdGYTmWzBaZdHfc9977GM2+FK2jTMo4MFLPR0c
         UcvEQEPO/BTvyeCW4X51OLQZo+rIdCVuEmqDYPkRWgyPvTWv0j9b1E7ZZlhhkgn/J7ie
         kDuHxY6MU0PDX1+odR2I9diXnq15LHJIKSYaCE1J5kUzvJtksAZzt51zJ5uGCQbugEnQ
         lsXCSxdLxRapGabJZUfEG33GEXXjaiS6rgjhEaM5FZQO4K64U/eT6jt5OH09oyDQlKlI
         bQ0A==
X-Gm-Message-State: AElRT7EWgym8K2g28vzqIEi9XzmKsbqB9+FkcW4agtobz47ZA9m/LdCF
        yESzZ7MPe8NfxWhz+/66eqUmpk6x
X-Google-Smtp-Source: AG47ELvtxBI2zGAFeqziCLyayfAHHc3mird5VJ3cbleRaqV4xc0KSyuuUjSm9Y5S6reFeyrA+M9A1g==
X-Received: by 10.223.160.195 with SMTP id n3mr3080350wrn.92.1521238762522;
        Fri, 16 Mar 2018 15:19:22 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id p29sm8247569wmf.3.2018.03.16.15.19.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Mar 2018 15:19:22 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, git-packagers@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RelNotes: add details on Perl module changes
References: <20180316220748.4279-1-tmz@pobox.com>
Date:   Fri, 16 Mar 2018 15:19:21 -0700
In-Reply-To: <20180316220748.4279-1-tmz@pobox.com> (Todd Zullinger's message
        of "Fri, 16 Mar 2018 18:07:48 -0400")
Message-ID: <xmqqd103zms6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Todd Zullinger <tmz@pobox.com> writes:

> Document changes to core and non-core Perl module handling in 2.17.
> ...
> Maybe something like this?  I had intended to suggest a note about
> NO_PERL_CPAN_FALLBACKS as well, so that's included too.

Thanks.  A help like this in individual areas from people more
familiar than I am is greatly appreciated.

