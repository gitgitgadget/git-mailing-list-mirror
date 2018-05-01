Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4E5121841
	for <e@80x24.org>; Tue,  1 May 2018 09:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753918AbeEAJjh (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 05:39:37 -0400
Received: from mail-lf0-f52.google.com ([209.85.215.52]:44197 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752251AbeEAJjg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 05:39:36 -0400
Received: by mail-lf0-f52.google.com with SMTP id h197-v6so15608843lfg.11
        for <git@vger.kernel.org>; Tue, 01 May 2018 02:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=m7GpUBrUcYiiAs2UFcpXykGuYlUUT1a2BUW/tDznzBE=;
        b=lF2JjsqlA5GqfudjAeQUg8PGcVITWHYFn9lHq7wbf/FkUJBQGsPubR+xLkdvEKe1bu
         PEqOkvz0zGtk00ImcTkti1/yjPZd6F/srgVRjt/4tasEew3YZL5UOZU0RGi5/oaeS1p0
         qTRHKDZSwde4m/GmNJIQs9sBbjnGZioLp/oHv+C/yDSSFo4dzbDP8deyAhcAEIdByVHG
         ZyMgkYZrYB/5v9I8WVVWoRtCNX8oHTTEigL0UGSOVdPrgZyaedEN2cnt82YHS/jYZgxJ
         huO6/CbTcvBn+20Q8FmP+bReg5kqu9oy/zIe8K+SAV8cE5H4tMQozXHJKDuejawz2FHz
         DQdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m7GpUBrUcYiiAs2UFcpXykGuYlUUT1a2BUW/tDznzBE=;
        b=p+s2VN9yVYMWPcVvegRYky/EYoAf38r179FPqYYu/3VWiStlVsr6ouTMSg5lShKddD
         vraJBGo79y9Cf34giTW1mEr2bxbGbK0u6KK58a+FbMm/FwWRxizS/XeGGKT0UF6MKkMn
         KFivTdHNObXsh3l6WkbPLI9aAvMfVlAevHImNw5q7oZF245OnGzTQlA/sUXvsR8K3CIU
         ov0u25XB0Tf5RHZvbgeRabEWR0RNo9GrQ3189RqGsxXTmmEw9rT7Coft7es4fENp/o9G
         65rCpOJd+5RyCtIL2lcP5xFEXYF0re8wBCeluKrvug9BbBdIzT+vLZXgHSOcDBMuDYqg
         9JrQ==
X-Gm-Message-State: ALQs6tDldvzVRWyeMYulY2VJhHrY+QobhPRV8odlTvPbMaROJCVJ42cf
        kXKUWfVZRpwnoXqgEobe/sI=
X-Google-Smtp-Source: AB8JxZrWa9QPDQ7bJ34NLFmauLEI+Wfq7f9axObn0xIkZJ7V1itdAj0gWqEHp0/X9gktRDBJ5IhLow==
X-Received: by 2002:a2e:9a82:: with SMTP id p2-v6mr9598712lji.110.1525167575085;
        Tue, 01 May 2018 02:39:35 -0700 (PDT)
Received: from duynguyen.home (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id f16-v6sm1932125lfh.94.2018.05.01.02.39.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 May 2018 02:39:34 -0700 (PDT)
Date:   Tue, 1 May 2018 11:39:32 +0200
From:   Duy Nguyen <pclouds@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 02/41] server-info: remove unused members from struct
 pack_info
Message-ID: <20180501093932.GB15820@duynguyen.home>
References: <20180423233951.276447-1-sandals@crustytoothpaste.net>
 <20180423233951.276447-3-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423233951.276447-3-sandals@crustytoothpaste.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 23, 2018 at 11:39:12PM +0000, brian m. carlson wrote:
> The head member of struct pack_info is completely unused and the
> nr_heads member is used only in one place, which is an assignment.
> Since these structure members are not useful, remove them.

If you reroll, you could add that their last use was in 3e15c67c90
(server-info: throw away T computation as well. - 2005-12-04)
--
Duy

