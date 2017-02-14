Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4632B1FAF4
	for <e@80x24.org>; Tue, 14 Feb 2017 22:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751327AbdBNWC1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 17:02:27 -0500
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34420 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750711AbdBNWC0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 17:02:26 -0500
Received: by mail-oi0-f68.google.com with SMTP id w144so1687491oiw.1
        for <git@vger.kernel.org>; Tue, 14 Feb 2017 14:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=GPy76mU01F6RfIr+VwhWgcAMK3I+qXL10bQEdkknisc=;
        b=lyGHcMu0W3bulyUcy9+CyUcxqQvBblQ+dbBwennggq1zCo1dCxQmpnwTtCJdYtkcrq
         WcB8HMRyewmz+GX3pNVeGmFzS2zmETbVMIeP1l1zq6IG9BW3teeClJUW79U12gv/qIME
         thgSQFJtZxLsYlrjVE/v0xx9Qe4xyM3MP2qpzv1x5bk16u8DmYt2k/PjakKdHzQiydKk
         8LfAwSwRboZJUoxm78p6rlYbnOxlweU7sdsOFWlA9UEqN3W0F4Q1s2TK4ub2bttLbOHj
         YlZ2X0RY+lNyofGS3LPwPvRolOmhgjRyQPxXotqTJDS+7UWiWmPTPsuS4yqorqjM9nma
         CYTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=GPy76mU01F6RfIr+VwhWgcAMK3I+qXL10bQEdkknisc=;
        b=WFeVNYci/HvSKkZ6Ca6usAsACFsZgRMB2R+JpxgL3bSuqPHi2flZl/yBXUWbkBCEmD
         CKFUCjVUMFCcuBpoHxBpchMZnOVr/T0/Ytojb8ZcQEZBeC1/DMzdK7JcsxhWnH3s7d52
         84lGzA4aWJ9Ts4GZr+m2qVZST1vwfzKs32/Miyn2FkCdraXoi33JO2X7nKJRSWovQUO8
         uvQ7EOD4ljDx6ZmmHmwIRNukcVnq61skG3A3kTAgJ3GHeq1cixx7y3CS1IIIzhZZ+RHq
         TkEfFg0zwZsngvcQv60zCFk0GNKlAkl9kV2vGILnIaQDMmUAnhzrfjWgeZp7gOYgjz9+
         61SA==
X-Gm-Message-State: AMke39mcbY4rw2kDt65FMm0rka2K4iRGMjiplIsyEgeHGxcfXRiirlGS7+moW/v7PQY1jQ==
X-Received: by 10.84.238.1 with SMTP id u1mr39337045plk.174.1487109745482;
        Tue, 14 Feb 2017 14:02:25 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:2447:f72c:8fdf:75c6])
        by smtp.gmail.com with ESMTPSA id m6sm3096127pfm.22.2017.02.14.14.02.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Feb 2017 14:02:24 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 00/19] object_id part 6
References: <20170214023141.842922-1-sandals@crustytoothpaste.net>
Date:   Tue, 14 Feb 2017 14:02:24 -0800
In-Reply-To: <20170214023141.842922-1-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Tue, 14 Feb 2017 02:31:22 +0000")
Message-ID: <xmqqvasc77nz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> This is another series in the continuing conversion to struct object_id.
>
> This series converts more of the builtin directory and some of the refs
> code to use struct object_id. Additionally, it implements an
> nth_packed_object_oid function which provides a struct object_id version
> of the nth_packed_object function, and a parse_oid_hex function that
> makes parsing easier.
>
> The patch to use parse_oid_hex in the refs code has been split out into
> its own patch, just because I'm wary of that code and potentially
> breaking things, and I want it to be easy to revert in case things go
> wrong.  I have no reason to believe it is anything other than fully
> functional, however.

Thanks.  Will queue.

There are a few hunks in builtin/merge.c that ends up getting discarded
when merged to 'pu' as is-old-style-invocation will just be removed,
but the conflict resolution was trivial.

