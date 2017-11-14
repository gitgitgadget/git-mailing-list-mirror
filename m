Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CE341F43C
	for <e@80x24.org>; Tue, 14 Nov 2017 19:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755983AbdKNTrZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 14:47:25 -0500
Received: from mail-qt0-f171.google.com ([209.85.216.171]:54199 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755948AbdKNTrW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 14:47:22 -0500
Received: by mail-qt0-f171.google.com with SMTP id n61so28469759qte.10
        for <git@vger.kernel.org>; Tue, 14 Nov 2017 11:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ds5HKfBP7aXNGFurGqXM0niQvjIkbHI/LWlBB3u2iEQ=;
        b=XSjjyU96YUXkEA74Ea4ZhF0bfVI1BE8BgN8bkPTe67XskrYnKDqxddIjlelTH7O33s
         iiPJ4PSUD7rcpB9pOYsNFI4M1uy5zGWl/9aLu8tZIW4PxuOos1JHOyH/XELkDLeIh4Ue
         78uunjUNAyRFIAEEtxCmPQJ3+yfMpmbPlTE2+JqWsYoBLvjU+YTkOer+aCyMgxUL7+xQ
         3/OjnuKCbKqqp6THd6YHwPMxmqosANxflkhD2kLoIS/Rd51CsknkP77W0GnvWfU+aA82
         OPPJtKlv0azIWGA+KMN0iv68BmueyhbHpTDawXpaxPsfe4+avo97A1j/j0QUVjFa5Q9C
         R2JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ds5HKfBP7aXNGFurGqXM0niQvjIkbHI/LWlBB3u2iEQ=;
        b=IMwovL0/ItVtQ8RTjT3p/OuQlWup7YHTKmB0ZZwD7andv195dXUu4nd1KUPt4PNFFI
         FuWv8ujl5RLVRhbDlqXCd0wlFh8o7j+U9XEuVMRFNeIs+NduZwL9D9hpU/8Cg74MrW8y
         k8uwAB9/eAiwTNKgkIRUavrg8fAMp4QtDxesK3yhnzDVeG+WgSkmc2rdfyxAapn3CP1o
         99UhDK+TrMUPgKFLoVMm7Ebj9MlHwMmO4o1sp2xdWjJksN+7YxTH1bJKWPWoQ8NBnKvx
         J9KY8JlH6+nQtcl9nwz/fBDgUCChGulQdUTGy7aHL2EQAHtyQf1MV1jsOOqSQAxiDxfJ
         GzDg==
X-Gm-Message-State: AJaThX4rmbp/X3avCyhBHc1bFN3VCHtQ8wuafeFAxJzH8qq03hKV+tCG
        U7HamKeJ2wfKnCrsvh4MHG8=
X-Google-Smtp-Source: AGs4zMbzgXsUd9ztElBYXvDjwbeyVVdaM/fDuZxDKlODCQj4Jl5/fn0FbpqHQXBzDonD9XauovmxRw==
X-Received: by 10.55.106.132 with SMTP id f126mr20361155qkc.295.1510688841260;
        Tue, 14 Nov 2017 11:47:21 -0800 (PST)
Received: from zaya.teonanacatl.net (pool-173-67-181-41.hrbgpa.fios.verizon.net. [173.67.181.41])
        by smtp.gmail.com with ESMTPSA id z15sm12921959qti.47.2017.11.14.11.47.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Nov 2017 11:47:20 -0800 (PST)
Date:   Tue, 14 Nov 2017 14:47:18 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     Shawn Landden <slandden@gmail.com>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH] sha1: add gnutls as a sha1 provider
Message-ID: <20171114194718.GY5144@zaya.teonanacatl.net>
References: <20171114093402.29256-1-slandden@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20171114093402.29256-1-slandden@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Shawn,

Shawn Landden wrote:
> I think this is preferrable to bringing the assembly routines into 
> the git code-base, as a way of getting access to these high-performance 
> routines to a git available in Debian, Ubuntu, or Fedora (which 
> all use BLK_SHA1=1 due to GPLv2 + OpenSSL license considerations, 
> see Debian Bug #879459).

While it seems like it could be useful to have the choice of using the 
fast SHA1 implementation without concern about licensing issues, 
there's a few details I thought were worth mentioning.

Fedora moved from OpenSSL SHA1 to BLK_SHA1 to reduce the size of the 
binaries and dependencies, not due to licensing issues (Fedora 
considers OpenSSL a system library and allows linking GPLv2 code).

Fedora now uses the default DC_SHA1 (the collision-detecting SHA1 
implementation).  DC_SHA1 is not, as far as I know, as fast as the 
OpenSSL/GnuTLS SHA1, but it's safer given the increasingly successful 
attacks against SHA1.  I don't envision changing that to gain 
performance.  (And, of course, the speed of SHA1 should become less of 
an issue once git moves to a new, stronger hash.)

It looks like the Debian packages use the default DC_SHA1 
implementation as well.  Regardless of the licensing concerns 
regarding OpenSSL in Debian, I suspect they'll want to use the 
default, collision-detecting SHA1 implementation.  That doesn't mean a 
patch to add the option of GnuTLS isn't useful though.

Fedora does link with OpenSSL's libcrypto and libssl in Fedora for the 
remote-curl helpers and imap-send.  I believe the remote-curl helpers 
just link with curl, which happens to use OpenSSL on Fedora and could 
use GnuTLS instead.  The imap-send command might also use curl and 
whatever crypto library curl is built with too, but I'm not terribly 
familiar with imap-send. (I think those are the only uses of libcrypto 
or libssl in Fedora's packages, but I could be mistaken).

That's a lot of text without having anything to say about the actual 
patch.  Hopefully it's at least mildly useful to you or others. :)

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
When we remember we are all mad, the mysteries of life disappear and
life stands explained.
    -- Mark Twain

