From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 0/4] drop some "int x = x" hacks to silence gcc warnings
Date: Thu, 21 Mar 2013 12:45:37 +0100
Message-ID: <514AF2E1.7020409@viscovery.net>
References: <20130321110338.GA18552@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 21 12:46:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIdwj-0003Kn-Af
	for gcvg-git-2@plane.gmane.org; Thu, 21 Mar 2013 12:46:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932589Ab3CULpp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Mar 2013 07:45:45 -0400
Received: from so.liwest.at ([212.33.55.24]:38048 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932517Ab3CULpn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Mar 2013 07:45:43 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1UIdwA-0006mP-TB; Thu, 21 Mar 2013 12:45:39 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id E3D761660F;
	Thu, 21 Mar 2013 12:45:37 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <20130321110338.GA18552@sigill.intra.peff.net>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218712>

Am 3/21/2013 12:03, schrieb Jeff King:
> I was fooling around with clang and noticed that it complains about the
> "int x = x" construct under -Wall. That is IMHO a deficiency in clang,
> since the idiom has a well-defined use in silencing -Wuninitialized
> warnings.

IMO, that's a myth. The construct invokes undefined behavior at least
since C99, and the compilers are right to complain about it.

But you might just say that standards are not worth the paper they are
printed on, and you may possibly be right for practical reasons. But I
still consider it a myth that "int x = x" is an idiom. I'm in the C
business since more than 25 years, and the first time I saw the "idiom"
was in git code. Is there any evidence that the construct is used
elsewhere? Have I been in the wrong corner of the C world for such a long
time?

-- Hannes
