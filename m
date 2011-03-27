From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] tests: fix overeager scrubbing of environment variables
Date: Sun, 27 Mar 2011 16:37:56 -0500
Message-ID: <20110327213756.GD25927@elie>
References: <4D8FAAAC.3050905@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sun Mar 27 23:38:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3xey-0006U1-Tp
	for gcvg-git-2@lo.gmane.org; Sun, 27 Mar 2011 23:38:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262Ab1C0ViC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Mar 2011 17:38:02 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47980 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750960Ab1C0ViB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Mar 2011 17:38:01 -0400
Received: by iwn34 with SMTP id 34so2999939iwn.19
        for <git@vger.kernel.org>; Sun, 27 Mar 2011 14:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=mPH4ZdE+DYsgbgJB7k2bBlFUUawD/LtwNXKCSxPnOZo=;
        b=T2qffhWp0O6gQ3UzH740bDtZFbpY4UzUtJmipU7TNTDwNGeZmvwIuaWi8qCU8e1ey5
         wycEqYjeIa4G9F0/2NVngpe6Zx63RNeRC1JYMqZ9GnldN9w5HAKD1mCtOL/jdLoDFbyE
         +LIe2XtYjov7ojdxFd04L2o0lzaFxJ9uPq/Ac=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=PqOG0tVIL15GqHpLcYqA7TjUgxwWa/z/pl86u6VlUlcQVwYV3SfYr7qUIYe+T3H+2P
         KsIu4VN37VPMugt1DhxMS4+Yl10kq/iXCDLTuu92No+VIyF8bsviVMZUjnJCZWhnlQKx
         2DaWrD7jZutjxioGy4vKZYZhNX28a+0alM0B8=
Received: by 10.42.152.71 with SMTP id h7mr5578175icw.440.1301261880564;
        Sun, 27 Mar 2011 14:38:00 -0700 (PDT)
Received: from elie (adsl-68-255-101-206.dsl.chcgil.ameritech.net [68.255.101.206])
        by mx.google.com with ESMTPS id uk4sm2339811icb.21.2011.03.27.14.37.58
        (version=SSLv3 cipher=OTHER);
        Sun, 27 Mar 2011 14:37:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4D8FAAAC.3050905@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170090>

Jens Lehmann wrote:

> - GIT_SKIP_TESTS
> - GIT_TEST*
> - GIT_PROVE_OPTS
>
> Let's fix that by adding them to the exception list.
>
> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>

Acked-by: Jonathan Nieder <jrnieder@gmail.com>

It misses a few, though:

 - GIT_REMOTE_SVN_TEST_BIG_FILES
 - GIT_NOTES_TIMING_TESTS
 - GIT_PATCHID_TIMING_TESTS
 - GIT_VALGRIND_OPTIONS

If we were starting over I suppose those would all be GIT_TEST* but
there's something to be said for muscle memory.

> I noticed today that skipping a test the way I was used to suddenly failed:
>
> GIT_SKIP_TESTS='t1234' GIT_TEST_OPTS='--root=/dev/shm' make -j10 test
>
> This should work according to t/README, but didn't anymore.

I would have just written that in the change description.

Good catch, thanks.
