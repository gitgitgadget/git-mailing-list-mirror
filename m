From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: Re: HTTP tests fail on OS X
Date: Fri, 21 Jun 2013 13:03:40 -0400
Message-ID: <D0852D0F-3282-41DF-8A5A-4BEF1B39ED66@gernhardtsoftware.com>
References: <C44E969B-A5AE-44EF-BFCA-CAEF69516BEB@gernhardtsoftware.com> <20130621043052.GA5318@sigill.intra.peff.net> <20130621044236.GA5798@sigill.intra.peff.net> <26902D6D-D105-4943-BC67-461CEF82D888@gernhardtsoftware.com> <20130621044953.GA5962@sigill.intra.peff.net>
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org List" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 21 19:03:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uq4kV-0004Q8-Am
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 19:03:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423442Ab3FURDn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 13:03:43 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:38240 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423399Ab3FURDm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Jun 2013 13:03:42 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id E3C1027362F7; Fri, 21 Jun 2013 17:03:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.5 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [10.10.10.10] (cpe-142-105-190-134.rochester.res.rr.com [142.105.190.134])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id C98DB273617E;
	Fri, 21 Jun 2013 17:03:40 +0000 (UTC)
In-Reply-To: <20130621044953.GA5962@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.1508)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228631>


On Jun 21, 2013, at 12:49 AM, Jeff King <peff@peff.net> wrote:

> I'm not sure what else to look at...I guess try ratcheting up the
> debugging/log level on your failing copy and see if it prints anything
> useful.

I found this error in the error.log:

[Fri Jun 21 12:59:59 2013] [emerg] (2)No such file or directory: Couldn't create accept lock (/private/var/run/accept.lock.64288) (5)

Annoying that httpd returns before it tries to create the lock.

Without the IfVersion directive, it creates the lock in the ./httpd directory instead.  Not sure why apache is doing that, it's very irritating.

~~ Brian
