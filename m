Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33C0E20A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 17:06:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbeLJRGx (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 12:06:53 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:37351 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbeLJRGx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 12:06:53 -0500
Received: by mail-it1-f193.google.com with SMTP id b5so19327717iti.2
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 09:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qm2Xy6zR40rSxqsF+7xvafJ5+U/lES+4LTXseRBkEHs=;
        b=r4DZRXSWEDFfGGAzR0icOSjHOhst7YXrCSpaxd8MJREHyb1IA1a0V9FK6VtNp7ba1q
         +khxKbmjQaXXQpwyCmZM8KsiEGjO3zTHjVnV9A7AGFlBYXqvwBVg20XplxeSYTc312p0
         iYYgZbQDiIBNKwtl1nM1zDILJO9yebKfmbW4oXp8nIpV7VtSgJT/r6aTvvi6xqSGWpbS
         t9/QCjXwub1rTioMP/uOV61ZKPt6kqKKmWYLhNbDDuikBWs9Gxsr5MrKrZc5oxVcZDfJ
         F3Gv+A554kv+bO3QAS3bOJ0nRfL5Eui5ldtLsI2pTR5Sn4+sjSLIk6bnUTNaTUlMVIYs
         WDfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qm2Xy6zR40rSxqsF+7xvafJ5+U/lES+4LTXseRBkEHs=;
        b=htyxA1mGBWJyeL97EbooTbU5h/ir9Eo9AMShVIFq50A/K3YKepSZdIzh796ZvXJBY4
         bPB/OeTOPdQtAlHxkQJBITKRA7UBs1hy7IZEUhcGPsb3rfN7R3dXoFY2tx09bxwfRvpx
         fJujovLZ8vvO0XMaNAW1FAESiRe8q8TKYZ7+yAMYxHwPjBBvqYKw9SlhoBTUZUrQcRFM
         1QLRm2F32rjVoJJ1z5Wm0YQ2JCD7Ka0M3ty0Lz4K4v2Vw+15UMCuOEgot3vzVpxXb3UV
         F0k2/53Wfzzrv68qVAGlPAiMsLPOxa9JdGXlGGx3h1mSUEUO0lF0f60Jn6hgzgStRyao
         1YSA==
X-Gm-Message-State: AA+aEWa/GsOcq2kl69VZpCCkzP8JDDgf0hnoqk/SsAssQgJuJ4EdCE8N
        mu3so8MKrQD2ZH2sLV6g1RuPF6Hs1CVAnRXZ0/rB4g==
X-Google-Smtp-Source: AFSGD/UqrhhmaLx+HmtaKOXYn/CCz8hX2sVM6O3a2hwsejk+3EGhHQ0fxv+r7sQclY3Zp4xPMGesyASVJMy8za+ATAc=
X-Received: by 2002:a02:183:: with SMTP id 3mr12470043jak.130.1544461611337;
 Mon, 10 Dec 2018 09:06:51 -0800 (PST)
MIME-Version: 1.0
References: <20181209200449.16342-1-t.gummerer@gmail.com>
In-Reply-To: <20181209200449.16342-1-t.gummerer@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 10 Dec 2018 18:06:24 +0100
Message-ID: <CACsJy8CbtK+OuhSy0490e=OjALsk8QQgDHo6q1xjTrz2R56vNA@mail.gmail.com>
Subject: Re: [PATCH 0/8] introduce no-overlay and cached mode in git checkout
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 9, 2018 at 9:04 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
> My hope is also that the no-overlay mode could become the new default
> in the restore-files command Duy is currently working on.

I already wrote something like that in git-restore-files.txt even
though the implementation is not there :D

There will be a hell of conflicts when the two series enter 'pu' (or
even worse, when the third one to update worktree only appears) so I'm
going to send the switch-branch/restore-files series out but mostly to
gather comments and will rebase once the other series land.

(Alternatively I'll split my series and let the switch-branch part
land first, may be simpler)
-- 
Duy
