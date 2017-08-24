Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85534208DB
	for <e@80x24.org>; Thu, 24 Aug 2017 07:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751215AbdHXHBm (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Aug 2017 03:01:42 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:52844 "EHLO
        alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751114AbdHXHBl (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 24 Aug 2017 03:01:41 -0400
X-AuditID: 1207440f-a5bff70000007960-c9-599e79d49149
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 4E.03.31072.4D97E995; Thu, 24 Aug 2017 03:01:40 -0400 (EDT)
Received: from mail-it0-f45.google.com (mail-it0-f45.google.com [209.85.214.45])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v7O71dMT026130
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
        for <git@vger.kernel.org>; Thu, 24 Aug 2017 03:01:39 -0400
Received: by mail-it0-f45.google.com with SMTP id 190so10487834itx.0
        for <git@vger.kernel.org>; Thu, 24 Aug 2017 00:01:39 -0700 (PDT)
X-Gm-Message-State: AHYfb5i18miveMpy/J/8fURMB1LwEtgJcuDYlPh6zGxdHnvXV3fAOJVr
        N5yEd3/V+NRcUXcZm+xk73I/NqLhkQ==
X-Received: by 10.36.41.143 with SMTP id p137mr4760376itp.98.1503558099067;
 Thu, 24 Aug 2017 00:01:39 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mhagger@alum.mit.edu
Received: by 10.107.15.204 with HTTP; Thu, 24 Aug 2017 00:01:38 -0700 (PDT)
In-Reply-To: <xmqqd17mx82h.fsf@gitster.mtv.corp.google.com>
References: <030b6bb22973df429ddbb64a079b9cdc1fbcb1b7.1503313472.git.mhagger@alum.mit.edu>
 <xmqqd17mx82h.fsf@gitster.mtv.corp.google.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Date:   Thu, 24 Aug 2017 09:01:38 +0200
X-Gmail-Original-Message-ID: <CAMy9T_FJiDG7uzs8cDExzz_UPiRvAwM61Xfsv=wMUkNJCTghCw@mail.gmail.com>
Message-ID: <CAMy9T_FJiDG7uzs8cDExzz_UPiRvAwM61Xfsv=wMUkNJCTghCw@mail.gmail.com>
Subject: Re: [PATCH] Retry acquiring reference locks for 100ms
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplleLIzCtJLcpLzFFi42IRYndR1L1SOS/S4OB6IYuuK91MDowenzfJ
        BTBGcdmkpOZklqUW6dslcGV8WNvKVnBBrOLYujVsDYwLhLoYOTkkBEwkPm3ZyNrFyMUhJLCD
        SaJj3QpGCOcRk8Sx9RPZIZw+RolZ818xQrTkS3Q1PGaDsIslDq55zg5i8woISpyc+YQFxBYS
        kJN4teEGUD0HkO0tMeMTP0iYU8Ba4uXDT0wQM7sZJS6fug42k01AV2JRTzMTiM0ioCqx698b
        Foj5iRKrGqYwQswPkPg48w0riC0sYCdx+udCsL0iAmoSE9sOgdUzC7hKTGl5yQRha0q0bv/N
        PoFReBaS82YhSS1gZFrFKJeYU5qrm5uYmVOcmqxbnJyYl5dapGuil5tZopeaUrqJERLG/DsY
        u9bLHGIU4GBU4uHVWDI3Uog1say4MvcQoyQHk5Io7xPpeZFCfEn5KZUZicUZ8UWlOanFhxgl
        OJiVRHjDKoByvCmJlVWpRfkwKWkOFiVxXvUl6n5CAumJJanZqakFqUUwWRkODiUJ3vcgjYJF
        qempFWmZOSUIaSYOTpDhPEDDF4INLy5IzC3OTIfIn2I05rhyZd0XJo4pB7Z/YRJiycvPS5US
        591fDlQqAFKaUZoHNw2Wil4xigM9J8xbD0xMQjzANAY37xXQKiagVZNOzAFZVZKIkJJqYLTt
        7Zn6vTKgzpyv/uHX2au4s1OaHW5Klb2P0ygL9xV1fdGy7ue3JWJFAg4SKzU6OG+Gef/NeCW1
        YuvdE28P7FRx/3x2dZ+z8xw1tY8JS5k/ZZtM6vdZo3hrvkThh5Zdh3zn759hc4OfZ9ViF0+/
        0F2fJLeyRPVlbT/34nHl8bnzGeLir6Z+nafEUpyRaKjFXFScCACt0UuPIAMAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 23, 2017 at 11:55 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
>
>> The philosophy of reference locking has been, "if another process is
>> changing a reference, then whatever I'm trying to do to it will
>> probably fail anyway because my old-SHA-1 value is probably no longer
>> current". But this argument falls down if the other process has locked
>> the reference to do something that doesn't actually change the value
>> of the reference, such as `pack-refs` or `reflog expire`. There
>> actually *is* a decent chance that a planned reference update will
>> still be able to go through after the other process has released the
>> lock.
>
> The reason why these 'read-only' operations take locks is because
> they want to ensure that other people will not mess with the
> anchoring points of the history they base their operation on while
> they do their work, right?

In the case of `pack-refs`, after it makes packed versions of the
loose references, it needs to lock each loose reference before pruning
it, so that it can verify in a non-racy way that the loose reference
still has the same value as the one it just packed.

In the case of `reflog expire`, it locks the reference because that
implies a lock on the reflog file, which it needs to rewrite. (Reflog
files don't have their own locks.) Otherwise it could inadvertently
overwrite a new reflog entry that is added by another process while it
is rewriting the file.

>> So when trying to lock an individual reference (e.g., when creating
>> "refs/heads/master.lock"), if it is already locked, then retry the
>> lock acquisition for approximately 100 ms before giving up. This
>> should eliminate some unnecessary lock conflicts without wasting a lot
>> of time.
>>
>> Add a configuration setting, `core.filesRefLockTimeout`, to allow this
>> setting to be tweaked.
>
> I suspect that this came from real-life needs of a server operator.
> What numbers should I be asking to justify this change? ;-)
>
> "Without this change, 0.4% of pushes used to fail due to losing the
> race against periodic GC, but with this, the rate went down to 0.2%,
> which is 50% improvement!" or something like that?

We've had a patch like this deployed to our servers for quite some
time, so I don't remember too accurately. But I think we were seeing
maybe 10-50 such errors every day across our whole infrastructure
(we're talking like literally one in a million updates). That number
went basically to zero after retries were added.

It's also not particularly serious when the race happens: the
reference update is rejected, but it is rejected cleanly.

So it's definitely a rare race, and probably only of any interest at
all on a high-traffic Git server. OTOH the cure is pretty simple, so
it seems worth fixing.

Michael
