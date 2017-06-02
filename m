Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA55F20D11
	for <e@80x24.org>; Fri,  2 Jun 2017 05:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751147AbdFBFIH (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 01:08:07 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:34462 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751136AbdFBFIG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 01:08:06 -0400
Received: by mail-pf0-f182.google.com with SMTP id 9so46382069pfj.1
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 22:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=aPM3uQJXVCum3mV5wWQs+IBJTDWmHk1b6lhmXaztFlk=;
        b=abCmybjD+ssUz8l/I86kBRw3NlDJlIan7jC9JI8XWM18rvzrAfa5IE8TdXDH0Sct+t
         nzE+R31hXfnabEhy9ZnY9qr7rgv/Soaw/T0og2M7htWgn2r1U069CE6XRlSHjRI7D/6E
         SLaHk8LmeF74M72v9J+pnX+8kj+YXezxDD2beYtVUu/fu07FVgHJ4bl+dMmUBvyrrGUi
         QtTdKJueUQdEDoNnUSNRRi93a9IC3UfrJ1MosjZz7BkzIwtGceMqbFp0rqK6ldWHnE5L
         irQdiAEJ5GHBu2pZTNjwOUwlyvFpaC7RGNeTmVoBWZnMMRKRmgD5m7Fv2MCiFKwo05VE
         Gjrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=aPM3uQJXVCum3mV5wWQs+IBJTDWmHk1b6lhmXaztFlk=;
        b=A/vGhkgLxTprxpEWAncf7DQKDaB2PpKys2qHlajHQe8oV2JY0oE7Jwcm85vgE1NDVa
         lvRMvygu0L3XlPhGXX7yJ0qMXZZvRAefxihTFugZlOAKP/HRyAeulJPAC6vNoPjaBZ5H
         RyzWwblA4BTmKwt/O5uTe/ttHpyU5bersiMdNdR5sFlkARbfV4rLdMP2sMvnO2XpXshn
         wtiwySQh3fz/PolvmsxRXorgv8bMdiENOfS1GQoUQGWqozKNjp02wlCq9vRe5PS9XbIM
         P7DZcrh9XM/YDX9uh325IShPbmqe0Y7ClUh1n0uluQuyAFlFQnEvNomZMBortFBJIamx
         ybZw==
X-Gm-Message-State: AODbwcCHi+Y1pVnL+xMFSjCKEHp+DkQUu4X4CYUyme/CAuTc6uasl3uA
        PAkL50hlN09Yrw==
X-Received: by 10.98.64.93 with SMTP id n90mr4837421pfa.96.1496380086017;
        Thu, 01 Jun 2017 22:08:06 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:ec2c:8ebb:3fc7:e0d4])
        by smtp.gmail.com with ESMTPSA id m18sm38782597pfj.108.2017.06.01.22.08.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 01 Jun 2017 22:08:05 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, sandals@crustytoothpaste.net
Subject: Re: [PATCH 00/33] object id conversion (grep and diff)
References: <20170530173109.54904-1-bmwill@google.com>
        <xmqqzidr18an.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 02 Jun 2017 14:08:04 +0900
In-Reply-To: <xmqqzidr18an.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Fri, 02 Jun 2017 10:34:56 +0900")
Message-ID: <xmqqefv3yo23.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Brandon Williams <bmwill@google.com> writes:
>
>> A month or so ago I thought I would lend a hand to Brian and do a round of
>> conversions from sha1 -> struct object_id.  Now that Brian's latest series has
>> hit master I can finally send these patches out.
>>
>> The first couple patches are from Brian which convert some of the notes logic
>> to using 'struct object_id'.  The remaining patches are to convert the grep and
>> diff machinery to using 'struct object_id'.
>
> Nicely done for all of them.  Thanks.  Will queue (with tweaks
> mentioned in the comments).

Oops.  I won't be able to queue this for now as it heavily conflicts
with blame-lib topic.  The resolution should be trivial, mechanical
and boring, but takes time that I do not have today.
