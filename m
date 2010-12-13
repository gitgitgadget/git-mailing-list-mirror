From: "J.H." <warthog9@eaglescrag.net>
Subject: Re: [RFC PATCH 0/2] gitweb: die_error (error handling) improvements
Date: Sun, 12 Dec 2010 18:17:12 -0800
Message-ID: <4D058228.7040905@eaglescrag.net>
References: <20101213004259.9475.87376.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 13 03:15:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PRxwk-0005OI-Gs
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 03:15:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756556Ab0LMCPU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Dec 2010 21:15:20 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:40576 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756187Ab0LMCPT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Dec 2010 21:15:19 -0500
Received: from voot-cruiser.eaglescrag.net (c-71-202-185-40.hsd1.ca.comcast.net [71.202.185.40])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.4/8.14.3) with ESMTP id oBD2FGho028587
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Sun, 12 Dec 2010 18:15:17 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Lightning/1.0b2pre Thunderbird/3.0.10
In-Reply-To: <20101213004259.9475.87376.stgit@localhost.localdomain>
X-Enigmail-Version: 1.0.1
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Sun, 12 Dec 2010 18:15:17 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163504>

On 12/12/2010 04:46 PM, Jakub Narebski wrote:
> The following two patch series changes improve error / exception
> handling in gitweb, preparing the way for gitweb output caching, but
> useful even without it.
> 
> I'm sending this patch series early to gather feedback on possible
> ways of improving error / exception handling in gitweb.

Personally, instead of another band-aid over this problem, and adding
(or further legitimizing) goto statements inside gitweb I'd much *MUCH*
rather we actually put in the work to actually clean this up.

This is the direction I'm heading in, which I mentioned in an earlier
e-mail.

There are a *LOT* of disadvantages to the eval mechanism in perl.  It's
the standard but gitweb is getting more and more complex, and eval is
simplistic.  Couple that with the complexity and uncertainty that things
like goto add to the code, I would *MUCH* rather not see this series go
in, as I think it is the wrong approach to fixing this.

- John 'Warthog9' Hawley
