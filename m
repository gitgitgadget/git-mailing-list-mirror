Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B27620A04
	for <e@80x24.org>; Sun, 16 Apr 2017 11:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755246AbdDPL0T (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Apr 2017 07:26:19 -0400
Received: from mail-oi0-f51.google.com ([209.85.218.51]:33256 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754941AbdDPL0S (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Apr 2017 07:26:18 -0400
Received: by mail-oi0-f51.google.com with SMTP id b187so122226485oif.0
        for <git@vger.kernel.org>; Sun, 16 Apr 2017 04:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LMc5DJo8M7mAcvhGGrA64YRQABi/9XGHaMHVUvPBsgc=;
        b=cmtWfctZ24ho0IqJkEfFSjQuTNveJ9MNNS4aZcl4RUs8Ll3eByAd3wjG/4BcMFqCBm
         sIRwhdJwtKzapY07NCUbRa2zurCET8IncBkgVB4DSCqINP2UNPGJHy25yPVs9o7hfh53
         jkhKY6mEPBZskDu7V8L2qKp5COW5BogZI97jS0tV1VJz3kSJ0EcxUqvDS94xr+GNNvGa
         i959Ij0Ohk83y36Zj+enB7MmxKzKlONQdLW09f8CjcTE9Mhbaiv9PHdxHcjtIF3gpR+R
         nqMNXBIEjnGdAFtoWsR2HFUSU/fDM6o0ZuUCLOoY9w4/9aozCWfY+BVpFtyybrLdE0L6
         UAeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LMc5DJo8M7mAcvhGGrA64YRQABi/9XGHaMHVUvPBsgc=;
        b=Lu92msEX3pexCic7hIYEtcFUpRPwT2za7MwgnxK/NNzLm7vw6yT+51QPQM2onpl/jO
         S+pvt/iJRLt03DX9fcZV73H720DJG+7I6uo2c8NAUpAqbVcpVcLpktTspwA/Z1AF1v5b
         CX3PuOIDV3Du8gi1dmtRC0RrPb7ecuS2z0f66TLTHBUILSJRlpyZAoJ5OrB6B39O8GjS
         HQF9oveY2YN3sLB0sshyx2QA80C98iQltX3Xre6dJt15wFmrsFKNru610GhCBv67M4cx
         g0k+dFCYBLwj3gP18CFwA5e8VSjC9g4+HrXYU5LNmoJ+6PbP/amU02+LdFryTiHE74t4
         x65Q==
X-Gm-Message-State: AN3rC/6UE10hlpjwNgnFbHRBTLbcfbvH4Por8671EHXQZhDLkiflEyv8
        iCZ8aNREHhUS40i8cUbpA+0cbQSdhg==
X-Received: by 10.157.61.163 with SMTP id l32mr3070341otc.28.1492341978127;
 Sun, 16 Apr 2017 04:26:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.70 with HTTP; Sun, 16 Apr 2017 04:25:47 -0700 (PDT)
In-Reply-To: <CAO-Op+GujOUuueqwOKbb1NosZ-VYY5KVWm1+HNMC8xhd0ApEDw@mail.gmail.com>
References: <CAO-Op+GujOUuueqwOKbb1NosZ-VYY5KVWm1+HNMC8xhd0ApEDw@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 16 Apr 2017 18:25:47 +0700
Message-ID: <CACsJy8DQWrLZF3wUQ5WF2FfriM6ko8Zwm_x5ErEEWTE6n5rayw@mail.gmail.com>
Subject: Re: [BUG] ls-files '**' globstar matches one or more directories
 instead of zero or more directories
To:     Alistair Buxton <a.j.buxton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 15, 2017 at 2:17 AM, Alistair Buxton <a.j.buxton@gmail.com> wrote:
> To reproduce, go to any git repository and run:
>
>     diff <(git ls-files '**/*' | sort) <(git ls-files | sort)

Actually the '**/' magic only kicks in if you write

git ls-files ':(glob)**/*'

Without that '**' is a normal '*' and matching just subdirs is expected.
-- 
Duy
