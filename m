From: Jeff Epler <jepler@unpythonic.net>
Subject: Re: [PATCH 1/1] Introduce new build variables
 INSTALL_MODE_EXECUTABLE and INSTALL_MODE_DATA.
Date: Thu, 31 Jan 2013 07:25:27 -0600
Message-ID: <20130131132526.GA10622@unpythonic.net>
References: <5109D230.2030101@iam.tj>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: TJ <git@iam.tj>
X-From: git-owner@vger.kernel.org Thu Jan 31 14:33:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0uGz-0000w8-In
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 14:33:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754730Ab3AaNd1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 08:33:27 -0500
Received: from dsl.unpythonic.net ([206.222.212.217]:35592 "EHLO
	unpythonic.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754600Ab3AaNd1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 08:33:27 -0500
Received: by unpythonic.net (Postfix, from userid 1000)
	id 470492185F6; Thu, 31 Jan 2013 07:25:26 -0600 (CST)
Content-Disposition: inline
In-Reply-To: <5109D230.2030101@iam.tj>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215116>

I was not familiar with this behavior of 'install -d' that it tries to change
the mode of an existing directory, but GNU coreutils 8.12.197-032bb
certainly behaves as TJ reports.

As a possible alternative, what about
    [ -d $(DESTDIR)$(main1dir) ] || $(INSTALL) -d -m 755 $(DESTDIR)$(man1dir)
so that $(INSTALL) is not called when the target directory exists
already.

Jeff
