Return-Path: <SRS0=9JxE=D5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9784BC388F7
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 19:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EA1D24658
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 19:06:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S369888AbgJVTGx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Oct 2020 15:06:53 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:45208 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S369851AbgJVTGw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Oct 2020 15:06:52 -0400
Received: by mail-ej1-f67.google.com with SMTP id dt13so3884778ejb.12
        for <git@vger.kernel.org>; Thu, 22 Oct 2020 12:06:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TCQlW6dA/FrUBV6YFUPh5RJe/QOZJEySErR83ynxGFE=;
        b=uBrv/nX1DvXSPkQsPZ/uHOA+909vXJB7Gc1coRBQK7FJcvK0myazkzCP8yn54gPDMP
         zG0Ypnb3owAIIW0QF+ATw6gldXF0VPaj34gn775AIHCzgbvIAu0BWTMhiV4UXjmJ4gT9
         6VOdOqXlDJv8kbRu6uaKgOj8YCJK9CBbxhZzhG4pflkKz5cLW7RmoWK0P94oUNgu2vH0
         vboSeAB3ezFXBLih0b3cNodusX5/99uyJUmE4J/VyNv8G2ril4xtMUMYVk9z99ICKg1I
         WNUhD/o4eC+ZccXyqWs9zQH84XcCxTVaAdu3jEnq86zKARu/+i/xhCOiGLy9b+h5G+lL
         Sqog==
X-Gm-Message-State: AOAM531AYgt485XHp9y3n1ym89VyuyIM516QF5gHeZsYaM7xSipX5UWv
        yI4ilmdttYC8xVK1spQAbmv/PdcBo/hp34Vs1aVE4U5YMvs=
X-Google-Smtp-Source: ABdhPJyarWqzyqbVGU5V0JSfZ8Vung1nybD38nfuog/m0+Tb/B2ilSu4BBFyr9OdlrWMwWivz63/1m0BINZYEBTW36Y=
X-Received: by 2002:a17:906:c7d9:: with SMTP id dc25mr3725678ejb.482.1603393610354;
 Thu, 22 Oct 2020 12:06:50 -0700 (PDT)
MIME-Version: 1.0
References: <DM5PR03MB2826A616AC30710E169B7237B5360@DM5PR03MB2826.namprd03.prod.outlook.com>
 <DM5PR03MB2826C04CC5AAF3B61BDDAFE2B5360@DM5PR03MB2826.namprd03.prod.outlook.com>
 <20200925222801.GC1392312@camp.crustytoothpaste.net> <DM5PR03MB28262362A9D3B0EDECBE6106B50A0@DM5PR03MB2826.namprd03.prod.outlook.com>
 <DM5PR03MB2826382CD1A5AA8F3ED60FD9B51D0@DM5PR03MB2826.namprd03.prod.outlook.com>
In-Reply-To: <DM5PR03MB2826382CD1A5AA8F3ED60FD9B51D0@DM5PR03MB2826.namprd03.prod.outlook.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 22 Oct 2020 15:06:39 -0400
Message-ID: <CAPig+cSbUjb0=TRGdpdTV9XyVbRad-f-_Ypw72wVE0OBR6TaQg@mail.gmail.com>
Subject: Re: Git Alias not working in worktree
To:     Frank Illenseer <illenseer@altair.de>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 22, 2020 at 8:06 AM Frank Illenseer <illenseer@altair.de> wrote:
> Does anyone have any idea as to why the alias definitions from the
> config of a worktree is not working? - I would still be interested
> in a solution to get this working.

For reference, the original question was posted in[1], and brian
mentioned[2] that he would take a look at it. brian, did happen to
investigate this at all?

[1]: https://lore.kernel.org/git/DM5PR03MB2826C04CC5AAF3B61BDDAFE2B5360@DM5PR03MB2826.namprd03.prod.outlook.com/
[2]: https://lore.kernel.org/git/20200925222801.GC1392312@camp.crustytoothpaste.net/
