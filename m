From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH 1/1] --color and --no-color git-log options don't need diffs to be computed.
Date: Sat, 29 Sep 2007 14:52:36 +0200
Message-ID: <85ve9t8wh7.fsf@lola.goethe.zz>
References: <e5bfff550709290429n291968f2md8068a945ff7a79e@mail.gmail.com>
	<20070929123724.01BB045EC@madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sat Sep 29 14:52:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbboY-0007bG-7R
	for gcvg-git-2@gmane.org; Sat, 29 Sep 2007 14:52:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755830AbXI2Mwu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2007 08:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755974AbXI2Mwu
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Sep 2007 08:52:50 -0400
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:35443 "EHLO
	mail-in-01.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755802AbXI2Mwt (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Sep 2007 08:52:49 -0400
Received: from mail-in-14-z2.arcor-online.net (mail-in-14-z2.arcor-online.net [151.189.8.31])
	by mail-in-01.arcor-online.net (Postfix) with ESMTP id B486E15CC60;
	Sat, 29 Sep 2007 14:52:48 +0200 (CEST)
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net [151.189.21.43])
	by mail-in-14-z2.arcor-online.net (Postfix) with ESMTP id A13B1201004;
	Sat, 29 Sep 2007 14:52:48 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-000-036.pools.arcor-ip.net [84.61.0.36])
	by mail-in-03.arcor-online.net (Postfix) with ESMTP id 49E8F312767;
	Sat, 29 Sep 2007 14:52:33 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id A2F501C06F89; Sat, 29 Sep 2007 14:52:36 +0200 (CEST)
In-Reply-To: <20070929123724.01BB045EC@madism.org> (Pierre Habouzit's message of "Sat\, 29 Sep 2007 14\:35\:56 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.2/4429/Sat Sep 29 08:49:25 2007 on mail-in-03.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59464>

Pierre Habouzit <madcoder@debian.org> writes:

> Signed-off-by: Pierre Habouzit <madcoder@debian.org>

> -				if (strcmp(argv[i], "-z"))
> -					revs->diff = 1;
> +				revs->diff = strcmp(argv[i], "-z")
> +					&& strcmp(argv[i], "--color")
> +					&& strcmp(argv[i], "--no-color");
>  				i += opts - 1;
>  				continue;

This can clear a previously set value of revs->diff.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
