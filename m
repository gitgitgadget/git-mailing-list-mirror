Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817FBC47247
	for <git@archiver.kernel.org>; Tue,  5 May 2020 08:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 669E62083B
	for <git@archiver.kernel.org>; Tue,  5 May 2020 08:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbgEEIHk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 04:07:40 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:41555 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbgEEIHj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 May 2020 04:07:39 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 49GXQK32mLz1qt46;
        Tue,  5 May 2020 10:07:37 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 49GXQK2bDZz1qsp5;
        Tue,  5 May 2020 10:07:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id P7gw3HjcvTIu; Tue,  5 May 2020 10:07:36 +0200 (CEST)
X-Auth-Info: 4Ift2sXWSqzs4/uK8Oj/cDBIWe7Nil6a7xQuFsCjalDQnwVm8e6NnKs9aGwr8GRa
Received: from igel.home (ppp-46-244-190-77.dynamic.mnet-online.de [46.244.190.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue,  5 May 2020 10:07:36 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 2140C2C0B74; Tue,  5 May 2020 10:07:36 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Ewa =?utf-8?B?xZpsaXdpxYRza2E=?= <kreska07@gmail.com>
Cc:     Sergey Organov <sorganov@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        git@vger.kernel.org
Subject: Re: file is showing as modified even that it was never commited
References: <CAEoQP9iY-0+=ETA0vrHL0HngccwtNA_3KX4WSSokJpOgJDGUeA@mail.gmail.com>
        <20200504055530.GA13290@konoha>
        <CAEoQP9hyMi=oj18atTJo+dR3ve_zzrLQoOja0CKAAVHei6rA0g@mail.gmail.com>
        <20200504120024.GA3372@konoha>
        <CAEoQP9gs-a1NanNpYiFQgTs0C+CeYhbD8rMjoFVat1ZSijNA2A@mail.gmail.com>
        <874ksvei1r.fsf@osv.gnss.ru>
        <CAEoQP9guAWg8E95Pi4MOih7z5rPg7OCB+_jZ6EMhJxpFsM3A1A@mail.gmail.com>
        <871rnz4eln.fsf@igel.home>
        <CAEoQP9jkP6KinqOM41zbJhV7+MbA742Xgit2ztK1OcJ78+YbdQ@mail.gmail.com>
X-Yow:  What a COINCIDENCE!  I'm an authorized ``SNOOTS OF THE STARS'' dealer!!
Date:   Tue, 05 May 2020 10:07:36 +0200
In-Reply-To: <CAEoQP9jkP6KinqOM41zbJhV7+MbA742Xgit2ztK1OcJ78+YbdQ@mail.gmail.com>
        ("Ewa =?utf-8?B?xZpsaXdpxYRza2EiJ3M=?= message of "Tue, 5 May 2020 09:49:11
 +0200")
Message-ID: <87zhamiz3r.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mai 05 2020, Ewa Śliwińska wrote:

> That is not the problem now, I worry only about those "modified" files.

Just git add them again.  Each time you git add a file, only the current
content is staged.  If you modify it further, you need to git add it
again if you want to commit the new contents.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
