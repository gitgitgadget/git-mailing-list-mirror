Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90E721F4C0
	for <e@80x24.org>; Thu, 31 Oct 2019 06:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbfJaGVq (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Oct 2019 02:21:46 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38574 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbfJaGVq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Oct 2019 02:21:46 -0400
Received: by mail-pf1-f194.google.com with SMTP id c13so3549089pfp.5
        for <git@vger.kernel.org>; Wed, 30 Oct 2019 23:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+T2hPNHTtKCGVXXChU9ktm5BozF713rCxFF2EaQe6GU=;
        b=F+nOZJ6AhqFni1MSN2Yh3xkYznFDI1J8Hq0ASQrBgfW8xhjHnurjIDFyoIrSmoCOgb
         dyG8ORz4o5XOCqwRu24rQk/cfiB+3MefohfMJHhISGuYLvzngpP05NONKffkdaqP1wSA
         ZuPk1zw2E721W1um7Ij5/9ucfU0vNRl+Jmxanx6W8oKRX1kUEdCOwP218qBmIh5h4uV2
         Z/hxrqlzUzCbwZd9NoWqqliDjQUPfn+P2yGTamkENg+f3NhOyVV6IjPmDjKuyskjYZbf
         tcpZjijDTIaeF3wsKhylVu/2iKGpPQ8NglCkzfhYDv6LiCuIVI/GKeRrUZlp5DNpF+jA
         GP/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+T2hPNHTtKCGVXXChU9ktm5BozF713rCxFF2EaQe6GU=;
        b=amX81E9uKJXTy20bx2KW/xg7mLUXxIZiYYweu6xA0ZR/xKityuNDEdFhGz+l5W1ZDs
         bnqiqxi9ifxqSpBXvoiuQraQAxy0r5hy1jO1pia79nwkht11I1DnPao5Cw9kEYvmzx2f
         qs9SEGsSgfSzOpiqv9OMQQM0wjKTcyxMcUmbUF3C7E3gBLzo0NwB2Mcz5cm7VKdxVK+H
         QEruu5aV12ywOUdQlRBPcYmxseoGKZ9GSWmA97aeEZ0vq19/WYBd739nZ4hxqaYaxqgD
         1Lj3Kd2gcAXZvIxxfWFHNQ0RhqFoUfq+CZbEsbb23Kkhqr9bg70rkr/FKZ/Xbwu7jUWt
         VXKw==
X-Gm-Message-State: APjAAAVOVP8zOGUxYpcl5ZwatubI+epeYQfWBXrcihj1ojd82NoCxzLG
        lAQ2z3GJoits1W/Ytzi85Bg8S7G7CYvI1AA5Taf8330B
X-Google-Smtp-Source: APXvYqwJVlnS4pNLFRXzIJ6zZrv+6oEvqI0Lu74kOBcxiAn+GcFQ0FNZIxfmnqb26foNRpMY4Y4+4Q5FCgrM1HMLFAU=
X-Received: by 2002:a65:55c3:: with SMTP id k3mr4226788pgs.155.1572502904202;
 Wed, 30 Oct 2019 23:21:44 -0700 (PDT)
MIME-Version: 1.0
References: <20191030204104.19603-1-martin.agren@gmail.com> <20191031023150.mdbj74sthrftnqie@camp.crustytoothpaste.net>
In-Reply-To: <20191031023150.mdbj74sthrftnqie@camp.crustytoothpaste.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 31 Oct 2019 07:21:32 +0100
Message-ID: <CAN0heSrY9jOrRmt_ViJZ8Yv96XPNh4atArxqNO1=Tr57wdt0Zw@mail.gmail.com>
Subject: Re: [PATCH] manpage-bold-literal.xsl: provide namespaced template for "d:literal"
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 31 Oct 2019 at 03:32, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2019-10-30 at 20:41:04, Martin =C3=85gren wrote:
> >  I'm pretty sure about the background here, but I'm not at all sure
> >  that this is the prettiest or correctest fix.
>
> This fix is correct.  Thanks for sending a patch for this, and sorry
> about regressing our bolding behavior.

Thanks! And no worries. I should have spotted this sooner.

> If you want to avoid duplication, you can write the existing template as
> follows:
>
>   <xsl:template match=3D"literal|d:literal">
>
> That will match both literal and d:literal tags.  You still need the
> namespace declaration you added, of course.

Thanks. I use this for v2.

Martin
