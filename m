Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 821C51F954
	for <e@80x24.org>; Sat, 18 Aug 2018 16:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbeHRTNz (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Aug 2018 15:13:55 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:44035 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbeHRTNz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Aug 2018 15:13:55 -0400
Received: by mail-io0-f194.google.com with SMTP id q19-v6so9297005ioh.11
        for <git@vger.kernel.org>; Sat, 18 Aug 2018 09:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ujNeKxs037aX2Zi9j3jbO5Zu1Yo7EZowq/BEG6DlKfE=;
        b=q6LCjL5iQFen5RBbMLVc29cq59GqwV43shg0SxNfOdkEAOtq9VoV4LWvPO0m9kPTGX
         GwJFGe6NJS7dF5Kf3OBRs/cmpNIuBaCn2lI6yA2XbTyj/pQ+k4UfoagLYpn0ivQgFEbf
         1QYmZHLO5Uh589JJcLv6hOoe+EjiiU69hpxjAvyPVD6kX1kAwIWyMzyd3sC/c5TS4C5G
         3vZqYU9XxXbhVHIrFN1t+qaRslDspCoBWStzo3qDfrKTc+YPG+D8wAJ3y7rL4e4F09Hz
         kaIB6jAwaMwsT3Z8nVMJ0KauSMeg54zTOEyfFWykRJcsGRxYWlgfAvBD6Ui7Lyo7ttCn
         NvQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ujNeKxs037aX2Zi9j3jbO5Zu1Yo7EZowq/BEG6DlKfE=;
        b=bVR2Hcrnyl42uNFXzAfJgSF/4gcbpLCb+iq4pToHjOCpguKZ0377Eon+KGgwcJADj2
         A0xZrQf8nw9BCN2N9DwDr1gtQZDQ/Stj+whqF2gZoINnehRO2xgtY4m1IrcVMtTQrLyX
         JCkqJR6GlpDbcfXKqaeJkHpbCikl4Hax56F5eTa0kJ1dlbp2FScfpPIlwucz3akaPLDK
         s0+SezUgQlxJs9nTRQp65BidCEWK9RSi42/XFHafM8jdv5GW0A66lWaCZ3NRiuerLmKl
         Ho1yWsjpjxy4I3HIXV5jZG9FAHwyPeVtaPti+q6m+T76rNjKHvOKT8TYcbSgh2fCW3ha
         Uqgw==
X-Gm-Message-State: AOUpUlEgjCvSA2rrOxCdrp9JNbd1mlpc9JRBzsA6KhzdGqJ+RvxYeN6x
        3mKFTrjDR5aI8MyvdZlAuCfCr0YGoh9aRaKLVH4=
X-Google-Smtp-Source: AA+uWPyuQcLcRgZz2fN01m1UdPLmuwhg5GTTRTN5QfV81RxOmPMMDqKP4FLq8FD+Wwz5OrNO5+75IroAsrQTgMBt1CA=
X-Received: by 2002:a6b:8f4b:: with SMTP id r72-v6mr32963345iod.118.1534608343299;
 Sat, 18 Aug 2018 09:05:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1533672584.git.jonathantanmy@google.com>
 <cover.1533767314.git.jonathantanmy@google.com> <3dab08e467c23f2c0785e34c3a8703d809b6479a.1533767314.git.jonathantanmy@google.com>
In-Reply-To: <3dab08e467c23f2c0785e34c3a8703d809b6479a.1533767314.git.jonathantanmy@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 18 Aug 2018 18:05:17 +0200
Message-ID: <CACsJy8D63N3UPspm9-+ns0mv0OhEKDtxC25oZHR-d6SB6Hf2Lg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] repack: repack promisor objects if -a or -A is set
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 9, 2018 at 12:35 AM Jonathan Tan <jonathantanmy@google.com> wrote:
> @@ -179,6 +179,76 @@ static void prepare_pack_objects(struct child_process *cmd,
>         cmd->out = -1;
>  }
>
> +/*
> + * Write oid to the given struct child_process's stdin, starting it first if
> + * necessary.
> + */
> +static int write_oid(const struct object_id *oid, struct packed_git *pack,
> +                    uint32_t pos, void *data)
> +{
> +       struct child_process *cmd = data;
> +
> +       if (cmd->in == -1) {
> +               if (start_command(cmd))
> +                       die("Could not start pack-objects to repack promisor objects");

_() ? (also other messages)
-- 
Duy
