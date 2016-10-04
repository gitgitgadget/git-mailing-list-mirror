Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABC3E20986
	for <e@80x24.org>; Tue,  4 Oct 2016 20:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753974AbcJDUqa (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 16:46:30 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:36345 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753441AbcJDUqa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 16:46:30 -0400
Received: by mail-yw0-f193.google.com with SMTP id r132so4912168ywg.3
        for <git@vger.kernel.org>; Tue, 04 Oct 2016 13:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LrrHH7YH8s4Jx9iaX1MmXGuEi02k1Nvkx/MiV8zX+yk=;
        b=SfQU7V4X0J2GpdIH3hCxgC0GecWmP03/D2DLuo32djzn1gyTNkOhrARQw+nDG/s6Ss
         YOmaZlcQJIqMHc9+0U2u1euR0ONv8fPmM2DsCmdlew1wuoGKs+Th+g1LXAsLJZCVKXgp
         OEzTewLWc4UGN+sZeZd4or8oSpAx9+8NrPbT/QWupVEgpAoqfekb0Z2B+EvNjr+5GLeE
         38AZAWSCqhJmYJmx8U+uG5Iudb3elYSdlAlmTxwioNyMcYUZd2p4UARwQcz0TX5h885o
         ExNGDDHhG584K6tZ23cYf//hZL1Yom7oebb4irwWXhcf8dJ3O+EXFnqXmPQKGLOaPsst
         V0ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LrrHH7YH8s4Jx9iaX1MmXGuEi02k1Nvkx/MiV8zX+yk=;
        b=aHUeBZKWZyr80MIi2Res/MIL2gjkmE4Q8NdDn/y3j779GqayJzYX1p0K52DvRE2C45
         25gRw0kXUWf7+XvqKPsrJkSPeEe//2OqLwYLKFHsqhcXzHPnlghu1qWCIxrkkCP4C9ng
         Ms1s9v2i4ok2NhX8X3/EGM1PrH1Hz5nbwYlEya8pSbWfZAtzMDryIHyR5qo7rgDQfZ3z
         /cPRdvimUpt4TEqKsV3W4Lit6GspDEyNUeyKQmTFO2AHJXPI0IzLv1UGrEHajVSNHhQc
         K1g4Gm/J6CvQ8tjNPD9mOwheuvvb4wjNoGRH+LCDBfd8Hvqsryq6XvUSrZm2D6FOGESw
         Nq+g==
X-Gm-Message-State: AA6/9RlLmGlljG4N3uOwFBrvyY1TcMh0UXicv6zikC1qsCOFuPmTO7URE9EhYdXeKkp9IkFGSy4ChaGOsEv5Sg==
X-Received: by 10.129.76.194 with SMTP id z185mr4597026ywa.257.1475613989265;
 Tue, 04 Oct 2016 13:46:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.96.195 with HTTP; Tue, 4 Oct 2016 13:46:08 -0700 (PDT)
In-Reply-To: <20161004135353.6ywgoxutjcbaali5@sigill.intra.peff.net>
References: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
 <20161003203448.cdfbitl5jmhlpb5o@sigill.intra.peff.net> <CA+P7+xrUOnDebwZnfu-xv-GuTJka4-eNUAfBudQf5ZhnkczU6w@mail.gmail.com>
 <20161004135353.6ywgoxutjcbaali5@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 4 Oct 2016 13:46:08 -0700
Message-ID: <CA+P7+xqSzm7S4-Mc+keJ1JWioYUmF76es0A3xN+Hwq+EJ6dJSA@mail.gmail.com>
Subject: Re: [PATCH 08/18] link_alt_odb_entry: refactor string handling
To:     Jeff King <peff@peff.net>
Cc:     Git mailing list <git@vger.kernel.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 4, 2016 at 6:53 AM, Jeff King <peff@peff.net> wrote:
> On Mon, Oct 03, 2016 at 11:05:42PM -0700, Jacob Keller wrote:
>
>> This definitely makes reading the following function much easier,
>> though the diff is a bit funky. I think the end result is much
>> clearer.
>
> Yeah, it's really hard to see that all of the "ent" setup is kept,
> because it moves _and_ changes its content (from pfxlen to pathbuf.len).
>
> I actually tried to split this into two patches to make the diff easier
> to read, but there are two mutually dependent changes: moving to
> pathbuf.len everywhere requires not-freeing pathbuf in the early code
> path. But if you do that and don't move all of "is it usable" checks up,
> then you have to add a bunch of new error-handling code that would just
> get ripped out in the next patch.
>
> There's definitely _some_ of that in this series already (e.g., the
> counting logic in alt_sha1_path() added by patch 14 that just gets
> ripped out in patch 15 when fill_sha1_path() learns to use a strbuf). I
> tried to balance "show each individual obvious step" with "don't make
> people review a bunch of scaffolding that's not going to be in the final
> product".
>
> -Peff

Mostly the diff is funky because of how the diff selected which chunks
moved vs how your patch described what chunks moved.

Thanks,
Jake
