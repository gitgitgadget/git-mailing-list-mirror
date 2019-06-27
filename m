Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B26F1F461
	for <e@80x24.org>; Thu, 27 Jun 2019 08:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbfF0IyK (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 04:54:10 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35176 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbfF0IyK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 04:54:10 -0400
Received: by mail-io1-f67.google.com with SMTP id m24so3098189ioo.2
        for <git@vger.kernel.org>; Thu, 27 Jun 2019 01:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0o0ORj+H2VO3xM7Piz9sDDMQRxHf6ENc9VucNvwt65U=;
        b=JejJWapa8ZRWLWV322bRi8RBztHevZ41mqAynW7v0OdGh+MzQ1wdGEGzhGfL9iKk58
         poCPcjrGG85QwN/rVE/dXncygERdhZOkUJIujcc/BtT0O8IpzqNtEP3FRwoUyWDIsH88
         D6r1jml8/mr+iMUKRkfmVeW84veN0ryFm0PnDLF4DGk9KHSTP0hsNHFtqH2TDOHUhaJJ
         tFg63DXDSqpLPnxTXoJpfysnxgwFaxAoLXV0eKoXNawdpnMuxGpdGel/AoVYLkTV/d5L
         04wH6YUwSonqL2kCqP2Qo81i8dmHScIvarXaRWuJzoNJ6CVpdeg5+m+W1gxLaD/mbw6X
         rLmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0o0ORj+H2VO3xM7Piz9sDDMQRxHf6ENc9VucNvwt65U=;
        b=k6Zly3s+/AdRexr2UASGPZVC/fnqaBirT7l5dD4Mjw0PZs4UPsIdk+EK5tyx2Hg0tk
         CgqyslNRV9//qn+9VsJz3k2GZoV2zLCX5HaBR7XQxfjwd3T4BPSqGImMdM/ypFFQcIeI
         lnsHimYLqI5QdQdJHVvx0WyLorXWRZ0u01xsZcoF+OEe1Gf+YPgeNuniYTprEJ3pc4zH
         6UK35Z2N3XK4ISz1ihPfYlsPw7EnmvLyfKc2+0LgeZX/YOQJFUSSA4EVsBNdpeRRzK0i
         PZb/cHtHWxeGfY1YQp7VIDya5Mtmif5ODK1e7hF4Zouezop4sdFZGv2H6xlxGn85RCck
         A+7w==
X-Gm-Message-State: APjAAAUoeleRK++Vz+uxMOtMmYW8yn1NwHrD8Ti22HEwFShDgZ5hThW/
        Hc+Ie32II947p61T1rTcYnGsf0mvsSyNBMl7yOs=
X-Google-Smtp-Source: APXvYqzSZLmnC+nTwPn8K6USXmx3pueGjRzJre9tuzVywAqPebmTJVpuOX7ekVBRtfAm20v7O0Fsu3hidIpDebHdAPs=
X-Received: by 2002:a6b:b497:: with SMTP id d145mr3299477iof.17.1561625649261;
 Thu, 27 Jun 2019 01:54:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190620095523.10003-1-pclouds@gmail.com> <xmqq8stoce5w.fsf@gitster-ct.c.googlers.com>
 <CACsJy8Di1720RhDxgieVNTfpNONJhi5ZniKje=wj4pZDy-0EwQ@mail.gmail.com>
In-Reply-To: <CACsJy8Di1720RhDxgieVNTfpNONJhi5ZniKje=wj4pZDy-0EwQ@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 27 Jun 2019 15:53:43 +0700
Message-ID: <CACsJy8CeChO6wJkr_Pp8aH1a6rJwUCDYtK89SLwLw_9KOgQHeA@mail.gmail.com>
Subject: Re: [PATCH 0/4] Some more on top of nd/switch-and-restore
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 27, 2019 at 9:53 AM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Thu, Jun 27, 2019 at 2:58 AM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
> >
> > > This is small refinements (except 4/4).
> >
> > What's the status of these?
>
> Small test fixup needed. I should be able to do it later today.

Actually since the patch that needs updates is 4/4, which is not part
of nd/switch-and-store-more, I think the status is "ready". You
probably could safely make them part nd/switch-and-restore.
--=20
Duy
