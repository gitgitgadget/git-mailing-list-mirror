From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Git on Windows, CRLF issues
Date: Tue, 22 Apr 2008 08:41:46 +0200
Message-ID: <480D88AA.1020004@viscovery.net>
References: <alpine.DEB.1.00.0804212145570.21181@perkele.intern.softwolves.pp.se>	 <alpine.DEB.1.00.0804212104560.2298@eeepc-johanness> <32541b130804211453x77f3fd49hef645a417a9919ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Peter Karlsson <peter@softwolves.pp.se>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 08:42:36 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoCD5-00056g-DS
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 08:42:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754658AbYDVGls (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 02:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754580AbYDVGls
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 02:41:48 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:34703 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754166AbYDVGls (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 02:41:48 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JoCCI-0001RG-I0; Tue, 22 Apr 2008 08:41:46 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 53F186C4; Tue, 22 Apr 2008 08:41:46 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <32541b130804211453x77f3fd49hef645a417a9919ca@mail.gmail.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80068>

Avery Pennarun schrieb:
> Does anyone know the most efficient way to [convert CRLF] with
> git-filter-branch, when there are already thousands of files in the
> repo with CRLF in them?  Running dos2unix on all the files for every
> single revision could take a *very* long time.

I chose to write a custom script. Otherwise, a file that stays the same
throughout the history would still have been converted on each commit. My
script converted each unique file only once, then reconstructed the tree
objects and then changed the commits.

In the end I don't think it payed off. It took me a week or so to convert
the repo; I just could have let filter-branch run for a week, too. But I
also have to mention that I did the CVS->git conversion a few times to get
a suitable history, and I also repeated the CRLF conversion sometimes, and
back then git-filter-branch did not exist in its current shape.

-- Hannes
