Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56EE120A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 15:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbeLJPUo (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 10:20:44 -0500
Received: from mail.javad.com ([54.86.164.124]:44580 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727313AbeLJPUo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 10:20:44 -0500
X-Greylist: delayed 515 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Dec 2018 10:20:43 EST
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id E2DC53E939;
        Mon, 10 Dec 2018 15:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1544454728;
        bh=tUe+ObPA33qm64ZLTAF3ysCyyN1Iw7QpYM/h4P5um9M=; l=535;
        h=Received:From:To:Subject;
        b=Ppo2ygj2zTfOTNrefAK3ez25j96AcirY4gTovPtORmLQOn1KAD510qmsixHrK1Vpb
         HTOjiQIxWPTkte1hZ51bOuyyMxWWb4eYELGTsi6DKwyT5bo8WGGRiWDKrq4MELz4eh
         Fb1p1RGXcEv+pW6u7Q48EU8S0KPz4iLQslG1ibbw=
Authentication-Results: ip-172-31-2-110;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (ip-172-31-2-110: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1gWNE6-0004rP-Ao; Mon, 10 Dec 2018 18:12:06 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     biswaranjan panda <biswaranjan.nitrkl@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Retrieving a file in git that was deleted and committed
References: <CADHAf1Y_d=-9By4jC2xd+BmWJgfGmBNUr=uSuQtfuHDrarN4kw@mail.gmail.com>
Date:   Mon, 10 Dec 2018 18:12:06 +0300
In-Reply-To: <CADHAf1Y_d=-9By4jC2xd+BmWJgfGmBNUr=uSuQtfuHDrarN4kw@mail.gmail.com>
        (biswaranjan panda's message of "Thu, 6 Dec 2018 22:49:23 -0800")
Message-ID: <87sgz58lh5.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

biswaranjan panda <biswaranjan.nitrkl@gmail.com> writes:

> I have the following scenario:
>
> On a branch A, I deleted a file foo.txt and committed the change. Then
> I did a bunch of other changes.
> Now I want to undelete foo.txt.

[...]

> I would appreciate if anyone knows how to preserve git blame history.

Provided you deleted the file by mistake and you didn't yet publish the
history, just rewrite the history, fixing the commit that deleted the
file. "git rebase -i" is a suitable way to do it.

-- Sergey
