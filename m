From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v3] quickfetch(): Prevent overflow of the rev-list command
 line
Date: Thu, 09 Jul 2009 16:56:09 +0200
Message-ID: <4A560509.8060909@viscovery.net>
References: <alpine.DEB.2.00.0906181310400.23400@ds9.cixit.se> <200907091552.44545.johan@herland.net> <4A55FCD5.2020908@viscovery.net> <200907091642.05746.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Alex Riesen <raa.lkml@gmail.com>, Jeff King <peff@peff.net>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Jul 09 16:57:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOv3V-0002ri-91
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 16:57:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759785AbZGIO4N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 10:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759193AbZGIO4N
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 10:56:13 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:39988 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757615AbZGIO4M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2009 10:56:12 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MOv2f-0000NN-ST; Thu, 09 Jul 2009 16:56:10 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 7E63F6B7; Thu,  9 Jul 2009 16:56:09 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <200907091642.05746.johan@herland.net>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122981>

Johan Herland schrieb:
> On Thursday 09 July 2009, Johannes Sixt wrote:
>> But actually I meant you to make a test that triggers the SIGPIPE that
>> would kill git-fetch if it were not ignored. This one doesn't trigger it,
>> either.
> 
> AFAIU from earlier in this thread (and a mail from Peter linking to 
> http://markmail.org/message/dbgdj4csafen65ye), SIGPIPE _never_ triggers on 
> Windows, thus ignoring SIGPIPE is not needed for the fix per se. However, as 
> a side-effect of the fix, we may now get SIGPIPE on Linux (and other POSIX 
> platforms), so although it never triggers on Windows, it's still needed.

I know that, of course. But try this: Remove the signal(SIGPIPE, SIG_IGN)
and run the test suite. There is not a single failure. IOW, we don't have
a single test case that verifies that the signal(SIGPIPE, SIG_IGN) is
needed. I would like to have that test case, and you seem to know how to
construct it (otherwise there wouldn't be so much buzz about it).

-- Hannes
