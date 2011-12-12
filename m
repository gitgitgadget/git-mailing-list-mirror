From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Breakage (?) in configure and git_vsnprintf()
Date: Mon, 12 Dec 2011 08:45:39 +0100
Message-ID: <4EE5B123.2030708@viscovery.net>
References: <4EE4F97B.9000202@alum.mit.edu> <20111212064305.GA16511@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	git discussion list <git@vger.kernel.org>,
	Michal Rokos <michal.rokos@nextsoft.cz>,
	Brandon Casey <casey@nrlssc.navy.mil>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 12 08:45:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ra0a6-0005mT-D7
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 08:45:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751519Ab1LLHpq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 02:45:46 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:64147 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751036Ab1LLHpq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 02:45:46 -0500
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Ra0Zv-0003RO-No; Mon, 12 Dec 2011 08:45:39 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 6F6361660F;
	Mon, 12 Dec 2011 08:45:39 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <20111212064305.GA16511@sigill.intra.peff.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186879>

Am 12/12/2011 7:43, schrieb Jeff King:
> I'll leave the issue of "-std=c89" triggering SNPRINTF_RETURNS_BOGUS to
> people who know and care about autoconf. My gut is to say "don't do
> that".

Right. But Michael's problem was actually that SNPRINTF_RETURNS_BOGUS was
set incorrectly; his system has a working snprintf (or so I assume). The
reason for the failure is that ./configure's test program produced a
warning, and that warning was turned into an error due to -Werror. Without
-Werror, the test program would have compiled successfully, and the
working snprintf would have been detected.

-- Hannes
