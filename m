From: Michael Witten <mfwitten@MIT.EDU>
Subject: Re: [PATCH review] Build: make PERL_PATH = /usr/bin/env perl
Date: Sun, 1 Jun 2008 00:48:31 -0400
Message-ID: <8F19F8D7-A9D3-41F5-9F64-1E955BC08DF0@mit.edu>
References: <1212258886-87484-1-git-send-email-mfwitten@mit.edu> <7vabi6fdun.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 01 06:50:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2fWS-0004VQ-TN
	for gcvg-git-2@gmane.org; Sun, 01 Jun 2008 06:50:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbYFAEtF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Jun 2008 00:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbYFAEtE
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jun 2008 00:49:04 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:57015 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750971AbYFAEtD (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Jun 2008 00:49:03 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id m514n0Gh026933;
	Sun, 1 Jun 2008 00:49:00 -0400 (EDT)
Received: from MACGREGOR-TWO-TWENTY-FOUR.MIT.EDU (MACGREGOR-TWO-TWENTY-FOUR.MIT.EDU [18.239.5.224])
	(authenticated bits=0)
        (User authenticated as mfwitten@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id m514mVGi004985
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sun, 1 Jun 2008 00:48:36 -0400 (EDT)
In-Reply-To: <7vabi6fdun.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.924)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83431>


On 31 May 2008, at 3:55 PM, Junio C Hamano wrote:

> If you insist, you can do so from your "make" command line, but I'd  
> prefer
> the default configuration as vanilla as possible.

The main trouble I've run into is with multiple versions of perl  
installed.
For instance, it is unadvisable to overwrite the Mac OS X provided perl
distribution. Consequently, custom installations are usually put into
/usr/local (also, MacPorts install everything into /opt/local).

This means that a 'vanilla' configuration may not (most likely will  
not) make
use of the perl distribution that is actually employed by the user.

This matters, because some tools like git-send-email require extra CPAN
modules such as Net::SMTP::SSL, which won't be found unless git has been
configured with a custom PERL_PATH.

It would seem to me that something like '/usr/bin/env perl' is slightly
more vanilla in the sense that it can handle more cases.

Perhaps the Makefile can be smarter about guessing the right path?

Sincerely,
Michael Witten
