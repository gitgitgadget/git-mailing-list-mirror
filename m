Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED2171F454
	for <e@80x24.org>; Fri,  1 Nov 2019 00:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbfKAA1A (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Oct 2019 20:27:00 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51526 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbfKAA07 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Oct 2019 20:26:59 -0400
Received: by mail-wm1-f68.google.com with SMTP id q70so7792439wme.1
        for <git@vger.kernel.org>; Thu, 31 Oct 2019 17:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RV+DPX30KpZDd7hUB9KQ7C0LHPgWExxFrLaDLR0A9MU=;
        b=F6G5IBrbAwZpJXjrP8Qe1Qs+0+z6aYUoxFDAo8NU56rGkmGl7e4ZzDnlp2QOCD0XVm
         FhVajNEKuVUHaD+qmrBVTvJadJFnH0ftU5SsoB5dhNKIHNxAkkhv/ukAsCqUGRVSusXM
         Ygo920S5H6Jb2QVxP8CsZkrJLNP9sUSqTK/SbS7+P0KF4hhS47/TldHX66WTde/Svdrj
         4jqjoyMW97u9/kCYTT3cd7kL16Nfv8YLLr36LLJVuRmea7kf1xE2GriAVJT855NXwb0i
         cP9Gu0g/QUkC5vY21hmqAYW26HuByp2xhcY715/1bvEfKlvEPPRvII8gDaEwEu8r6NFq
         uYNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RV+DPX30KpZDd7hUB9KQ7C0LHPgWExxFrLaDLR0A9MU=;
        b=F/7oekGTZbXgt7cE68MgfstKzZVuCqg2GgIUkHp8XHnuxNsr/EMv7wMfU/+ngkOoMv
         +WaJvk677Fdshy168+3IlGoxwQjSTNaFAHy5jgozF8PYfOPO3jjbE1qq5cKXITo3cbHg
         aANhpViopLj41mT5vNenReBtdVHgi6ceDfzE526DURprCh90ebrHG+XZlXM5nJ2o6tkq
         yOIqaUScZVBxhwHZdZf/QqajUGoKNoyLgml5TjCqm3+HbidfFp06XEh+QYTpX1kL1c9j
         afWVy0sS3gnMkLg+H6mqlymSZI6WjbLOqhhEa69UQDxqwkFfASqdl7FUn92U1o1DaEBl
         oUlQ==
X-Gm-Message-State: APjAAAUQ4Yxfxn5FTEZTIVP9cOKszv5Y/A+3C8tHyZmdqVL32UzoyWhh
        IrloCtO8ajMB59NCiwYv+njk13sj
X-Google-Smtp-Source: APXvYqz5s/zQOo1B7mNI5CGTGTEzZZf/yVFrMhJ9+YeFkfTwoPKFR/y2+kSLhhEMjwZJvpHtPUrVuA==
X-Received: by 2002:a1c:5f42:: with SMTP id t63mr7365978wmb.163.1572568016378;
        Thu, 31 Oct 2019 17:26:56 -0700 (PDT)
Received: from localhost (host96-200-dynamic.171-212-r.retail.telecomitalia.it. [212.171.200.96])
        by smtp.gmail.com with ESMTPSA id 200sm7461392wme.32.2019.10.31.17.26.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Oct 2019 17:26:55 -0700 (PDT)
Date:   Fri, 1 Nov 2019 01:26:54 +0100
From:   Davide Berardi <berardi.dav@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Segmentation fault on non-commit objects.
Message-ID: <20191101002654.GB49846@carpenter.lan>
References: <20191029092735.GA84120@carpenter.lan>
 <nycvar.QRO.7.76.6.1910291408460.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1910291408460.46@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>Ciao,
>Johannes
Hi Johannes,

I've implemented your comments on a new patch, you can find it at[1]

Thanks.
Ciao, D.

[1] https://public-inbox.org/git/20191101002432.GA49846@carpenter.lan/T/#u
