Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C803B1F463
	for <e@80x24.org>; Thu, 26 Sep 2019 18:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbfIZSFQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 14:05:16 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41615 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727631AbfIZSFP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 14:05:15 -0400
Received: by mail-lf1-f65.google.com with SMTP id r2so2387697lfn.8
        for <git@vger.kernel.org>; Thu, 26 Sep 2019 11:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S/uXA98eqNB+JWeht2bndc93JX0JFKeFSgn2iDW3u14=;
        b=me98xtOMSKjEiWZ1v7P1fzExXuN+2pjgO0zyh4+yUDYS1pJDRleT4XNU7iCN0kuDiS
         ruqXFtHsDOXb6MegSvHrbGdWGaQTnfMFPlU3u2k4KANcsPuI6Znj8XAzQGQvE2zT3H2p
         4xqc0sTj06A2ZG8Z5q9A2x1MVZPzHoeoBwS9dXqymBNfznxTx0oIDDZ5nXCv7Dohmth0
         2qwuNYn5VQfJ/tbGI5QUo4rzQ5LwLGNuTZvrMJv0Fzo67ppIfSLjtSnKHbm5aMHTcq0M
         1wHOOiJhjMfs28YBpSCibgutCOMhtWN3SVip0E82goo5hD8LIQrHOKO21BeCx3V3Fi/+
         KE3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S/uXA98eqNB+JWeht2bndc93JX0JFKeFSgn2iDW3u14=;
        b=M7YKUfR+MVFUbWS0HFt6Cic+3IOk8erFGq7Pn4RHIxjJ7xYZW2bQxrVAwdP2lwbTvx
         PG4m4th5utR4Q3f8TCnf6EsagubG/D0HJ/ViGrgqD2Z/au5rPW0m++t9NCoUshYxWcVY
         VKTIXXl1KATIr910DxW5qeZd6zZPJImD/7KU5N+X4B6DlLJ1vCeanMGFcL8aiIL0zyUT
         Gr3wvuWxDssdy1zdUPkB1A9LAp510Azq83hrr4yi1zTKw2Y2MoARi196K1keqRo7RmMo
         VrPrM1pGfvWF3aNCg/Uy4wPpVNMSc0AC6w+FmncSIw+Wg5WHUkIEV6KwKUAViWYdm5kc
         cKNA==
X-Gm-Message-State: APjAAAVO7F18pn2oPVpENJw4O/P0JmYkFogzJ0oYiSBZWbfuxnKLcg++
        R3WqszHogaqLUWchUGS+QPQ8SQwCio/ovzh9BNA=
X-Google-Smtp-Source: APXvYqwB30xUoovOCGqyYJG/roF0ggkSqNFc+H5CA5dzGTA4lUpYXRxdb1gLbUMpAlX3RFGWxzJwdvLUDfgLQGPJazA=
X-Received: by 2002:a19:ae0b:: with SMTP id f11mr3185454lfc.28.1569521113515;
 Thu, 26 Sep 2019 11:05:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190925020158.751492-1-alexhenrie24@gmail.com>
 <20190925020158.751492-2-alexhenrie24@gmail.com> <8307cccf-e115-c720-6670-2ab537066a01@gmail.com>
In-Reply-To: <8307cccf-e115-c720-6670-2ab537066a01@gmail.com>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Thu, 26 Sep 2019 12:05:01 -0600
Message-ID: <CAMMLpeTxGiGrgYcC8jbtV-vAeEKMGZD7YRK397mwwpQdHig4KA@mail.gmail.com>
Subject: Re: [PATCH 1/3] commit-graph: remove a duplicate assignment
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>, dstolee@microsoft.com,
        Junio C Hamano <gitster@pobox.com>, davvid@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 26, 2019 at 7:02 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> Could we instead remove the assignment during the declaration? It is
> easier to know the while loop will work if the assignment is closer
> to the loop.

Sure, that's fine. I'll send a v2 with that change.

-Alex
