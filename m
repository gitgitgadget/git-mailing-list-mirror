Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91D061F404
	for <e@80x24.org>; Mon,  9 Apr 2018 17:36:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752283AbeDIRgi (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 13:36:38 -0400
Received: from mail-yb0-f179.google.com ([209.85.213.179]:34770 "EHLO
        mail-yb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751653AbeDIRgh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 13:36:37 -0400
Received: by mail-yb0-f179.google.com with SMTP id b14-v6so1636707ybk.1
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 10:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=c6jxE06XARPuf640pA/vDA71YVQZIzXAhVvT8xl/vpw=;
        b=vAByUq3vF/RFBrlSc/wbZydEB7rmNmluQnN7Dnn1cg4++2P5XsWSAW0HSMveqZ3noc
         0ri0NQUO0iB4KUAsQ3/jekQ5spgbkz+uP0WkFZFxE6sZBlWv5Gn7f5ZdE7IWM9RRZi5f
         y65iZ7gNbM7X3aiWktY78B8mCUHToYfqVI7KY6S8JeykeTPGrw3yhcSXG2YMli1fW0JT
         Zn7p/ep9EVLpG5XL39ggz2bnF1eNOKY75W5OPQpGtw7HhRw+OAnIXJ6v2w3GO89lQKPC
         cBY+zW53U2yJNqq6BFPAK8y/KA22KbClASHTbos2YYxaNq6d0zcr9sy1AkZf98LD2MUf
         x5YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=c6jxE06XARPuf640pA/vDA71YVQZIzXAhVvT8xl/vpw=;
        b=Cse5XDwc2QIedGOzwpVh/DWzN1SjR4lwHcgz0qmUEAZTT10b05iFxQmNHQdvh143an
         xbiVO00YlA3LIR7wIiFRmgamFKvDEOIR2vlnmYW/gWezVp4jBhqVUgMZrQ8Dn5tyODSX
         sIyDMeEwbpTa2DphC5adCiE1t8JuJKbkCPntR9iXGNP0V/rp+H/4+/P9zcrQf8F5ytU1
         bgaxUbMIhhgfCAkXF17yeipw/s462gnJD75pKA1IFw1raG4RUz4LSq8vgRL5D6SkCLaa
         tM4lw3H1fq5eG+KPeFIGkZOHQYdwTfjSK//QjRJpRFjOpN7quSSp5ZF9j/qH+hPd99H9
         KF7A==
X-Gm-Message-State: ALQs6tDMiAHzi7x/8liNPqhzhU6V5VMXyNZ67YP2xfQ+z+Wnmgltfsjn
        hp02hYqKmvV4nPzLZJMuRrTjb2addk9VcWc5TaUADJWn
X-Google-Smtp-Source: AIpwx4+E0CprNmobxO6tM4HKMRNgnJ+JbnMov9+Mg8apAZtp3DX6cQPUrs8JpiUxgxXRF797WAabj0yYBgqD7FIF34E=
X-Received: by 2002:a25:ba51:: with SMTP id z17-v6mr17967591ybj.334.1523295396508;
 Mon, 09 Apr 2018 10:36:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf81:0:0:0:0:0 with HTTP; Mon, 9 Apr 2018 10:36:35 -0700 (PDT)
In-Reply-To: <nycvar.QRO.7.76.6.1804091038430.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180406232136.253950-1-sbeller@google.com> <nycvar.QRO.7.76.6.1804091038430.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 9 Apr 2018 10:36:35 -0700
Message-ID: <CAGZ79katzVNaC-9qScniMqhBgtT9mD=o=xZffTf6q8=vq08tpg@mail.gmail.com>
Subject: Re: [RFC PATCH 00/19] object-store refactoring 3 (replace objects,
 main ref store)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

+cc list

On Mon, Apr 9, 2018 at 1:39 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Stefan,
>
> On Fri, 6 Apr 2018, Stefan Beller wrote:
>
>> See cfc62fc98c (sha1_file: add repository argument to link_alt_odb_entry,
>> 2018-03-23) for explanation.
>
> "See ... for explanation." ... are you going full Russian on us? ;-)

That commit is supposed to merge to master now, so we don't lose it.
I just dislike to repeat myself, and there we explained that trick already.
As commit messages don't link well together in email clients, I will
repeat the important part.

Thanks,
Stefan

>
> Ciao,
> Dscho
