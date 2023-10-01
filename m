Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19432E7849C
	for <git@archiver.kernel.org>; Sun,  1 Oct 2023 23:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234245AbjJAXwL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Oct 2023 19:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjJAXwK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2023 19:52:10 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68447C6
        for <git@vger.kernel.org>; Sun,  1 Oct 2023 16:52:08 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99357737980so2200655066b.2
        for <git@vger.kernel.org>; Sun, 01 Oct 2023 16:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696204324; x=1696809124; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aIy9rijFTFA3P8OS2RuJVxl5katO0evgWVReZ4tov8E=;
        b=AX2buGZ78YROXxYg3CnuirknCad3DL/rQYUd+O8s1/8XNsGxU+0jyTsWrMTtfaqKAt
         HopDVaZTrG+xKLqMEX8wpVIlbjaEJw7KcDL9ddv6K5X71nmuUpOq2vsgrfLeX3ZI+VgL
         k/CaGMdSVoa3dpNi9TR2kUkcVoUjTwhmB++WHGZkkWQI2k6NcqOzH1jFkYdLhWCRFPMC
         6ORWitW2TD0mhAKCPPLyRRFs2dt1yPbaf/YUJPwBmN9qr6iXxJkgBc4k8TIRBttJ2v+M
         m6DUfr9zT2in+dUjcJi1LMfnSH/VRq0WgePIevbCeOH2vdAlWpKKTaYBbUHdl6AAXL+I
         ltcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696204324; x=1696809124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aIy9rijFTFA3P8OS2RuJVxl5katO0evgWVReZ4tov8E=;
        b=B6YGZHPCz6la9thdp/YCY2xuNfOu8SDdl3qS/OQ94lF8eaKQYYC55x+0lz9jO3Xsau
         GNwexP6/FKhRPKXrakX1QqfyJvcq5HvczIddE6vc7mvDb/YqIn8w2xblWR4RY7I0EE2O
         8JtO40SKHYy6L93om3v0TFASi9gaPjoyaJbvh7adZRE2qHy3oQtYvrI2tGgn5WSEq3Ig
         WFJYEOTtaQVCMQsoNaLV4NUa03xWjhAb+SjAfVJhSzVTuILSGWipSopNW5TLmhrs+hsb
         oN7z7800O/Qx02d+/gbv5rlde+0Nfl3c5BbvU742L8Xc2ruIhvQHl0DSatgPOSeBiA6P
         xqzA==
X-Gm-Message-State: AOJu0YzeGe8DgY8nhHcFAPvltAImw39WHDtFFO0qtuXxGOGlazL9hRp+
        wKB+0Z2zDmj4FG1D57WwzM7CdFwsm8yDLxNnrUM=
X-Google-Smtp-Source: AGHT+IE0QLLkbaG7R44Wrlc58+7nkH0MP17fZ4JiSQmmXnG44Ft6MPdzd0ac7hXHN84WZkugEa/PAGhhqcmBtOOElc8=
X-Received: by 2002:a17:906:225c:b0:9a1:cfd5:1f3a with SMTP id
 28-20020a170906225c00b009a1cfd51f3amr10212331ejr.13.1696204324387; Sun, 01
 Oct 2023 16:52:04 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1591.git.1696193527923.gitgitgadget@gmail.com> <xmqq7co6f1le.fsf@gitster.g>
In-Reply-To: <xmqq7co6f1le.fsf@gitster.g>
From:   Javier Mora <cousteaulecommandant@gmail.com>
Date:   Mon, 2 Oct 2023 00:51:53 +0100
Message-ID: <CAH1-q0g+xdb_mUi0sXrQjF4nkX1Nkpops_V1e86qACLxs1uPqg@mail.gmail.com>
Subject: Re: [PATCH] git-status.txt: fix minor asciidoc format issue
To:     Junio C Hamano <gitster@pobox.com>
Cc:     cousteau via GitGitGadget <gitgitgadget@gmail.com>,
        Josh Soref <jsoref@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yeah, I saw that right after I submitted my patch :(
Only problem is that that patch doesn't use the same formatting as the
rest of the document (uses a code block / preformatted text instead of
a list as other options in the document do) so my version of the patch
is just a minor cosmetic improvement now.  (In any case, the result is
quite similar in the plain text manpage version; the change is more
noticeable in the HTML version though.)

If you're still interested in the "format as a list" issue and it
makes things easier to you, I can submit a merge of both commits
(fixing the merge conflict).

El dom, 1 oct 2023 a las 22:57, Junio C Hamano (<gitster@pobox.com>) escrib=
i=C3=B3:
>
> "cousteau via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Javier Mora <cousteaulecommandant@gmail.com>
> >
> > The paragraph below the list of short option combinations
> > isn't correctly formatted, making the result hard to read.
>
> In <pull.1590.git.1695392082207.gitgitgadget@gmail.com>, Josh fixed
> this issue a bit differently but in the same spirit, and the fix in
> 38a15f47 (Documentation/git-status: add missing line breaks,
> 2023-09-22) is about to hit the 'master' branch.
>
> Thanks.
>
> [Reference]
>
> * https://lore.kernel.org/git/pull.1590.git.1695392082207.gitgitgadget@gm=
ail.com/
>
