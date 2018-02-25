Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C36A1F404
	for <e@80x24.org>; Sun, 25 Feb 2018 18:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751634AbeBYS22 (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Feb 2018 13:28:28 -0500
Received: from mail-wr0-f175.google.com ([209.85.128.175]:35169 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751558AbeBYS21 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Feb 2018 13:28:27 -0500
Received: by mail-wr0-f175.google.com with SMTP id l43so18982267wrc.2
        for <git@vger.kernel.org>; Sun, 25 Feb 2018 10:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=hwJX7rlOqtC1TpFpdu2Ga8mRvQ24AQ6bVaUjvJEer7o=;
        b=cn7hksWLk+l4ydGlxcLs7CeO0cmnHbzl1TVkBJybq9VWfqlvMWtVL93O/aT01OOIQn
         jJ1bZKW3UMq+9a+QvmCkgDah00EIkh6g5LWTv4EHVuCh2hVdMCqYdqXP1LaANZJXYIRF
         Eq52mZNq8f05VyUb6DIWqyYr0saUaNAljRBDi4gj7w/lxwtJaJW5AZGFvQSOQyDmdtwv
         0Ih3Z9//ohjF6vpmMpTocQ8yNbiIRCGhy5XYXh64wmWOpjrhLHCLL7rWSBfsHn0pwd3f
         jhgW9JTnyh5gCAlXMwxtuBeJ+YyAyi7HHVsS4P84gdaw1Yw9g4kDWAuUT46yx+phDyXo
         bdHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=hwJX7rlOqtC1TpFpdu2Ga8mRvQ24AQ6bVaUjvJEer7o=;
        b=J7bF2oqapRX5eYzIEyqAwD7u/hagu1BbGZ6NYbNpVxwTZr3sn1eG1ndnBH8obwazPv
         tB1qTazcyCfikHSJXDLh6+zYz3q1ROxrcHj3GhGlPy6ErssYpBfaSP1+9BiCo6lvhbii
         szo47djee8i6Z9DjUaIy/8j1TvfLARyAJACn3QydIgZm59/M92Oz0/7e867Wb6s5RYlD
         rH3Ieg99l4begMdOtBZqW6/eQleCpzijmlz3k6V0vYAojouHdepKVsxUk83nI76bbY1w
         o4Ll+t7lJBsT3pGu8W3Vj1WLZMi9vy0axjjZW51hU+6JfvlXEWGZ/yWc4qirny+fRbhf
         KjIw==
X-Gm-Message-State: APf1xPAirFKhwWy05yGib1zOtyzrSA3dayzLZftjTqlbuSH0J6h17qko
        V10Kt0wrPVH6xcFIooZTttbrPI8C7zeqnmoe9sm8qA==
X-Google-Smtp-Source: AG47ELvqgf7Hm+y8vSrwJJEOiwluFnP5o/E5hQs9V7MwZbLBzEhRkCvlnZ8qEDSr/8dCRsIdxBEfeX7ttGdGpHw3xdg=
X-Received: by 10.223.177.194 with SMTP id r2mr4506754wra.89.1519583306475;
 Sun, 25 Feb 2018 10:28:26 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.197.147 with HTTP; Sun, 25 Feb 2018 10:28:25 -0800 (PST)
From:   =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Date:   Sun, 25 Feb 2018 21:28:25 +0300
Message-ID: <CAL21Bmnz=H96EE=yerdigujYQ6M7Y_U-RkDF7oR-UPDU+cZNFA@mail.gmail.com>
Subject: ref-filter: how to improve the code
To:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,
I am trying to remove cat-file formatting part and reuse same
functionality from ref-filter.
I have a problem that cat-file sometimes needs to continue running
even if the request is broken, while in ref-filter we invoke die() in
many places everywhere during formatting process. I write this email
because I want to discuss how to implement the solution better.

ref-filter has 2 functions which could be interesting for us:
format_ref_array_item() and show_ref_array_item(). I guess it's a good
idea to print everything in show_ref_array_item(), including all
errors. In that case all current users of ref-filter will invoke
show_ref_array_item() (as they did it before), and cat-file could use
format_ref_array_item() and work with the result in its own logic.

I tried to replace all die("...") with `return error("...")` and
finally exit(), but actual problem is that we print "error:..."
instead of "fatal:...", and it looks funny.
The draft of the code is here: https://github.com/telezhnaya/git/commits/p2

One of the easiest solutions is to add strbuf parameter for errors to
all functions that we use during formatting process, fill it in and
print in show_ref_array_item() if necessary. What do you think about
this idea?

Another way is to change the resulting error message, print current
message with "error" prefix and then print something like "fatal:
could not format the output". It is easier but I am not sure that it's
a good idea to change the interface.

If you have another ideas - please share them with me. It is really
important step to make formatting logic more general and easier to
reuse.

Thanks!
Olga
