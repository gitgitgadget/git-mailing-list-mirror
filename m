Return-Path: <SRS0=7IA6=Z3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E1FC43603
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 17:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EFF722525
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 17:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730135AbfLERdX convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 5 Dec 2019 12:33:23 -0500
Received: from elephants.elehost.com ([216.66.27.132]:36107 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729396AbfLERdX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Dec 2019 12:33:23 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id xB5HXJ7u048491
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 5 Dec 2019 12:33:19 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Nathaniel Manista'" <nathaniel@google.com>, <git@vger.kernel.org>
References: <CAEOYnAQYMrNAe9s1V-0DVLdL-B_KpHMDP5e=yRnbCkMWdrvFHQ@mail.gmail.com>
In-Reply-To: <CAEOYnAQYMrNAe9s1V-0DVLdL-B_KpHMDP5e=yRnbCkMWdrvFHQ@mail.gmail.com>
Subject: RE: [ISSUE] Stop accessing, storing, and sharing the user's time zone
Date:   Thu, 5 Dec 2019 12:33:13 -0500
Message-ID: <047b01d5ab92$159a8240$40cf86c0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGSZ87M+0b1HQfUDxVKMhYVkZ/1cqgyU9Wg
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On December 5, 2019 12:14 PM, Nathaniel Manista wrote:
> (This is also filed at https://bugs.chromium.org/p/git/issues/detail?id=43.)

Getting permission denied trying to access this.

> Affected Version: All? This has been bothering me at least a year.
> 
> What steps will reproduce the problem?
> 1. Author a commit.
> 2. "git log --pretty=fuller"
> 
> What is the expected output?
> The log will display that the timestamps of the commit have both the
> author time and committer time in UTC. Internally no part of the
> commit will have stored any time zone information and when the commit
> is shared with others no information about where the user was in the
> world at the time of the commit will be obtainable from it.
> 
> What do you see instead?
> Authoring and sharing a commit by default exposes the user's time zone.
> 
> Additional context:
> "commit --date=YYYY-MM-DDThh:mm:ss+0000" suffices to put the author
> time in UTC but not the commit time in UTC. But the user shouldn't
> have to pass a flag at all.
> 
> Where the user is in the world is PII that git ought not to record and
> make available as part of the user's software engineering (make
> available to colleagues, in the case of proprietary development, and
> make available to the world, in the case of open source). Git should
> entirely stop accessing, recording, and sharing the user's time zone,
> full stop. Failing that, git should by default stop accessing,
> recording, and sharing the user's time zone, but if individual users
> want to have their time zones on their commits, they can opt into it.
> Failing that, users should be able to add a .gitconfig line to ensure
> that all author timestamps, all committer timestamps, and any other
> information are in UTC.

My position has been UTC as the standard in all cases with storing LCT as an optional only. I like the opt-in concept. I currently am running a repository located at UTC+2, with developers at UTC-5. It is driving us a bit wonky. I would rather see only UTC.

Regards,
Randall

