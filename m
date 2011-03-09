From: Robert Wruck <wruck@tweerlei.de>
Subject: Re: [BUG] git cat-file does not terminate
Date: Wed, 09 Mar 2011 15:49:41 +0100
Message-ID: <4D779385.3070602@tweerlei.de>
References: <4D70E340.3050309@tweerlei.de> <20110304154014.GE24660@m62s10.vlinux.de> <20110304160047.GA9662@sigill.intra.peff.net> <7vzkpa7qmp.fsf@alter.siamese.dyndns.org> <20110308211423.GB4594@sigill.intra.peff.net> <7vwrk9cjib.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Peter Baumann <waste.manager@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 09 15:49:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxKi6-0004YN-U3
	for gcvg-git-2@lo.gmane.org; Wed, 09 Mar 2011 15:49:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756984Ab1CIOtt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2011 09:49:49 -0500
Received: from mail.tweerlei.de ([88.198.48.46]:38748 "EHLO mail.tweerlei.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751911Ab1CIOtt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2011 09:49:49 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mail.tweerlei.de (Postfix) with ESMTPSA id 70E6D277EA;
	Wed,  9 Mar 2011 15:49:46 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.9) Gecko/20100915 Thunderbird/3.1.4
In-Reply-To: <7vwrk9cjib.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168734>

> I asked (1) if we can find out at runtime if we are on which version of
> cygwin1.dll, and (2) if we can have a small list of "bad" versions of
> cygwin1.dll.  If both are true, the runtime test should be trivial, no?

Currently I don't know of a programmatic way to get the cygwin version 
except `cygcheck -c cygwin` or `uname -r` but these utilities seem to 
know where to find it. I'll take a look at the source.

Unfortunately, the same cygwin version works on most platforms except 
WinXP, so its rather a platform issue and I fear that in this case all 
cygwin versions up to a currently unknown fixed version will be subject.
Depending on the machine, the "limit" at which write() fails seems to 
vary as well. In my initial report, it was about 80MB, on another 
machine it was around 200MB...

I submitted a bug report to cygwin over the weekend and tried to debug 
what's going on in cygwin1.dll but haven't gone very far yet.

-Robert
