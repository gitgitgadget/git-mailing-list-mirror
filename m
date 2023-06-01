Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01E0C77B7A
	for <git@archiver.kernel.org>; Thu,  1 Jun 2023 10:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbjFAKiU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jun 2023 06:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232681AbjFAKiT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2023 06:38:19 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F289D107
        for <git@vger.kernel.org>; Thu,  1 Jun 2023 03:38:17 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9A38F1F86C;
        Thu,  1 Jun 2023 10:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1685615896; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CqwJioGlLUoaPnHtOj8GBIyFDyP3o0qfTTOdsy250cg=;
        b=LpT2pXhZRQC7fXU2ljWaJcMWYCM/p18lVfjEbixDDkSYEkyv0Plz4xwkY+oiNpS417gYAc
        WSU4ojRhqBZ8z1Pz6+mG1uFuNMufz1iUzNjkWISgZa6LTNCPkOjm8oDCf4I2gSTzxCkyka
        IvmWadnKwsrCMq+SSnRXF9XE9P5KaGM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1685615896;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CqwJioGlLUoaPnHtOj8GBIyFDyP3o0qfTTOdsy250cg=;
        b=XwSkUhsooQ8NoU0l1vcQdH9HBefuzLp5l2i4bhOod2UnnhGdXE77opsdWwcwQgKDp0kTSc
        LsrtrOXYNhlmUcDA==
Received: from hawking.suse.de (unknown [10.168.4.11])
        by relay2.suse.de (Postfix) with ESMTP id 74E6D2C141;
        Thu,  1 Jun 2023 10:38:16 +0000 (UTC)
Received: by hawking.suse.de (Postfix, from userid 17005)
        id 44E514A04EA; Thu,  1 Jun 2023 12:38:16 +0200 (CEST)
From:   Andreas Schwab <schwab@suse.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: git gc complains about "unable to read $oid" but git fsck finds
 no problems
In-Reply-To: <xmqqsfbba42c.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        01 Jun 2023 19:07:39 +0900")
References: <mvmfs7ba4el.fsf@suse.de> <xmqqsfbba42c.fsf@gitster.g>
X-Yow:  Hey, I LIKE that POINT!!
Date:   Thu, 01 Jun 2023 12:38:16 +0200
Message-ID: <mvmbkhza2nb.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Jun 01 2023, Junio C Hamano wrote:

> I vaguely recall there was a recent threaad discussing fsck and
> normal codepath doing different checks.
>
> Does this look similar to what you have?  (sorry, I am running out
> of gas tonight to dig deeply myself).
>
> https://lore.kernel.org/git/20230330181716.GA3286761@coredump.intra.peff.net/

Thanks, that indeed looks similar.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
