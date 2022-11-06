Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E90B7C4332F
	for <git@archiver.kernel.org>; Sun,  6 Nov 2022 19:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiKFTP4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Nov 2022 14:15:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiKFTPz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Nov 2022 14:15:55 -0500
Received: from mail.cboltz.de (mail.cboltz.de [88.99.101.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32BDB867
        for <git@vger.kernel.org>; Sun,  6 Nov 2022 11:15:52 -0800 (PST)
X-sprachakt.com-SMTP-Auth: no
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.cboltz.de (Postfix) with ESMTP id 6D59E5C0400;
        Sun,  6 Nov 2022 20:15:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at mail.cboltz.de
Received: from mail.cboltz.de ([127.0.0.1])
        by localhost (mail.cboltz.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id u00YxQQ4x6hb; Sun,  6 Nov 2022 20:15:49 +0100 (CET)
Received: from [192.168.178.41] (i59F7FFCC.versanet.de [89.247.255.204])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by mail.cboltz.de (Postfix) with ESMTPSA;
        Sun,  6 Nov 2022 20:15:49 +0100 (CET)
Message-ID: <15a2baf8-53f6-de75-a6bf-ecb4a83d78c4@opensuse.org>
Date:   Sun, 6 Nov 2022 20:15:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: git can not be built for s390x since update to git-2.38.0
Content-Language: en-US
From:   Sarah Julia Kriesch <sarah.kriesch@opensuse.org>
To:     git@vger.kernel.org
Cc:     andreas.stieger@gmx.de, tmz@pobox.com
References: <64b10e7e-2807-8ae5-88c7-3df7f6f1f3bd@opensuse.org>
In-Reply-To: <64b10e7e-2807-8ae5-88c7-3df7f6f1f3bd@opensuse.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It seems, that I did a mistake.
I thought, that I have tested it based on openSUSE Factory without 
excluding the tests.
It is failing continuously with adding the tests.

I have seen, that Fedora is excluding many tests additionnally for 
s390x. That is another difference in the spec file:
https://src.fedoraproject.org/rpms/git/blob/rawhide/f/git.spec

We have also identified this week, that chainlint.pl --stats says "0 
tests". That can explain the empty output.

~/rpmbuild/BUILD/git-2.38.1/t> /usr/bin/perl chainlint.pl --stats 
--emit-all chainlinttmp/tests
total: 0 workers, 0 scripts, 0 tests, 0 errors, 0.01s/0.01s (wall/user)

Best regards,
Sarah

Am 06.11.22 um 19:32 schrieb Sarah Julia Kriesch:
> > Gesendet: Mittwoch, 02. November 2022 um 19:49 Uhr
> > Von: "Todd Zullinger" <tmz@pobox.com>
> > An: "Sarah Julia Kriesch" <sarah.kriesch@opensuse.org>
> > Cc: git@vger.kernel.org, andreas.stieger@gmx.de
> > Betreff: Re: git can not be built for s390x since update to git-2.38.0
> >
> > Sarah Julia Kriesch wrote:
> > > I am one of the zsystems Maintainers (s390x architecture) at 
> openSUSE and
> > > git can not be built any more since the update from 2.37.3 to 
> 2.38.0, and
> > > with 2.38.1 afterwards. We have tried to debug it.
> >
> > I don't know if it's of much help, but for what it's worth
> > 2.38.0 and 2.38.1 been built in Fedora for s390x without
> > issue.  Build logs and artifacts for 2.38.1 can be found
> > here:
> >
> > https://koji.fedoraproject.org/koji/buildinfo?buildID=2077983
> >
>
>
> Best regards,
> Sarah
> > --
> > Todd
> >

-- 
Sarah Julia Kriesch
openSUSE

