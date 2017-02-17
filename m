Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 337B2201A9
	for <e@80x24.org>; Fri, 17 Feb 2017 23:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964965AbdBQXyB (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 18:54:01 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36708 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964960AbdBQXyA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 18:54:00 -0500
Received: by mail-pf0-f193.google.com with SMTP id c193so268890pfb.3
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 15:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=yCcDfnDI4KyuIw3AGyII29i02PNmh41lA1DcGZOPSwo=;
        b=ABwZlC3V0lrRkhMfoUUc8icRbGlPLU8mkXihv/+YfJR0hbIV7fCo0CNGRWecK4HggC
         X3Dsq6Uc5b9dtuDea0y8ONqEycbVDLek15hzHqtIlxomIltzC3j/0bspdLjmS19de6Zs
         ko2crIVxlinnTGz59KNCwceBe9myZ1Xwxsz/ixAyDNzbP9nmzuGtJCnmpda787VjI5QV
         kSM24wvNixM3pm24eaj0AmESXtMD0d8tQ2zFfxz4KGbm55kndQl/EzCpA712cjOUPotJ
         hQJFs8FwHWMMWq5pDcQ6IpQppyDnfvR4h5IN+dq4TQjN6HcxrSkICm4HYo1Buoeb8Euu
         m9vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=yCcDfnDI4KyuIw3AGyII29i02PNmh41lA1DcGZOPSwo=;
        b=louzfdTOF2cnJn1cQeYL/2205IlOz2NsXxCLirl3YBTslbAT8AhONC4YXE/2IKSQ2C
         EgIv8TuxDLqoBfq7z+3sBcCuQ0BXMH885a+gUWiP9EbYCC5DwKnR2E2qCFGDPzsoXnbf
         71JEZ8XsqLhEadsN62xIjT5+9LadIYKNZNNgAv/2lBQuRefIbH3YVVHVsRGzkew6Oev7
         7dZF6wYPW/OlGsn9TFg3NPDPdu0T5lexnIgHqSGtxOttnKQh/afrfbuPdy71B/084utq
         /vx1voncOaUUliOad6jjIDdxT7iboo21ntTtGvX75isHHaB+rpSxPnSbaDJ3aMaBveT9
         3SWQ==
X-Gm-Message-State: AMke39nnpWd76TMYwzoV573RwDn9WTzF0J176ys+q9bwiNdRgmktUFLkxUHChVv0NSuHzA==
X-Received: by 10.98.11.9 with SMTP id t9mr5345636pfi.123.1487375612124;
        Fri, 17 Feb 2017 15:53:32 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:3130:38b1:b121:8f0d])
        by smtp.gmail.com with ESMTPSA id 10sm21446218pfs.113.2017.02.17.15.53.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 17 Feb 2017 15:53:31 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kyle Meyer <kyle@kyleam.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 3/3] rename_ref: replace empty deletion message in HEAD's log
References: <20170126211205.5gz3zsrptop7n34n@sigill.intra.peff.net>
        <20170217035800.13214-1-kyle@kyleam.com>
        <20170217035800.13214-4-kyle@kyleam.com>
        <20170217083112.vn7m4udsopmlvnn5@sigill.intra.peff.net>
        <xmqqk28ou2o1.fsf@gitster.mtv.corp.google.com>
        <871suwqtar.fsf@kyleam.com>
Date:   Fri, 17 Feb 2017 15:53:20 -0800
In-Reply-To: <871suwqtar.fsf@kyleam.com> (Kyle Meyer's message of "Fri, 17 Feb
        2017 18:41:32 -0500")
Message-ID: <xmqqmvdknzm7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kyle Meyer <kyle@kyleam.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
> [...]
>
>> Do we even want these "internal" delete_ref() invocations to be
>> logged in HEAD's reflog?  I understand that this is inside the
>> implementation of renaming an old ref to a new ref, and reflog
>> message given to delete_ref() would matter only if the HEAD happens
>> to be pointing at old ref---but then HEAD will be repointed to the
>> new ref by somebody else [*1*] that called this function to rename
>> old to new and it _will_ log it.
>
> I know the discussion has developed further, but just a note that I
> think the last statement is inaccurate: currently, a rename will not be
> recorded in HEAD's log.  "git branch -m" will show a renaming event in
> the new branch's log, but the only trace of the event in HEAD's log is
> the deletion entry with an empty message.

Yes, I think Peff diagnosed it and suggested a fix.

