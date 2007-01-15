From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [RFC] Git config file reader in Perl (WIP)
Date: Mon, 15 Jan 2007 01:56:14 -0800
Message-ID: <20070115095613.GA4037@localdomain>
References: <200701150144.56793.jnareb@gmail.com> <20070115070826.GB939@localdomain> <200701151003.44498.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 15 19:00:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@m.gmane.org
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6Vi1-0006aR-2X
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 18:33:25 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1H6V9T-0003eK-BU
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 17:57:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbXAOJ4Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Jan 2007 04:56:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932167AbXAOJ4Q
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 04:56:16 -0500
Received: from hand.yhbt.net ([66.150.188.102]:38830 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932165AbXAOJ4Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 04:56:16 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 4C57B7DC094;
	Mon, 15 Jan 2007 01:56:14 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Mon, 15 Jan 2007 01:56:14 -0800
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <200701151003.44498.jnareb@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36811>

Jakub Narebski <jnareb@gmail.com> wrote:
> Eric Wong wrote:
> > Jakub Narebski <jnareb@gmail.com> wrote:
> >> To make gitweb faster I thought about adding to it, or to Git.pm,
> >> simple nonvalidation config file reader. Nonvalidating means that
> >> it would accept some input which git-repo-config considers invalid.
> > 
> > How about something like git-for-each-ref that dumps the entire output
> > of a config file into an eval()-able string?  That way we don't have to
> > deal with corner-cases and subtle differences between C and Perl
> > implementations.
> 
> The idea is (at least for gitweb) to avoid cost of fork. And I think
> if the format gets documented properly, there should be no differences
> in config file parsing.

If the Perl output is redirected to a file (say .git/config.perl) and
only regenerated when .git/config changes, `do(".git/config.perl")' will
likely be faster since all the parsing will be done by Perl itself.

-- 
Eric Wong
