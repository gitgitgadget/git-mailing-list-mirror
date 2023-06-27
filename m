Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A46A5EB64D9
	for <git@archiver.kernel.org>; Tue, 27 Jun 2023 17:52:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbjF0Rwe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jun 2023 13:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbjF0Rwc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2023 13:52:32 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCF8272D
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 10:52:30 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 45288183478;
        Tue, 27 Jun 2023 13:52:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ynf0mWTd3MjNKP6YIs+45wHBahLbGr7rhcaauo
        ustZQ=; b=UiLUg7hVIRDzVN+04T750sFeV0VfvhGuLMK6VTTtNlSwWaZdkdyFWC
        q6fFMcD71t7jKPLRUjzNaKuGg4GkmBE/BErFlLSk8fkp9/D414D04eZx2iM7aYxf
        S4RydD9lfkrscqQ/lCtEP3ZO9tk318E9Ar++ssqGbVRHVYRLfPzIQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3D531183477;
        Tue, 27 Jun 2023 13:52:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.233.135.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9D503183476;
        Tue, 27 Jun 2023 13:52:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Mark Levedahl <mlevedahl@gmail.com>
Cc:     mdl123@verizon.net, git@vger.kernel.org, adam@dinwoodie.org,
        me@yadavpratyush.com, johannes.schindelin@gmx.de,
        sunshine@sunshineco.com
Subject: Re: [PATCH v1 0/4] Remove obsolete Cygwin support from git-gui
References: <20230624212347.179656-1-mlevedahl@gmail.com>
        <20230626165305.37488-1-mlevedahl@gmail.com>
Date:   Tue, 27 Jun 2023 10:52:27 -0700
In-Reply-To: <20230626165305.37488-1-mlevedahl@gmail.com> (Mark Levedahl's
        message of "Mon, 26 Jun 2023 12:53:01 -0400")
Message-ID: <xmqq4jmsiyhw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 61EE2770-1513-11EE-B543-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark Levedahl <mlevedahl@gmail.com> writes:

> === This is an update, incorporating responses to Junio's and Eric's
> comments:
>   -- clarified what the "upstream" git-gui branch is
>   -- Removed some changes from patch 2 as requested by Junio, reducing
>      changes in patch 3 and patch 4
>        All code is fixed only after applying patch 4
>        Differences in patch 3 and 4 are minimimized
>    -- updated comments to clarify G4w dedicated code.
>    -- updated all comments to (hopefully) clarify points of confusion
> ===
> ...
> Mark Levedahl (4):
>   git gui Makefile - remove Cygwin modifications
>   git-gui - remove obsolete Cygwin specific code
>   git-gui - use cygstart to browse on Cygwin
>   git-gui - use mkshortcut on Cygwin
>
>  Makefile                  |  21 +------
>  git-gui.sh                | 118 +++-----------------------------------
>  lib/choose_repository.tcl |  27 +--------
>  lib/shortcut.tcl          |  31 +++++-----
>  4 files changed, 27 insertions(+), 170 deletions(-)

OK, Dscho says v1 looks good, and I have no further comments.

Pratyush, can I expect that you take further comments and usher
these patches to your tree, and eventually tell me to pull from your
repository?

Thanks, all.
