Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9E611F404
	for <e@80x24.org>; Fri, 31 Aug 2018 03:29:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbeHaHej (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 03:34:39 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46059 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbeHaHei (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 03:34:38 -0400
Received: by mail-pf1-f196.google.com with SMTP id i26-v6so4814378pfo.12
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 20:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=MoPv5KmY/GXEYeLzLbYmx0dMaiKMcrBFv5v0Yw3tp8c=;
        b=idH4uhtQ6npn5EC5hb//TfjqlUyuJ8gJuJVSr7kZSJzgtropfc/4i+Kw4s9bA3ND9S
         EdmOB8g74A1fe1A19Oxv86EcyYFn5gMaZHV2Qme/WtIIBTrxbftHLjAP2vGAvLD7yBn0
         Xy41SCl2VXK6QboxO9uhSqXgT0IHZnt6sVZWE2cjpB3zeF/Zqe4ybEux9M9SwnGZ2cf8
         3lytsxyABCYf+5zNRG+EUoV8jaIUoA8ydueOmpNC+pc9OLEKzPn6PsUsIObbbj8hfzXN
         hnZU0qSsQoEcSbn3iVMU3evEklQi3WWpYRoK7+0M/ExEPUuS/+fWZAqcTxQIbF0jNNrH
         z7Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=MoPv5KmY/GXEYeLzLbYmx0dMaiKMcrBFv5v0Yw3tp8c=;
        b=FkLXK8ZnHrR5L9l3w2LToxbP3G3c68GNKbq7Hcoyttje3SouE8Dc+yvok6iaHLg8hM
         /x71pOer2Fij/FfH2tKNY8pUQDwLgBPlLZR+R9uktryAzQPwCJyQ9xjzNU2JbDKM/FZE
         s4oFPrnoQMV1JOkzkXTg2ILfECt1bKKpHCrWqgaLqDg6ckPk020drvQkBZuSPBUcaWPO
         IwlO+7ltb7WO1zlP9oNZVmXxXAznwmgL+3zIDxJDgrCGZKh7heVqz0Xe+zbrwHIUpk+F
         0hDOrT+xEwGMFtXZLkaxw/WhB8WJIS8C1vhaAX7ryOiHXhDss7eFjDJ0/LL5E2CiVVfx
         A8sA==
X-Gm-Message-State: APzg51BcSdEKm8eI0HD7f+VpBwxwip+/ZF0LUj9R+UkyOfEC69WXDJJI
        J1JmpvsXI6XE+6ELuvjFDvk=
X-Google-Smtp-Source: ANB0VdaQtp1BHkauRcpcsT7VzZ0DUaQIQIA+gZ5W8f3TeJO7+xFLwWQG3un4PbQEl/FGn3EhqFl2EQ==
X-Received: by 2002:a62:990f:: with SMTP id d15-v6mr13694166pfe.162.1535686159676;
        Thu, 30 Aug 2018 20:29:19 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id g21-v6sm16646593pfe.41.2018.08.30.20.29.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Aug 2018 20:29:19 -0700 (PDT)
Date:   Thu, 30 Aug 2018 20:29:17 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Robert Dailey <rcdailey.lists@gmail.com>, Git <git@vger.kernel.org>
Subject: Re: Automatic core.autocrlf?
Message-ID: <20180831032917.GC98946@aiede.svl.corp.google.com>
References: <CAHd499APYCH2r2=+M_AGKUzN0GDmrwDty4wK=Xy-utCdMrd56w@mail.gmail.com>
 <20180830045407.GB140348@aiede.svl.corp.google.com>
 <CAHd499BCk4Q4oPY=CXK=YrUbNUbz4J_KoeQngfz=92Qfc6q=eA@mail.gmail.com>
 <20180830185648.GA10427@tor.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180830185648.GA10427@tor.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Torsten Bögershausen wrote:

> My original plan was to try to "make obsolete"/retire
> and phase out core.autocrlf completely.
> However, since e.g. egit/jgit uses it
> (they don't have support for .gitattributes at all) I am not sure if this
> is a good idea either.

Interesting.  [1] appears to have intended to add this feature.
Do you remember when it is that you tested?

Feel free to file bugs using [2] for any missing features.

Thanks,
Jonathan

[1] https://git.eclipse.org/r/c/60635
[2] https://www.eclipse.org/jgit/support/
