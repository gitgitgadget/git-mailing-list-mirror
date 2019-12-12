Return-Path: <SRS0=AaZj=2C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D176C43603
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 14:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DD6421655
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 14:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t+08CmdY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729560AbfLLOCP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Dec 2019 09:02:15 -0500
Received: from mail-io1-f42.google.com ([209.85.166.42]:32813 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729524AbfLLOCP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Dec 2019 09:02:15 -0500
Received: by mail-io1-f42.google.com with SMTP id s25so2921461iob.0
        for <git@vger.kernel.org>; Thu, 12 Dec 2019 06:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=iPGuXgU5BaCYeUhMKAJONsHklK5o1aEYRjLpXVvOsjY=;
        b=t+08CmdYNBNkghFg1guvXAYgz0/yYxkm0MOI3MMl+x41aj1j4mGA5gZMmWrfX3OD6R
         E77thZvgqvUVtiyaSk6d8T4JpkQHqd0fV1ZgBI8iwPdP6071v31My26bkgttfHXy6gYH
         eFKsd6Bl4LwY0EkGHhtrCsYbJ2a9r4VnkjszZkiSQYpyJgxlL2smQqBS8nFUsqXBhnXd
         nYW4Q2f00Udk/05rK37ri/wARjKPYpl8kfg34qz0Irz/hRy0Wy4vO5udW9mThIQ+E/Km
         7kOEOpnEPZkfQBpDC01k6azXSqp106hNBiNzCKmzaEEhGxAqcGvYJyV+lY7xniCbrdkD
         goJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=iPGuXgU5BaCYeUhMKAJONsHklK5o1aEYRjLpXVvOsjY=;
        b=p5wBeZrNRCWpPRcwsFds6PVKUzWGVFUHPw0dS4Ke7a5MnXXd+6IQ8Pg+Uy49wEDiUp
         5MTxhoKLTeNSYEx3ufDRfFa/kooV/9em1ppCpG4Sg3lNIxs3/WIsw62H5EkfHItjgJW1
         VEh9otgHhLDCiP0DITPul2ylX7lY68nlNzFoKSuL1anphRzeS5N0zEj+UmkZbo+PW54d
         cQVpMf8rhAy21aJwiD/7bRod1QrVw3CIS4rnY7CVsaWaA/twpispgGuehODPtZtTEvwn
         Coit0DkGw+KSOfLYwLCTa2A/O7QmXOhj0Rrb4DXS22AYhzzcYyeL4zofMRWOGfSQvwwP
         pULA==
X-Gm-Message-State: APjAAAX/Ao0adQM9HDEQCn9i0ba+7oY2GU6bqpqYiqpf/o/wOGBSsKru
        Bb60Kre/YOn8DzILSwBrsQoVyP3Bhhcbwt2tmbVgtHyDpEQ=
X-Google-Smtp-Source: APXvYqwO/PeMihJaGJwh5WtLB8cucsgPTd97+cqeSJVeKmj6Mc9mSTAVsU5mrcjr+3lgVssn1BYwMvcVdjhnyvmoLGc=
X-Received: by 2002:a5d:9249:: with SMTP id e9mr3160322iol.242.1576159333985;
 Thu, 12 Dec 2019 06:02:13 -0800 (PST)
MIME-Version: 1.0
From:   Syler <hileo77@gmail.com>
Date:   Thu, 12 Dec 2019 15:02:03 +0100
Message-ID: <CAC4O4kJzdShY8wW67hR4_AxEjS09bRYLHTCj98Z1VRYbLpE=EQ@mail.gmail.com>
Subject: Syntax related question
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

i have a question about this code `*.s#?`, is the code after #
supposed to be interpreted as a comment? my understanding is that its
not a comment, also does the # need to be the first character to be
interpreted as a comment?

the reason why I'm asking, I'm making simple extension for vs code,
syntax highlighting, auto completion that kind of stuff and i want to
add the ability to chose one of the templates of the github/gitignore
repo their syntax highlighting interprets the code above as containing
a comment after the # but the way i understood the rules is that it is
not interpreted as a comment, so i just want to be sure that I'm
implementing it correctly.
