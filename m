From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [RFC 2/2] Don't push a repository with unpushed submodules
Date: Wed, 29 Jun 2011 13:34:53 -0400
Message-ID: <4E0B623D.1060507@xiplink.com>
References: <1309112987-3185-1-git-send-email-iveqy@iveqy.com> <1309112987-3185-3-git-send-email-iveqy@iveqy.com> <4E0A506B.6040407@xiplink.com> <20110628230248.GA4436@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, hvoigt@hvoigt.net,
	jens.lehmann@web.de
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Wed Jun 29 19:35:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbyfY-0007EV-DW
	for gcvg-git-2@lo.gmane.org; Wed, 29 Jun 2011 19:35:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757284Ab1F2RfR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jun 2011 13:35:17 -0400
Received: from smtp172.iad.emailsrvr.com ([207.97.245.172]:55055 "EHLO
	smtp172.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752279Ab1F2RfO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2011 13:35:14 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp47.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTP id 2E3243A8450;
	Wed, 29 Jun 2011 13:35:13 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp47.relay.iad1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id DEE9B3A828B;
	Wed, 29 Jun 2011 13:35:12 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110516 Thunderbird/3.1.10
In-Reply-To: <20110628230248.GA4436@paksenarrion.iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176451>

On 11-06-28 07:02 PM, Fredrik Gustafsson wrote:
> 
>  [ ... ]
> 
> Serverside, we cannot guarantee that all submodules are reachable, they
> might be on different servers, maybe not even connected to eachothers. Even
> if they are connected this would requiring network traffic. Making this check 
> an even bigger performance killer. This check is not supposed to guarantee a 
> sane server-repo (that would be much harder) and therefore this check is 
> "overkill" to have on the server-side. Client side we always have all
> information needed for this.
> 
> Note the problem:
> "Prevent the developer of pushing a superrepo that has submodule
> (commits) only locally avaliable"
> 
> That's the problem we're trying to solve, NOT:
> 
> "Prevent the developer of pushing a superrepo that has submodule
> (commits) not avaliable for an other developer"
> 
> The second problem is just too complex and too slow to solve in a generic
> way.

Fair enough.

So my only remaining concern is that using "push -f" to override the check is
too much.  I'd rather see a different option control this.  Maybe
--ignore-submodules?  (I think it'd be fine if -f implied --ignore-submodules.)

		M.
