Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7007A20958
	for <e@80x24.org>; Fri, 24 Mar 2017 05:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752638AbdCXFpn (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 01:45:43 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:35694 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751477AbdCXFpl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 01:45:41 -0400
Received: by mail-wm0-f46.google.com with SMTP id u132so4661585wmg.0
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 22:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7qPgeb4gzRhbAGgo3qw7H9l1UyU68JBoEVKJUY/iXn4=;
        b=T2l8fQsGaEgpckpDR/BaQZJPnbZKY43OzRFAZtJz8wyUfMp3aHT82Io6gC+GJTHzDF
         xrwv7qBW/HY9yiyL9EUN2zN16VeFKqs6Dvjdo4gjoAfs4EuPOP2lhk87x0Np0CWMSNOW
         j20E25vA13JvM0CtEx+wTEe3fLDqnJ1KsGBEcsAFwaLxkSt+jq7z0gfvFvnK/Ab1sR+Y
         qIOi0+zX7wwZm1642dxid5HH0LuxubanGi+C+7xpzjiUT2m8HoApWEUIOnCV+07R9lEr
         GOV0EVwrk0AQPx4M8BhFzYn2Iw3lQRgHmfEPthsylN7/OvmvoQTtFvnP7li5j197k6zb
         NHTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7qPgeb4gzRhbAGgo3qw7H9l1UyU68JBoEVKJUY/iXn4=;
        b=MLczurhSzzoxfNDF6r/hL1s/klA+OV/mhPwpaWIHiQSgv6emVO18ZoLIwtfPVq6OM2
         pvkz9Ibp0FSpmhyAOs/52kohsx+589lOkTZQhMsDLE4AFvMVGVY8JCG/Iw05FNSwKxzh
         gUoOF8onIA5XqxlhH1f9PlDzlAgWhWVklYDtnC7iBmv5SZl4EtFvzUF+KdJxBAPC/5ul
         x4rUBedFVUQNDOn83cfEUGb2TCeCCLUapXCaYbTZP/drwFOdCNKzVv65Ilp8bqVisPWJ
         MfzkWRkKaGf46KUz/7gHz0ilx/+AmmUch+4WsiwB+20i8A9yz7OsvH14tHrXP+QbcKGv
         XkKw==
X-Gm-Message-State: AFeK/H1EXgI9Q50YzIHc0Mt7gfKRdm5iV/aQmZeNkjj+FK5TsW4Hid+75SMqvgsU2dTUARBvvHNc0oKhOUXFVA==
X-Received: by 10.28.94.194 with SMTP id s185mr1042715wmb.52.1490334339242;
 Thu, 23 Mar 2017 22:45:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.91.2 with HTTP; Thu, 23 Mar 2017 22:45:18 -0700 (PDT)
In-Reply-To: <xmqq8tnveuqv.fsf@gitster.mtv.corp.google.com>
References: <20170321055203.26488-1-alexhenrie24@gmail.com>
 <xmqqinn2sfdw.fsf@gitster.mtv.corp.google.com> <xmqqzigemfij.fsf@gitster.mtv.corp.google.com>
 <CAMMLpeQZXzPtN+mmtRS33vbT6hFz8p0qqjFMhz9tUHk747=Z3Q@mail.gmail.com>
 <xmqqmvcdmeuv.fsf@gitster.mtv.corp.google.com> <CAMMLpeR-zCpL5Gx=BoK8G9_wL2TBe-wD3VnsAShAuVVzS=Nirg@mail.gmail.com>
 <xmqqfui4f0pp.fsf@gitster.mtv.corp.google.com> <CAMMLpeRtzYM3a639DcNbhqAmz3dNkRebvQps-gusEKx+eQqPgQ@mail.gmail.com>
 <xmqq8tnveuqv.fsf@gitster.mtv.corp.google.com>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Thu, 23 Mar 2017 23:45:18 -0600
Message-ID: <CAMMLpeSawRe7SLmFPzZ+EerQvtcyvObYyv=iWMwhiRvjNPreHw@mail.gmail.com>
Subject: Re: [PATCH] log: if --decorate is not given, default to --decorate=auto
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2017-03-23 12:03 GMT-06:00 Junio C Hamano <gitster@pobox.com>:
> Alex Henrie <alexhenrie24@gmail.com> writes:
>
>> Yes, that makes sense. I assume that when you talk about 'next', you
>> mean 'master'?
>
> No, I do mean 'next'.  See "A note from the maintainer" post that
> are sent to the list every once in a while (i.e. after a new release
> is tagged) for the project structure.
>
>     https://public-inbox.org/git/xmqqy3vztypi.fsf@gitster.mtv.corp.google.com/

That document was very helpful, thanks.

>> If we want to use `git -p log` in a test, we'll have to change the
>> behavior of pager_in_use(). Alternatively, we could use
>> `GIT_PAGER_IN_USE=1 git log` instead.
>
> Testing "git -p" is not the goal; testing that decorate defaults to
> auto during an interactive session is.  We could run tests under pty
> like t7006 does using lib-terminal.sh if we really want to emulate
> an interactive session.
>
> Exporting GIT_PAGER_IN_USE may be sufficient for the purpose of
> convincing the command to be in an interactive session for this
> test, even though it feels a bit too brittle to depend on the
> internal implementation detail.

Okay, I've now written a lib-terminal test for git log. I'll send the
revised patch momentarily.

-Alex
