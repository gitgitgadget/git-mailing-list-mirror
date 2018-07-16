Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB41A1F597
	for <e@80x24.org>; Mon, 16 Jul 2018 15:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbeGPPtt (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 11:49:49 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:38629 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727265AbeGPPtt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 11:49:49 -0400
Received: by mail-yb0-f195.google.com with SMTP id i9-v6so15554861ybo.5
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 08:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CfhFcHV8WCCGH9HsJ6aEvDUivoy8qcY6evVVX8v3gq8=;
        b=kW2d3Fo3UB5njMrbVD9eKTWhFJw2QHauyx6qRSvjqArg4hom7H6XE/VJKSzO3DCUSw
         T0CrQIqTHEJXWO8trhfFqT1E4LD7cMeyAQlqR6FJZyOwJxgsZnY/4ahkiWzVWOx1nvi6
         vdUKX6DBEJWnOwVItmFeJuYyG8hS6eKWQ3ejbTE1spds3QD9QE4wW0B290cH0xA2g+8z
         jYgClQnVd2riFgZ0ZT2Ne/JL3VXFPzkmUq7hOeEO99BKSgIpr4KbaZ392f1Ev22ZtkNn
         TmK4VrqxjryVeHv21ymKf8xhmYCcqa72Qq9oL9K/I+qtzfBJOZlPab8xPxjvs9ErZcul
         Gpwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CfhFcHV8WCCGH9HsJ6aEvDUivoy8qcY6evVVX8v3gq8=;
        b=skVY+Mx41/VDcjL4uQfoHfvZeUZhOPppkawWhX1SXJkzmoGWVr3/IqOb0R2iHs04jE
         Ko0Qoef8Zz++0bhkKfJ8EXY93HE0JuYB5F4RcRjHEYMIuF5i79SqqZbvJVEzANSdx+70
         48DXJi469HD46dhW2J1cNs9mJwVg3O6CpWDtP8a4311zgFQIEv/mtFFNk0Rtts5PKeHL
         LSZyymxxU8Biq/ZhHlldsndrSGRTkIbBCjk1gNS8FFztZIskYBWDTHcreAtdnQJRklYT
         t8iJFUp6ao4blTvtf+D6L8FkAGYJqlY7Jug/BzhRiiaYHp09GWDNReLsXMW3l8t6CY9O
         umiQ==
X-Gm-Message-State: AOUpUlG4k1/0g07wGu16UQbuYnQa7mbds0aSE5egkPVkh40pTKhuUy2T
        8FdFAeu1tXxlgW5FlN3BCSIKEA==
X-Google-Smtp-Source: AAOMgpferVaaO8TCvpxhJWLLPlroZq/brbD1TxwPtDPoYO6g6mgIaV13pH9ypOO28WdjTQsIlCVqIw==
X-Received: by 2002:a25:ad9a:: with SMTP id z26-v6mr8834987ybi.246.1531754514529;
        Mon, 16 Jul 2018 08:21:54 -0700 (PDT)
Received: from localhost ([107.217.158.181])
        by smtp.gmail.com with ESMTPSA id c5-v6sm8606108ywk.40.2018.07.16.08.21.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 08:21:53 -0700 (PDT)
Date:   Mon, 16 Jul 2018 10:21:52 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v2 00/16] object_id part 14
Message-ID: <20180716152152.GA51419@syl.attlocal.net>
References: <20180716012808.961328-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716012808.961328-1-sandals@crustytoothpaste.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 16, 2018 at 01:27:52AM +0000, brian m. carlson wrote:
> This is the fourteenth series of patches to switch to using struct
> object_id and the_hash_algo.  This series converts several core pieces
> to use struct object_id, including the oid* and hex functions.
>
> All of these patches have been tested with both SHA-1 and a 256-bit
> hash.
>
> Most of these patches are fixes for things that will clearly cause
> segfaults or other very obvious breakage on a Git with a 256-bit hash.
>
> Changes from v1:
> * Drop patch that's been replaced by one from Ben Peart.
> * Update patch handling hash* and oid* functions.

Along with Derrick, I also read this series and found it to be without
problems. This looks good to me, too.

Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
