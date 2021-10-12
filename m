Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A058C433EF
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 23:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C45D60724
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 23:01:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235640AbhJLXDk convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 12 Oct 2021 19:03:40 -0400
Received: from h2.fbrelay.privateemail.com ([131.153.2.43]:41267 "EHLO
        h2.fbrelay.privateemail.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229588AbhJLXDk (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 Oct 2021 19:03:40 -0400
Received: from MTA-10-3.privateemail.com (mta-10-1.privateemail.com [68.65.122.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by h1.fbrelay.privateemail.com (Postfix) with ESMTPS id 08C5780116
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 19:01:37 -0400 (EDT)
Received: from mta-10.privateemail.com (localhost [127.0.0.1])
        by mta-10.privateemail.com (Postfix) with ESMTP id CFFC918000A1;
        Tue, 12 Oct 2021 19:01:35 -0400 (EDT)
Received: from [192.168.0.46] (unknown [10.20.151.214])
        by mta-10.privateemail.com (Postfix) with ESMTPA id 1EFAC180009F;
        Tue, 12 Oct 2021 19:01:34 -0400 (EDT)
Date:   Tue, 12 Oct 2021 19:01:28 -0400
From:   Hamza Mahfooz <someguy@effective-light.com>
Subject: Re: [PATCH v12 3/3] grep: fix an edge case concerning ascii patterns
 and UTF-8 data
To:     =?iso-8859-1?b?xnZhciBBcm5mavZy8A==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Message-Id: <GYZV0R.L35VU8UQBN4L2@effective-light.com>
In-Reply-To: <87a6jjlzz1.fsf@evledraar.gmail.com>
References: <20211008224918.603392-1-someguy@effective-light.com>
        <20211008224918.603392-3-someguy@effective-light.com>
        <87a6jjlzz1.fsf@evledraar.gmail.com>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Oct 9 2021 at 03:37:58 AM +0200, Ævar Arnfjörð Bjarmason 
<avarab@gmail.com> wrote:
> Are there cases where my "utf8_all_the_things" POC patch would have
> turned on PCRE2_UTF, but yours doesn't? IOW is there a 1=1 mapping 
> still
> between the encoding mode log/revision.c thinks it's in & PCRE2_UTF?

As far as I can tell, the only place where ignore_locale is mutated is 
in
setup_revisions(), so there should be a 1=1 mapping.


