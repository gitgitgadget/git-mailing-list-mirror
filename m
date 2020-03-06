Return-Path: <SRS0=QY2u=4X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1481C10DCE
	for <git@archiver.kernel.org>; Fri,  6 Mar 2020 15:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 737E620409
	for <git@archiver.kernel.org>; Fri,  6 Mar 2020 15:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TnjKaOAO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgCFPAt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Mar 2020 10:00:49 -0500
Received: from mail-oi1-f172.google.com ([209.85.167.172]:41723 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbgCFPAt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Mar 2020 10:00:49 -0500
Received: by mail-oi1-f172.google.com with SMTP id i1so2783003oie.8
        for <git@vger.kernel.org>; Fri, 06 Mar 2020 07:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Qx3XhilsJmM1VgGrN5t8fPYVrZ6mFFzVSeZ0YDjLbHw=;
        b=TnjKaOAOi0irYFigk9VZevaMW5Z454UriMFWskGAWynOyg8Su88Iiz35O+YWJqqCg+
         OX/e8Igy5BYYm/JVJlRJNj7robake+1GMNIN4eEU4AswBUY1GwEWRoOSSTgiF5q4PeG/
         jwNOAmPBTj5StDHrX5VVdETDAw7jwSfuJ0gJi1ipQIdHUHVbe2jBwm4e2F1YUbb4x75z
         PZXEXscJ/RnODnzwbOv5rzpqCnJio/az1doYZ/d+TtTihWWhTBbWYj0vMJC+N1cFE2G8
         tzJyBHlwJ3e8S6l/PacROE4+TCCI7Gbusgb+1r6THuxL5BrRi9Geo+giQqcUNifXR/56
         BbsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Qx3XhilsJmM1VgGrN5t8fPYVrZ6mFFzVSeZ0YDjLbHw=;
        b=fhSRZVQYu9Su/4xb2ZLijjH4A1bLZX973vDzam/jltwX00awssxlqXTxXHmh8+mScH
         K3MQyce7uJocXQt4Kn1ELcbUSHAPhcRVk/fl2/qOg132BdYPqBJUwBq04ipKsEiY6AAB
         hIT0FSHZgBr8aNIZWsbpksuBoNyhZn6tNaKEfezlBmgD23scZg1G0AudxjuHBiU0bcU/
         qLZGnh1w0xZAmC3t26ofUiHyIVtHbFYMa6mBOMbgwBfcDnD5rV3qLpn7sG7T3k3Lc7f9
         9hkm5zQsaRjscUe55uGsBhCJA4WxxuwXfHv/W0ePV8G0gq3G+qsrXBCy4/gpTqWvoQNQ
         SCZw==
X-Gm-Message-State: ANhLgQ03DXCyEtbImhFi+yHxIn0932KGKBHQWJIZzP8/ZZ5GAv35j/v9
        n3i3a/yTrXATMif5Eyr5Ydlr56969LkvaSfI9WXEmckw
X-Google-Smtp-Source: ADFU+vtUD9Y+UrgKV2MD9kicYvHeVHyWcgfOLmUTvrBq3PeNwtVesGJapMELu4uBMMHgw1i/wqrB9fy+qByDsgf+0HQ=
X-Received: by 2002:aca:130c:: with SMTP id e12mr2781332oii.6.1583506847955;
 Fri, 06 Mar 2020 07:00:47 -0800 (PST)
MIME-Version: 1.0
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 6 Mar 2020 07:00:37 -0800
Message-ID: <CABPp-BHk0TyxEgudMX_-zzpFsUPHCmRkvZezN_49J2ivi2-N+w@mail.gmail.com>
Subject: Git Merge 2020 slides and reproducibility
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Had a few different folks ask me at Git Merge about slides for my
talk.  I said I'd post them on github somewhere, but in case you were
one of the folks and have a hard time finding it...they are up at
https://github.com/newren/presentations/blob/pdfs/merge-performance/merge-performance-slides.pdf
and steps to reproduce the speedups I got can be found at
https://github.com/newren/git/blob/git-merge-2020-demo/README.md
(though be forewarned that the code is has lots of fixmes & ifdefs &
other problems, has awful commit messages, etc.; I will be cleaning it
up soon).

I know the "suggested" way to make this stuff available was on
Twitter, but I don't really have any much of any social media presence
(I can't even access the blog I once had) and don't want to make a
twitter account just for this.  (If someone else wants to repost my
slides, feel free.)

Elijah
