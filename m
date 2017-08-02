Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D91820899
	for <e@80x24.org>; Wed,  2 Aug 2017 12:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753150AbdHBMVH (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 08:21:07 -0400
Received: from mail-qt0-f170.google.com ([209.85.216.170]:36907 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753114AbdHBMVG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 08:21:06 -0400
Received: by mail-qt0-f170.google.com with SMTP id 16so25617947qtz.4
        for <git@vger.kernel.org>; Wed, 02 Aug 2017 05:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pAoHhHSxSlVkUrPbApDJi6zG/2RXlglvGw/4fdMKwis=;
        b=flYUcyfrvFY6ZrVFwymurVneZE7Gn+NVNiAMvvu0Ml1XrmBp/YoWoGOKUddGDS9sFQ
         WiVqNK2Kx9N21f7Hq+H42dpDVosKs6WzTlPvJdnUlL5ie70MsoYMBfdMcZ/E3th1qly+
         TU8hT6QPcAKE/D1RgQEOM3K6If70aK+TEMmTs2qId3U6u8h1xEd3RA7s/OcKTXf80I2+
         gDbZ2N3Z0vdg+zvWlLNiliCOQmSYxB83VwIqZ0R9weJnI0fw9udQOmZWkmc9fsJLqLXW
         WrTn1Hi0Mmciiyv7XV/e/9/4MuahxJxsyCwr8gVr2OakSXFMjn4vVzvhltNnBZJNDm8r
         keUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pAoHhHSxSlVkUrPbApDJi6zG/2RXlglvGw/4fdMKwis=;
        b=dXyKX0ySq+dHAFBqcByJGV+i+etw4VwynZ+MnhkdqSeZM55UAf59vP7kTV8wbBeHJg
         JLvhVeRxaTGqe3EMZfMXN+CPOq0XiDq1IMyKMwyg8KCM6AWuslgHBQlXKuSvxtpFBKN1
         43C8FLOtPr41cFwqcsAHDve5N8M9TkvPDo3ZZIg/R3Y7ozhG70a/4jI/2U2S01+KQ0aS
         m0+VThsPXq+GjDAw5SE++5sJDvBx5Xtssk4xFP+10sayelVkNpM1fL2zlCeowK0tY6DI
         7hq658f2pYGsfayAsGUkohdjuWZvtxr0A3Z4TZGGjEuTk5ugyLeCEia5bO01ICR9xVEV
         shsQ==
X-Gm-Message-State: AIVw110/dGXe1GGA7iA5lihnK0z1kwE2SkwskigGFNOEX4f5K02pH3E1
        +LeTJ8CeHOZ2Axz7tIJxRpdhttvgUrT7
X-Received: by 10.200.9.47 with SMTP id t44mr2777519qth.16.1501676465488; Wed,
 02 Aug 2017 05:21:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.44.102 with HTTP; Wed, 2 Aug 2017 05:20:44 -0700 (PDT)
In-Reply-To: <CAJo=hJv=zJvbzfAZwspxECXrnBJR4XfJbGZegsNUCx=6uheO2Q@mail.gmail.com>
References: <CAJo=hJv7scc1L0_MdRkFeLAJGjYm2UkTFNOgj2e4+9Zj7KSiiQ@mail.gmail.com>
 <CAMy9T_HCnyc1g8XWOOWhe7nN0aEFyyBskV2aOMb_fe+wGvEJ7A@mail.gmail.com>
 <CAJo=hJvFRJ7honjenB6sUofK14xiUXGwJ1DQHZyTauVKA5v5vw@mail.gmail.com>
 <CAMy9T_HUoD4--s1gNTUjnCgdiAqfYbX-GSqygDwNO-JRwdh4NQ@mail.gmail.com> <CAJo=hJv=zJvbzfAZwspxECXrnBJR4XfJbGZegsNUCx=6uheO2Q@mail.gmail.com>
From:   Dave Borowitz <dborowitz@google.com>
Date:   Wed, 2 Aug 2017 08:20:44 -0400
Message-ID: <CAD0k6qRTa6jSgEBBX1Ux5yg4QMMWPpyOGTa471cRhtzBaS-KjQ@mail.gmail.com>
Subject: Re: reftable [v4]: new ref storage format
To:     Shawn Pearce <spearce@spearce.org>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, git <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 1, 2017 at 10:38 PM, Shawn Pearce <spearce@spearce.org> wrote:
>> Peff and I discussed off-list whether the lookup-by-SHA-1 feature is
>> so important in the first place. Currently, all references must be
>> scanned for the advertisement anyway,
>
> Not really. You can hide refs and allow-tip-sha1 so clients can fetch
> a ref even if it wasn't in the advertisement. We really want to use
> that wire protocol capability with Gerrit Code Review to hide the
> refs/changes/ namespace from the advertisement, but allow clients to
> fetch any of those refs if they send its current SHA-1 in a want line
> anyway.
>
> So a server could scan only the refs/{heads,tags}/ prefixes for the
> advertisement, and then leverage the lookup-by-SHA1 to verify other
> SHA-1s sent by the client.
>
>> so avoiding a second scan to vet
>> SHA-1s received from the client is at best going to reduce the effort
>> by a constant factor. Do you have numbers showing that this
>> optimization is worth it?
>
> No, but I don't think I need to do much to prove it. My 866k ref
> example advertisement right now is >62 MiB. If we do what I'm
> suggesting in the paragraphs above, the advertisement is ~51 KiB.

That being said, our bias towards minimizing the number of ref scans
is rooted in our experience where scanning 866k refs takes 5 seconds
to get the response from the storage backend into the git server.
Cutting ref scans from 2 to 1 (or 1 to 0) is a big deal in that case.
But that 5s number is based on our current, slow storage, not on
reftable. If migrating to reftable turns each 5s scan into a 400ms
scan, we might be able to live with that, even if we don't have fast
lookup by SHA-1.

>> OTOH a mythical protocol v2 might reduce the need to scan the
>> references for advertisement, so maybe this optimization will be more
>> helpful in the future?

I haven't been following the status of the proposal, but I was
assuming a client-speaks-first protocol would also imply the client
asking for refnames, not SHA-1s, in which case lookup by SHA-1 is no
longer relevant.
