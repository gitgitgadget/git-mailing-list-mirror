Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CA051F6AC
	for <e@80x24.org>; Tue,  3 Jul 2018 16:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932716AbeGCQBK (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 12:01:10 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40697 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932531AbeGCQBJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 12:01:09 -0400
Received: by mail-wm0-f68.google.com with SMTP id z13-v6so2857858wma.5
        for <git@vger.kernel.org>; Tue, 03 Jul 2018 09:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=JecuWv7o16qHHbS9d4QR4txnFOserWhuzp6c1Y/iHUM=;
        b=fdq0MBxgZJfG++hlEuL2GBldlryTUKcd6zCkI5kssD+zwu3YhpWVnOnMqTz5xvi0hS
         P3DN+Lq09ubG8plTN1D65gU6Z1fR8IKENTn21nVydER+SIwn62wJT114nyCLMA/jIbUu
         LxL+iuaJKatre/lY8/eK7iqHUwBJyS89LcrfcBnwOcbRd7KNPGOFBHb5RXL/x7efVWcH
         zIhXp8SNfWXQVC176AvPpXPo/Vr4n6VItQP8E60CCwjklj/NGr3HSz9PQo0Nwq2nHJtY
         3lbSXOPeXwc9QqgFRWHgtSC7A7ekE0gHnhTEJfkaINbjiLPKk+h3H+3iNTFdITOq+j2r
         Ulqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=JecuWv7o16qHHbS9d4QR4txnFOserWhuzp6c1Y/iHUM=;
        b=PFqyux6Jpt6z325CJeSHKSRrau895ofA+/ZVbFGZTUiuIaHLZKAAZ6ixgv9XuNLwV4
         /QVslEpWj9bqIdyv9XSDa6OGALfDJdxduWheQnYeTu7cnhF4TZhG5f5GhcujrpjDoior
         xNw1VuoMHrPmVCrFddV0FrVygtSUEpNACbffze6zm08AaFg2b0wRDl/YmCfB+FNMi9x7
         A5arHEbXYQcQuqzwJed5VSmRgMv8AGI+7oXdp4iyNBqNPIWAWizOyJllNn5OPl1785fO
         VlZA8EPOjrcWqBo6n2SVr3ps6IBaJaKlwZJQtnpVgeASeLl+jrbNYMUOWRx+/XmIBMDZ
         +HGQ==
X-Gm-Message-State: APt69E05gTZZguMEvQSKETn90umU82kRHuB1b2VDov51+LHhUGWOFr+T
        GFoiW+umAfE2EXkcfgwpEFQ=
X-Google-Smtp-Source: AAOMgpdewsGo8JewsLZSyWneY2L5XIbnGV4JAv3tduu8xdvFiQfgXp5CgB4NFERsEv1sAWfNcaShIQ==
X-Received: by 2002:a1c:2bc7:: with SMTP id r190-v6mr11275634wmr.26.1530633667454;
        Tue, 03 Jul 2018 09:01:07 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 131-v6sm3722536wmm.31.2018.07.03.09.01.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 09:01:06 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Lars Schneider <larsxschneider@gmail.com>,
        Steve Groeger <GROEGES@uk.ibm.com>, git@vger.kernel.org
Subject: Re: Use of new .gitattributes working-tree-encoding attribute across different platform types
References: <OF5D40FE06.C18CD7CD-ON002582B9.002B7A02-002582B9.002B7A07@notes.na.collabserv.com>
        <20180628024446.GD644867@genre.crustytoothpaste.net>
        <20180628143405.GA16657@sigill.intra.peff.net>
        <4E8CDDC9-2957-401F-9BBE-93276C026848@gmail.com>
        <20180628172707.GA31766@sigill.intra.peff.net>
        <20180701175657.GC7965@genre.crustytoothpaste.net>
        <20180702181742.GA12208@sigill.intra.peff.net>
Date:   Tue, 03 Jul 2018 09:01:05 -0700
In-Reply-To: <20180702181742.GA12208@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 2 Jul 2018 14:17:42 -0400")
Message-ID: <xmqqsh50s3zy.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> One thing I almost did in the example I gave above was to literally call
> the encoding name by a "real" one. I.e.:
>
>   echo '*.txt working-tree-encoding=iso-8859-1' >.gitattributes
>   git config encoding.iso-8859-1.replace latin1
>
> or something. But I wondered if it was a little crazy as a practice,
> since mapping "iso-8859-1" to "utf-8" is probably going to lead to
> headaches.
>
> But your example above of semantically equivalent variants with
> different spellings would be a good use of that trick.

Yeah, I think the above looks quite sensible.
