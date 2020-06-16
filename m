Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12FDCC433E0
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 17:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2F6A20B1F
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 17:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.de header.i=@mail.de header.b="goCakhkp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbgFPRR2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 13:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727962AbgFPRR1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 13:17:27 -0400
Received: from shout02.mail.de (shout02.mail.de [IPv6:2001:868:100:600::217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51842C061573
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 10:17:26 -0700 (PDT)
Received: from postfix01.mail.de (postfix02.bt.mail.de [10.0.121.126])
        by shout02.mail.de (Postfix) with ESMTP id D1EE8C0225;
        Tue, 16 Jun 2020 19:17:22 +0200 (CEST)
Received: from smtp02.mail.de (smtp02.bt.mail.de [10.0.121.212])
        by postfix01.mail.de (Postfix) with ESMTP id ADD65A007A;
        Tue, 16 Jun 2020 19:17:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.de;
        s=mailde201610; t=1592327842;
        bh=AUPN1vAH8VDY1bW0nKXMwzmySAQ9APeP3AxPpnqaS+4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=goCakhkpYDVlSWbHMak+eYfMpA73+29krKbbTTEtW2BbR72FqDBbmKsd7+tKBqcf8
         DFpFY32AX57yhIVHHhtd2LyQ4huwDL2rUVvmrMPnj9BkHV6xkzxaVDfKbdSo/bKbJ3
         b/EJBulqLUIK+4jn2AwlltPklCkudcHL8N1OQKCo=
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp02.mail.de (Postfix) with ESMTPSA id 1ED5FA3B97;
        Tue, 16 Jun 2020 19:17:21 +0200 (CEST)
Subject: Re: Collaborative conflict resolution feature request
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Sergey Organov <sorganov@gmail.com>,
        "Curtin, Eric" <Eric.Curtin@dell.com>,
        Christian Couder <christian.couder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "Geary, Niall" <Niall.Geary@dell.com>,
        "rowlands, scott" <Scott.Rowlands@dell.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
References: <BY5PR19MB3400EB9AD87DFE612AFD5CC390810@BY5PR19MB3400.namprd19.prod.outlook.com>
 <CAP8UFD3m9ANt6UOyOoMDy2haTJjhzL5ctFiki46ktgH3RLPqjA@mail.gmail.com>
 <BY5PR19MB3400AE170C9F5FF501D27B18909E0@BY5PR19MB3400.namprd19.prod.outlook.com>
 <432b9e0b-eedf-6d39-ebc0-0416f8574afc@iee.email> <87zh943bda.fsf@osv.gnss.ru>
 <39c45b18-194c-0ff1-4a6d-1db8dee788c7@iee.email>
From:   Stefan Moch <stefanmoch@mail.de>
Message-ID: <fe2cd745-29a7-3341-d321-4199b184bc96@mail.de>
Date:   Tue, 16 Jun 2020 19:17:14 +0200
MIME-Version: 1.0
In-Reply-To: <39c45b18-194c-0ff1-4a6d-1db8dee788c7@iee.email>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-purgate-size: 3030
X-purgate-ID: 154282::1592327842-0000058E-DD0DD540/0/0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley wrote:
> On 15/06/2020 10:51, Sergey Organov wrote:
>> Philip Oakley <philipoakley@iee.email> writes:
>>
>>
>> [...]
>>
>>> Also look at 'rerere'.
>> 'rerere' is a superb feature, but isn't it local? If so, how could it
>> help for collaboration? What's the idea? Is there a way to share
>> 'rerere'?
> I saw this (rerere) is two parts. First was to ensure Eric was aware of
> it as a possible capability for use by the 'merge manager', and others,
> so that they didn't loose sight of their conflict resolutions for the
> time when the 'big merge window' came around. E.g. So a dev could do a
> local fix based on their rerere database and then send a patch to the
> merge manager indication their approach to the resolution.
>
> Meanwhile, second, at the moment the rerere database is 'local', mainly,
> as I understand it because of the number of context lines a local user
> has chosen (hence not immediately portable).
>
> I personally believe that it should be possible to some how exchange
> resolutions without that pre-optimisation of the context line choice. I
> had a look back at the old rerere script and that had small fingerprints
> of each resolution stored in the database (at least as I read it).
> However when I look at the modern rerere database it looks like it has
> full pre & post images, rather than just the conflicts, so I'm not yet
> sure what's really happening (i.e. I haven't dived into the c code).
>
> A possibly more sensible approach (to exchanging resolutions) is simply
> to do the merge, without commit, then save that merge as if it's a
> single side commit (with the other merge parent listed in the commit
> message), and that commit can then be pushed/pulled etc and a variant of
> `rerere train` can be used to recreate the local database. In a sense
> the fake merge (why not a proper merge) is a variant of a stash where
> you aren't wanting to pollute the branch trees with this extra 'flotsam'.

There is a `contrib/rerere-train.sh` script in git's repository,
that can recreate rerere resolutions from existing merge commits.

Extending the options Eric outlined, a collaborative conflict
resolution workflow might thus be:

  * developers do test merges on temporary branches between their
    feature branch and the main development – or other feature
    branches if necessary (maybe create test merges on a regular
    basis to minimize the new conflicts)
  * these temporary branches get pushed, but not merged to other
    branches
  * the branch manager fetches these branches and uses
    `rerere-train.sh` to fill the local rerere database with
    conflict resolutions from the test merges
  * the temporary branches get deleted
  * the recorded resolutions get reused when needed (keep in mind
    rerere's gc config, see gc.rerereResolved and gc.rerereUnresolved)

The last discussion on rerere-train.sh on this list was here:

https://lore.kernel.org/git/BZAQIE4YND2I.Z7BFCW7BLH3K@penguin/

