Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC7141F404
	for <e@80x24.org>; Sat, 23 Dec 2017 14:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750842AbdLWORw (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Dec 2017 09:17:52 -0500
Received: from mail-io0-f174.google.com ([209.85.223.174]:40983 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750802AbdLWORv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Dec 2017 09:17:51 -0500
Received: by mail-io0-f174.google.com with SMTP id o2so27212678ioe.8
        for <git@vger.kernel.org>; Sat, 23 Dec 2017 06:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=dnUenSTa03PMpGQvNj8ANrqqtyIT3W8+wDPwwFNk3Mg=;
        b=XWWA6qqjxi+v9bTmUhn3BjAGvhIGQsnM7f1YMvtx9LLiw3GS2nS1Nm6zNcKOyFaWGp
         eZv8ROYjZ+1Fc8coHwr8B60NUSdZCmvmWCdMnQjOi6WeNrxLi7VXb6ZYtclZlSppjd3s
         crQt61gWz2q0hpoiaZaPcpplsEwH9zeZNbVGat/CIgOn8JLoJfLM0GsUflF2oo0gYXGp
         widuj7A6j2ObSsFS2J3ASpbIDslKE0vOgp4vzxrQzVHyLv064ADiS599/U2mVLp9LW+Q
         74muu1TmfmMER3crLl/HQvavs4E51iTTERW5el9MCfpE3J4lRPtrN8JrV9YHCXqkep86
         7erQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=dnUenSTa03PMpGQvNj8ANrqqtyIT3W8+wDPwwFNk3Mg=;
        b=ai3kzcENA+VgrIeKsYo6ycMuhi0109oScuFZ/Kua4Q78bl2km09lVFQUleZiBrmc9w
         S7lRzNUWENORwINEw3AyH8k4ssxxO2Afc//GOVQhm9rHnDZP7ItBNZZ1I9p4tvfhjBQ8
         9xLWQTFFj/9/KGsi5rrkPzBCsjickR3Szefs6ZpnXXbVUX6RVMXsWohOtcZBJ8r/LiCj
         S8a3ucu5yLHV5BT7qKhbICW8YNCtrZddbxY2hjy80j/Tn7KFs8Pyz9YY1LX7qdeJL6HC
         MSzjr91sGrIDXXYbB6E7lig79ucaWHv/LiPW5cIs/Zc/rHUaw+TS3dHZUNYcZ47xvrJc
         vaOw==
X-Gm-Message-State: AKGB3mK00+wYzf4c51iTuqah0sGim+Jsp8SoAQ0Xrgeq8d/3L3TUBWSN
        7q9s8YMfaRlDGPIQFK8g3efXbLnxDkRks7dYq70=
X-Google-Smtp-Source: ACJfBouP/S9wmStLw1cWdedn9m7RWoqj+NFmhUwNdkT3oz7oetyVH2VZ38toXZTpquhk24jcoJ4HTvcLZlwQQ9GoicU=
X-Received: by 10.107.201.2 with SMTP id z2mr9590940iof.287.1514038671213;
 Sat, 23 Dec 2017 06:17:51 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.109.73 with HTTP; Sat, 23 Dec 2017 06:17:30 -0800 (PST)
From:   Daniel Knittl-Frank <knittl89@googlemail.com>
Date:   Sat, 23 Dec 2017 15:17:30 +0100
Message-ID: <CACx-yZ3VAaPQ4dU40_JFm_=WGH5ZX-28bXKqGqVnj39-6_9duw@mail.gmail.com>
Subject: [RFC] Prepend "tags/" when describing tags with embedded name
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 15, 2017 at 8:25 PM, Junio C Hamano <gitster@pobox.com> wrote:
> I think the code makes sense, but it won't be understandable by
> those who do not know what you discussed in the original thread.
>
> A proper commit log message, with a new test or two in t6120, would
> be an appropriate way to fix that.
>
> Care to follow through, along the lines in
> Documentation/SubmittingPatches?

The updated branch including tests can be found at:
http://repo.or.cz/git/dkf.git/shortlog/refs/heads/bugfix/describe-all

One existing test in t6210 needed updating to match the new behavior,
three new tests have been added: annotated tags, lightweight tags, and
branches.

Daniel

-- 
typed with http://neo-layout.org
