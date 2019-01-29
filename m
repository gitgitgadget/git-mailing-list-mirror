Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2BB51F453
	for <e@80x24.org>; Tue, 29 Jan 2019 01:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfA2BwM (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 20:52:12 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37612 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbfA2BwM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 20:52:12 -0500
Received: by mail-ed1-f68.google.com with SMTP id h15so14710471edb.4
        for <git@vger.kernel.org>; Mon, 28 Jan 2019 17:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kiHuRMlZ1IlZYsSgZ4BV4JETkNxtru4PsPXViTN9X0U=;
        b=FigQ0HJlb6Hmr4F7jokDSpPIYfzSDyplbpTfZR9ul0oR5Yv3SPLI4fKcfAQ5/kVkIi
         EThC6hrzeliZdD3sgWv8rVYVJMFrDtxqg+Gn94LqQIfqSgCLGpiazHUfVTS4EbKWkjm+
         nVmzpcsBtIabeukuTi6FEKY8Wp4HukFODFRBGyJeE+9tBTpSeA9hhZ+oP/epmFeS/h2+
         Ip1fX1eQ2wBLo1H/KzKCxUqSO0LttsJJv/b8CAFE2XLSbIZeqpWbNHhpSGzyaiSgOwqR
         9+R9ibCBfErorBfcA7Euiz/1SBKAu6+4oAWIeJAeDtJ8HSw5/HBNw2atXe5aGjbaSsxa
         wkYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kiHuRMlZ1IlZYsSgZ4BV4JETkNxtru4PsPXViTN9X0U=;
        b=ECzL4JZ/TN3K3KQ0l3jOaF71A4KUZkU4OO+onqDmCduXSqNS+nbC/gyo9JZLXVIBLv
         S9MCLxLX3Vfb3gPmnGzCPG4DsMorFW73zDxaevoKDEEJIRDLThIdQ3z7e21YfU1n8ms+
         lAdVqX1yn0AO7d5gNKDchMFYtIdQmYga4ERSVLjD0NeDtF6tmwZ2CNqdvJBuXQMv3m86
         ZN3NHy9AFi/DjZP/FIuCBhscCqiHTqYAufknskwRVFfkw/9Djk53WQedw+BqMjORgGkp
         hyDiihHarmAOMHuq1dJTKrA7wlJbpa16w4unn8Q/0CRZ9r4FjjJNobozD+og2lJojhzl
         hH/Q==
X-Gm-Message-State: AJcUukdcZBN5Z9vXzvSS+V9uF1P2m/VGABFSwtgVhNpUKc8CFf26RKNL
        VZZRROscloR8xQR6CzUfZQg=
X-Google-Smtp-Source: ALg8bN7FSRKDg8niFpEP6KTeo/v8D3zr4dDO3RiAPiMDTmBtc+NX895pDbw6cjunIZjKpkZ+B3fwsA==
X-Received: by 2002:a50:a982:: with SMTP id n2mr23102851edc.236.1548726730964;
        Mon, 28 Jan 2019 17:52:10 -0800 (PST)
Received: from ltop.local ([2a02:a03f:40eb:400:2585:e198:b6f8:6c4e])
        by smtp.gmail.com with ESMTPSA id g21sm14397937edc.63.2019.01.28.17.52.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 17:52:10 -0800 (PST)
Date:   Tue, 29 Jan 2019 02:52:09 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: sparse job, was Re: [PATCH] test-xml-encode: fix sparse NULL
 pointer warnings
Message-ID: <20190129015207.6emajopy7xqmqo4j@ltop.local>
References: <68a8c70e-dc42-1df3-3616-c096f63cb848@ramsayjones.plus.com>
 <nycvar.QRO.7.76.6.1901281706440.41@tvgsbejvaqbjf.bet>
 <a6b689da-b002-0aa2-e9d6-755d004bc320@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6b689da-b002-0aa2-e9d6-755d004bc320@ramsayjones.plus.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 28, 2019 at 08:13:03PM +0000, Ramsay Jones wrote:

Hi

> The dependencies for the 'sparse' package includes: libc6 (>= 2.14),
> libllvm4.0 (>= 1:4.0~), libxml2 (>= 2.7.4), perl:any
> 
> However, for git, we only need to build 'cgcc' and 'sparse', which
> means we can forget about libxml (only used for c2xml), and libllvm
> (only used for sparse-llvm/sparsec/sparsei). Also, I'm not sure what
> perl is doing there ...

perl is only used as the interpreter of cgcc.

> 
> Note that these dependencies (along with the dependent programs) are
> optional and I can happily build sparse without them:
> 
>   $ make clean
>   Makefile:124: Your system does not have libxml, disabling c2xml
>   Makefile:146: Your system does not have gtk3/gtk2, disabling test-inspect
>   Makefile:179: Your system does not have llvm, disabling sparse-llvm
>     CLEAN
>   $ 

Absolutely.
 
-- Luc (sparse's maintainer)
