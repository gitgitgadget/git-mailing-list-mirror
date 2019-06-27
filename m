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
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D3E51F461
	for <e@80x24.org>; Thu, 27 Jun 2019 02:54:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfF0CyA (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jun 2019 22:54:00 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:41799 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbfF0CyA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jun 2019 22:54:00 -0400
Received: by mail-io1-f65.google.com with SMTP id w25so1386106ioc.8
        for <git@vger.kernel.org>; Wed, 26 Jun 2019 19:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rDBAWtYaLJMpaM4G4J4V0jlmB8XIr9NqEx6tFsvKkgI=;
        b=rkC2t/EkDdKVH/3znjEu4fhNXZ8Y28Go6O8ILQHkdaNrGgvrp8T9qKfeMC/eYPaHhy
         BMz9IYFbIrjLmrgO9uNMu+S3FLD9s1f6RSPqELN6VBUbMGv+jUW7cdc3WWVLcTH8mT1P
         qt3IBXnl5t1Q51+54wYdYas4k+Ow9M+NrlTycujYjF9veHUgaB+F8pPo0E8BN/drG00q
         UuyTp9+Amk9byBUId7kubu5xckwvvOw+/30Te5L4IxhKxpEmCH7JvrsryHkJEi6XNw4h
         KpKHdGKeJPfh+IkDg1FpJOf9W3eDqD88FQCwrCIKWbwZV3Iw26pPKhZsLHEDED9lHlhy
         BdwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rDBAWtYaLJMpaM4G4J4V0jlmB8XIr9NqEx6tFsvKkgI=;
        b=PWhLwH3s1oBHYznEi90MObEENTvmx3k12SW2sC3FOOhq7Vuydk/qrJvyayxRCv4MQm
         Zlo7ucmQmVrP8cYapdBCY8faNOtOe0S+XSZSh2Wg8bOsz1GlGQEtlLAaiSYv6p0KgPnp
         FMH/hoYsDtv2FtTq5FSmUNQpSf+mzL1ojTdqRQyRIyFE7oYIZau0nYglTK9cdsxvb8eR
         ctxnTn5FYnqR9SUcUkmYvP/Mij7ab+NwMkrCypFRKe1/SJkUN1Gay30AiY5RKlyVjRI9
         +RcQllWiMlCw9Em4/zIjbvLzH6nl3e4Qum+WhAG3bY7x0bzeAMkUG69j8DPTaWxipqMG
         EC0A==
X-Gm-Message-State: APjAAAVj3niJfMzRgrydaNizAESlKig8T3FyLe+DaKmavCctc3Dmx4ID
        e9GH6HAwsPMGxovpQsCy7Gm41MxTdBIpOPSan14=
X-Google-Smtp-Source: APXvYqyIiYOME9+sFYDe2UT8TKwXE7UlQyGkYThuFyuQecL0C4uOX2A3FTbdZpq+B/UYLE7Z5u3kwDlXOWICOC8ZokU=
X-Received: by 2002:a6b:7f0b:: with SMTP id l11mr1798335ioq.282.1561604039289;
 Wed, 26 Jun 2019 19:53:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190620095523.10003-1-pclouds@gmail.com> <xmqq8stoce5w.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq8stoce5w.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 27 Jun 2019 09:53:33 +0700
Message-ID: <CACsJy8Di1720RhDxgieVNTfpNONJhi5ZniKje=wj4pZDy-0EwQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] Some more on top of nd/switch-and-restore
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 27, 2019 at 2:58 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>
> > This is small refinements (except 4/4).
>
> What's the status of these?

Small test fixup needed. I should be able to do it later today.

> As another low-prio topic interferes
> with the code touched by nd/switch-and-restore and hence needs to
> wait for these to stabilize, I'd rather see us focus on finishing
> these before switching our attention to other things.
>
> Thanks.
--=20
Duy
