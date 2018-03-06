Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 548141F576
	for <e@80x24.org>; Tue,  6 Mar 2018 08:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932425AbeCFIHC (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 03:07:02 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:40870 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750797AbeCFIHB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 03:07:01 -0500
Received: by mail-wr0-f194.google.com with SMTP id o76so19905413wrb.7
        for <git@vger.kernel.org>; Tue, 06 Mar 2018 00:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=mD6jPXNx2+AAFZohqIUBOJwR26pvAWDeVVubpu0HFmY=;
        b=caSvazCebFGeWgeCx+GJV1W9wNW97gzjrQY0Fdq+xE+61QQbFql492QFLzrYRLdTWS
         7kyFsfRHyvL3gQr0I/ZdR7pMyiJX/GKbCJ7ClwZqMLA0dBq10lXNK7cfIkKtyZxj+fSL
         cZCcHLxEOlHUecnpNbsxS3EfygeBNKoyfO5oNmjrkXCeKhmmajROH+bzrA1xmLaSXNpD
         C93msi163+tMCJ4zH//xzGL+btNRIAM00mPZ6qls2vRRGnz6PmEjxmIvjYIgtUDHenXy
         lr6SgyG5O3LY5lE7r5flKodj498FQEgG+GYzVUz3lEkAD28QoGrmO1f3LpyrgBfRA6CR
         K4bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=mD6jPXNx2+AAFZohqIUBOJwR26pvAWDeVVubpu0HFmY=;
        b=gtmSzZh2qM1X7UrzLxWA3urlRGoh2+o+utZADHlHrWu2UJgG9CZ6SM2F1+X1goBqRp
         vkhXLWHesQeHofgnP/wmjshNyX29vKPxgjfhoxVP8b37bmMvW/7RbS4Off8FxNM7+hCL
         RKNPg20AHRDwyoVG0c+2BptR6Cch7ROZwJmEDd0iUQU1doBzxpqvvsCGIQrP5bpqexvr
         wxrSKohW6vMxq6Aq79gm35J432RBvKHWD9Gu5TRREWByIwHtpzDuOBidR5cJ+VXwwyn1
         PnZup0kFSIN1W5t/2VACIbnOPi3hLWCJPFtcGppLHdkITjy12zIn5xqdepIRiMKS1Gzw
         Edng==
X-Gm-Message-State: APf1xPCAqFFXxaod7mw407nUTZLi/36hg8wZf8GYEzuPdxOFtmz/rEs8
        uj8bGa+YW7ma1Ye3qMNtMMs=
X-Google-Smtp-Source: AG47ELvSy/5TrgCXgkQOUhWPMypZyobTA1ZsJ5yD0xvtjuoD6Rj0bD+Zr+kj8xUchR5bXiEV04m1CA==
X-Received: by 10.223.144.35 with SMTP id h32mr15861415wrh.2.1520323619755;
        Tue, 06 Mar 2018 00:06:59 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id w17sm13724919wrb.12.2018.03.06.00.06.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Mar 2018 00:06:59 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Ludwig <chrissicool@gmail.com>
Cc:     git@vger.kernel.org, Nathan Payre <nathan.payre@etu.univ-lyon1.fr>,
        Matthieu Moy <matthieu.moy@univ-lyon1.fr>,
        Timothee Albertin <timothee.albertin@etu.univ-lyon1.fr>,
        Daniel Bensoussan <daniel.bensoussan--bohm@etu.univ-lyon1.fr>
Subject: Re: git-send-email: Support for Reply-To
References: <20180303235814.7241-1-chrissicool@gmail.com>
Date:   Tue, 06 Mar 2018 00:06:58 -0800
In-Reply-To: <20180303235814.7241-1-chrissicool@gmail.com> (Christian Ludwig's
        message of "Sun, 4 Mar 2018 00:58:12 +0100")
Message-ID: <xmqq371d7hlp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Ludwig <chrissicool@gmail.com> writes:

> this is the third iteration of this series. There was a request to
> rebase the changes on the refactoring patch b6049542 ("send-email:
> extract email-parsing code into a subroutine", 2017-12-15). This is
> the result.

Thanks.  Let me Cc the party who did the refactoring, as it was
unclear how much value the change that did only refactoring without
having an actual user of the end result---now we do have code that
uses it.

> The diffstat is the same compared to the last revision. It could be
> made smaller by sacrificing readibility and breaking the scheme
> introduced by the refactoring patch. But I do agree that send-email's
> readability could benefit from slicing it into handy functions. And the
> refactoring patch reduces the nesting of loops/conditionals.

Thanks.

I compared the result of applying these on top of the refactoring
commit, and cherry-picking the previous round on top of the same
refactoring commit, and found that they pretty much result in the
same code (which was an exercise for me to gain confidence in this
code).
