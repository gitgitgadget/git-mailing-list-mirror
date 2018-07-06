Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFC5E1F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 18:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934093AbeGFSVJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 14:21:09 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:56149 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933740AbeGFSVJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 14:21:09 -0400
Received: by mail-wm0-f68.google.com with SMTP id v16-v6so15706605wmv.5
        for <git@vger.kernel.org>; Fri, 06 Jul 2018 11:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+QdrMyo3bHuCmYiUv35kSoMzVRo92j0EqDRGkdSuCkc=;
        b=KyuwHDk7Hxsbp2knp58KyTJA7DyIV+DbM2tQhKp3rOpm83j/eFDelG5qPqu81n3PJo
         4SqDKRTUO/YOqyJTzZTEn52r2xxqN+HN9Fyky3r+kOW+8EzUwvI09bFCDlpgj3Kty8uj
         KuiGMEvz2kw+opqfHyCaiNXEa9uS90WkbqAPfAzqKZFsS4JJ99+FPGUa8HQnVHfpAD+w
         lXRyAtWgEakBerV3QJxe54qUbBKV/3CxRCW5UHQYOsew8ilSMlvzPn5X6F8yTtWIsn14
         1EgAU6hKd8JUPNh5rKSvFXw5GF+YELGYJVRoqs1XjxR/cSYsDKHSGibzPjynX+5128QO
         r6zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=+QdrMyo3bHuCmYiUv35kSoMzVRo92j0EqDRGkdSuCkc=;
        b=ZtWslgWpANP1t5JjPq7ZtNSsxj8YrkYjGx+5IEWf/7UWkDXfuNVctHgFQKKK4W5xm+
         Ipn3LjdKmBgn7Y+v3JdSK9juQvo8+eVv/+s1IsmRnikUUgf1HiyaIvEkJ8Az0+jerrhH
         /JSvYMkhJCJ/15TWl9+0GhmbJ2k6gEVcjpaIfbzzuhKwXerrSWDiRE2r5BuZvSXTxrfB
         m3PTqJIuqJJUC4098D1yFayLHGN4UNc8EJPUaxvOCnJYVvg0Spo49T600c4VeZ0Q5hOA
         GI0bM6PLo8WrB4g+4urOhBBNiFD2IkcNUIlPqQczn4hpnPhxR0p1gtqRLa9zddXXK2XB
         vZyQ==
X-Gm-Message-State: APt69E1u+j7zuw/Hk1Th/nn8cqUwhQGdOWqUz2t99K61l6Stq/uiAXvv
        fVSWraK3PuDKbnqtlIKkaMBGqN+q
X-Google-Smtp-Source: AAOMgpdRoV+HzPCBYsT573NCPYpU6+Qo1CbFA0dVEwXjYzFUdMmMOAxys7BJyvj9D7/+FQfoy5jaww==
X-Received: by 2002:a1c:ad42:: with SMTP id w63-v6mr7687162wme.100.1530901267744;
        Fri, 06 Jul 2018 11:21:07 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id j77-v6sm4706749wmd.19.2018.07.06.11.21.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 11:21:06 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org, avarab@gmail.com
Subject: Re: [PATCH v3 0/2] grep.c: teach --only-matching to 'git-grep(1)'
References: <cover.1529961706.git.me@ttaylorr.com>
        <cover.1530654455.git.me@ttaylorr.com>
        <20180705142110.GA10192@sigill.intra.peff.net>
        <20180705143401.GA87330@syl.attlocal.net>
Date:   Fri, 06 Jul 2018 11:21:06 -0700
In-Reply-To: <20180705143401.GA87330@syl.attlocal.net> (Taylor Blau's message
        of "Thu, 5 Jul 2018 09:34:01 -0500")
Message-ID: <xmqqlgaokyy5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> I think that this might be clear enough on its own, especially since
> this is the same as BSD grep on my machine. I think that part_s_ of a
> line indicates that behavior, but perhaps not. On GNU grep, this is:
>
>   Print only the matched (non-empty) parts of a matching line, with each
>   such part on a separate output line.

Interesting.  I wonder what "git grep -o '^'" would do ;-)

> I'm happy to pick either and re-send this patch (2/2) again, if it
> wouldn't be too much to juggle. Otherwise, I can re-roll to v4.

Please do not re-send a different version of a patch with the same
v$n value.  Either re-send, otherwise re-roll, will give us v4, not
v3.

In any case, I find that the GNU phrasing is the most clear among
the ones I've seen in this thread so far.

