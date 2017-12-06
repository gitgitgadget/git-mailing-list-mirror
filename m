Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADF7F20C32
	for <e@80x24.org>; Wed,  6 Dec 2017 22:55:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752127AbdLFWzQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Dec 2017 17:55:16 -0500
Received: from mail-yb0-f171.google.com ([209.85.213.171]:46365 "EHLO
        mail-yb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752034AbdLFWzP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Dec 2017 17:55:15 -0500
Received: by mail-yb0-f171.google.com with SMTP id g9so2236976yba.13
        for <git@vger.kernel.org>; Wed, 06 Dec 2017 14:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+dOPS0lhf5GQTbv1wtOK+K61FWYi6lwsu5nKPPWm1m4=;
        b=sUQsQQi2z41FFH0jDkA9TLBQtZZlAjQbWfgKzgKb0Ud2sFbNI8ufWgz8fskkEZMDZS
         kwXfSuTgMWIe8Z7Vu3Pb6RYPMuc0wJnzyCJzaaQTKqXLN2WQEMHOp2qAaoWe9y3Il+1+
         eVMIXKELbBsk5NFVv1QJjiuc1L6DNCCxy2JhUYRkp/RsKRjDCDT40ZtFEwrq5jA4Pi5B
         kvsC2MDPmsZxEwkFDhux3I/z0COMb2wG8T3Vxec4lviuPXMPWWIeqPns1OYodurDDd/J
         i/EQ7UEJQH+S6X7eNgArU4RttxgqyHgiMlUddvq+Nje07WCxtGLc+OfznpOJiaxr/kg/
         srQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+dOPS0lhf5GQTbv1wtOK+K61FWYi6lwsu5nKPPWm1m4=;
        b=UvOqwIP/FuhYHYH2i0Ml4LL7FziyHcWqsqm7nAcGMAc/bgfByDrUOuvSnE1sau0Ur7
         dPKjtl0gWgeHNuFpUxO4lWsd/udRj1rkvN2PMwUIR6A37fCrcT3lenUruUsJunhWD/Z8
         OF+IVmpCc2kYoLIjrvZv/Vy3FQp0XVMx/5z7Ve+cUfbJ49Yjt1E2WdrqXtY3bI4ebR3E
         ObJPwBs+uqBr+VWy4HlpK30/MKvKe3daPRyAyF8eOdaAUj+JuhYwWZqfmhDxBA+gXM8A
         gvU5vw+z/Dhq2wi4pWTsoHLqwVanEQWtIBWk+UVyEz70yCadSv9x5tZT3xqoxfBwxSQ3
         xRkA==
X-Gm-Message-State: AKGB3mI2J5EURYom1XnCBYme483LLAsTILghIth3Lct4mwZHzagxph+E
        MfRxS78cSxa1adn5uNQTtp1Lj7YwVV7M5SMmwHs=
X-Google-Smtp-Source: AGs4zMaCqWmwCAlVChUw263mp5y/1M9s1yzw84qrZ9lukMxhmDCeAqEOMxwjZhehci2wJ6L7vnp3zwSQWKaDBzrAoDg=
X-Received: by 10.37.128.81 with SMTP id a17mr7113407ybn.502.1512600910065;
 Wed, 06 Dec 2017 14:55:10 -0800 (PST)
MIME-Version: 1.0
Received: by 10.129.135.70 with HTTP; Wed, 6 Dec 2017 14:55:09 -0800 (PST)
In-Reply-To: <xmqqvahjfsdx.fsf@gitster.mtv.corp.google.com>
References: <xmqqlgiiobcy.fsf@gitster.mtv.corp.google.com> <20171206153821.24435-1-nathan.payre@etu.univ-lyon1.fr>
 <xmqqvahjfsdx.fsf@gitster.mtv.corp.google.com>
From:   Nathan PAYRE <second.payre@gmail.com>
Date:   Wed, 6 Dec 2017 23:55:09 +0100
Message-ID: <CAGb4CBWZciqxdfpSkK1vezhiuSYX5Yy-xSq=Uj4h+vhRo9uyoQ@mail.gmail.com>
Subject: Re: [PATCH v2] send-email: extract email-parsing code into a subroutine
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Nathan Payre <nathan.payre@etu.univ-lyon1.fr>,
        Git Mailing List <git@vger.kernel.org>,
        Matthieu Moy <matthieu.moy@univ-lyon1.fr>,
        Timothee Albertin <timothee.albertin@etu.univ-lyon1.fr>,
        Daniel Bensoussan <daniel.bensoussan--bohm@etu.univ-lyon1.fr>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com>: writes:

> ... throughout this patch, not limited to this section, indentation
> is strange and there seem to be many "print" that show messages that
> do not seem to be meant for end-user consumption.  I can see that
> this aspires to improve the readability, but not quite yet ;-).

Hmmm I'm wondering who place thoses print in my code !
I will fix it fast. :-)

> Also "reusable in other place" is by itself not an unconditional
> plus, until readers can be convinced that that 'other place' really
> wants to be able to call this function.  Is there some untold
> motivation behind this change---such as a planned update to actually
> use this helper subroutine?

This subroutine will be used to implement, initially a new option called
"--quote-email", but became "--cite" added after "--in-reply-to".
This will permit to the user to cite a mail and reply with a patch and keep
Cc, To ...
See discussion :
https://public-inbox.org/git/20171030223444.5052-1-nathan.payre@etu.univ-lyon1.fr/

And Daniel Timothee and I wanted to refactor an other part of the file
using parse_header_line(). Near Line 1570.
