Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D54C433EF
	for <git@archiver.kernel.org>; Sun, 15 May 2022 16:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237815AbiEOQwB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 May 2022 12:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiEOQv6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 May 2022 12:51:58 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015F52C67A
        for <git@vger.kernel.org>; Sun, 15 May 2022 09:51:57 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C9B37184547;
        Sun, 15 May 2022 12:51:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Iom9YAju1BTIWZmYEupj70Bis7WWkVXdcXs30+
        P/EkU=; b=XGabhYcIjLpyIweAC4G/8zcLjtYHk7H0SWb7HZdUiplA8hQSGWA3m9
        +zhw33DYXVW8XChzmfv3JRkdXZeMYg/vm6lmTH3SA36VlsvIs3yKuIkN9PFBnDgz
        3N9dI42wqUOD6403OBwKNqPdCzHIRsrdQauZpLST3/08FBT6bUtvY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C28D3184546;
        Sun, 15 May 2022 12:51:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6D3C2184545;
        Sun, 15 May 2022 12:51:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Git List <git@vger.kernel.org>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel?= =?utf-8?Q?=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: sudo: git describe during GIT_VERSION_GEN not as expected..
References: <7bb71920-b840-5133-ceac-664c09942772@iee.email>
Date:   Sun, 15 May 2022 09:51:52 -0700
In-Reply-To: <7bb71920-b840-5133-ceac-664c09942772@iee.email> (Philip Oakley's
        message of "Sun, 15 May 2022 11:12:29 +0100")
Message-ID: <xmqqwnem7n87.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 52A4AC98-D46F-11EC-92D6-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

> I have run into a problem with make/install of git on my old travel
> laptop. While trying to make / install git with some patches on top of 
> yesterdays next (coincidental timing) I'm finding that the generated
> git version is the default value rather than that of a regular 'get 
> describe' as used in GIT_VERSION_GEN.

Yup, we've been discussing on this issue since the Git 2.35.3 (and
friends) and Git 2.36 release.

  https://lore.kernel.org/git/20220426183105.99779-1-carenas@gmail.com/

I think the last round:

  https://lore.kernel.org/git/20220513010020.55361-1-carenas@gmail.com/

is more or less done, so perhaps we should start merging it down to
'next' and all the way down to the older maintenance tracks like
maint-2.30 that are affected.

Thanks.
