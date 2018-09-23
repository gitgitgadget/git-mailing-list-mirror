Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBA541F453
	for <e@80x24.org>; Sun, 23 Sep 2018 13:10:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbeIWTIO (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Sep 2018 15:08:14 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35351 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbeIWTIO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Sep 2018 15:08:14 -0400
Received: by mail-io1-f68.google.com with SMTP id w11-v6so15727024iob.2
        for <git@vger.kernel.org>; Sun, 23 Sep 2018 06:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=W224jIiSeqEvuDOj1f/T4VM9FWyV0lTSLFVKzq/QhW0=;
        b=emhrFxNlGWZDoUIcZFXlCtyqhTNR/cTAzZ2e1qPOhW1NklskXiQM3Mj0sSPyAlfJXw
         O2arX+N2UTSEHXXWOSSyyid16Caf1S6/HH9oHvSOvmgaIa9U6nH7QTRL+eDqdx5rCsI0
         W3zu46tndTfAN0greGYL5TgBGJb9DnABrip9Bst7zkuk5Ncy5PePpa8JLZnjci/RP2sT
         WWRdLYsbnYsfK/b4J47Q5DzUE3/+V0UQKi7ybBgKNwVhKw+ROabkvuPTzehr27CUlnp/
         HByFAMWIY8XNODT27/zaCo/jfeLhPBoeOtzbv64vDyVCth7r3vQuCSNyJeuCrPCzSCc7
         TrlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=W224jIiSeqEvuDOj1f/T4VM9FWyV0lTSLFVKzq/QhW0=;
        b=dXqfJvMd9r+hAeFYBquiETSd8+jyqc/prj6IZrNRwiZpPEa2fDwjMkB/leg9xZzOk/
         Ux7AZ/pHUYbr0dxFsMUFelmDdmJlcxyS0225ciUbMZGqm83ik0v8O8KJVGheDNe2mqMp
         d3yJjyvClXaoIN/VbgVrVusMJHLfT/ZY9uXO13IsMRujWqE+3vCamMT4EZHtP7L7/FTp
         Z9P++RLD9Kb/3u36aqntIfOZmtO9IjmsvH20FRmgvDPQpVa0lUQNJGwkxri9g9DVp0+U
         ErIP9Qv0Sax2sfrfyTbu1wMMdyzQN0lMVF/x4BwhoU/wIGBL9POhMGhZakQkn9xxMXBW
         7QDA==
X-Gm-Message-State: ABuFfohQ2JSLPuEzfBY8qFYHpbn2PRjLElVffg87nDuj7pzokVRtStIY
        SqHTjCu8wQUbA68lFdB+baRWuaykM0OnrgRYQhfHdQ==
X-Google-Smtp-Source: ACcGV62rWsAS2x1R13bpwp3d0LnIUI7/A4kzLUkrn0sIKebkP384BvXf7qNxivYQq1VtQDrKkFeOjtX8xO3w/bhMyY4=
X-Received: by 2002:a5e:d803:: with SMTP id l3-v6mr4300766iok.236.1537708247967;
 Sun, 23 Sep 2018 06:10:47 -0700 (PDT)
MIME-Version: 1.0
References: <20180922180500.4689-1-pclouds@gmail.com> <20180922180500.4689-4-pclouds@gmail.com>
 <CAPig+cTtjwCMRMx2xS1WPyM30ipxx5QJK_Aueu50i-jLQdpdBA@mail.gmail.com>
In-Reply-To: <CAPig+cTtjwCMRMx2xS1WPyM30ipxx5QJK_Aueu50i-jLQdpdBA@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 23 Sep 2018 15:10:21 +0200
Message-ID: <CACsJy8BM=JH+z2yaMjqJpfXvSxjkagVNJAs7SPsiFJYw-eCYDg@mail.gmail.com>
Subject: Re: [PATCH 3/8] refs: new ref types to make per-worktree refs visible
 to all worktrees
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 23, 2018 at 10:06 AM Eric Sunshine <sunshine@sunshineco.com> wr=
ote:
>
> On Sat, Sep 22, 2018 at 2:05 PM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy=
 <pclouds@gmail.com> wrote:
> > [...]
> > The main worktree has to be treated specially because well.. it's
> > special from the beginning. So HEAD from the main worktree is
> > acccessible via the name "main/HEAD" (we can't use
> > "worktrees/main/HEAD" because "main" under "worktrees" is not
> > reserved).
>
> Bikeshedding: I wonder if this would be more intuitive if called
> simply "/HEAD" rather than "main/HEAD".

A ref name cannot start with '/'. I'm open to a different name than
"main" though, it just felt a better name than "main-worktree".
--=20
Duy
