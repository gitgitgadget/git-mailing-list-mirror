From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [RFC PATCH] push: start warning upcoming default change for
 push.default
Date: Fri, 16 Mar 2012 09:51:52 +0100
Message-ID: <20120316085152.GA22273@ecki>
References: <vpqobs65gfc.fsf@bauges.imag.fr>
 <1331281886-11667-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Mar 16 09:53:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8SuU-0002zP-Q5
	for gcvg-git-2@plane.gmane.org; Fri, 16 Mar 2012 09:53:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032684Ab2CPIxM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Mar 2012 04:53:12 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:2197 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032664Ab2CPIwi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2012 04:52:38 -0400
Received: from localhost (p5B22EAFE.dip.t-dialin.net [91.34.234.254])
	by bsmtp.bon.at (Postfix) with ESMTP id E2F23A7EE9;
	Fri, 16 Mar 2012 09:53:33 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1331281886-11667-1-git-send-email-Matthieu.Moy@imag.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193245>

Hi,

On Fri, Mar 09, 2012 at 09:31:26AM +0100, Matthieu Moy wrote:
>
> In preparation for flipping the default to the "upstream" mode from the
> "matching" mode that is the upstream default, start warning users when they
> rely on unconfigured "git push" to default to the "matching" mode.

I haven't had time to follow the entire discussion, but I have been
thinking about this myself a little and I also find it hard to decide
between "current" and "upstream". So I just wanted to throw in another
option:

If neither default is the right thing to do, then we should not choose
either. Instead, by default make push act according to "current" or
"upstream" only if they would do the same thing anyways. In other words,
push the current branch only if it is also tracking a remote branch of
the same name.

If "current" and "upstream" disagree, git push errors out and asks the
user to use an explicit refspec or change push.default according to
their preferred workflow.

Clemens
