Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87C271F403
	for <e@80x24.org>; Sun,  3 Jun 2018 15:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751572AbeFCPSB (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 11:18:01 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:42030 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751393AbeFCPSA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 11:18:00 -0400
Received: by mail-ot0-f196.google.com with SMTP id l13-v6so34673958otk.9
        for <git@vger.kernel.org>; Sun, 03 Jun 2018 08:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yGXww7170Sd/oLZ43SrCenCYbp9OIEHb2e7d+iMasJM=;
        b=XUfYdvKuUTLFBTUktbypELAuJ2evGiACPaLGWkoyOwRqewj/XOHtUkRlh3bnmuFghS
         g1/i7Q0kMPEDXo+1F4Ube0kfQH1RBLCb4itHQsGJSlVs0i5CMI0LtCL/e1tTd7Xmc/jG
         HgeXZlpQ6bTm130hM7nfLaP+UAHX6WyNKFWCYmd9+l+ZK3GgHP2vY3wUerPL7qWJjSWt
         5hvO52i10gJuxbpLxNZ06uUbpmLTRRJ8wUlwCXro2o0Wmz34MUb/JaED8M3alCSPwzyj
         M0Mr/xYk79jCAa6Os+oTLNB6qORncvtf64I4tkF9CJjWBYqaPXRGZgLqh+cNdqvHWZfP
         vzrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yGXww7170Sd/oLZ43SrCenCYbp9OIEHb2e7d+iMasJM=;
        b=Jn0GA/fPwXE2crwftbkijwWQ1mSkvuWT5QW4gprDyWvKPbNZQ1xulGG88Rp46J+vLH
         tvXloqKDwcwI8IuKVXcTgus73QqlLstbB7ZGdOXJal2PZ1WqLvjz+7/CuFEIU4pJdo0e
         P/GTxNlxdO9tkmlLFW6EPvl8LfyNEg5lpjOz2Yks3kcIjVWub7E3UV7xmKJ/JGJ2cx3E
         Zlu16ho0bWPAt+bcR15gZRfGnlETy6ZBGOQadV5bHnniS+hn+NfGMUVMTrW80gKch/JX
         rktjukvVpSVpPfcIuQ2r31FYhmMigiFZmKqnmpK2iZ3TVKbH12lW13tRUQspsCCGsW+j
         C7OA==
X-Gm-Message-State: ALKqPwf3K/TjBdf3zj8IykWt3rvAVfLZWSXy3garBjDst8P56zuEBDCR
        FCWuUJsortfSJQZY5mxKvFqKoTBw7+238Xl7wCI=
X-Google-Smtp-Source: ADUXVKJvLRgLBBiaJg04wjp8nwIU3jqFTDTystIbX5sAgo3LSEOcW3oECMjQZ3HjY5Xv/0+x3Wlc9SlzPTYLU+nnr1o=
X-Received: by 2002:a9d:2f91:: with SMTP id r17-v6mr13273587otb.356.1528039080404;
 Sun, 03 Jun 2018 08:18:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:b285:0:0:0:0:0 with HTTP; Sun, 3 Jun 2018 08:17:30 -0700 (PDT)
In-Reply-To: <CAPig+cSVJq8iaKJDO_AiFs6-01PbtoRj1=56cv6_nNPQwEPacQ@mail.gmail.com>
References: <20180602043241.9941-1-pclouds@gmail.com> <20180602043241.9941-22-pclouds@gmail.com>
 <CAPig+cSVJq8iaKJDO_AiFs6-01PbtoRj1=56cv6_nNPQwEPacQ@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 3 Jun 2018 17:17:30 +0200
Message-ID: <CACsJy8D0zJAPCS6YHZo8NCb+S3ZJE7PsWoV-PrTXuQjeJ8zOwA@mail.gmail.com>
Subject: Re: [PATCH 21/22] transport.c: mark more strings for translation
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 3, 2018 at 10:29 AM, Eric Sunshine <sunshine@sunshineco.com> wr=
ote:
> On Sat, Jun 2, 2018 at 12:32 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Du=
y <pclouds@gmail.com> wrote:
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.=
com>
>> ---
>> diff --git a/transport.c b/transport.c
>> @@ -875,7 +875,7 @@ struct transport *transport_get(struct remote *remot=
e, const char *url)
>>         ret->progress =3D isatty(2);
>>
>>         if (!remote)
>> -               die("No remote provided to transport_get()");
>> +               BUG("No remote provided to transport_get()");
>
> Did you want to downcase "No" or just didn't bother since it's not
> intended for end-user?

Not bother since it's BUG().
--=20
Duy
