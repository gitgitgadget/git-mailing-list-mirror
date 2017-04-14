Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 718FB2013A
	for <e@80x24.org>; Fri, 14 Apr 2017 22:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755233AbdDNWyR (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Apr 2017 18:54:17 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:37990 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752629AbdDNWyP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2017 18:54:15 -0400
Received: by mail-wm0-f50.google.com with SMTP id t189so2275337wmt.1
        for <git@vger.kernel.org>; Fri, 14 Apr 2017 15:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9Iqre+q6aIDw3nP3RyOpNE0AQAthCMfeI0uUJQKt9+g=;
        b=VnyaNqgebbqqGamwCaeG72h4ElGDgrNuL4Q060czao6ylrbPgf/wzdaCrJRvj9Zf8l
         91jS9bzYnURxbs5S6xRumOoHKpYmnZE8nodiWQWSYyyYFGPReW5xuVGHFWiraR8tBFJj
         oyFJToveh+VlxM7YPY3/EGS3+ZObdOriUQkXxBe8xTqPkRPjvqAyIk3ZKVRSQsRsr3oK
         7Yw7tAVh+57em9S4pzdXbbNYtqrQH0WIzTWhfc3kJhEQ5UOPfKy3OcDUcXpQI4DffKu8
         nnwRhYt8tFhYw+QmEdqfMFn9OpmAVNRK/QyovFRrgipDd1PgWfKbb32AodpFQcjdYrls
         hx/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9Iqre+q6aIDw3nP3RyOpNE0AQAthCMfeI0uUJQKt9+g=;
        b=UbrZuWeEbLeFthxQTCAzMS5UOzWf/Ov8UVjgvgadRDQZbXMzX6qx18ZWRjbyUjOt7H
         ShbHU85oJC4YAuCJwMrCQIqy7oOhY01qyo6g9lulExAGyIeasVFLVjkaw1X3wezM6goS
         Ru+J9mBO/umCEicGGPW/UhpvLJqtnivHhccBW+jRmvmFKTZCVEDxBVtyx4JhzchMQAO5
         pzLntyDqKYwGYEk9+dDHC1tvAHQmFb9dnSNev+3B2KTTkynpHF/IVzej0Jh2YBfltyom
         KXK3pcf5CKU/rXNSSPfZDnI99//VC6ZucU8XbBe5Ct+t88RMiPuwN9k0I7oGPF0hoNtN
         FlVg==
X-Gm-Message-State: AN3rC/6DJycpoYI3wVaL/oBxin+6g07gNF/I3cMmRRIF3KsMCEW9DzYe
        2fNidLT1xAxMIFy2rHfuVnX3gjGTqw==
X-Received: by 10.28.31.200 with SMTP id f191mr529333wmf.63.1492210454187;
 Fri, 14 Apr 2017 15:54:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.98.212 with HTTP; Fri, 14 Apr 2017 15:53:53 -0700 (PDT)
In-Reply-To: <CACBZZX4_yTbJ77XZYGGyh1B_Lo=OqteQTDXyaSjdoR9RvVuHAA@mail.gmail.com>
References: <20170414165044.13990-1-giuseppe.bilotta@gmail.com> <CACBZZX4_yTbJ77XZYGGyh1B_Lo=OqteQTDXyaSjdoR9RvVuHAA@mail.gmail.com>
From:   Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Date:   Sat, 15 Apr 2017 00:53:53 +0200
Message-ID: <CAOxFTcw5iePfT55=nDVvFUsjEo1rHMxwOd_r3JCe3+8sfd7QPQ@mail.gmail.com>
Subject: Re: [PATCHv2] rebase: pass --[no]-signoff option to git am
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git ML <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 15, 2017 at 12:44 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Fri, Apr 14, 2017 at 6:50 PM, Giuseppe Bilotta
> <giuseppe.bilotta@gmail.com> wrote:
>
> It should be --[no-]signoff, not --[no]-signoff, since the latter
> implies that ---signoff works, see my 2c7ee986c7 where I fixed some
> existing instances of this.

Oops, yes of course. I'll resubmit.

--=20
Giuseppe "Oblomov" Bilotta
