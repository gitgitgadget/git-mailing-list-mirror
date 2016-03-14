From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH/RFC/GSoC 00/17] A barebones git-rebase in C
Date: Mon, 14 Mar 2016 19:15:45 +0700
Message-ID: <CACsJy8BmiqFJ1tN6-uAWqXMUyvGRdWP2DVfgwE56Y1K9KHCsfQ@mail.gmail.com>
References: <1457779597-6918-1-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>, sam.halliday@gmail.com
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 14 13:17:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afRRD-00030w-BK
	for gcvg-git-2@plane.gmane.org; Mon, 14 Mar 2016 13:17:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934275AbcCNMQ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2016 08:16:28 -0400
Received: from mail-lb0-f178.google.com ([209.85.217.178]:36382 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934235AbcCNMQQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2016 08:16:16 -0400
Received: by mail-lb0-f178.google.com with SMTP id x1so235996548lbj.3
        for <git@vger.kernel.org>; Mon, 14 Mar 2016 05:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3RKrdzDqGemP6FF0oxLFqJqMN46mddkKs9mDjvM2utI=;
        b=j2HMsiRV9zs+hLuuwe5MB7FJ+EXD5/6Aa3/MQE/lTx58YYoMiWmAcT6vOZzYKtxaFl
         8hQy2Wfk4k/I8n1WXfdPp2ZXuQM1Eix1YRa5V1YMaUo/wQ6/nBgVNf+M+n66o9U6+0Q4
         Wt5tt1VassMshW4WH4u+McdB5T5d+YnOVh7PIuREA+RLi1NVD9brrIDLWLVBGAj98fHC
         DiH2zV0u+FjovV7YWRWUu773ncZR+LhslgkMvWL6EHZYNGcgLxETNjj12NPYolk9JdvC
         X156ftvvdmy+TMcSPCoxCr/ClK3SanWWnfgEVKjKTsJa3UH/fQGQ7bRLZaYbmVSBVLUG
         Xrmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3RKrdzDqGemP6FF0oxLFqJqMN46mddkKs9mDjvM2utI=;
        b=gy7gaPganGsJoo2Ash9Bg/agiYKt+l8nTlO7PwiW12nSnzzwuEfejaAbzCgGy1KDLx
         YdviIeBxNRAv6dTy6J/5aU4VSzFU6FOIyRcfYteNaUzNAVB+IVpPuJiaigv1bssiXnMW
         kbd5RVit5941wB5nDjp+eL/Ve68XNhHbOHcUBfaXYSoArUUKFUvlnFIBcQvrqcggYi0s
         AuAJgUy6cMZjkNbAwp5pdKyGKqVYrdDNRWIEk/fF0zhC8+3N17NAzh6flI3SPm9wm/4X
         joAbrTiN/hOaSwETAg8U0gSVhR39lwtOmhX38H+PXZX5WIygDSV80ap+icu2GaATjK6J
         CsGQ==
X-Gm-Message-State: AD7BkJJyYE1ZBarqYBL34Owby4qFWxLixGsAXEOxdKjp/pioDwK7VwNJxkuii3F2NQgilzuxRnN9uT1fSIK08w==
X-Received: by 10.25.160.79 with SMTP id j76mr7842831lfe.83.1457957775037;
 Mon, 14 Mar 2016 05:16:15 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Mon, 14 Mar 2016 05:15:45 -0700 (PDT)
In-Reply-To: <1457779597-6918-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288776>

On Sat, Mar 12, 2016 at 5:46 PM, Paul Tan <pyokagan@gmail.com> wrote:
> So, we have around a 1.4x-1.8x speedup for Linux users, and a 1.7x-13x speedup
> for Windows users. The annoying long delay before the interactive editor is
> launched on Windows is gotten rid of, which I'm very happy about :-)

Nice numbers :-) Sorry I can't look at your patches yet. Just a very
minor comment from diffstat..

>  rebase-am.c                        | 110 +++++++++++
>  rebase-am.h                        |  22 +++
>  rebase-common.c                    | 220 ++++++++++++++++++++++
>  rebase-common.h                    |  48 +++++
>  rebase-interactive.c               | 375 +++++++++++++++++++++++++++++++++++++
>  rebase-interactive.h               |  33 ++++
>  rebase-merge.c                     | 256 +++++++++++++++++++++++++
>  rebase-merge.h                     |  28 +++
>  rebase-todo.c                      | 251 +++++++++++++++++++++++++
>  rebase-todo.h                      |  55 ++++++

topdir is already very crowded. Maybe you could move all these files
to "rebase" subdir.
-- 
Duy
