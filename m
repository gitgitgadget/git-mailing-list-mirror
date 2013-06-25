From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH] [submodule] Add depth to submodule update
Date: Wed, 26 Jun 2013 00:11:32 +0200
Message-ID: <20130625221132.GB4161@sandbox-ub>
References: <1371974698-28685-1-git-send-email-iveqy@iveqy.com>
 <20130624224925.GC32270@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	Jens Lehmann <jens.lehmann@web.de>
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Wed Jun 26 00:11:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrbSg-0001HQ-Ig
	for gcvg-git-2@plane.gmane.org; Wed, 26 Jun 2013 00:11:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751727Ab3FYWLj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jun 2013 18:11:39 -0400
Received: from smtprelay03.ispgateway.de ([80.67.31.37]:38838 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751267Ab3FYWLi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jun 2013 18:11:38 -0400
Received: from [77.20.34.36] (helo=sandbox-ub)
	by smtprelay03.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1UrbSY-0002pj-Fh; Wed, 26 Jun 2013 00:11:34 +0200
Content-Disposition: inline
In-Reply-To: <20130624224925.GC32270@paksenarrion.iveqy.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229006>

On Tue, Jun 25, 2013 at 12:49:25AM +0200, Fredrik Gustafsson wrote:
> Used only when a clone is initialized. This is useful when the submodule(s)
> are huge and you're not really interested in anything but the latest commit.
> 
> Signed-off-by: Fredrik Gustafsson <iveqy@iveqy.com>

I this is a valid use case. But this option only makes sense when a
submodule is newly cloned so I am not sure whether submodule update is
the correct place. Let me think about this a little more. Since we do
not have any extra command that initiates the clone this is probably the
only place we can put this option. But at the moment it does not feel
completely right.

Apart from that the code looks good. If the user does a checkout of a
revision that was not fetched submodule update will error out the same
way as if someone forgot to push his submodule changes. So that should
not be a problem.

Cheers Heiko
