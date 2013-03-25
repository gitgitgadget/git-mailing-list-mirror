From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2 3/3] t7800: run --dir-diff tests with and without symlinks
Date: Mon, 25 Mar 2013 08:26:52 +0100
Message-ID: <514FFC3C.3010203@viscovery.net>
References: <cover.1363980749.git.john@keeping.me.uk> <cover.1364045138.git.john@keeping.me.uk> <cf71cc8757c7cb59e93d762fba922635c077376d.1364045138.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Mar 25 08:27:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UK1oi-0001h6-Sv
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 08:27:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752712Ab3CYH1N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 03:27:13 -0400
Received: from so.liwest.at ([212.33.55.24]:50672 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751267Ab3CYH1M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 03:27:12 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1UK1o9-0008Ks-7Q; Mon, 25 Mar 2013 08:27:05 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id C9F1A1660F;
	Mon, 25 Mar 2013 08:27:04 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <cf71cc8757c7cb59e93d762fba922635c077376d.1364045138.git.john@keeping.me.uk>
X-Enigmail-Version: 1.5.1
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219015>

The series looks good, but I can't test it because it does not apply
anywhere here.

Am 3/23/2013 14:31, schrieb John Keeping:
> Currently the difftool --dir-diff tests may or may not use symlinks
> depending on the operating system on which they are run.  In one case
> this has caused a test failure to be noticed only on Windows when the
> test also fails on Linux when difftool is invoked with --no-symlinks.
> 
> Rewrite these tests so that they do not depend on the environment but
> run explicitly with both --symlinks and --no-symlinks, protecting the
> --symlinks version with a SYMLINKS prerequisite.

At first, I wondered what the point of having --symlinks and --no-symlinks
was when there is no discernable difference. But 1f229345 (difftool: Use
symlinks when diffing against the worktree) makes it pretty clear: It's an
optimization, and --no-symlinks is only intended as an escape hatch.

-- Hannes
