Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81497C4361B
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 00:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B8D323B23
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 00:15:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725957AbgLSAOo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 19:14:44 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:57406 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbgLSAOo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 19:14:44 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <seth@eseth.com>)
        id 1kqPso-005vlB-5h; Fri, 18 Dec 2020 17:14:02 -0700
Received: from mta5.zcs.xmission.com ([166.70.13.69])
        by in01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <seth@eseth.com>)
        id 1kqPsn-00036R-DH; Fri, 18 Dec 2020 17:14:01 -0700
Received: from localhost (localhost [127.0.0.1])
        by mta5.zcs.xmission.com (Postfix) with ESMTP id 3EC6112804A0;
        Fri, 18 Dec 2020 17:14:01 -0700 (MST)
X-Amavis-Modified: Mail body modified (using disclaimer) -
        mta5.zcs.xmission.com
Received: from mta5.zcs.xmission.com ([127.0.0.1])
        by localhost (mta5.zcs.xmission.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id omGhneoNDYeh; Fri, 18 Dec 2020 17:14:01 -0700 (MST)
Received: from ellen (c-76-27-24-148.hsd1.ut.comcast.net [76.27.24.148])
        by mta5.zcs.xmission.com (Postfix) with ESMTPSA id 86CD712803E0;
        Fri, 18 Dec 2020 17:14:00 -0700 (MST)
Date:   Fri, 18 Dec 2020 17:13:58 -0700
From:   Seth House <seth@eseth.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org, David Aguilar <davvid@gmail.com>
Message-ID: <20201219001358.GA153461@ellen>
References: <5fdaef83a40ba_d0e26208f6@natae.notmuch>
 <e5c73fed-b87e-2091-794e-19aced4dd25b@kdbg.org>
 <20201217094424.GA75257@ellen>
 <5fdb3471c6bb7_d6d032087@natae.notmuch>
 <20201217175037.GA80608@ellen>
 <5fdc0e6dd79a7_f2faf208a1@natae.notmuch>
 <20201218023534.GA117762@ellen>
 <5fdc18a91c402_f2faf20837@natae.notmuch>
 <20201218054947.GA123376@ellen>
 <5fdc7a7d3a933_f4673208d0@natae.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5fdc7a7d3a933_f4673208d0@natae.notmuch>
X-XM-SPF: eid=1kqPsn-00036R-DH;;;mid=<20201219001358.GA153461@ellen>;;;hst=in01.mta.xmission.com;;;ip=166.70.13.69;;;frm=seth@eseth.com;;;spf=none
X-SA-Exim-Connect-IP: 166.70.13.69
X-SA-Exim-Mail-From: seth@eseth.com
Subject: Re: [RFC/PATCH] mergetool: use resolved conflicts in all the views
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 18, 2020 at 03:46:37AM -0600, Felipe Contreras wrote:
> Yes, with evidence and reasoning.

[Citation needed]

> Yes, but the author of diffconflicts is not infallible.
> 
> Explain why the *users* of the diffconclits tool would be affected
> negatively

You've got that right -- I'm definitely not infallible. My point isn't
that I'm right; my point is that is my *preference*. Other mergetool
authors may have different preferences.

I think where we're not seeing eye-to-eye is that you're focusing on
potential "negative" consequences whereas I'm talking about having more
information about the merge rather than less.

There is very likely no negative consequences for most, if not all,
mergetools. I wrote the initial version of diffconflicts ten years ago
and I've been using it nearly every day since. I'm fairly confident in
the end result. What is a fact is there is undisputedly less information
about the merge if we overwrite LOCAL and REMOTE; as I've written,
I think the tradeoff is worthwhile for most tools but a per-tool
configuration will allow people that feel differently to choose
differently.

This is where I will part this particular debate. If you are not arguing
for the sake of arguing and if you are genuinely willing to have your
mind changed then I invite you to reread my blog post, rewatch my
YouTube video, and reread parts this thread -- watch out for where
I talk about why LOCAL and REMOTE (and BASE) are useful.

Cheers.

