From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2] correct verify_path for Windows
Date: Mon, 13 Oct 2008 08:00:48 +0200
Message-ID: <48F2E410.2080504@viscovery.net>
References: <c475e2e60810020702q573570dcp31a5dc18bf98ef30@mail.gmail.com> <20081004233945.GM21650@dpotapov.dyndns.org> <B985AE98-F6E2-4C23-8D34-5A22A9F89FA7@gmail.com> <20081007032623.GX21650@dpotapov.dyndns.org> <48EAFF23.1020607@viscovery.net> <20081011163310.GZ21650@dpotapov.dyndns.org> <81b0412b0810111558vb69be00if4842fa91d777c3b@mail.gmail.com> <20081012135048.GC21650@dpotapov.dyndns.org> <20081012181836.GA10626@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Joshua Juran <jjuran@gmail.com>,
	Giovanni Funchal <gafunchal@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 13 08:02:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpGVK-0006hI-33
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 08:02:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752621AbYJMGAx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 02:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752647AbYJMGAx
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 02:00:53 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:57116 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752203AbYJMGAx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 02:00:53 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KpGU4-00040Z-VH; Mon, 13 Oct 2008 08:00:49 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 8212D54D; Mon, 13 Oct 2008 08:00:48 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20081012181836.GA10626@steel.home>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.2 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_95=3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98083>

Alex Riesen schrieb:
> I looked at the callers (briefly). Performance could be a problem: add
> and checkout can work with real big file lists and long pathnames.
> So ok, than. It is critical.

You are kidding, aren't you? What you win by a few CPU instructions here
is dwarfed by the time that the stat() implementation requires. Dmitry,
please use the more readable tolower().

-- Hannes
