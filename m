Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79366202C9
	for <e@80x24.org>; Tue, 28 Feb 2017 23:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751529AbdB1Xao (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 18:30:44 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33588 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751037AbdB1Xam (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 18:30:42 -0500
Received: by mail-pg0-f65.google.com with SMTP id x17so3388699pgi.0
        for <git@vger.kernel.org>; Tue, 28 Feb 2017 15:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=P6bwWgGUNLayj54QF1F5uftcL7VPjiFCDD1vcJo9dGk=;
        b=iRKlaH6M2DwRDEFu1wsRfWOTNUVRgUlOuU8FgXh/KuNbImz+V2O1m5xomsNkxmTU/I
         X/CxisuMtWL/A6243fumKfTQ+5YS22ra2hYJnJF3bYjvt9HlHOjRl7oF6ohmJR1jpClj
         GtKr3oj8pOG+G3sYBRyOfqevYPF103MEnegaaHHJUVFnCt3yBYeUB5L6YzdRKA2FLhh6
         V7rw60tEI1ObZlH5jvsfXOx9YbMTEy5aENRqw0xgy2gXPxkL+W7P3gETCRU8hgYhW+uk
         bataCkq8llxi49CxVY7QtKB0oCOo0TdBrvkMHLvgTPG6jcb9JHOrT/cV6hEEI7oXMQat
         8zJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=P6bwWgGUNLayj54QF1F5uftcL7VPjiFCDD1vcJo9dGk=;
        b=a+btOBHS4BgrgKWCbM8DVPnxpS/alfrv8fh7Q9HRv+WSzASEenwViDbDvMpu6AGdBN
         eyXg35xR9pMShACy9GVU+grmO/3NN5H7Ed3QGepRIUPQX/d/sT6aLjvrfT2CYkmFDKXA
         fGf5ffd1QzlY7evaByc2O0LBQchRiblqxzK8u3BpDduol8hsNj6/yBeyOdabMbvO4vW7
         ukSXfhg7U0uzeU1p/Px5W/1esiMugem0Y6BcvL586UsBtHdBE1n3dAVa4YdzVUleNRWz
         kR1RUHA0aqAvua1uPyJrCf7LWjpRvxQrO53PkktmC3ZjUgZ/exfRVhhgk7VfmHgbnLXW
         hQ4g==
X-Gm-Message-State: AMke39lGf2cp6LcKhGSAgTaOpv/OPEgJPP47wBgfXqIkBYvKWaLHVrYcZEPjtk0jIicISA==
X-Received: by 10.99.51.76 with SMTP id z73mr5077561pgz.137.1488320844127;
        Tue, 28 Feb 2017 14:27:24 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:e0d7:55f8:67f2:62dd])
        by smtp.gmail.com with ESMTPSA id 9sm6085747pfk.121.2017.02.28.14.27.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 28 Feb 2017 14:27:23 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/6] Use time_t
References: <cover.1488231002.git.johannes.schindelin@gmx.de>
        <20170228142802.hu5esthnqdsgc2po@sigill.intra.peff.net>
        <xmqqvarukz0g.fsf@gitster.mtv.corp.google.com>
        <20170228200145.ymbqmxwrbbrwagks@sigill.intra.peff.net>
Date:   Tue, 28 Feb 2017 14:27:22 -0800
In-Reply-To: <20170228200145.ymbqmxwrbbrwagks@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 28 Feb 2017 15:01:45 -0500")
Message-ID: <xmqqh93ehrxx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> ... We can certainly stick with it for now (it's awkward if you
> really do have an entry on Jan 1 1970, but other than that it's an OK
> marker). I agree that the most negatively value is probably a saner
> choice, but we can switch to it after the dust settles.

I was trying to suggest that we should strive to switch to the most
negative or whatever the most implausible value in the new range
(and leave it as a possible bug to be fixed if we missed a place
that still used "0 is impossible") while doing the ulong to time_t
(or timestamp_t that is i64).  

"safer in the short term" wasn't meant to be "let's not spend time
to do quality work".  As long as we are switching, we should follow
it through.

>> But we need to cross the bridge to signed timestamp sometime, and I
>> do not see any reason why that somtime should not be now.
>
> Yep.
>
> -Peff
