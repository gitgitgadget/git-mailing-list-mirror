Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 462671F516
	for <e@80x24.org>; Thu, 28 Jun 2018 13:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934626AbeF1NEP (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 09:04:15 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:37527 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933090AbeF1NEO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 09:04:14 -0400
Received: by mail-it0-f67.google.com with SMTP id p17-v6so7461745itc.2
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 06:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=t0dSyihvFTHVybHAahxCZdzRGWyIBqPEUNhRpuCZ9Xs=;
        b=oBIYjykANP+9B+BPr+MRC0exdSVRSHRNrXQU/QrnCFE7cA3lfzqd1KZpqIgfyY2xUy
         TuvJAq5+s+5vJpDm/a0ttxgUpyngkEgwnxWaXM9QO3rdsDT/E38n0gZBHAhfy8spCxMx
         3gpgc18DNc/V2sz1YFkWaS/YwdWJGgfABUJ8YR+MdlNDLuubEeuWUBcSM+/jrIGnv4uO
         GwMl9xwALHn3zJAuVde96js3duqy+Q80ETCFxkEZeQRI9TVxFQ9KiJvkvD0TWYb6mUKy
         7oXQyttw/BJf9GwPRjmWrQ0RvAcoyhxHcb3AS3mFWaFa6RBoUmoqFKhBVz1ZsjKG0TXz
         K2HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=t0dSyihvFTHVybHAahxCZdzRGWyIBqPEUNhRpuCZ9Xs=;
        b=iAwu2U/DznAWv3s/XhJL4WkpjTkLMIh8hebdqtrU/jwU8XDo0Q/+vJhAG8g0AcIlCF
         G8URh74+a9fw/obNueGPXulg0xIL7KXAgycVijLbENP5xQQqmIomdXea3qxvxXwbbJz+
         t4uvonQOuTBmDGjacCp9zU6rwlXRvommtONDrk0GmRuh6MyAYRVSKxSXLZUxI65EQg/Y
         YkX1lzB/4yD01hNm0taltgYnljVBBbUUPIQ9FcwoXCTXNhrhVDkXpgavl4zXcJ9ar1hT
         AkSloo1zWtVzNAmDOEyXAHZgMYVy/bw5h0YARq+Nv83QfOaJWJQUJyCx3Jlb9BMJzCz4
         MIIw==
X-Gm-Message-State: APt69E2sxg925Ijk96xfXFIpnKEKDkO7FpdUDvlkqZVJ/w35g4YlIKhM
        pKCEkqYo/qHpUgaWJdCTP9hgmlBNPJxEOgUtlhI=
X-Google-Smtp-Source: AAOMgpdu10IE/Gp0vb/MA44t+/I6/uJ8H/KXvgpxbizWZQCjM1rrMuMGvdONsbCQ0NF5uLmRiwhwUrmo7YR5+YqKe3Y=
X-Received: by 2002:a24:6bd7:: with SMTP id v206-v6mr7900111itc.129.1530191053613;
 Thu, 28 Jun 2018 06:04:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:2293:0:0:0:0:0 with HTTP; Thu, 28 Jun 2018 06:04:13
 -0700 (PDT)
In-Reply-To: <xmqqsh5amt8n.fsf@gitster-ct.c.googlers.com>
References: <20180623121846.19750-1-chriscool@tuxfamily.org> <xmqqsh5amt8n.fsf@gitster-ct.c.googlers.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 28 Jun 2018 15:04:13 +0200
Message-ID: <CAP8UFD3-abjhC41zYGz5z8Qs_xChwpg4xRcMisTVP8N2ri0hNA@mail.gmail.com>
Subject: Re: [PATCH v1 0/9] Introducing remote ODBs
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 25, 2018 at 11:49 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Just an early warning, as I haven't even complained on patch titles
> of these patches in the series ;-)
>
> 5702.20 and 5702.21 seems to fail in standalone test, when these are
> directly queued on top of Git v2.18.0; I haven't looked into the
> failure myself (yet).

Yeah sorry about that.

These tests can be fixed with only
s/extensions.partialClone/odb.magic.promisorRemote/ though.
