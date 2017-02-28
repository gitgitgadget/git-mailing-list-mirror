Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38AF7201B0
	for <e@80x24.org>; Tue, 28 Feb 2017 17:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751291AbdB1Rfv (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 12:35:51 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33676 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751037AbdB1Rfu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 12:35:50 -0500
Received: by mail-pg0-f68.google.com with SMTP id x17so2334794pgi.0
        for <git@vger.kernel.org>; Tue, 28 Feb 2017 09:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=xTeX4gWfP/Y9N2aJlUoEKZ5dyBYqt2CMHlKvQDclTxo=;
        b=QYkuh+nVe7BT6b+fHSxzCEqGM4M1DkrnySmUhnW46OAi5Fysv0bgvPxT1XSYDmNkAa
         vVSvM91vEZFEgcquu8cNBSOpkc5RsKdHv9okIZGCqNE4TnvV0eeNnItWN6d27ZBvYIub
         WQDZdhHVPmrYGgtOSkU5okQIaauHTiHB4yndZz5wBw64lJoxhvAKUcWvzH4HX2eESIiD
         mM9eYKqgfcdAyTGXTZ4DhYhP5Pm65T6TtLL2tf6JP8Zcb53jX+xyKQhbtdiOybFjS4Gb
         ywsFRJbWcuSIACJpfug9PF7YbESxNZvyoVbH5nQVRMJo7ku2PMv56vzTbhEAXHrsJ+0I
         MKlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=xTeX4gWfP/Y9N2aJlUoEKZ5dyBYqt2CMHlKvQDclTxo=;
        b=KLhLnr5jkt+NJLQf7COOf7coRRsyHKsFT6bZslCP8Sz9RoXrlTDjFGEXqPDn2kfTl2
         7FHeON2Z3/vWJj8mSCQ6TYTReY8RFVoi4nOvb7g5NNCt4dA9Yb9aVYfihbVcCF36EsU4
         BPsBoFfWSST/c7CWbKiKvDxHAdi1T7Uyt7UAQZ4OW8OFThDe6+K7K2OlIGoHa/5Kmy11
         iEPVz/v7K7464mUSZ39jKZ57P5Yx21Y9Qcl6ueUOnob0gsXV/Tsh4f4K/iGfGXxAJGvm
         9hvdptdjCwTJdOpygAE1SFxuF/rAk0gtHyxp/+UOttgOP3y3HKq+xjG8Oiwo0yyp/PfV
         00cg==
X-Gm-Message-State: AMke39lYiqAEMYoHch3hMjss1CK4kQlVcrE7rvTZ3fUu4iLSmCARHHD4kpqH7wtGxVYAlA==
X-Received: by 10.98.99.196 with SMTP id x187mr3789168pfb.168.1488302809490;
        Tue, 28 Feb 2017 09:26:49 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:e0d7:55f8:67f2:62dd])
        by smtp.gmail.com with ESMTPSA id w123sm5445136pfb.44.2017.02.28.09.26.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 28 Feb 2017 09:26:40 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/6] Use time_t
References: <cover.1488231002.git.johannes.schindelin@gmx.de>
        <20170228142802.hu5esthnqdsgc2po@sigill.intra.peff.net>
Date:   Tue, 28 Feb 2017 09:26:23 -0800
In-Reply-To: <20170228142802.hu5esthnqdsgc2po@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 28 Feb 2017 09:28:02 -0500")
Message-ID: <xmqqvarukz0g.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I do not just agree, but I think the move to a signed timestamp is a big
> improvement. Git's object format is happy to represent times before
> 1970, but the code is not. I know this has been a pain for people who
> import ancient histories into Git.
>
> It looks from the discussion like the sanest path forward is our own
> signed-64bit timestamp_t. That's unfortunate compared to using the
> standard time_t, but hopefully it would reduce the number of knobs (like
> TIME_T_IS_INT64) in the long run.

Keeping it unsigned is safer in the short-term.  There are some
places that uses 0 as "impossible time" (e.g. somebody tried to
parse a string as time and returns a failure) and these places need
to be found and be replaced with probably the most negative value
that timestamp_t cn represent.  Another possible special value we
may use is for "expiring everything" but I think we tend to just use
the timestamp of the present time for that purpose and not UONG_MAX,
so we should be OK there.

But we need to cross the bridge to signed timestamp sometime, and I
do not see any reason why that somtime should not be now.


