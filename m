Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 574731F404
	for <e@80x24.org>; Thu, 12 Apr 2018 19:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753113AbeDLTgn (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Apr 2018 15:36:43 -0400
Received: from mail-out02.uio.no ([129.240.10.71]:59858 "EHLO
        mail-out02.uio.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753091AbeDLTgm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Apr 2018 15:36:42 -0400
Received: from mail-mx04.uio.no ([129.240.10.25])
        by mail-out02.uio.no with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <h.b.furuseth@usit.uio.no>)
        id 1f6i1R-000Eoq-9f; Thu, 12 Apr 2018 21:36:41 +0200
Received: from bombur.uio.no ([129.240.203.105])
        by mail-mx04.uio.no with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        user hbf (Exim 4.90_1)
        (envelope-from <h.b.furuseth@usit.uio.no>)
        id 1f6i1Q-000Cth-QS; Thu, 12 Apr 2018 21:36:41 +0200
Subject: Re: File versioning based on shallow Git repositories?
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org
References: <hbf.20180412fvfi@bombur.uio.no>
 <87d0z4b6ti.fsf@evledraar.gmail.com>
From:   Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no>
Message-ID: <4af21bcd-7a68-50df-4cce-0b050ccaeb90@usit.uio.no>
Date:   Thu, 12 Apr 2018 21:36:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <87d0z4b6ti.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 8bit
X-UiO-SPF-Received: Received-SPF: neutral (mail-mx04.uio.no: 129.240.203.105 is neither permitted nor denied by domain of usit.uio.no) client-ip=129.240.203.105; envelope-from=h.b.furuseth@usit.uio.no; helo=bombur.uio.no;
X-UiO-Spam-info: not spam, SpamAssassin (score=-4.7, required=5.0, autolearn=disabled, AWL=0.290,UIO_MAIL_IS_INTERNAL=-5, uiobl=NO, uiouri=NO)
X-UiO-Scanned: DD9064F9488E418611E3BE7344444EF5231D6D66
X-UiOonly: 977589A8EA43D896B1F4E73CEDA4D02B767CD382
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12. april 2018 20:47, Ævar Arnfjörð Bjarmason wrote:
> 1. Create a backup.git repo
> 2. Each time you make a backup, checkout a new orphan branch, see "git
>     checkout --orphan"
> 3. You copy the files over, commit them, "git log" at this point shows
>     one commit no matter if you've done this before.
> 4. You create a tag for this backup, e.g. one named after the current
>     time, delete the branch.
> 5. You then have a retention period for the tags, e.g. only keep the
>     last 30 tags if you do daily backups for 30 days of backups.
> 
> Then as soon as you delete the tags the old commit will be unreferenced,
> and you can make git-gc delete the data.

Nice!
Why the tags though, instead of branches named after the current time?

One --orphan branch/tag per day with several commits would work for me.

Also maybe it'll be worthwhile to generate .git/info/grafts in a local
clone of the repo to get back easily visible history.  No grafts in
the original repo, grafts mess things up.

-- 
Hallvard
