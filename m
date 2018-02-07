Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6DF11F404
	for <e@80x24.org>; Wed,  7 Feb 2018 18:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754118AbeBGSnB (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 13:43:01 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60906 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753941AbeBGSnA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 13:43:00 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AA8D3C9152;
        Wed,  7 Feb 2018 13:42:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=xfwsP1weG3ZwyP+nsE8GCXcAloU=; b=lUmegwK
        mx3wAHE0PDg+0Fd+SzUN/H4+K1rxkIuhx5J0urKsicrDVVCugK0rUVkW9F0Ho51a
        /FltsmRY1mEpLTkZAvV9TeDVwxH1ntZcslLK3kX0RnmOc35L3n6AUQbqjsiMut0E
        BE5ob2N2+8rTqDTkL/1kojoqOsxgTdOzMHNw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to; q=dns; s=sasl; b=wewWHkIBZaY+MNEMLEuvIrKFzP+jyb1WK
        8xGKwl5dSjZrHh5vGAEk96qrQa/XRa3QwiZ7xLGMh+MSih6hihmWfnI552O1Yvh6
        1c4P5ChLhvE6KtmDnI/XFT60rlCo4Z/KrxgMPw5iHcJMjDAwZ6LECmAvACyoSfwh
        EHk0NE+6sk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A0FC7C9150;
        Wed,  7 Feb 2018 13:42:59 -0500 (EST)
Received: from zaya.teonanacatl.net (unknown [173.67.181.41])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 110C5C914F;
        Wed,  7 Feb 2018 13:42:59 -0500 (EST)
Date:   Wed, 7 Feb 2018 13:42:57 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: categorization, documentation and packaging of "git core"
 commands
Message-ID: <20180207184257.GM1427@zaya.teonanacatl.net>
References: <alpine.LFD.2.21.1802070801470.19185@android-a172fe96dd584b41>
 <20180207172902.GL1427@zaya.teonanacatl.net>
 <alpine.LFD.2.21.1802071308250.9047@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1802071308250.9047@localhost.localdomain>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Pobox-Relay-ID: B817E762-0C36-11E8-B3A6-692D1A68708C-09356542!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robert P. J. Day wrote:
> On Wed, 7 Feb 2018, Todd Zullinger wrote:
> 
>> Robert P. J. Day wrote:
>>> first, here are the executables under /usr/libexec/git-core/ that
>>> are unreferenced by that web page, but that should be fine as
>>> almost all of them would be considered underlying helpers or
>>> utilities (except for things like git-subtree, but we're still
>>> unclear on its status, right?):
>>
>> I don't think there's anything unclear about git subtree's status.
>> It's in contrib/ within the source, so it's not part of the core git
>> suite.  Some distributions (Fedora being one of them) ship a
>> git-subtree package to provide it for users who want it.
> 
>   not true, "git-subtree" is part of fedora's lowest-level
> "git-core" package.

Eek, my apologies for providing bad information.  I really
should know the Fedora git packaging better than that. :/

Amusingly, I did suggest packaging it as a subpackage
specifically to avoid any confusion that it was a core
command in the Fedora bug which requested it be included in
the git packaging:

    https://bugzilla.redhat.com/show_bug.cgi?id=864651

I'll see about changing that going forward in the Fedora
packaging.  I think it deserves to be in a subpackage.

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Doing a job RIGHT the first time gets the job done.
Doing the job WRONG fourteen times gives you job security.

