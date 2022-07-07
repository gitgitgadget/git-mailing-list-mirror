Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F45AC433EF
	for <git@archiver.kernel.org>; Thu,  7 Jul 2022 19:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236770AbiGGTNB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jul 2022 15:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236764AbiGGTM7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jul 2022 15:12:59 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA855C94D
        for <git@vger.kernel.org>; Thu,  7 Jul 2022 12:12:58 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-10bec750eedso18840736fac.8
        for <git@vger.kernel.org>; Thu, 07 Jul 2022 12:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=U1HR9MF9Ukpp8WcI2Uo/9oB2zUFegLUuD88CHqNzaVg=;
        b=icklH4COoyljuEn0dT+zrpMnRedvIXJMUCZi1U18yZsNnR+gINZNziLUbDnKxq239B
         42oXtuL29INDczjnbRd4lfkhB1ompiXto1NTgN66fVeyQGl3ELW7szrU2vn6k2d78NXu
         3LPf3TvZXI8Po8GWbGbjc2NmKBcY47xbqP2h74/2mJ20ip9cKId3XOx6EDBT3eatNrBF
         mQQQvY3BhEaGpTYnLqUg/AtHEmw5lIHFlp15FvQpPzKX7jQxgToLzduNszApKdEL4dUr
         I23LIHPL2o/AlHN/YttJUnpY3neeqa3nJ7OJex/ZBNY5pKCaC0mfydd0YX3bGRjtdg3t
         VWaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=U1HR9MF9Ukpp8WcI2Uo/9oB2zUFegLUuD88CHqNzaVg=;
        b=QP6flgQMMBhAmgRrUtUKN682Npoue3ZW64UbehH2Pq1Iwe+9VFd+s8P5PuQtSD2FZg
         8f4cUZGwIjbseM8W+DR5i6Nl5j/gZCn3/mDESAMcgajxNIRpKtYwtPOy5hG+2kJdzmZi
         WDwSfS7i7OVLGwwPHRxMNAZTPe9oZXqHMcGaCCekDtbD0wMtp/7bk1O+cw1QjSDghZJy
         PhkG8x/NNJrguZXDka8LjTC++85oTEHjeudaADBZuhtlrgefFk5ngO3EO9jivTg9V5fd
         d61WY4XkQcSTS7a/pxxdCLsiCW4O4ojHaXXloIH+KzyeKYUT/3PkdP2qlw318h5bc50b
         ktgg==
X-Gm-Message-State: AJIora+OAAEjbbtsAOL2JXg3JtJ7+4CaVX46KLV08ws46jz7wg/1mDiv
        hcC/ZopZNfHGlw1x3ZKd1smP3tTEszQxxyMAWW5F8CxRSr0=
X-Google-Smtp-Source: AGRyM1u6USnKnQT6kUtnyLaGkKzw6i/elecrwaKK8DQZN2C0jdnCXgpMTpw144IQhW5kRehzN6xE8HYcXlZXPWJlF68=
X-Received: by 2002:a05:6870:5714:b0:10b:bbf3:5b24 with SMTP id
 k20-20020a056870571400b0010bbbf35b24mr3847694oap.106.1657221178068; Thu, 07
 Jul 2022 12:12:58 -0700 (PDT)
MIME-Version: 1.0
References: <CADS2hGpnkiPzivVDyN-PnGsQCTafqx68PxigXvBK1bv4O=p4kg@mail.gmail.com>
 <20220707170032.GR17705@kitsune.suse.cz>
In-Reply-To: <20220707170032.GR17705@kitsune.suse.cz>
From:   Jonas Aschenbrenner <jonas.aschenbrenner@gmail.com>
Date:   Thu, 7 Jul 2022 21:12:47 +0200
Message-ID: <CADS2hGoHzx4oGxZnx-DwstKLVM7w4afcYcgmPuAb=ex3WB78iA@mail.gmail.com>
Subject: Re: Suggestion to rename "blame" of the "git blame" command to
 something more neutral
To:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks. I wasn't  aware of the fact that there is a "git annotate"
command before.
The point regarding the word "blame" seems to remain.
Maybe the "git blame" command can be removed in a future major version
and a flag added to "git annotate" so that "git annotate" can return
the data in the format in which "git blame" currently returns it.

On Thu, Jul 7, 2022 at 7:00 PM Michal Such=C3=A1nek <msuchanek@suse.de> wro=
te:
>
> On Thu, Jul 07, 2022 at 05:35:41PM +0200, Jonas Aschenbrenner wrote:
> > Similar to the change of the default branch name from "master" to
> > "main" to use a word which has less negative associations,
> > I suggest to replace the word "blame" with something more neutral.
> > Maybe "annotate". That word seems to already be used at some places
> > for this Git feature.
>
> Have you seen git-annotate(1)
>
> Best regards
>
> Michal
