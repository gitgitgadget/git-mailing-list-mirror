From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v2 3/3] t7800: run --dir-diff tests with and without
 symlinks
Date: Mon, 25 Mar 2013 10:35:16 +0000
Message-ID: <20130325103516.GC2286@serenity.lan>
References: <cover.1363980749.git.john@keeping.me.uk>
 <cover.1364045138.git.john@keeping.me.uk>
 <cf71cc8757c7cb59e93d762fba922635c077376d.1364045138.git.john@keeping.me.uk>
 <514FFC3C.3010203@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Mar 25 11:35:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UK4ku-0003Mb-2Y
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 11:35:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755643Ab3CYKf2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 06:35:28 -0400
Received: from hyena.aluminati.org ([64.22.123.221]:57463 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754579Ab3CYKf2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 06:35:28 -0400
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 98335202DB;
	Mon, 25 Mar 2013 10:35:27 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ee20eKz1cZ1U; Mon, 25 Mar 2013 10:35:27 +0000 (GMT)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id 6AAAF22B4D;
	Mon, 25 Mar 2013 10:35:17 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <514FFC3C.3010203@viscovery.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219024>

On Mon, Mar 25, 2013 at 08:26:52AM +0100, Johannes Sixt wrote:
> The series looks good, but I can't test it because it does not apply
> anywhere here.

It's built on top of da/difftool-fixes, is there some problem that stops
it applying cleanly on top of that?

> Am 3/23/2013 14:31, schrieb John Keeping:
> > Currently the difftool --dir-diff tests may or may not use symlinks
> > depending on the operating system on which they are run.  In one case
> > this has caused a test failure to be noticed only on Windows when the
> > test also fails on Linux when difftool is invoked with --no-symlinks.
> > 
> > Rewrite these tests so that they do not depend on the environment but
> > run explicitly with both --symlinks and --no-symlinks, protecting the
> > --symlinks version with a SYMLINKS prerequisite.
> 
> At first, I wondered what the point of having --symlinks and --no-symlinks
> was when there is no discernable difference. But 1f229345 (difftool: Use
> symlinks when diffing against the worktree) makes it pretty clear: It's an
> optimization, and --no-symlinks is only intended as an escape hatch.
