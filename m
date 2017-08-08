Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4551220899
	for <e@80x24.org>; Tue,  8 Aug 2017 20:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752367AbdHHUuF (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 16:50:05 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:33894 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752205AbdHHUuE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 16:50:04 -0400
Received: by mail-pf0-f170.google.com with SMTP id o86so19087679pfj.1
        for <git@vger.kernel.org>; Tue, 08 Aug 2017 13:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kGGB2l7cL7LbykkH04MbJ/APIwc+b5i308G2eu98IB4=;
        b=WFEE+u6hoQYkzZcdc3NBDr4hmWqGabNjgdyHXkN0bxd+aVwb03NJ3ghaMoEUrrwKU0
         +aYDSCVY0gOC+YibLLPtiasAAK+BNaHa2vfWddrdlkabHUxyiwXLraWr/kM0QFKxG55h
         U24zscfuYvW2AablyNH/VYIA3FGt/HgBi/wT10BEPU8AOp9PCcVc9twNs/OPa6oqJLuw
         vy8YgSMwEKDWqJu0sTCIWmLqZlkHRHV1EUablsmmXNreXcc+GBtQXPyD2vdQ2fU4dRO2
         nC/qtLgiOyBeVnMUyUSzC/dTgglkfwdMXXLw+tCX9jAH1DE2zB+5lbqoCs/MxalbO/z6
         yXhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kGGB2l7cL7LbykkH04MbJ/APIwc+b5i308G2eu98IB4=;
        b=ThxzQPOgdfBJutIbmDf7ync1NuK5oDQ5C2hqCE167QrhmGiNlEmugYP1Q1IMFGhjbI
         6stSoEqEJo7Qf65cKgj33bv28ok14+lRbc4MEIHtsmhlNAHK6LNFnaQ9CsLJ/TT75WrD
         e3vJNv4QS8awBN5VCaNKcG4vqtiie2mWFza6AxuWzy/c60IBP2TjvhcdnIgnE57zrZ5X
         6HdV6KzWXpnfLsaclPswGZXb+ept4Ad01Ck2u92kLxevODQG+qE5yPnwWJTeS0g7vMdE
         +zDFhiKeo6dsRDQrbDNR+TyP7XqljPC+isi+8GvS1y4qlwUYCttsCt8DrD9QNv0fVLSh
         swHA==
X-Gm-Message-State: AHYfb5i4RWdPF27piw33+Mwve3szxtBx+4zTDpMisMzAqg2BHuSURX23
        gzBV9ew+3/Y2C2RK5r+1xg==
X-Received: by 10.84.231.203 with SMTP id g11mr6283863pln.199.1502225403621;
        Tue, 08 Aug 2017 13:50:03 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:3038:f339:86a3:23e0])
        by smtp.gmail.com with ESMTPSA id w189sm3525798pgb.91.2017.08.08.13.50.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 08 Aug 2017 13:50:03 -0700 (PDT)
Date:   Tue, 8 Aug 2017 13:50:01 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC PATCH 01/10] pack: move pack name-related functions
Message-ID: <20170808135001.48f2440e@twelve2.svl.corp.google.com>
In-Reply-To: <CAGZ79kYQP74fTu1hFDLyKhS-2NTbUhtirWTxRMNavgO09SenYg@mail.gmail.com>
References: <cover.1502220307.git.jonathantanmy@google.com>
        <368a1095557aa5f68cebd4d4e08628351c03b843.1502220307.git.jonathantanmy@google.com>
        <CAGZ79kYQP74fTu1hFDLyKhS-2NTbUhtirWTxRMNavgO09SenYg@mail.gmail.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 8 Aug 2017 13:36:24 -0700
Stefan Beller <sbeller@google.com> wrote:

> On Tue, Aug 8, 2017 at 12:32 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> > Currently, sha1_file.c and cache.h contain many functions, both related
> > to and unrelated to packfiles. This makes both files very large and
> > causes an unclear separation of concerns.
> >
> > Create a new file, pack.c, to hold all packfile-related functions
> > currently in sha1_file.c, and designate pack.h to hold these
> > packfile-related functions.
> 
> There are also packed refs, so one could (like I did) think that
> pack.c is for generic packing of things, maybe packfile.c
> would be more clear?

Good point. I'll use packfile.c and packfile.h in the next version.
