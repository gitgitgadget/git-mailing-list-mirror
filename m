Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC1DE20281
	for <e@80x24.org>; Mon,  2 Oct 2017 23:34:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751199AbdJBXeq (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 19:34:46 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:43940 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750984AbdJBXep (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 19:34:45 -0400
Received: by mail-pg0-f52.google.com with SMTP id s184so2118137pgc.0
        for <git@vger.kernel.org>; Mon, 02 Oct 2017 16:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Q0B1486PM30x2S5U3ll6TGV7ymn2hT7PWby+rl0aRgM=;
        b=oKrfAh8OIZniw+rk6Gl4+nf4/He67MCqD1MOm3DVdT8LJVNNwOL17t5q50jDBt08yH
         xYHHJ2ZLkJhUZdNpsO66ndgIZwI9jyT3hwElIPa/l5CbBEhCWOH4SqhwS4X/zENaSv6U
         AiCp8ZL7xCr4EJQu69uGk6nyPQCLEmAr/j8FiN3QdopM8rpK0SQcYdAYB2YUMG06Wg4w
         l9F3oyCHoJqdWuzKKXWL/EtlFvGQ3lAO8/0EW+nSMrqxY171GoYtHzrVlVpS0j+dMo6v
         VQYP5yNe3mga8zcYUql8l3WsFL+tXTI/+RPuBrrk5sPAehBoHgHXPKSbZbgFO5yp8fMX
         3XWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Q0B1486PM30x2S5U3ll6TGV7ymn2hT7PWby+rl0aRgM=;
        b=uSSza4S7gpNWJ6aXQk0fDEpQryA6go1r/c8Qriv/JL3VsP7IgnoAuaHkfRkHebPUqm
         IUnyMp0rwIwdQlyXb3J1kOY+dbszBsSCW95r59UT2Hg3ENICeZo/zqC7+HuTeP2mfiJG
         KPBKCv3pGR2IDKmlytamGaysr00ZFFyxr60fB24a3QCPqtAZ35RU8Fu+8DAbXq/SQ36j
         euh2Sea7TbP4BZ/ECuZ86OeP0GOCcp3m4QF38FtEI59KrEaUp9b2KPdVqtHWXXgRtXQw
         5t4RzjStq+KkF9bSeU8bUGDsEv3acFT7LLDgj53ksdFVoFlUXC5XIXDb/hmerF5bxK03
         G9cQ==
X-Gm-Message-State: AHPjjUj+WeCCqK/9sxzH+ejw5cXgZcb07TI4HiyDJPvMn04tcWyliBcW
        mqOm1V0/kle9aOSb+nWKQRZ5jQ==
X-Google-Smtp-Source: AOwi7QBWATDW5brF1bbnV/ovtf22rggxJ72ggDrUKleqcidDKJMoVl8U9L5RnCnD5VjPqtvwhR2I6g==
X-Received: by 10.98.20.78 with SMTP id 75mr15511372pfu.239.1506987284558;
        Mon, 02 Oct 2017 16:34:44 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:585e:6aa2:d831:b9e9])
        by smtp.gmail.com with ESMTPSA id n12sm19108263pfb.131.2017.10.02.16.34.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 02 Oct 2017 16:34:43 -0700 (PDT)
Date:   Mon, 2 Oct 2017 16:34:42 -0700
From:   Brandon Williams <bmwill@google.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 00/24] object_id part 10
Message-ID: <20171002233442.GE5189@google.com>
References: <20171001220831.214705-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20171001220831.214705-1-sandals@crustytoothpaste.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/01, brian m. carlson wrote:
> This is the tenth in a series of patches to convert from unsigned char
> [20] to struct object_id.  This series mostly involves changes to the
> refs code.  After these changes, there are almost no references to
> unsigned char in the main refs code.
> 
> I've tried to update the code comments as I've touched them, but if I've
> missed any, please point them out.  A big thank-you goes out to René
> Scharfe, who did the work to make resolve_ref_unsafe optionally take a
> NULL pointer; this dramatically reduced the size of one of the patches,
> and allowed a few others to be dropped during the rebase.

Aside from a few unimportant style nits the series looks good to me!

-- 
Brandon Williams
