Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEFCF1F404
	for <e@80x24.org>; Wed,  7 Feb 2018 22:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750736AbeBGWDY (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 17:03:24 -0500
Received: from grym.ekleog.org ([94.23.42.210]:52782 "EHLO smtp.gaspard.ninja"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750726AbeBGWDX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 17:03:23 -0500
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 Feb 2018 17:03:23 EST
Received: by smtp.gaspard.ninja (OpenSMTPD) with ESMTP id f1574422
        for <git@vger.kernel.org>;
        Wed, 7 Feb 2018 21:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=gaspard.io; h=to
        :from:subject:message-id:date:mime-version:content-type
        :content-transfer-encoding; s=grym-20170528; bh=sJpyUHTivZq+sPBV
        yCEaOvQEkMY=; b=aH5OVR4wz4bmXwQ9kd4BBW+20MIc5BKI5EHk/mZc2Dy9mTU0
        Sp/jcGC39BxfnzPzP65qQR4uvdBSt1i+BMdJEgfvx4HOMMwWEi0ACViAGzzpeYQn
        G9iJZOMHDszPc1TQpp0HwHbq5BSvemJ8vQnU+9ac2ppO8MW/23y3rp4ivAY=
Received: by smtp.gaspard.ninja (OpenSMTPD) with ESMTPSA id 0f2bdbc0 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO)
        for <git@vger.kernel.org>;
        Wed, 7 Feb 2018 21:56:42 +0000 (UTC)
To:     git@vger.kernel.org
From:   Leo Gaspard <leo@gaspard.io>
Subject: Fetch-hooks
Message-ID: <5898be69-4211-d441-494d-93477179cf0e@gaspard.io>
Date:   Wed, 7 Feb 2018 22:56:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

tl;dr: Is there currently a way to have fetch hooks, and if not do you
think it could be a nice feature?

I was in the process of implementing hooks for git that ensure the
repository is always cleanly signed by someone allowed to by the
repository itself. I think I've completed the signature-checking part
[1] and the push hook [2] (even though it isn't really configurable at
the moment).

However, I was starting to think about handling the fetch step, and
couldn't find any fetch hook. Is there one?

If not, would you think it is would be a good idea to add one, that
would eg. be passed the commit-before, commit-after and could block the
changing of the reference if it failed?

The only other solution I could think of is using a separate script for
fetching, but that would be fragile, as the user could always not think
about it well and run a git fetch, breaking the objective that after the
first clone all commits were correctly signature-checked.

Thanks for reading me!
Leo

PS1: I am not subscribed to the ML.

PS2: I've tried asking freenode#git, without success so far.


[1]
https://github.com/Ekleog/signed-git/blob/master/git-hooks/check-range-signed.sh

[2] https://github.com/Ekleog/signed-git/blob/master/git-hooks/pre-push
