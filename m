From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH 2/2] Support sizes >=2G in various config options
 accepting 'g' sizes.
Date: Tue, 6 Sep 2011 09:44:21 +0200
Message-ID: <20110906074421.GB28490@ecki>
References: <1315223155-4218-1-git-send-email-nix@esperi.org.uk>
 <1315223155-4218-2-git-send-email-nix@esperi.org.uk>
 <CAGdFq_gFNHq9Cgv4F4Q6VQ=G7odfUJ5pUFWn=OYE-BfXzP=Enw@mail.gmail.com>
 <87ty8rm6th.fsf@spindle.srvr.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Nix <nix@esperi.org.uk>
X-From: git-owner@vger.kernel.org Tue Sep 06 09:46:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0qMt-000877-9r
	for gcvg-git-2@lo.gmane.org; Tue, 06 Sep 2011 09:46:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753292Ab1IFHqq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Sep 2011 03:46:46 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:61696 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753111Ab1IFHqp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2011 03:46:45 -0400
Received: from localhost (p5B22CD62.dip.t-dialin.net [91.34.205.98])
	by bsmtp.bon.at (Postfix) with ESMTP id EE8F32C401D;
	Tue,  6 Sep 2011 09:46:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <87ty8rm6th.fsf@spindle.srvr.nix>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180776>

On Mon, Sep 05, 2011 at 02:56:10PM +0100, Nix wrote:
> 
> Well, we're parsing longs, not ints. If sizeof(long)>sizeof(int), or we
> have long long and sizeof(long long)>sizeof(int), then we can always
> detect overflows when saving into the appropriate type: but if we don't
> have long long, or if we have neither strto(u)ll() nor strto[ui]max(),
> we could only detect overflow by looking at the raw text string and
> checking it by hand to see if it would fit. I judged this pointless
> extra complexity for a very rare edge case (machines with neither
> strot(u)ll() nor strto[ui]max() are generally quite old and people
> aren't going to be specifying sizes in gigabytes on such machines
> anyway.)

Is this also true for Windows and other platforms?

And I don't think it's about whether or not people are likely to
specify sizes in gigabytes on old machines. People are bound to
blindly copy configuration files from one machine to another. In
any case, my expectation would be for the configuration options to
do what I tell them, or error out if they do not make sense.

Clemens
