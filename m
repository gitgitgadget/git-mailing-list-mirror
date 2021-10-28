Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A4FFC433F5
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 17:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E615610C8
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 17:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbhJ1RTC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 13:19:02 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:52509 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbhJ1RTB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 13:19:01 -0400
Received: from mail.cetitecgmbh.com ([87.190.42.90]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MrQMz-1n2qm01K1n-00oaXY; Thu, 28 Oct 2021 19:16:23 +0200
Received: from pflvmailgateway.corp.cetitec.com (unknown [127.0.0.1])
        by mail.cetitecgmbh.com (Postfix) with ESMTP id 5E0781E01E7;
        Thu, 28 Oct 2021 17:16:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cetitec.com
Received: from mail.cetitecgmbh.com ([127.0.0.1])
        by pflvmailgateway.corp.cetitec.com (pflvmailgateway.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id rLdFIw-Zri6H; Thu, 28 Oct 2021 19:16:22 +0200 (CEST)
Received: from pflmari.corp.cetitec.com (24-usr-pf-main.vpn.it.cetitec.com [10.8.5.24])
        by mail.cetitecgmbh.com (Postfix) with ESMTPSA id 04A921E01E6;
        Thu, 28 Oct 2021 19:16:21 +0200 (CEST)
Received: by pflmari.corp.cetitec.com (Postfix, from local account)
Date:   Thu, 28 Oct 2021 19:16:21 +0200
From:   Alex Riesen <alexander.riesen@cetitec.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 2/2] Fix "commit-msg" hook unexpectedly called for "git
 pull --no-verify"
Message-ID: <YXra5UgxtgVubJL/@pflmari>
References: <YXlBhmfXl3wFQ5Bj@pflmari>
 <YXlD5ecNSdeBSMoS@coredump.intra.peff.net>
 <YXlTpzrY7KFqRlno@pflmari>
 <xmqq4k92w7do.fsf@gitster.g>
 <YXpFTJTo0pKhM7xG@pflmari>
 <YXpZddOixrJDd//s@pflmari>
 <edca7f6b-e89c-7efa-c6f5-2c3aaaea54f9@gmail.com>
 <YXrFaJXbuSuwfhQ7@pflmari>
 <YXrFy9I1KPz3IZyp@pflmari>
 <xmqqv91hrt2y.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqv91hrt2y.fsf@gitster.g>
X-Provags-ID: V03:K1:12//aMuvcI033katPXwuZsEzaxhALX0Mw+ZVf9s90QamUYKGi1s
 d+V1Bl6ucMiEDyVnWSma+7jEoGdkOri4yEAhXmdCaQ3gVmt0qoZVzdjDl1trEMqwHcw9kKN
 DuobL7M5aeIudyUEAp3s6/VAH/0tCYSi473eDVvgxA0b2AxlCujayXKhhXEgK0Ef+5y4UPI
 9p2Mx/yC3TCvqOz0lNMow==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vozFjNMPVAA=:GbkSogvJ5I3dUOkXhOur9M
 xK899rM6D5K2uziJx2nthiggLkPbqz8EehBQspy1J/EgdowWQSwSG+ZaKWdS36dNPSN4JuIGs
 9ShqwT3fo8AHGdR0IJ0yT5wLaSEPkcaCJQG2+xOge8CQMqdi0W+a5ImDaIrNi+Nsl5An+gdO4
 MUEGcdgO3EU4es+zidEA3yO9vTGW90CQKUaovLtbsqS0L/SZCt1N+e3TRPSMeprclT0qd5sM6
 +pVAjnAfo7kJDVL6COuEMoAvO4qDnX5b+UM+nBNeq6YC+e+RkbML5/lSLXbkUon2JbRPId2K2
 U7VuMF3xCUJGJ378Nf1V26AeZZf9jQ06GkkAjrfB0Hp4M/x14MViGsH2BGZG7AlncKYd21+6B
 AoG+RJZEJUlcScMjjgChh7x9Um9SeNeUHpB9zz5bupLfHRthFdjtgtafeHaOuWvMlnQeHazPG
 iYBUvXH/LeBQCtf8gWePDPw1RBFPVPKQPVmyC9SQNz0tNhtKq4FTCckPUQXffKs9avt+Q7xoD
 2kOWJPUPfA+NVVmgHORxRcMuIp7vuLTzxJ+ipYgHCw9wIv7db52+nzR0JLspHia6+DteqOEa7
 1n0JsKGAvkO7O0UD6dVD1jH8W2G7rgfz1tOTSm1xMtAHpsmdWe3EIO8MMb5h5WqBmF7LEiQGv
 Ts1HRwWmJnEHL7gcqVwyNYKkBxZ4k8goVGzRH3rfNQuINrEzKg0+uFnSALPJepTUI0O8DS4s7
 qpB84UssueVq07wH
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano, Thu, Oct 28, 2021 18:51:17 +0200:
> Alex Riesen <alexander.riesen@cetitec.com> writes:
> 
> > Subject: Re: [PATCH 2/2] Fix "commit-msg" hook unexpectedly called for "git pull --no-verify"
> 
> Perhaps
> 
>     Subject: [PATCH] pull: honor --no-verify and do not call the commit-msg hook
> 
> instead.

Looks fine from my side. Shall I resend?

> Looks quite straight-forward, especially that now this just mimicks
> how --[no-]verify-signatures is passed through.
> 
> Thanks, will queue.

Or did you queue it as is?

Regards,
Alex

