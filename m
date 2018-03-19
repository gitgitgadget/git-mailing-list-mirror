Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 484991F404
	for <e@80x24.org>; Mon, 19 Mar 2018 19:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969627AbeCSTi3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 15:38:29 -0400
Received: from mail-ot0-f173.google.com ([74.125.82.173]:32990 "EHLO
        mail-ot0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965605AbeCSTiZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 15:38:25 -0400
Received: by mail-ot0-f173.google.com with SMTP id y11-v6so18647229otg.0
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 12:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=f3z6LrzUcXWxBZt+TpjIPohNR2NV+NNqh38tTvTPL8U=;
        b=kxogULxo93SVDZuXj5ecm9iVinQwoxx3rUr/hsLsM2xLxbRmOhJ9KcFL5b6FJ4v32e
         ikpy4HDlPyawqcDelUEL1M9CTTx93x8v//u+lhImv6i01V56UDoZMgE2tgThq1HUhPvF
         s4jZee8gRr0v+ku6j0wijW6UuM+ZIP7upmp/epbhFAqeSwK8hHFQLmQrreH0strB9dTJ
         S90tZO/S+4VrEXWHcBLvE5T3NDjDp7KpRnfeGyHvTNI6b1PUK6WyHUDTTGAW9FrnJEpS
         eslt2OsUGaQd2gcCmXCjl55skSuERxeXMXwJjuIneMyO6u0LPRs9FlYyzP4yDxdQd1Pk
         xxoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=f3z6LrzUcXWxBZt+TpjIPohNR2NV+NNqh38tTvTPL8U=;
        b=FHkCaIBOgnFvnsbZ82ASzS0C9eaLOg44GgF+e7QR6RANrSDohoBCM5aoRSJcr/UXKm
         qmpzylfODpAuJIMihjilUzpvaxbYscXfoU7VZoRsRJMsniB5+K2XEoss9/kkTxzXnIPZ
         SKuEW0WlqYbNTIoMAKq6NK0Om1cUGFu5II8AToFcuiqja13utKtSX0v0T8ZSOGTDd/pX
         BEGtvezo212Fvlz1iTiFVK0sYnregDQDittefcBwz9BPTybbiSU1gwmCiodI3UE2VXcX
         34fidipb+LFJKWPo2YfQn+4JFuLS6UONyULsyOKN5MhGlby4x72YXELXAhNMZjx7z7UF
         XeLA==
X-Gm-Message-State: AElRT7EihWLegfcKrXOPa2PKTn/ayeyPtF/b1ci5u3UC6UIxkc8I0gmC
        M6q+NTf0ZJtuz3xxLl30EMeY4lQEiog8kMuoaR7VIY+P
X-Google-Smtp-Source: AG47ELu2SLcRVIACUIKc9L3DTMT2M4Zp3Q8xPODMDuV1MC35C+vqxdiVakgerKpLuADA0SfpLA6/UfFbV7bwrg0/gfE=
X-Received: by 2002:a9d:2ef0:: with SMTP id w103-v6mr2505198ota.400.1521488304636;
 Mon, 19 Mar 2018 12:38:24 -0700 (PDT)
MIME-Version: 1.0
References: <20180319025046.58052-1-dnj@google.com> <20180319025046.58052-4-dnj@google.com>
 <87woy7c1cf.fsf@evledraar.gmail.com>
In-Reply-To: <87woy7c1cf.fsf@evledraar.gmail.com>
From:   Daniel Jacques <dnj@google.com>
Date:   Mon, 19 Mar 2018 19:38:14 +0000
Message-ID: <CAD1RUU8JnQjspZjmWvM5h=3Rprk4TmfsNvBRAGVzze=WAnRQbg@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] exec_cmd: RUNTIME_PREFIX on some POSIX systems
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 19, 2018 at 3:27 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <ava=
rab@gmail.com>
wrote:

> I wonder if it wouldn't be a lot more understandable if these were noted
> together, i.e. let's first document RUNTIME_PREFIX, then for all the
> other ones say below that:

Sounds good to me, done.

> Whitespace changed mixed in with the actual change.

Oops, automatic "clang-format" slipped in there. I've reverted this part.

Thanks for reviewing!
