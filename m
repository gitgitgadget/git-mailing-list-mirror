From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: Re: [PATCH] checkout: add 'pre-checkout' hook
Date: Wed, 14 Oct 2009 18:25:28 +1300
Organization: Catalyst IT (NZ) Ltd
Message-ID: <4AD560C8.8010108@catalyst.net.nz>
References: <1255495525-11254-1-git-send-email-sam.vilain@catalyst.net.nz> <20091014051319.GF31810@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, elliot@catalyst.net.nz
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 14 07:30:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxwRH-0001cU-Ts
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 07:30:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753894AbZJNF0J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 01:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753211AbZJNF0H
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 01:26:07 -0400
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:51313 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751560AbZJNF0G (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 01:26:06 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.catalyst.net.nz (Postfix) with ESMTP id 9B739323A2;
	Wed, 14 Oct 2009 18:25:29 +1300 (NZDT)
X-Virus-Scanned: Debian amavisd-new at catalyst.net.nz
Received: from mail.catalyst.net.nz ([127.0.0.1])
	by localhost (bertrand.catalyst.net.nz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id etwbJu7NMx+V; Wed, 14 Oct 2009 18:25:29 +1300 (NZDT)
Received: from [IPv6:2404:130:0:1000:21d:7dff:fe90:5fe0] (unknown [IPv6:2404:130:0:1000:21d:7dff:fe90:5fe0])
	(Authenticated sender: samv)
	by mail.catalyst.net.nz (Postfix) with ESMTPSA id 050C032214;
	Wed, 14 Oct 2009 18:25:29 +1300 (NZDT)
User-Agent: Mozilla-Thunderbird 2.0.0.19 (X11/20090103)
In-Reply-To: <20091014051319.GF31810@coredump.intra.peff.net>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130254>

Jeff King wrote:
>> Add a simple hook that will run before checkouts.
> 
> What is the use case that makes it useful as a hook, and not simply as
> something people can do before running checkout?
> 
> I guess you can use it to block a checkout, but only after finding out
> _what_ you are going to checkout, but an exact use case escapes me.

Right.  Yes, this could be explained more.

Actually the use case is submodules.  When switching branches, the user
wants to add a hook to remove submodules.  However post-checkout is too
late, because the index and the .gitmodules file do not record the
submodule locations.

Of course the best explanation is a test case :) I'll look at cooking
one up.
-- 
Sam Vilain, Perl Hacker, Catalyst IT (NZ) Ltd.
phone: +64 4 499 2267        PGP ID: 0x66B25843
