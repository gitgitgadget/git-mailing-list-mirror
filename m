Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36340C0502A
	for <git@archiver.kernel.org>; Sun, 28 Aug 2022 01:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbiH1BBO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Aug 2022 21:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiH1BBN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Aug 2022 21:01:13 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C5452DE9
        for <git@vger.kernel.org>; Sat, 27 Aug 2022 18:01:12 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id og21so9470948ejc.2
        for <git@vger.kernel.org>; Sat, 27 Aug 2022 18:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Twp6qd1XAhqfBQPqObhJca8JqjYnZXsnUjZqFvlwVOk=;
        b=iXeqZWwdbLABxLw/LVPI7LZRhEKl0N8/jvpDyhc3g9vdFUijaemT1X03vTGFtaiALt
         xMpmDl3m81oZSGOAxAJA2nM11IdwNkxMqzrsbm2WTT2EfcNyGSiMKFOC3RCABxfmBsLF
         SMqqPE9XcwyMFkAxcOfbbQ7PHW/vDbbz66tLVAF3yUZRDquPQWbUoYBzrPBwChYR3Un9
         DKyetzd5N5rheA8tBieIOBp7zhAvc9IzIMRSwf5r3YbELFqW4WYbqQFsRd88W8tlQmCo
         KtKblscuuQvqGgBUGnF0UIhpUcxDveg3PYJbQy2m/v/Tc1tkduMOVfT/gu3J1WSRpoGo
         RKIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Twp6qd1XAhqfBQPqObhJca8JqjYnZXsnUjZqFvlwVOk=;
        b=T2D6XWr+HBLVcDeMrx9WrXu0Hn4ePeN+nY21xkMdrHhEu2fU+TdRHCXTsFmV5kHecF
         G54uM8ZukXoKqfG9XkcPKXgqPbPjkmPL4J+X4nfGYVXgq+Eq8/hMjpOUXN4dRbvc8mSC
         +Aek39iEMn0wx+O2IJxODZLbK5q9bpf6lduKmK7CTfVKqiMy9R+HNjJD9eMSCtJNjrKT
         MomGZrRdorCfCzFVKfUNV96/uvTnpn59C8R4aJjtBDqioj/UxfJmHQa2/1KESl4PQnnc
         hHQntjJsFat6gz0aKBXpFfC6qcHeqx4JvUrTGr2q2Xt/MUHgANmh46AnbeJx9KY5S47q
         Kq7Q==
X-Gm-Message-State: ACgBeo1yE90USaICm2hNznFnzlbmB4ZWqW7DZP2cC2jyaEBToigNd37C
        UREzS7uhCo9G5R7wxZNl/iZBxeWVcJfecwafbhAgrWgA
X-Google-Smtp-Source: AA6agR7K5ghahyJ9ibd8w3D1EsxNQBCwhf4PgYzg/IXAFoEFHSnymd8nrc+/8yQU163g6o9FPZRiwyv6oR50Z2tuHl0=
X-Received: by 2002:a17:906:ef90:b0:730:9d18:17b3 with SMTP id
 ze16-20020a170906ef9000b007309d1817b3mr9594313ejb.141.1661648470946; Sat, 27
 Aug 2022 18:01:10 -0700 (PDT)
MIME-Version: 1.0
References: <AM0PR08MB4323160241D4341FB1B99CC2FD749@AM0PR08MB4323.eurprd08.prod.outlook.com>
In-Reply-To: <AM0PR08MB4323160241D4341FB1B99CC2FD749@AM0PR08MB4323.eurprd08.prod.outlook.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Sat, 27 Aug 2022 20:00:59 -0500
Message-ID: <CAMP44s2iwWhpeBrzuRK5mB9ekpy4MRu5OEQ-BA4mvbUb1EJRqw@mail.gmail.com>
Subject: Re: Ambiguous 'HEAD' issue.
To:     Caglar Akyuz <caglar.akyuz@sparsetechnology.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 27, 2022 at 5:15 PM Caglar Akyuz
<caglar.akyuz@sparsetechnology.com> wrote:

> Recently I changed one of my repo's origin URL from gitlab to github.  After this switch, I start getting:
>
>   warning: refname 'HEAD' is ambiguous.

> * git show-ref | grep -i head -> nothing suspicious

Are you sure? You don't have a ref called "HEAD"? Just "HEAD".

-- 
Felipe Contreras
