Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	PDS_TONAME_EQ_TOLOCAL_SHORT,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6813CC34056
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 18:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3621F24656
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 18:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UR7VNaPy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgBSSBS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 13:01:18 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46486 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbgBSSBS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 13:01:18 -0500
Received: by mail-ed1-f67.google.com with SMTP id p14so22071478edy.13
        for <git@vger.kernel.org>; Wed, 19 Feb 2020 10:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=eLfLxJlrRVORamM+7TIejUUDT63RDFpjsoDcKL+K8aA=;
        b=UR7VNaPyZv3PRfjWDGp7UElB9lCGUVIYm/77Gu86+eRBQRuXtLzInoELF5cEJHuUZ+
         XfpB1CUxLGvyGErEgVBh4NnQA2rpvVGPG3iNeb6DMY8Prnnab7ox9Vmi4xKsNyUWNTG3
         m4AXkdAdyT1c6vt/p4qpfd2FJV5MSNNTOqLRkm6RToRGoYg/WoRVWUw6+xwGHVkhH7aS
         Bg0lKoLrgzlrQe1ZC1mLpbkav0JDG5HQKKEU2iNpJrgikYFLGDZvVSBUftFZ6gMdbE5j
         CCN+wzIxBUrphB9jkk2/6p/xLxgtMW6p9Z6NKsu2n57/vul14BsiPHxRey9jNG79dHNR
         9B+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=eLfLxJlrRVORamM+7TIejUUDT63RDFpjsoDcKL+K8aA=;
        b=aULm+0hh6v6zj15Ha9DcuAX0U3NTOQ5C4MMuvUuM1qbzD/uvYvcmKKUfQ595uP1RDj
         jqA6Eh0SFL+OWZwn1ZIWoXagiKx3YDW72965wf2OgvYtajsuAE5VmsuX6081/k/Q0Kbg
         7of3qVn5Vm+ouU3oDBskd+9RiJQGCiIgtlxF6rpZPrIX33HnXLtU72y+WkT+3ukSu1kQ
         k5pWHpFbGIotiVALO5BeSynMFfOS0LidmoU7CQpSLtHRYOcRk7zavjsWnWQh4pjutLYi
         t67bCnjqWAL2nASFPpfQKez7SfJVLl8dtzbj/rphWYZteQwKGYDQjEQn5GaEYOHqoy2S
         1Z4A==
X-Gm-Message-State: APjAAAVJdAz1pf0kXKVgo8nqK5FuLbE+CHGGA3H9bRlKIWSVct4HN0iS
        uMvMt2+gFm4ud/6dEPPIPMECMnopZJCVpsf+9lQ7SO8KuT5rwQ==
X-Google-Smtp-Source: APXvYqy7h4pp4W1eSNCKW8JxDU/vvmAPiATHN+r6lWAbJKjJqXmvoQ+UtV/B1Y9LqpdsejRwwdRsDK9WozMro1VFnjw=
X-Received: by 2002:a17:906:70c:: with SMTP id y12mr24929388ejb.67.1582135275723;
 Wed, 19 Feb 2020 10:01:15 -0800 (PST)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 19 Feb 2020 19:01:02 +0100
Message-ID: <CAP8UFD0bS_4MuAmz4zEEOU_m-tiBGd7jUS2iQU_qfQUJ7F=JAw@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 60
To:     git <git@vger.kernel.org>
Cc:     lwn@lwn.net, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Torsten Krah <krah.tm@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Eric Raymond <esr@thyrsus.com>,
        Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 60th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2020/02/19/edition-60/

Thanks a lot to Eric S. Raymond, Josh Steadmon and Johannes Schindelin who
helped this month!

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:
https://github.com/git/git.github.io/issues/417
