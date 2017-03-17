Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BCA520951
	for <e@80x24.org>; Fri, 17 Mar 2017 18:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751351AbdCQSSH (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 14:18:07 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53102 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751047AbdCQSSF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 14:18:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4BB92796E2;
        Fri, 17 Mar 2017 14:10:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BJ4VX71Do9xayAGj8lEyPAd/ZQU=; b=uO70dw
        SW7lEJKH7uJr8vLEUGrRsgWBj4X0M4z/ORrtZQwr7De3uwiaJhkyEPAW2yuDDiVJ
        EkEHV0wDNjM9V0bkGDJ3oK1I3+qdTZQFWPZ1hs4Gw7WQd7JkfGptcXUWQH4J9mQd
        0/ykzB2aVHxr3Wjo1kYrBPApubOXB18LnQrek=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kc0CzSSHHXrzKM09HgQ5LKf5jvl7t0cW
        IddG/Ezgm0vZnD2laEXChCyck82BLQxWDa1f2yEco5MrJVkdMMvK79EExgnZPT75
        w5ziQUO058ge1EoU6vZuKwRg/LlXqnKYExdfxPAULbjMOO5VU1ltw5tV3ZiXLCQ6
        BsOpNld+84c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 43F0B796E0;
        Fri, 17 Mar 2017 14:10:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AA615796DE;
        Fri, 17 Mar 2017 14:10:14 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Joe Rayhawk <jrayhawk@freedesktop.org>
Cc:     "Michael Haggerty" <mhagger@alum.mit.edu>, git@vger.kernel.org
Subject: Re: Shared repositories no longer securable against privilege escalation
References: <148971018136.2144.12683278043600094739@richardiv.omgwallhack.org>
        <195b30d7-9ea2-7a9b-79ca-41b7bb890a30@alum.mit.edu>
        <xmqqo9wz9b68.fsf@gitster.mtv.corp.google.com>
        <148976932628.2144.11216577266857568258@richardiv.omgwallhack.org>
Date:   Fri, 17 Mar 2017 11:10:13 -0700
In-Reply-To: <148976932628.2144.11216577266857568258@richardiv.omgwallhack.org>
        (Joe Rayhawk's message of "Fri, 17 Mar 2017 09:48:46 -0700")
Message-ID: <xmqqtw6r7p16.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F8233A7E-0B3C-11E7-BF4F-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joe Rayhawk <jrayhawk@freedesktop.org> writes:

> that, at least on base POSIX, using --shared to share a repository
> between multiple UIDs literally eliminates the purpose of having
> multiple UIDs.

I do not think the world is _that_ blank-and-white.  If you cannot
trust those who push to the repository, you can give them git-only
access without a shell account and keep separating them with UIDs.
If you can, then the --shared setting is suitable for you.
