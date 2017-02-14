Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 182911FAF4
	for <e@80x24.org>; Tue, 14 Feb 2017 17:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932280AbdBNRlA (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 12:41:00 -0500
Received: from mail-it0-f47.google.com ([209.85.214.47]:38233 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932276AbdBNRk7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 12:40:59 -0500
Received: by mail-it0-f47.google.com with SMTP id c7so41482173itd.1
        for <git@vger.kernel.org>; Tue, 14 Feb 2017 09:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=z3Q4OY2YRbM2DLO/nxGu4GxrPglJCf6jFq8Kl6Msn0s=;
        b=DD6lYFAxddU/ppT8uaQCRvDZTDDpWCo6RJfX+L5PQXuLRAF6HIGNHIVEZTOdkGzM1H
         AGLSAzyEvtSDZ3oCXfAso6bQYOqi8TdOQq5eJKLeWjL4VvmtEHxqfNVnmEbFi167xej3
         ylIrMyb3Hqg4Ak81+dSMYZJ69uGoikQUVuL+Z4jNhWlNxnS+0ANs9qYqNWwtzPfAtPsi
         6HFKxykMjpoQ3mzGBEhgmAfW0GC2Pq+KQkPzk9eR5q+JPEkheCfF2Fv9Rv/QOBcY0hev
         kWq/mawC8Tbtnc/yGwbpnYrS5klHDr+0YBb4khVP5fS03T1xsLpzqW9Mf7aq7qT8XMQx
         IW1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=z3Q4OY2YRbM2DLO/nxGu4GxrPglJCf6jFq8Kl6Msn0s=;
        b=pxWBo1EcwAr4Tk3yE856w/+TW0LlRC1Kkz6oUdiflFvqDE//7GF8fNWTnsSCydrzfQ
         +V/RPZYrPcdhqgyMixk+0HYO/rKI9ciBsF4lF4FH68y51d2f9QmDPPulYZMK9JWleM0m
         qjhS8/VC6VYEno+d9TOn8uo8CSz20y9l5C5kkPelmV3ezpwUbXMG9FIam8lpt9LInk7s
         2WoxmreKmBDnfU7wnL+8mR3fvpy/Mv1k2MLf0aMqQ/r2ZgDAGwfCZy4OdUDvZQNG1Ff2
         krNB2jL9F5B4RBoXMQsF5hUgG/s0oNSxsdrQEBW8cBxCfJvuxv0o3s7q7TyRw/7DP6pg
         Xs/w==
X-Gm-Message-State: AMke39kmSNR7ZkW3+WRCZf90kthbXABiC8jdL9sfKfEngHEI8Rm+x3O6ZxwFbzWlFx7Tts2yJ2z8gZqbvxknv6WN
X-Received: by 10.107.16.14 with SMTP id y14mr26253376ioi.164.1487094058068;
 Tue, 14 Feb 2017 09:40:58 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.33.148 with HTTP; Tue, 14 Feb 2017 09:40:57 -0800 (PST)
In-Reply-To: <CACsJy8D=qFQ2_62e4oO1pSBz4JfZV4Zcoai=Ghjw5DTaNxrwog@mail.gmail.com>
References: <20170213152011.12050-1-pclouds@gmail.com> <20170213152011.12050-7-pclouds@gmail.com>
 <CAGZ79kYkc-_=RiK1uJ+ndhQu=B8u=UDVusXZu-dYe7KnGNye3Q@mail.gmail.com> <CACsJy8D=qFQ2_62e4oO1pSBz4JfZV4Zcoai=Ghjw5DTaNxrwog@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 14 Feb 2017 09:40:57 -0800
Message-ID: <CAGZ79kaN-Z5zKHBCoeVzsQbJiHm408RB2QYZ8=W4QNP0Gdy7sQ@mail.gmail.com>
Subject: Re: [PATCH 06/11] refs-internal.h: correct is_per_worktree_ref()
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Turner <novalis@novalis.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 14, 2017 at 1:40 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Tue, Feb 14, 2017 at 5:37 AM, Stefan Beller <sbeller@google.com> wrote=
:
>> On Mon, Feb 13, 2017 at 7:20 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
>>> All refs outside refs/ directory is per-worktree, not just HEAD.
>>>
>>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
.com>
>>> ---
>>>  refs/refs-internal.h | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
>>> index f4aed49f5..69d02b6ba 100644
>>> --- a/refs/refs-internal.h
>>> +++ b/refs/refs-internal.h
>>> @@ -653,7 +653,7 @@ const char *resolve_ref_recursively(struct ref_stor=
e *refs,
>>>
>>>  static inline int is_per_worktree_ref(const char *refname)
>>>  {
>>> -       return !strcmp(refname, "HEAD") ||
>>> +       return !starts_with(refname, "refs/") ||
>>>                 starts_with(refname, "refs/bisect/");
>>
>> you're loosing HEAD here? (assuming we get HEAD in
>> short form here, as well as long form refs/HEAD)
>
> I don't understand. if refname is HEAD then both !strcmp(...) and
> !starts_with(refname, "refs/") return 1. If it's refs/HEAD, both
> return 0. In other words, there's no functional changes?

eh, my bad. You're right.
