Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 454D71F45F
	for <e@80x24.org>; Sun,  5 May 2019 20:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbfEEUrf (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 May 2019 16:47:35 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:50627 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726431AbfEEUrf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 May 2019 16:47:35 -0400
Received: by mail-wm1-f46.google.com with SMTP id p21so13314443wmc.0
        for <git@vger.kernel.org>; Sun, 05 May 2019 13:47:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6S3n6gEiZtWkkiMEQfyLOBKMgM8SfysBX04t4CZ3s/0=;
        b=nmMCpUcPGpGcVXEmSJf1/fGYkHk/qmr0HYQl2kj1TlMQomuC6exVvlK8hBnBmO0f95
         xiMXqg/UOpyvOjE9VZroKdBWb+O/rK5Z5xwXB4zlaAxbuxDYqfaTBmOGbblSgm9BiGhl
         fx21HfDcqI0wW2aJ01LBqddL9RtwAYbwl3eJaTjTHsLwWko+OaeYctkFpppto7OqGm/M
         9Xj8uOcPbwpf9j1XGTXDpVP89WAOBjkxion/FklWmYCuxAfvdQR+6FjK5yFAsqRDD5cU
         P/H0WOFEAB9CvA++IickOCUdFXEHlC+UgkMHqiaOLGjB1UeTcBfIh3lh1c6zNm4AcfJ8
         IGPg==
X-Gm-Message-State: APjAAAURwPNCJUpnz3g4HovwD5JCWpiazwqAJR/OsIBcnfTtbP5tnEcO
        +cOeethXczAjmhx1iRdJa4Jwx0/Gvw/ywV/YccE=
X-Google-Smtp-Source: APXvYqzqjeVcxC/6BMV465Y49GzoS3E9dcAcuqHu509NBz0ZT4v45Nc5CWVuzzGNmJxLkxgEvBO4K8BXzcpaYMGl2TI=
X-Received: by 2002:a05:600c:247:: with SMTP id 7mr14756957wmj.31.1557089253264;
 Sun, 05 May 2019 13:47:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAH8yC8nTyq5Fjc-6fUNn1iwkCO9i1Vrc0vFqxEVg4Eor3h-0Lw@mail.gmail.com>
In-Reply-To: <CAH8yC8nTyq5Fjc-6fUNn1iwkCO9i1Vrc0vFqxEVg4Eor3h-0Lw@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 5 May 2019 16:47:22 -0400
Message-ID: <CAPig+cSzsmeHp1S5WG3TVXEyZKt9eVrsCsWEkpwbNUZK_SJ53g@mail.gmail.com>
Subject: Re: Git build on antique PowerMac
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 5, 2019 at 3:43 PM Jeffrey Walton <noloader@gmail.com> wrote:
> I have a PowerMac I use for testing. [...]
> make -C t/ all
> readline() on unopened filehandle       test_must_fail
> run_sub_test_lib_test  at check-non-portable-shell.pl line 34.
> Modification of a read-only value attempted at
> check-non-portable-shell.pl line 34.
> make[1]: *** [test-lint-shell-syntax] Error 255
>
> Does anyone want to take a shot at this antique system? I can provide
> SSH access with root.

As the author of the code triggering that problem, I can take a look
at it. (You already have my public SSH key on your Solaris box.)

Given [1], I can see (I guess) why it's complaining about modification
of a read-only variable. However, the unopened filehandle complaint
looks odd.

[1]: https://www.perlmonks.org/?node_id=570712#default_unlocalized
