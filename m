Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62DB61FF34
	for <e@80x24.org>; Fri, 12 May 2017 17:35:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932250AbdELRfn (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 13:35:43 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:36837 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758791AbdELRfb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 13:35:31 -0400
Received: by mail-pf0-f174.google.com with SMTP id m17so33320323pfg.3
        for <git@vger.kernel.org>; Fri, 12 May 2017 10:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=zOcy0SWZsxbU/GcXU30z7AL60zZMlXa7VAnlZO+V7h4=;
        b=UcI1J2XgMThgoZY+Fx+DJd9Uixpk6RYD3RavgnF4VZeFWHKIda/pHjKv7vQXE2KXyA
         OIYZ3iR8DcqlVZoSlO2AU4WddZM4hGgp4FpMfm3YLrpCY/wdqEDBE4Uw3IpdMEjNsXpu
         n/VOMm+m3o2CSarUtyJGHXasSUuz3e+pHy2SL3oJKnq+LUMxVD4v33lb41kBNurmtUbh
         qOMZD1cmfoWgPTKd8YGlZriEP1/czbQi7tGamCvLujTrSPrK/bU7Bo79BmEttxcPjCrO
         PBgjkzTRZ5V81p7f+bN8FHcLIiDJn9QHlHuCLOXmwO2ep3Hq7LVWbAe1cDqIJOxk2uET
         P69Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=zOcy0SWZsxbU/GcXU30z7AL60zZMlXa7VAnlZO+V7h4=;
        b=tYdesKdJPOsoC5gmJ/zqdTs07zi9tXIGnULuqpJBRal81UYloACHQjBW/tnChPA1RQ
         hq+lnyChTGKp/lxGztOL6AOPvu8sAqEi6bZEWkFWYWWsRM8xxD1k+HBWbN0DyaFKEUYz
         ZLCQT6HFkeaMrJfrv7Q9yIh4WTENhE3AZHH5xk6SaQyJ1rR5/kuGlH7mR/m2+g6T/zc4
         q0BX52JCv78Z50iBo/sITDi7A7yme2vEqAg2kLbGFR+6RWJct80dNqvNUKzPXTH9ltCb
         sXfUiL6CO6Wv3GiU1qzYrHioKXytUyjc0l+2HPaxyuVbisEFApPS+Kj1el2aHvLGsRLR
         UNKg==
X-Gm-Message-State: AODbwcAwD2FfqBVNUodX6P14e3OW5w6KpJYeQtYFfNyMHR3WzECmIrU3
        scTJEGsfW45j6znI
X-Received: by 10.84.245.8 with SMTP id i8mr7313181pll.109.1494610530334;
        Fri, 12 May 2017 10:35:30 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:c4e0:75e9:f5fc:bc05])
        by smtp.gmail.com with ESMTPSA id p10sm6380678pgf.63.2017.05.12.10.35.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 12 May 2017 10:35:29 -0700 (PDT)
Date:   Fri, 12 May 2017 10:35:27 -0700
From:   Brandon Williams <bmwill@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Jeffrey Walton <noloader@gmail.com>,
        =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Fredrik Kuivinen <frekui@gmail.com>
Subject: Re: [PATCH 1/7] grep: don't redundantly compile throwaway patterns
 under threading
Message-ID: <20170512173527.GD98586@google.com>
References: <20170511170142.15934-1-avarab@gmail.com>
 <20170511170142.15934-2-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170511170142.15934-2-avarab@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/11, Ævar Arnfjörð Bjarmason wrote:
> Change the pattern compilation logic under threading so that grep
> doesn't compile a pattern it never ends up using on the non-threaded
> code path, only to compile it again N times for N threads which will
> each use their own copy, ignoring the initially compiled pattern.

Is there a reason each thread needs to compile the patterns as opposed
to them being compiled a single time and being copies N time for N
threads?

-- 
Brandon Williams
