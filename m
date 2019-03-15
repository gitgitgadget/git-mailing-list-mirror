Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3AA820248
	for <e@80x24.org>; Fri, 15 Mar 2019 18:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbfCOS71 (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Mar 2019 14:59:27 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:34117 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbfCOS70 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Mar 2019 14:59:26 -0400
Received: by mail-ot1-f43.google.com with SMTP id r19so9308648otn.1
        for <git@vger.kernel.org>; Fri, 15 Mar 2019 11:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=+Wxsebj3LK50fkDxZiHDtKcdQIykygRQesJninUBcIo=;
        b=G2+xvkIKo6QC4M9bdHMxOwX8N/9Tihpp49Gj/5NTKR5w93egUKIa6+SpiX9qV2dZsu
         zxoQYO7sdzSGAJPF0a7pMUbEaxZ+zovfSHwxXpd7GXSVGnuFM1gkZyZQF7YRcUxQYmcF
         9IFRpBRxNdKO7vs6qlm3ROPHS6Y3qpVl9EtcqJaDoy/8ogHfdLhh2ZewjptkZEmOZOIO
         ba6IIK6bc8F8ogUlDbeH+cZw3KL4/qB5X8gjnYVV00h897AY5R+Tjolf2Fy1xj6bfIYw
         trA3dUmgp8vioP81wkwR+eg4e9W5SPCz1t9F9R+o9AHWLHTWLm+qijapLCbjUoCsqEK8
         f1cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=+Wxsebj3LK50fkDxZiHDtKcdQIykygRQesJninUBcIo=;
        b=PnkNCIPXB46XOadSHsn5ZRuswqpSIzOmWObffmRONTlLTQiRKNRgLM4t8LgpCFUxBh
         lgNO8Vc2sgGPzpYZnbMqKPBuHY/dM5On9t39JVjb9cov4KQVxncwXbMBXd/iFYss9ZV/
         RLJQ0GwxBha1L5kpkRaAAZX4AzexKg42KP5xTd2vEfane4i9RDVtjmRtXAbkLSc3GyJJ
         Z6v2NB50mSq70iv0/aCJl5zTctoMUlacPYx2CtS5o67nDk27U6xlJsLVVaGmiboH/8uU
         eiHH/WXHMETKBAtgwCH4qbx2c/rmXEqqJ3l4yGTyKQ4RDVAL3uwaEievFk/6gjWgREkp
         FAGQ==
X-Gm-Message-State: APjAAAUyY0A8HEdgk6oRAcMA/bB9DcOTfZyBrbKYGYllJsdA00bhN3Z8
        65zfeRMsacrG0/T7RemvNL8a8I8ZbS4Z1GixmzAk1g==
X-Google-Smtp-Source: APXvYqzzq4edNm5U9HMeVzxaC7ImWlDVEGgb3yxaTiXof+tJ0RVGBjxrw7VSIw+nfW6hfDA1XzPbuziTc+eIVAoZwRs=
X-Received: by 2002:a9d:4914:: with SMTP id e20mr568112otf.18.1552676365445;
 Fri, 15 Mar 2019 11:59:25 -0700 (PDT)
MIME-Version: 1.0
From:   John Passaro <john.a.passaro@gmail.com>
Date:   Fri, 15 Mar 2019 14:58:48 -0400
Message-ID: <CAJdN7KiS+6y0a3sj0yuGuJ+URJe0SBJJTRg2ZpA2upN2rwZXCA@mail.gmail.com>
Subject: Shorthand for "$(git merge-base A B)"
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I find myself fairly frequently doing something like "git log $(git
merge-base A B)..C". As far as I can tell, there is no shorthand for
the $() part of this, but it seems like something that could be pretty
naturally added, or documented better if there is some esoteric
combination of the existing shorthands that would support it.

Is there any way to support a shorthand for $(git merge-base A B)? I
hoped a joiner in the spirit of A..B could be used:

A::B
A*B
A%B
If not, maybe A@{mb:B} or something along those lines?

I can imagine this would be a non-trivial amount of work, just
wondering if there is interest, or if anybody has thoughts on the
notation?

Thanks,
John
