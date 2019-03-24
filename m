Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA63D20248
	for <e@80x24.org>; Sun, 24 Mar 2019 08:04:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbfCXIEu (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Mar 2019 04:04:50 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:41097 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfCXIEu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Mar 2019 04:04:50 -0400
Received: by mail-oi1-f170.google.com with SMTP id v7so4725647oie.8
        for <git@vger.kernel.org>; Sun, 24 Mar 2019 01:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b3pVQ/iejMgQSXOFAG6dZJVdptoXCwUFUgX3dz0OzUA=;
        b=Ih0MUxck6eX0c/oaPSnKK+RYVN0NhxyF8G/VGcDclXUeJPFIpPK7fibsKYm9ROt8bM
         ssZH+0vqeDVAgwGUl3N8RcW1k0ONaqzFDpA71g0xUz4+VyX5A2XzHuJYNIp13bYRAFD/
         Vdx9/WHKCpeBMSsX3HaM0LYTLsj+W0oVDXPxVA7eMlyGIiK13bnl4dBRkYFWdIsu4aXC
         KspC8jc/eNnhlNDbzcyV98gMX3qLfVEGEw8+JcQWhTqSS4XXswb9c/P/kFH64j18m2e7
         /ohXxT7xDPbeucOzBvGQVlyuHx0mC/IylatI2UYUPdZxbuaEWQ8PJnvndWeVT03wKrUn
         XFNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b3pVQ/iejMgQSXOFAG6dZJVdptoXCwUFUgX3dz0OzUA=;
        b=YGTakwfd9oLLXRLrH0WtHeQKTq4nocPn0mPMYub8UamioHA0s/sW3raYykmYw/uzTv
         l+ondWYsTsR6hfJW7KO1Uw/F8pI/tO1eigXJHQkZFsY5/w2tUb0f67SGtygr3mlVCIJ9
         3DkzWkKwH1tHBzu0SQhapUZl7xYCU8MXwW/wk9XyPjMD/pBtCz51D1LmjaxwKoSASzXV
         V5KTJbqxdgba99yYwjQ+wvtMl0hyOhf9FODKkCpB3I7iVf7gbWIsSpzob9yEsri6EdF7
         oTaHee1g1F1Yf4O9yc6Y6XGyNpBqY168hM5oQkTi3kipY+8aKzVWqZ00DgZoOo//03fR
         fz5g==
X-Gm-Message-State: APjAAAWVIAvQ1gWf2GUdaLG1R6j2SSfQf9qg/AnzaiBD9fhCTVuQAeJz
        WtC6ivuko7A7xoh4NSC3+AVz0gAdm6r2j+BfckdaBA5t
X-Google-Smtp-Source: APXvYqxzhsUuY7WKCFLaXXA0vfCoAnGQnZk/1yD1nzwzc3434FxOMMeeVib+7UqGgTVIFz5DTzvM4+l+lUCDDb5Eezw=
X-Received: by 2002:aca:4812:: with SMTP id v18mr7526937oia.36.1553414689338;
 Sun, 24 Mar 2019 01:04:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190322160615.27124-1-jkapil.cs@gmail.com> <CAP8UFD3K4ft7UVSFeaQzKVVGFPwcLcpTKB+sqFN9X9_j_A093w@mail.gmail.com>
In-Reply-To: <CAP8UFD3K4ft7UVSFeaQzKVVGFPwcLcpTKB+sqFN9X9_j_A093w@mail.gmail.com>
From:   Kapil Jain <jkapil.cs@gmail.com>
Date:   Sun, 24 Mar 2019 13:34:37 +0530
Message-ID: <CAMknYEMBYxp1QJ3Ds9dmuS4ccHKtExx33d_Kv63UOwaUMm5oUQ@mail.gmail.com>
Subject: Re: [GSoC][RFC/PATCH] userdiff: added support for diffing shell scripts
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 24, 2019 at 1:34 AM Christian Couder
<christian.couder@gmail.com> wrote:
>
> To save some work by people who could help you, it might be a good
> idea to show the output of the failing test, for example the output of
> `./t4034-diff-words.sh -i -v` or `./t4034-diff-words.sh -i -v -x`.

Looks like i just needed to know about -i, -v and -x switches, they
helped in debugging.
The problem was with the expect file. It is resolved now.

Thanks, will be resubmitting with updated expect file.

is the parser used to parse the expect file specific to git ? or is it
some general one ?
