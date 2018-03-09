Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F287E1FAE2
	for <e@80x24.org>; Fri,  9 Mar 2018 11:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751054AbeCILUX (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Mar 2018 06:20:23 -0500
Received: from mail-ua0-f172.google.com ([209.85.217.172]:39752 "EHLO
        mail-ua0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750920AbeCILUV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Mar 2018 06:20:21 -0500
Received: by mail-ua0-f172.google.com with SMTP id e25so1979833uam.6
        for <git@vger.kernel.org>; Fri, 09 Mar 2018 03:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8CQK3PCfbypwXB5TdFTGAoQPBLhLEfPRPm5ylVhN/H0=;
        b=WKoRVLn4YBPkSCpClrwAZMs4ZU9C9T7OqfmFA5vLsiQ0v0Xlw9rHnFwzfg/Qgqb4X+
         NbGgCpw2/IZv8pEkZGj1ijMTEgJGkAUCAlAz4feE0+8vW9QoEzbufjuN/6IGKSzEOE4l
         lJSod/N2r3QGea+Xvs+nCsvwib+d75Obi4x+UWMsWVmpVIkzKHQQ1lw1oRTX+bJcCupz
         0kBBJK7aM1it/nrzRd0kuxbMJt69d0IprOapHYcDHTlv4TNYyrAmzBaE9bRp/eIfxwN8
         O8tLqBoqkbA/62isx6vNtWdwr6xXOMIe2g3n2WQebglIK2wBKANzzGLkgOsDqFc1sUh6
         OeEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8CQK3PCfbypwXB5TdFTGAoQPBLhLEfPRPm5ylVhN/H0=;
        b=fJB9i0kTSxqtD9awmw3uxmda9/IJr/Y7QE1RdFM9jIqPkIsmY8AB0AVb52TIddmkFx
         AugR4A3SPrUogGgdyC2rWmbS0C9hoa3DcdmTH4SUtMmaUSWdoLBxKv91FwNJUyKLaU2h
         Gjn8mQEaBTTSJzi1NJWh5ccYP6Ry35S8TYV2BLBBn4k3I3OSktxs3r7ZEP9LQhUuhgbO
         yne6qyxnmcaP8/sqDOi0Lac1tKvqB/u2HhuZ6YBr/8Yyh8Q2oH9nb18fohlPy6fK+CA7
         5YtLzyWOEtllonqLcf0rou8obvY6iDQ5y69ZWgWjnJHrFvKRhGQpF30ELXPwVU8lgG+O
         giUg==
X-Gm-Message-State: APf1xPB/3z/o9LU9znuBvpH2Dkw07huoOOx0MIJVQrb98mopKtVQ0QOx
        wEWlBoUzcJpMRiXQV0O7OGfehNhCcC9mCpaZgSI=
X-Google-Smtp-Source: AG47ELtJX1+XJEozh2W+412F8EnnFd82+zXn1Ar6zV1OONj+vdVGJJ3miYBKfFSdZegGrVtTU+eI41qX0Hype/9Jd1c=
X-Received: by 10.176.16.27 with SMTP id f27mr21854092uab.196.1520594421246;
 Fri, 09 Mar 2018 03:20:21 -0800 (PST)
MIME-Version: 1.0
Received: by 10.159.59.233 with HTTP; Fri, 9 Mar 2018 03:20:20 -0800 (PST)
In-Reply-To: <xmqqvae66ske.fsf@gitster-ct.c.googlers.com>
References: <CAPig+cRSDbFZ_C9opu3pr=m7HwFkeuoxUD_8Yqbd4XxX-W0cHg@mail.gmail.com>
 <20180308224458.5730-1-szeder.dev@gmail.com> <xmqqzi3i6t2v.fsf@gitster-ct.c.googlers.com>
 <CAM0VKjkkFR-zVQMMqp0pJn489bV1uqEHZkB8Mo789J0K+qO3vA@mail.gmail.com> <xmqqvae66ske.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Fri, 9 Mar 2018 12:20:20 +0100
Message-ID: <CAM0VKjnfNBGd4BPXGbpGSTH_YW8dfX=19Lr-DCcS=B5BHp_nCg@mail.gmail.com>
Subject: Re: [PATCH v1.1 1/2] t9400-git-cvsserver-server: don't rely on the
 output of 'test_cmp'
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 9, 2018 at 12:44 AM, Junio C Hamano <gitster@pobox.com> wrote:
> SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

>>> This makes "rm -f failures &&" unnecessary, no?
>>
>> Indeed, it does.
>
> OK, no need to resend, as I'll amend it locally before queuing
> (unless there is something else that needs updating, that is).

Thanks.

That 'rm' was unnecessary to begin with, because none of the previous
tests wrote and left behind a file 'failures', ever.  Though one could
argue that the original author was careful and added that 'rm failures'
as a protection against future changes to previous tests...  Dunno, we
are talking about a test that checked the stderr of 'test_cmp', so
anything is possible :)
