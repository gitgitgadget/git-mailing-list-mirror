Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02C9520372
	for <e@80x24.org>; Mon,  9 Oct 2017 23:21:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755195AbdJIXVB (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Oct 2017 19:21:01 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36964 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754404AbdJIXVB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2017 19:21:01 -0400
Received: by mail-pf0-f193.google.com with SMTP id z80so12520349pff.4
        for <git@vger.kernel.org>; Mon, 09 Oct 2017 16:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=27GxXbZ5AES5HiDj/T7tWas9pXLEMR7daeJkNEqGDPM=;
        b=aB81l2G4OBXgfR6OrKtiWkfcrV+RNTXsK//NDnxXqtSoRYY3aX8ntHiUGP0vwH2zA9
         q4PkpcYGbiaGjz9Kqpqecc6SWtD9B4KD82cQRsfopCoKM+efZ4P6pMvEFI+XEBNmSOIU
         e4wbiLZRoYYF6qVI93gYgYt8rA6XDFtkKE/Tvm2+vojuShhQaHGu5TZurQVb5aJnNcg8
         npyGqG5dN/Q5x/8RWu/0fijk88ctM3o4SyfRNpWGZn3ypuD/s2bceUFJaCyrR+MYHmTJ
         OjaXj4bYYtCvyuQnzT3jAOrM6ljaUPMgmsaAHn3ZGLcEFrSjuaFgiALbXLokh9+Ge7bQ
         Jegw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=27GxXbZ5AES5HiDj/T7tWas9pXLEMR7daeJkNEqGDPM=;
        b=PMLNdZK+EDigVqgTTETOb2aln65QvjPc7VaVo/A8/QZZGdyK4n2LJywadIg2gqSVzR
         ZSn1qhJBfrdRsJi4wIS4Zw96MeEWSIVyCMYnfZY0u+dVKBLKOGZILlQQFRRPDIfvPdMp
         D7OnbymJK4RcX6DVfEdQtSOXN2/8P9Cx/gGtb9K6TQ48Jac5uSSdO/5uW1D3BdsYLeFQ
         Ganw6Uulc/atPIk8tyoC6fmnPF1oQmMr33sQQyzS30LnjHrXe98FONGSojR/01SNkdjE
         +y9DVmGwp5j7JQLIHqQtMT5haPKqCrbx5DjrDkH/Oc/+L1JT26VxFKFyFJjwZL6AxK9a
         DHaw==
X-Gm-Message-State: AMCzsaW65iVNjpxvZxsYwvPiNncMTdLrGPjbGw+C4EMnzCwXldO4wTxy
        niXGOOMupKl9AJ0pHOLUk0A=
X-Google-Smtp-Source: AOwi7QCkYZHRZo1Es4U31CyArQ3fPxnonsTkGz4XrEUiaWjxGr8kf2agc3eM7TVp04IZJGiojV2fIQ==
X-Received: by 10.84.247.133 with SMTP id o5mr9949692pll.6.1507591260506;
        Mon, 09 Oct 2017 16:21:00 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:c9c7:66a0:181:dab2])
        by smtp.gmail.com with ESMTPSA id 77sm16594195pfi.103.2017.10.09.16.20.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 09 Oct 2017 16:20:59 -0700 (PDT)
Date:   Mon, 9 Oct 2017 16:20:57 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 06/24] Convert check_connected to use struct object_id
Message-ID: <20171009232057.GJ19555@aiede.mtv.corp.google.com>
References: <20171009011132.675341-1-sandals@crustytoothpaste.net>
 <20171009011132.675341-7-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171009011132.675341-7-sandals@crustytoothpaste.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

brian m. carlson wrote:

> Convert check_connected and the callbacks it takes to use struct
> object_id.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  builtin/clone.c        |  4 ++--
>  builtin/fetch.c        |  4 ++--
>  builtin/receive-pack.c | 10 +++++-----
>  connected.c            | 18 +++++++++---------
>  connected.h            |  4 ++--
>  5 files changed, 20 insertions(+), 20 deletions(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
