Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B8B11F464
	for <e@80x24.org>; Sat, 28 Sep 2019 04:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725818AbfI1EU2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Sep 2019 00:20:28 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36586 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbfI1EU2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Sep 2019 00:20:28 -0400
Received: by mail-io1-f66.google.com with SMTP id b136so22324100iof.3
        for <git@vger.kernel.org>; Fri, 27 Sep 2019 21:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=inTQzuzffxdDTJRufhhaZ2bKjIOa0phyDihMyKaBl2c=;
        b=fjWRjdwiuY4t2ide9wkSI9FrlqYDhi4jzbRZ6CSWgt3vI0vDFaEX3u46Izz77wn8C+
         IBqoPX4QCttzksUoY8qhJkp9JnF1rPyR58eryT1i5ufEtDMhkDJTyT3vHDKn59r4RqV1
         ykX9TrnS/KpfOYB/+5wAw6UYeakGTr4al5yCtd/ayOCVurbSxvwxskoe/OeqOrqbMRB6
         qWNXIcHEbORfwleFgsU9y1/SP3bkhhxOtAMOBVK6jt76dKoNb1qIGwwFyfuuT1hgdyua
         U8sgC5IHw/d/Ex9UcMgx8u8H5ytbgLpLvIDncArfGspIy9HFtmPIEYz5BuxyHAreYZ8o
         MEZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=inTQzuzffxdDTJRufhhaZ2bKjIOa0phyDihMyKaBl2c=;
        b=NWrEYVXgVdt/QOgpPwRtsHA6fOyW59biUVE47wOgLhbnfTRSSGihN6I9Di+pbRSrag
         vF72/pXc6Ml/WNs6+++CdssWtKUl8KMiMC2TWZfSz8OfskcBjcE5TIK6PHnYbVs82wg8
         LpukQTbUh6QViRL1IEa4uJ3SB1+TFKlSoyCU9+iyqUNt++zKBc8iHKV8Kb3jbhFLnhv+
         Hx44xvkuudaZG86zFHwg/OUt877+hrl+UEsrZDXhVkNycDWCT07iawWIExBfw0fJDy82
         CGN0QYzgm8A/b8qqjopeetRU7LHWzIMF80dNrDMnymjK57Q78i44WHq4rvOkARExD12E
         cNSg==
X-Gm-Message-State: APjAAAUn89Rf+UtFsdlgPIjjEmZ3XFkNRxSc6cnwng+XLereY5IfboCZ
        NjCPpToYdyMJm6WNvNnUM6GEErnztXh1+omFzvBqoQ==
X-Google-Smtp-Source: APXvYqzVWWEZ+COSP5Kcts9Iyadwf9z1znCbAlfQb4ENBMEIWRmqCWp+AwU6WwGo2EWHc7Hty3oNqY263zpMC4+LfEc=
X-Received: by 2002:a92:868e:: with SMTP id l14mr9033016ilh.140.1569644425448;
 Fri, 27 Sep 2019 21:20:25 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1568771073.git.matheus.bernardino@usp.br>
 <xmqq36gt5qhr.fsf@gitster-ct.c.googlers.com> <CAHd-oW4u+iPFMvSGNvSJxfPLE34dQQ3x5_aQ-Y4Pd99FXR1p7Q@mail.gmail.com>
 <xmqqh857vsqz.fsf@gitster-ct.c.googlers.com> <CAHd-oW5iEQarYVxEXoTG-ua2zdoybTrSjCBKtO0YT292fm0NQQ@mail.gmail.com>
 <xmqqtv8xksrs.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqtv8xksrs.fsf@gitster-ct.c.googlers.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Sat, 28 Sep 2019 01:20:14 -0300
Message-ID: <CAHd-oW6uG1fap-T4UF17bJmjoHAqWCDq9KbY+_8a3cEnnfATxg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] grep: don't add subrepos to in-memory alternates
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 28, 2019 at 12:24 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Matheus Tavares Bernardino <matheus.bernardino@usp.br> writes:
>
> > Right, this would be the best way of doing it. However, I think this
> > is not how it's currently implemented. I if correctly understood the
> > code in this call chain:
> >
> > grep_source_load_driver() >  userdiff_find_by_path() >
> > git_check_attr() > collect_some_attrs() > prepare_attr_stack() >
> > bootstrap_attr_stack()
> >
> > it seems that the whole stack is being rebuild for every path (even
> > for paths descending in the same superproject or submodule).
>
> bootstrap is guarded with "if (*stack) return;" and prepare knows to
> rewind to the common level and push down the new ones, no?

Right, I've somehow missed this guard and the fact that 'check' is
static at userdiff_find_by_path() so the stack is persistent. Thanks
for pointing this out and sorry for the noise.
