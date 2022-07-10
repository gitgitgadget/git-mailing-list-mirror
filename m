Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 664BAC43334
	for <git@archiver.kernel.org>; Sun, 10 Jul 2022 18:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiGJSBg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jul 2022 14:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGJSBf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jul 2022 14:01:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4356412772
        for <git@vger.kernel.org>; Sun, 10 Jul 2022 11:01:34 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id DD16D22482;
        Sun, 10 Jul 2022 18:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1657476092; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/7500vrH0XOLk0wzZDPX2FFkINuUWAu/dWtAe1MQ49U=;
        b=IV8WNYh5ztSO2why1AmIxS1B1weyASvts9s3RP0WEVBF5LGqGaVrSyX7oGEP02bHwNG9JQ
        idnr9PYD4v/osK8BdWP1iX39B/bMXT5EPGKRld435JABirEOiq/PPTWjpjsD739TDtLzLv
        MiBLcKzZg4Xji7wwNuz2k7W6h1/yu2s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1657476092;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/7500vrH0XOLk0wzZDPX2FFkINuUWAu/dWtAe1MQ49U=;
        b=lB3+KbzhY8a0XR60bpnui1P/ZucaXYww823p+5ugbL/ieLBR5eB4jHlJk/niNBX87moqEc
        JuLoCbI9hezzOEDg==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C425D2C141;
        Sun, 10 Jul 2022 18:01:32 +0000 (UTC)
Date:   Sun, 10 Jul 2022 20:01:31 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Jonas Aschenbrenner <jonas.aschenbrenner@gmail.com>,
        git@vger.kernel.org
Subject: Re: Suggestion to rename "blame" of the "git blame" command to
 something more neutral
Message-ID: <20220710180131.GU17705@kitsune.suse.cz>
References: <CADS2hGpnkiPzivVDyN-PnGsQCTafqx68PxigXvBK1bv4O=p4kg@mail.gmail.com>
 <220710.86r12t82ea.gmgdl@evledraar.gmail.com>
 <20220710145502.GT17705@kitsune.suse.cz>
 <xmqq1qutrkm8.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq1qutrkm8.fsf@gitster.g>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 10, 2022 at 09:35:43AM -0700, Junio C Hamano wrote:
> Michal Suchánek <msuchanek@suse.de> writes:
> 
> >> What do you think about this old patch of mine to add a 'git praise'?:
> >> https://lore.kernel.org/git/20190401101246.21418-1-avarab@gmail.com/
> >
> > Since you are asking .. I think it completely misses the point.
> >
> > I would consider it effective if users of git-praise(1) needed no
> > knowledge of existence of git-blame(1).
> 
> I think you are the one who completely misses the point of him
> sending the URL (hint: what is the date of the patch?)
> 
> "blame" is perfectly fine.  It is the tool we use to find a commit
> or a series of commits to be blamed for whichever blocks of code in
> the current codebase we are interested in.  Even if it is to find
> the source of the buggy or ugly code in the current codebase
> (i.e. "verb with negative connotation"), we are trying to put our
> fingers on the commit to be blamed.

If the word 'blame' is considered offensive by some pople a solution
which basically adds an alias for the blame command without eliminating
the offensive word is insufficient.

Sure, you may not find the word 'blame' offensive. I don't find it
offensive either. I don't find the word 'master' offensive either, and
it was changed anyway.

I don't want to decide whose offense is considered relevant and whose is
disregarded.

It's completely feasible to provide sound solution to eliminating the
word 'blame' from the git source with the exception of some
comaptibility alias, and the linked patch is not it.

Best regards

Michal

