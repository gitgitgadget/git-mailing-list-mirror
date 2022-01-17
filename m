Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B65ECC433EF
	for <git@archiver.kernel.org>; Mon, 17 Jan 2022 14:33:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234293AbiAQOd6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Jan 2022 09:33:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbiAQOd5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jan 2022 09:33:57 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F77EC061574
        for <git@vger.kernel.org>; Mon, 17 Jan 2022 06:33:57 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id v1so21649058ioj.10
        for <git@vger.kernel.org>; Mon, 17 Jan 2022 06:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=onLtL1HA/n861WVDN9G+lLCbDt7xJHItDJPOcuQ7ZRw=;
        b=Bq8qVqGNfTFmPKSTIyOItfkVgaFvIf/WnKkgXRePK5JThXOfxfFRfNEWEUQGcZe94K
         ltovAw276ih0osMKHGjeIFvHp2mz3TXMOAUS3imNTRnM5/MAoOW9kHYSTobZinmYIkHE
         kFETwG9ZiKxyqNLqrWwCcimLYKrAMCAi0tlV0wwkSlJlZlLxNSohTKEiw2Wn3Ps0gO5x
         SGPTGrWGT1UCUe8eugjTFJr4jEbR8pDBIDRRyIPhguDxq/9U3ar0zbxqVFzqPqwKV6xa
         zobrNMYZx6EH+waDCuHNnEDGDUOv4Eab9aaD2GqrOjYzgz2YWcuW4gN7bYPtsZY8NEWZ
         CWtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=onLtL1HA/n861WVDN9G+lLCbDt7xJHItDJPOcuQ7ZRw=;
        b=gMg/VuZI7YrOdm76Gbq1JCxWj8snzsnXX4TDV6hXN3wSuRfYUF+g12sZLaaWJsRFon
         hDNeLETv9PBJMGPqcOuRW4ezbpDNTkjTA0rLT1DruLQXo3744Nmz1oYeA07IAytjAMRU
         0yCDovPMhJiEyevq4zPvQkx+JMJOv7fQJKVnzejnYd/fgG2gWWWpr7xzuRPEMmPU3+Gt
         gTXrzMWH+bnSNqrRvldh4fgeOQYRhUbQ4mbucjv3t4JLu+nMlJvCdKGcPHt+QFQxol7w
         zxnmm1jVEygthEk5OSSJrL2E5qhFfa+gwhjNMdPPSmtoG1CEUF9N2oSQVj+E5af4HKUO
         mnLA==
X-Gm-Message-State: AOAM530MY4AKWmpTm7XiJ7kMhJqKgZP15rF+WxWspEpV5tdxfqb7IqsR
        h0DF7Rp/Alzt0Vw/ccejNrukYwvu1oKd8cQDy8GF0SZZprw=
X-Google-Smtp-Source: ABdhPJyQtnN3n38b+8p7qF+efiahCnoNpPw+n+Dg3+CvILu4fU7y3CkhSJ+qWtgYdFJf3J8CMEVwoib91Aicio4maf0=
X-Received: by 2002:a05:6602:14c9:: with SMTP id b9mr3010221iow.3.1642430036802;
 Mon, 17 Jan 2022 06:33:56 -0800 (PST)
MIME-Version: 1.0
References: <CAGr--=JiCv3XTrxP=foy+FrxbiYeMf=11eG_6kGBFmBr+P-=Jw@mail.gmail.com>
 <CABkJDHF6gS+j6LmT0hr2Z23izb0uBj7cs+XU_14O8wB8yTEpZw@mail.gmail.com>
In-Reply-To: <CABkJDHF6gS+j6LmT0hr2Z23izb0uBj7cs+XU_14O8wB8yTEpZw@mail.gmail.com>
From:   Birger Skogeng Pedersen <birger.sp@gmail.com>
Date:   Mon, 17 Jan 2022 15:33:46 +0100
Message-ID: <CAGr--=+_MvsbGYMzufhSDTpc1YMvfbOSDTArMbuGZ1rnxy2otg@mail.gmail.com>
Subject: Re: [INFO] Does Git GUI support Dark Mode on Windows 10 ?
To:     Sashank Bandi <bandi.rao999@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks a lot for trying to help me, Sashank. There seems to be an
issue with the code. I had to take a little guess at where the actual
line breaks should be, maybe I messed up?

I pasted the code here: https://github.com/prati0100/git-gui/issues/64

Can you take a look?

Best regards,
Birger
