Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF5C12023D
	for <e@80x24.org>; Mon, 22 May 2017 16:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935107AbdEVQnC (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 12:43:02 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:34726 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934376AbdEVQm7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 12:42:59 -0400
Received: by mail-pf0-f179.google.com with SMTP id 9so87495955pfj.1
        for <git@vger.kernel.org>; Mon, 22 May 2017 09:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wUzM2DW8Qum7FWOhmHH2qTXqdfA75T3bCB8VOGpYtlg=;
        b=gIHSHuZTP+M0qQn7mLZ3ZgMHng67LphyPewOkOv5V0WOsO9vYqUprpO4gl3U9xzNWI
         sY/ceyz3B8KofaERdKOKaDFPVNPR36ynkeNMJt2TK7gDsZN5kGC3xUuGmA+QHo+0ca7I
         Kg02RhcIYwbaGjFltpfGdW3YV+hWhGdxIiETlXybNg6fFg6nRW/z69vfYqjQ/pVNm0hC
         x7GuuAt8G9O5MDnWftwxnv+kQF2rL+jkYcOUChDoMIQkAH79ClWB98K8xBdVB64n6JDK
         xAgztMbQ0dY3rS5NWEX+dmhKfH2q/T0QGQUb9H8iaZoQpMnw9bHypP+gLxm8d6HwUQEs
         07Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wUzM2DW8Qum7FWOhmHH2qTXqdfA75T3bCB8VOGpYtlg=;
        b=JS6vLIijNzQWRfkt77OrvFka5aPPlDMTIp1bar+WrDmEFqqk9FxkStmjA5O9nzSZpK
         EC/E0uSL86r+Gx3Z4cfneyT5XKgdPRPMqak1T5/R9pvCIT4ZONQf/eSzkU3ZiFfLRrKk
         /XXKOWjV5ShwnSOcJZwpeCKDCFYevlKqkUfXQFV3G80ifHJxVkBynNwJnIqSP71o1YWC
         fGGlK7rLrhObeUDg566FxyVO4oY2+gdLEkYrY4OzGo/dPx7NE0hx8Id9+ouHYbN6g0dN
         CtPGHKaUxCbDqojGCixVgM3SS2vLByxemcPawkMFIzg5LxzOrGP3BzggbTpX9IXPxbEY
         JeEA==
X-Gm-Message-State: AODbwcBrgYGQWajg7HT9hguIUflPnCgoiMWvZtj4aTMg7a/0z0Dacodg
        wT19Zbuj/rX/7ZpxRAtKyzRzwdtMvUKko/Y=
X-Received: by 10.98.236.150 with SMTP id e22mr26358147pfm.48.1495471378212;
 Mon, 22 May 2017 09:42:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Mon, 22 May 2017 09:42:57 -0700 (PDT)
In-Reply-To: <578bfb5b-bdd1-a418-98f2-d26e1bff0be2@ramsayjones.plus.com>
References: <578bfb5b-bdd1-a418-98f2-d26e1bff0be2@ramsayjones.plus.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 22 May 2017 09:42:57 -0700
Message-ID: <CAGZ79kZsiMT3-KuPBz4WKJ7VHypGM49kwGNALVTL771iEb3w6A@mail.gmail.com>
Subject: Re: [PATCH] diff: mark some file local symbols as static
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 20, 2017 at 4:37 PM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>
> Hi Stefan,
>
> If you need to re-roll your 'sb/diff-color-move' branch, could you
> please squash this into to the relevant patches. (Each hunk would
> be squashed into a separate commit, thus:
>   - commit 9b68d54c11, "diff: buffer all output if asked to"
>   - commit 4b71ba47ab, "submodule.c: convert show_submodule_summary to use emit_line_fmt"
>   - commit 703d25581d, "diff.c: convert show_stats to use emit_line_*"
> ).
>
> Thanks!

Will do, thanks!
Stefan
