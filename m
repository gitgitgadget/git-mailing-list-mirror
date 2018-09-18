Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E2751F456
	for <e@80x24.org>; Tue, 18 Sep 2018 17:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730414AbeIRXdS (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Sep 2018 19:33:18 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:52280 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729618AbeIRXdR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Sep 2018 19:33:17 -0400
Received: by mail-it0-f43.google.com with SMTP id h3-v6so4548812ita.2
        for <git@vger.kernel.org>; Tue, 18 Sep 2018 10:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DW0sJRbWdD+CWmG2xDI0jRredKHy8y3zG5ECEGWPlOM=;
        b=p5jdcwUKYlUnRcJ0+tyLNWlC0E8EAg5Hp2V76UEJixo/xN31er0u10mxw0Ibw6A17j
         vuFcwwNuBw4qcS6fygSHPR/YPwE2mb+bYrLMff6GJQJbw4TK3JZH5+W1fD24+cJNKpeu
         QVpSel+Tl4yd0jzzIyapB/rM2Ut5cNB7oj5Q+BpGPCJ3mJUzP1giILLBLc05MTiNxOn0
         +zsDMSPgc5IFtJdBtk5mN0Q68hqO13o7cn4uic+hyRZYoIjzs/93Ajd324RxbAHxnCHf
         VxCdIBy3ch73WTSYe62v7UPwuaCdPZ70ygC1efTvAHq8viROwsNW9KyXH8RG0YFe9WIC
         q6Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DW0sJRbWdD+CWmG2xDI0jRredKHy8y3zG5ECEGWPlOM=;
        b=iIyTkjOhTHhSLBANd3ktVMHjGvkWzUCVg2NL2nzE8aYeVEP3IJgOqRlBg5EIxTTCp1
         XfPQ+Np371cJlIcEEqZTx3M5LyMHTqCrN5CfLH84DXH2UnvweySjdF5JO9kdhuYU0W03
         /jkKDv3vM2Y7JrNpRf3lqL0pQg+ChSte2C2EPKbYLMTrOCItUggdYTl3qGThV7lZ1Mes
         SN9mS/9Y9m1jHolJNrVmbrGPs22qPdO7p9dC1W6aqC7+pg6dJhrSKZdBE+5CH4zX56pR
         smfJMDqePYS+99nfw0wKkxdZq43Zr4IMwSi1OBFWd5g9blYTK2nRPPN5ierQvsa/FXOH
         vh3w==
X-Gm-Message-State: APzg51CFAXjSZDWoXV+TG+RgRuupj7XGdRz105q5oGYpdxTTti4gcx5P
        qdMqq7Mzwb4wfyjq7ER+GHW1bzsD0lbryehL9kw7nw==
X-Google-Smtp-Source: ANB0Vdaf8Idurcznk5YtDLPfc3wSNwkk/EM38fHQEvaTSZV7gGS3btrl9aqqjmEiWL4FQt9MVYVTVNzF2ZjQ6Feh9tA=
X-Received: by 2002:a24:7605:: with SMTP id z5-v6mr6384266itb.62.1537293573614;
 Tue, 18 Sep 2018 10:59:33 -0700 (PDT)
MIME-Version: 1.0
References: <955f404f-83ed-758e-017b-d6b4a1f69ef7@catalyst.net.nz>
In-Reply-To: <955f404f-83ed-758e-017b-d6b4a1f69ef7@catalyst.net.nz>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 18 Sep 2018 19:59:07 +0200
Message-ID: <CACsJy8Cbp+1-CXMup4m=qLgJA511X0NtM51sFma_8nmp4_EhKg@mail.gmail.com>
Subject: Re: Cannot negate `*` ignore pattern for directory with space in the name
To:     victorengmark@catalyst.net.nz
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 18, 2018 at 6:13 AM Victor Engmark
<victorengmark@catalyst.net.nz> wrote:
>
> To reproduce (from <https://unix.stackexchange.com/q/469708/3645>):
>
> $ cd "$(mktemp --directory)"
> $ mkdir foo\ bar
> $ touch foo\ bar/test
> $ git init
> Initialized empty Git repository in /tmp/tmp.iGmBR6y2xR/.git/
> $ git status --short
> ?? foo bar/
> $ cat > .gitignore << EOF
> > *
> > !foo bar
> > !foo\ bar
> > !"foo bar"

No need to quote, either with double quotes or backslashes. They are
interpreted as literal " and \

> $ git status --short
> [no output]

It's not exactly a bug, more like a trap. '*' matches anything, at
every level. So even if you negate 'foo bar', when we check 'foo
bar/test', '*' pattern applies again and ignores 'foo bar/test'. If
the first line in .gitignore is /* instead of * (to keep match
anything at the top level directory only), then it should work.
-- 
Duy
