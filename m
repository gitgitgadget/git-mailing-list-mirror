Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04AE7201C2
	for <e@80x24.org>; Tue, 14 Nov 2017 03:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751561AbdKNDDz (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 22:03:55 -0500
Received: from mail-qk0-f179.google.com ([209.85.220.179]:48349 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751191AbdKNDDy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 22:03:54 -0500
Received: by mail-qk0-f179.google.com with SMTP id a142so22411588qkb.5
        for <git@vger.kernel.org>; Mon, 13 Nov 2017 19:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZsAVh7w9bvRpWlSm9BeMgOHU9sRr0BB7m9qe+MNpTCI=;
        b=bd91e+QENL+XHjEmMj3hHYmWtH8NQ3KsWCjcJ6eoB+fV6BTqS4blLu42ChIpX/6P5w
         btynGWGjENF/6YjjqqXi954o08zANiVfsn0wSqc8rhwFw2R7/79JWBOynWgelWf6tOYO
         xZSvu5L+PZjP8Q5uYLIbZV35SUiZ1mm84j+NLT0TwKuLvDx1V0wEqsu3JiFd/oKqezmM
         Ec5om7ECkD39HGOe32npXjpJ0gSAtE2rCClcOviwfJBCjbyRzU+YiOSRcsFgUa2q611D
         hix0MzbhE09em5P1VunWZ4Tgfen0y2wtumMIwzJMLPG9KRhYLYaCovfuUCQSIsAOKH4F
         fTIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZsAVh7w9bvRpWlSm9BeMgOHU9sRr0BB7m9qe+MNpTCI=;
        b=A++R9Gr5eMMdptOdbKlKbAO4ngkPumpuEm3rskV39vMhjCUl6JvrksVjML5Qr69U9Z
         JLKI46YPW1czS3dyo3MZqJ7d7eJIc4PmattL6rISAQiOW+AkCx3M1A9TmqHddnnWMqpA
         t0xhyzhDISULTHClC9wNvavQB9ctdRL+y33gmv6zlcc6A0roKhLeyAOW3xGlYzHKTTs2
         kziJX42UDkOpq65XOuKX1oKfNqVuu+bAiuQ+tmDkByuK637PpGZ3MQLsm4JGvEHJwJNF
         zMDQUXYNFl/ye11WdLnVPNCBjnrlfPC9xuRJ6ID2/+kxpVhJw884gRtYRyoysgIKYgEz
         Iy2g==
X-Gm-Message-State: AJaThX5/HOHN/7tNyzLgGsdGRewgQXH6nt/LlDVkayeqAWIgeMXgKvbi
        k7ETa0UjZTX90CMXsYZErBo=
X-Google-Smtp-Source: AGs4zMYJfQHOVA/LkKP4Kx9VA7NKQMX530NyeunXazB1sgharbYHyLarZ9JBog5vaVpggq08qX8ofQ==
X-Received: by 10.55.169.210 with SMTP id s201mr9124132qke.124.1510628634122;
        Mon, 13 Nov 2017 19:03:54 -0800 (PST)
Received: from zaya.teonanacatl.net (pool-173-67-181-41.hrbgpa.fios.verizon.net. [173.67.181.41])
        by smtp.gmail.com with ESMTPSA id g47sm12030969qtk.37.2017.11.13.19.03.53
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 13 Nov 2017 19:03:53 -0800 (PST)
Date:   Mon, 13 Nov 2017 22:03:51 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Santiago Torres <santiago@nyu.edu>
Subject: Re: [PATCH] t/lib-gpg: fix gpgconf stderr redirect to /dev/null
Message-ID: <20171114030351.GS5144@zaya.teonanacatl.net>
References: <20171113210745.24638-1-tmz@pobox.com>
 <xmqq60ad7ewx.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqq60ad7ewx.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> **Blush**.  I should have caught this during the review.  Thanks.

I've written that code myself in the past and I am sure I will do it 
again. :)

> I wonder if this line in 3320 is doing what it meant to do:
>
>    test_must_fail git notes merge z 2>&1 >out && 
>    test_i18ngrep "Automatic notes merge failed" out && 
>    grep -v "A notes merge into refs/notes/x is already in-progress in" out

That's a fine question.  I only grepped for 2>&1 >/dev/null.  Dropping 
/dev/null, as you did only turns up that test as an additional hit.

I think, based on a very cursory reading of the test, that it's 
intending to direct stderr and stdout to the file out.  The test gets 
lucky that the code in builtin/notes.c directs the error message to 
stdout:

        printf(_("Automatic notes merge failed. Fix conflicts in %s and "
                 "commit the result with 'git notes merge --commit', or "
                 "abort the merge with 'git notes merge --abort'.\n"),
               git_path(NOTES_MERGE_WORKTREE));

Perhaps that should be using fprintf(stderr, ...) instead?  (And the 
test redirection corrected as well, of course.)  If that seems 
correct, I can submit the trivial patch for that as well, while I'm on 
the subject.

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Chaos, panic, and disorder - my job is done here.

