Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 243AA1F597
	for <e@80x24.org>; Sat,  4 Aug 2018 17:41:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbeHDTmy (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Aug 2018 15:42:54 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62190 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727953AbeHDTmx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Aug 2018 15:42:53 -0400
X-Greylist: delayed 467 seconds by postgrey-1.27 at vger.kernel.org; Sat, 04 Aug 2018 15:42:52 EDT
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DF7A61075CC;
        Sat,  4 Aug 2018 13:33:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=nv3I67raZoDFrq43jj2XlqmmJko=; b=YUka3hG
        aNrqIgdehT/uTR6dyaG7WcaaplIJUpASrxYlIBMnfRnwn7c8uG2iNuBPYOwPvg+Z
        MUnSiLYQabYlK1gL0ZOcuQzORFpda0R8oXIdlTp6h80qsUxfW4u3PFf533lKbDBP
        GrErfQf3gGNrTdJwjaO02TN2PyCePRyRlGA8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to; q=dns; s=sasl; b=tfqUiIq4v7q3uIS/mq2Km3rTyKldY4adx
        cbmnvoF31DCccRY7KuyMiZ4xhTZ1OZKkpPXf5g8FdutUqvA3ZH4CrkeVpUBm38n/
        gJgcYzLQJStY8cJTghTyFGAobM9HTI0De5A5skExt4LFxlHxilbyIu1N5RQTMuBc
        uHUc2WSBbI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D878A1075CB;
        Sat,  4 Aug 2018 13:33:42 -0400 (EDT)
Received: from zaya.teonanacatl.net (unknown [98.111.125.125])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 615991075CA;
        Sat,  4 Aug 2018 13:33:42 -0400 (EDT)
Date:   Sat, 4 Aug 2018 13:33:40 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Edward Thomson <ethomson@edwardthomson.com>,
        git@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] recover: restoration of deleted worktree files
Message-ID: <20180804173340.GK3764@zaya.teonanacatl.net>
References: <20180804142247.GA7@e3c0ce5ceb57>
 <20180804142416.GA6@5f28dc333bbd>
 <xmqqpnyyt9di.fsf@gitster-ct.c.googlers.com>
 <alpine.LFD.2.21.1808041214550.28242@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1808041214550.28242@localhost.localdomain>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Pobox-Relay-ID: 8810AD12-980C-11E8-A325-BFB3E64BB12D-09356542!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Robert P. J. Day wrote:
> On Sat, 4 Aug 2018, Junio C Hamano wrote:
>> In other words, I think this patch can be a fine addition to
>> somebody else's project (i.e. random collection of scripts that may
>> help Git users), so let's see how I can offer comments/inputs to
>> help you improve it.  So I won't comment on lang, log message, or
>> shell scripting style---these are project convention and the
>> git-core convention won't be relevant to this patch.
> 
>   not sure how relevant this is, but fedora bundles a bunch of neat
> utilities into two packages: git-tools and git-extras. i have no idea
> what relationship those packages have to official git, or who decides
> what goes into them.

For anyone curious, those packages (git-extras and
git-tools) are both entirely separate projects upstream and
in the fedora packaging.  A git-recover script may well be a
good fit in one of those upstream projects.

The git-(extras|tools) package names are a bit confusing
IMO.  But it's probably more confusing that they each add a
number of git-* commands in the default PATH the way they're
packaged.

We do package some bits from contrib/ (e.g. completion,
subtree, etc.) in the fedora git packages.  We don't add
scripts and commands from outside of the git tarballs as
part of the fedora git package, though.

So far, I don't recall anyone filing a bug report about
commands from git-extras or git-tools against git.  So it
seems that users of those additional packages aren't being
confused, thankfully.

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Between two evils, I always pick the one I never tried before.
    -- Mae West

