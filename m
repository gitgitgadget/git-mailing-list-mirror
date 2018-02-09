Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C69D31F404
	for <e@80x24.org>; Fri,  9 Feb 2018 03:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752261AbeBIDdY (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 22:33:24 -0500
Received: from mail-vk0-f68.google.com ([209.85.213.68]:42068 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752154AbeBIDdX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 22:33:23 -0500
Received: by mail-vk0-f68.google.com with SMTP id t4so4073049vkb.9
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 19:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SwamP2BN5d4vuQMpG2ha+1NkgpEiWi+c9ruEIlNXQRA=;
        b=IE4UyZs35WN5/nL0BzHSKgWbNzZ+Yt7ADp5GtsSfBnIMHC0v5gf2+W7Z3zGoGj3eQv
         Osa0q8J0/pwnTFjcT+82dEmCcR8JRYMFXpGEEE1xhOAzgeFrlW9wrXqytVGus957T4SL
         7iaIj4fBKfetWcz8AnYIHUjJojjaPVEGiO1JUreWU5zpRx7rTnw4pIs0klVQgvZj/YhK
         Rd12Dpis+2VRQXrkGqhX4va3bqqoqMirI6vQ3tgvEsptPogtYxL1ub6XTICqYK/udijE
         j7KbsqjsCaQrzLnsgo5EJF/oQNs9wQH/WUPiPaYC445zYaw7gU3pLHfpRnyH+yhvnKwY
         /eIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SwamP2BN5d4vuQMpG2ha+1NkgpEiWi+c9ruEIlNXQRA=;
        b=PturP4/IP83ShtJLgQTRs3c9KSsRjDCyt1/g9gBuKEugHC52Il58RWjPu515zGnTK9
         LN2XKUziRx5NrEyMCQNky0wRXpFjg1K8Tq4AStAOTUKMSCJIxiBYg7VY90lMLCoiY4FW
         bBJCZVZTyKv0Xc/UBkRl4Bkb8OrDUI664IbYXDJlz79EEAAF1A4oqf8+Wvy0PkdEi98M
         pKdzrVmtE9kclkn0hYX/yz6UEMMjbwZLLlsYKEyK0hu8txdI2L2Lp903TzzVrWLVEb0c
         aW5mRpx8IGnU2PPn1RcRNmP6unwuNM0RX2Ss+VUeLMREmkMAwTmh8JRE3KzvffFc6pea
         NDgw==
X-Gm-Message-State: APf1xPB4sLnAanrJDBvfu18K8q7uuk8hStajmDTQ3n5f1S7M65TGbqOL
        AYq4hX0oMbRFT4BPZUOzYurTb+/Bm9CSL3pvXWA=
X-Google-Smtp-Source: AH8x226h4bPnTTEGBr1PNCBUicI99AeixTxQyJSNYCgLr0RrRwQlrGcCT6e4cgLkE2Q4RI7YLFxLKHuGvGo3I4UsEyg=
X-Received: by 10.31.154.194 with SMTP id c185mr1288964vke.60.1518147203238;
 Thu, 08 Feb 2018 19:33:23 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.32.12 with HTTP; Thu, 8 Feb 2018 19:33:22 -0800 (PST)
In-Reply-To: <CAPig+cTtC8WaqJg301WE+EN2RYzka-+pOoJZNZFzjqsHtx+M-Q@mail.gmail.com>
References: <20180209024235.3431-1-szeder.dev@gmail.com> <20180209024235.3431-4-szeder.dev@gmail.com>
 <CAPig+cTtC8WaqJg301WE+EN2RYzka-+pOoJZNZFzjqsHtx+M-Q@mail.gmail.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Fri, 9 Feb 2018 04:33:22 +0100
Message-ID: <CAM0VKjnnt0Nq6GQXWaq6Jq_tvOzJx-KsEBjs-7NS2bim0UH+Og@mail.gmail.com>
Subject: Re: [PATCH 3/3] t1404: use 'test_must_fail stderr=<file>'
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 9, 2018 at 4:16 AM, Eric Sunshine <sunshine@sunshineco.com> wro=
te:
> On Thu, Feb 8, 2018 at 9:42 PM, SZEDER G=C3=A1bor <szeder.dev@gmail.com> =
wrote:
>> Instead of 'test_must_fail git cmd... 2>output.err', which redirects
>> the standard error of the 'test_must_fail' helper function as well,
>> causing various issues as discussed in the previous patch.
>
> ECANTPARSE: This either wants to say:
>
>     "Instead of <foo>, do <bar>."

The "do <bar>" part is in the subject line.

> or:
>
>     "'test_must_fail ... 2>...', which redirects ...
>      causes various issues discussed..."

Well, at this point I got the ECANTPARSE :)

> but fails to say either.
>
>> With this patch t1404 succeeds when run with '-x', even with shells
>> not supporting $BASH_XTRACEFD.
>>
>> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
