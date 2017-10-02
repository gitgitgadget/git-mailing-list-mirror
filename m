Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88290202DD
	for <e@80x24.org>; Mon,  2 Oct 2017 05:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750923AbdJBFu5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 01:50:57 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:45494 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750792AbdJBFu4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 01:50:56 -0400
Received: by mail-pg0-f46.google.com with SMTP id 188so2475257pgb.2
        for <git@vger.kernel.org>; Sun, 01 Oct 2017 22:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=N09+TkN5+rrJY11cxw08ECfjrbuQb3xXOO5x+LdsK4Q=;
        b=BUJdtNxSnS8z8sul2s2KdcgzGsaUsb5L+M4SqdAmi9LPYnjc6V+LQEimy6l8G116BC
         wErYIETP1LaXpkxWoFMq2kOEsW9XH+PeFm7pG8gvh8a2OWzg16/w++xsDdVD7r6+8xoE
         QNHFqR0ttbJoB9cH8K14EshuURVI8rqZIaElwvbRhlZs33ON2hzQqtToq94NY7jBsf+1
         ezaGHYg1bTaWFnU/WYLb36Kwc/bdkKmWfKR/uqxehENff4yw2GWUTS68/T47rlR/++wa
         YXEH0yPqnCGHXuZ2776bZ4fY6dUnsQJ1w0leGyHHniFdJV1Y99vP2YjKVpBQ1XbUZ21l
         /5MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=N09+TkN5+rrJY11cxw08ECfjrbuQb3xXOO5x+LdsK4Q=;
        b=dTfmbuDtMYXsv+NNIYVEosaKMMCIMXpqP1gG+7m3N0FrH5PAXc9eBoXb9CUzoqGp5l
         ELlOBkELuwKJYviKyN75Gsa8dLa6lhewE4rcoMsrnrTei9n1Z3KdsiXXrpq6SS0zOArM
         6NGkHTAaMbDizm5poGQT6MEm/Vk8TWxoJjZG3fQ2HSknB7RfmgIYeS/8poRI/2sXMsCl
         S5HiFP/lERwPzm6v/wKn3pe6cn5GR4n0FVUgFtb0qN8cSUngASGmqDLS+zwjiaMlzNSG
         bEXi88Bxi2jGOGTLJ9kziNhVA1Ra8o4ZzTEzDqUHWQxoxOMWu/fPTq3Zo6T3sncx6U0N
         Wu1g==
X-Gm-Message-State: AHPjjUhag40FUgsLoaEBNqEjbGObLKZiFznOp4opl9r5Xb3w6YwIkw3j
        opNfgDFFPKOqktqsmLsuyeoWPL/OzQI=
X-Google-Smtp-Source: AOwi7QDYVxH01xgJWznKQWkU+U9eo6Za7jpgYaKZ3/QZIObqcSQF2zy5fhgeGoFrm69mLLOMr+HwXw==
X-Received: by 10.101.81.77 with SMTP id g13mr11246451pgq.78.1506923455543;
        Sun, 01 Oct 2017 22:50:55 -0700 (PDT)
Received: from localhost ([205.175.97.239])
        by smtp.gmail.com with ESMTPSA id h10sm12512967pgq.86.2017.10.01.22.50.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Oct 2017 22:50:53 -0700 (PDT)
Date:   Sun, 1 Oct 2017 22:50:52 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, me@ttaylorr.com
Subject: [PATCH 0/1] ref-filter.c: pass empty-string as NULL to atom parsers
Message-ID: <20171002055052.GB10729@D-10-157-251-166.dhcp4.washington.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Attached is a one-long patch series to un-distinguish between atoms
without sub-arguments ("%(refname)") and atoms with empty sub-argument
lists ("%(refname:)").

This addresses a user-experience issue that Peff points out:

> Doh, that string_list behavior is what I was missing in my earlier
> comments. I agree this is probably the best way of doing it. I'm tempted
> to say that parse_ref_filter_atom() should do a similar thing. Right now
> we've got:
>
>   $ git for-each-ref --format='%(refname)' | wc
>      2206    2206   79929
>   $ git for-each-ref --format='%(refname:short)' | wc
>      2206    2206   53622
>   $ git for-each-ref --format='%(refname:)' | wc
>   fatal: unrecognized %(refname:) argument:
>       0       0       0

By treating %(refname) and %(refname:) as the same thing. Peff has
convinced me that these _are_ indeed the same thing, as the first is a
%(refname) atom without any sub-arguments, and the later is a %(refname)
%atom with empty sub-arguments.

The reasoning is highlighted in the comment this patch adds, which makes
more ergonomic the use of string_list_split in atom parser
implementations.

Thank you in advance :-).


--
- Taylor
