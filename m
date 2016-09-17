Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40ABD1FCA9
	for <e@80x24.org>; Sat, 17 Sep 2016 16:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752588AbcIQQDa (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Sep 2016 12:03:30 -0400
Received: from [195.159.176.226] ([195.159.176.226]:44256 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1752346AbcIQQD3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Sep 2016 12:03:29 -0400
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <gcvg-git-2@m.gmane.org>)
        id 1blI5L-0003Ct-K1
        for git@vger.kernel.org; Sat, 17 Sep 2016 18:03:23 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   Anatoly Borodin <anatoly.borodin@gmail.com>
Subject: Re: [wishlist] disable boring messages
Date:   Sat, 17 Sep 2016 16:03:07 +0000 (UTC)
Message-ID: <nrjpfr$565$1@blaine.gmane.org>
References: <20160916221753.pvqdwb7vspkosyxu@shurick.grid.su>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@blaine.gmane.org
User-Agent: tin/2.3.4-20160628 ("Newton") (UNIX) (FreeBSD/10.2-STABLE (i386))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

Alexander Inyukhin <shurick@sectorb.msk.ru> wrote:
> I have a lot of repos and a batch script to update them all,
> and I want to get rid of 'Fetching origin' and 'Already up-to-date.'
> messages leaving only new refs and tags.

There is an option `-q`, but it's too silent :)

As far as I can see, `git fetch` prints 'Fetching origin' etc to stdout,
and new refs/tags to stderr (don't ask me why). So

	git fetch blabla > /dev/null
	
should probably do the job.

Now, if you collect and save those logs, you may need some shell-fu to
redirect that stderr to stdout, but not to /dev/null. Something like

	(git fetch blabla > /dev/null) 2>&1

(run `git fetch` in a subshell)...

-- 
Mit freundlichen Grüßen,
Anatoly Borodin

