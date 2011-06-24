From: Eric Raible <raible@nextest.com>
Subject: BUG: 'cherry-pick -x' corner case
Date: Fri, 24 Jun 2011 14:54:49 -0700
Message-ID: <4E0507A9.7090000@nextest.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 25 00:00:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QaEPv-0004va-NX
	for gcvg-git-2@lo.gmane.org; Sat, 25 Jun 2011 00:00:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754843Ab1FXV7y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jun 2011 17:59:54 -0400
Received: from exchange.domain1.nextest.com ([12.96.234.114]:31425 "EHLO
	exchange.DOMAIN1.nextest.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754600Ab1FXV7y (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Jun 2011 17:59:54 -0400
X-Greylist: delayed 304 seconds by postgrey-1.27 at vger.kernel.org; Fri, 24 Jun 2011 17:59:54 EDT
Received: from [131.101.151.1] (131.101.151.1) by Exchange.DOMAIN1.nextest.com
 (131.101.21.39) with Microsoft SMTP Server (TLS) id 8.2.176.0; Fri, 24 Jun
 2011 14:58:22 -0700
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.18) Gecko/20110616 Lightning/1.0b2 Thunderbird/3.1.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176315>

When cherry-picking a (presumably trivial) commit that has only
the one-line summary (and no further text), cherry-pick -x appends
it's message directly to the one-line summary.

Thereby creating a commit which has a two-line summary.

Aside from that, even with a non-trivial commit the generated note
"(cherry picked from commit 555c9864971744abb558796aea28e12a1ac20839)"
seems abrupt when appended directly.

I'd suggest:

"\n[cherry-picked from commit 555c9864971744abb558796aea28e12a1ac20839]"

or even better:

"\n[cherry-picked from commit 555c986]"

I'll turn this into an actual patch if there's a chance of it being incorporated.

- Eric
