Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA9AB1F597
	for <e@80x24.org>; Tue, 31 Jul 2018 17:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729644AbeGaTAe (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 15:00:34 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:42546 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728226AbeGaTAe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 15:00:34 -0400
Received: by mail-vk0-f66.google.com with SMTP id t4-v6so7896285vke.9
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 10:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=b0phHB8w8EZH+9f43lWeZ4fwgayavqqFp/Aw/1V/zvs=;
        b=ioUErdghlWCqNnfWcTPVZRu4u/wCa6QYyC58yBn/op8LiEgzCshU8xUI0IvZz0W93X
         PMCQ9Xmb1DWIFhbX2+oKgmQM8+6SFmy4vF9wAyQrwJlaajnLF40sqYDbooM6qvwzH25S
         +CxVQH/6NBUslg12t+SE5Os+iQlhVMUzYGoy0m364K2un5f3vxdfhE+YexMxSy2iTY4U
         NOf/vLdjUqwg6tISM3o3V1VilzrawfxpPmLCmGSizOg0HRkbm1E6rlkTox9NyiAHXpJI
         UumF5MUdkmVmh5lL8k6YHI+aIbZcRgoKi6G8tBKeF2H5JB04d+dbgPMEKqQ2pkKJgKie
         rOpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=b0phHB8w8EZH+9f43lWeZ4fwgayavqqFp/Aw/1V/zvs=;
        b=l2aySOqmfofVxs/fTWPGGL8FGZh76GljMPzOGSJt6VsmDnM3b/dTy6lFjh4F8ghhgd
         BY6eZH/ltUzjdEf9V0DPuLK2OC0duxuIZgZ9s/s9ojMUvbtMLzKl2a42jVf2wUHmQ2VX
         j6VlP/Z7wSybeyQ2yWmFoh1gI7OtX4loK+EjfnM40KqhYb2m7dljAV7UKgW9mwVJIzdU
         DGNjs5lDZXLvPY7GeTD4irATw9/9R9MmsB81Bb9jbYQrrVBRRz4jlONdkX9PVa1ibhD5
         LRGcF/cPDG3L3wo8mHoq3fIHYXRsm0dF0iHJaO1JopvliVXThI2nFfK28xJndJEJpVyj
         wIbQ==
X-Gm-Message-State: AOUpUlHk86BNbUeG41L3dGPKI+uuop64fanNhOiEhgsfL8S5G+dTXFlb
        ntUaj+Au5v6DLMw7pLHwpAq06AK3Yis1TglkS69he0Ga
X-Google-Smtp-Source: AAOMgpdrP8VAzlywulMzwfK1D4ZR4pS92pTTUIuc9bBx+x2YblqKw8QBfMkMnnlOKz33j2OMMjExlJr9WFeoAshW6Qo=
X-Received: by 2002:a1f:6bc2:: with SMTP id k63-v6mr1574135vki.113.1533057556207;
 Tue, 31 Jul 2018 10:19:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:21c7:0:0:0:0:0 with HTTP; Tue, 31 Jul 2018 10:19:15
 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 31 Jul 2018 10:19:15 -0700
Message-ID: <CABPp-BH+YW6z147K-X7eTH2E9A3tUzteosKA1KadhSavM5c8Lg@mail.gmail.com>
Subject: Question on range-diff and notes.displayref
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Should git notes show up in a range-diff?  I happened to have
    notes.displayref=refs/notes/amlog
set in my git.git repo, and saw the below in my range-diff:

On Tue, Jul 31, 2018 at 10:12 AM, Elijah Newren <newren@gmail.com> wrote:
> 1:  4a1c9c3368 ! 1:  00f94a8b41 t1015: demonstrate directory/file conflict recovery failures
>     @@ -14,7 +14,6 @@
>
>          Signed-off-by: Elijah Newren <newren@gmail.com>
>          Signed-off-by: Junio C Hamano <gitster@pobox.com>
>     -    Message-Id: <20180713163331.22446-2-newren@gmail.com>
>
>      diff --git a/t/t1015-read-index-unmerged.sh b/t/t1015-read-index-unmerged.sh
>      new file mode 100755
> 2:  e105e8bfbd ! 2:  d3b8d7edb6 read-cache: fix directory/file conflict handling in read_index_unmerged()
>     @@ -59,7 +59,6 @@
>
>          Signed-off-by: Elijah Newren <newren@gmail.com>
>          Signed-off-by: Junio C Hamano <gitster@pobox.com>
>     -    Message-Id: <20180713163331.22446-3-newren@gmail.com>
>
<snip>


Maybe this is expected or wanted (tbdiff also shows the git notes for
what it's worth), but it seemed somewhat surprising to me.  I'd rather
not see such "differences" displayed for the patch series that I'm
submitting, but perhaps others see it differently?

Elijah
