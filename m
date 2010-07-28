From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv3] Updated patch series for providing mechanism to list
	available repositories
Date: Tue, 27 Jul 2010 19:33:36 -0500
Message-ID: <20100728003336.GA2248@dert.cs.uchicago.edu>
References: <1279725355-23016-1-git-send-email-gdb@mit.edu> <20100726232855.GA3157@burratino> <AANLkTikqA3kNif+7Bi+=xkJ2FgCFAsfCj0N5dft5pnFR@mail.gmail.com> <201007270916.59210.j.sixt@viscovery.net> <20100727174105.GA5578@burratino> <AANLkTikr5jjZJa2irLb2rNew8ngJcv3rhcFV+pNRpRrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	gitster@pobox.com, git@vger.kernel.org
To: Greg Brockman <gdb@MIT.EDU>
X-From: git-owner@vger.kernel.org Wed Jul 28 02:53:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Odutv-0008OS-5g
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 02:53:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753669Ab0G1Axd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jul 2010 20:53:33 -0400
Received: from camembert.cs.uchicago.edu ([128.135.164.153]:38550 "EHLO
	smtp.cs.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753509Ab0G1Axc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 20:53:32 -0400
X-Greylist: delayed 1194 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Jul 2010 20:53:32 EDT
Received: from dert.cs.uchicago.edu (dert.cs.uchicago.edu [128.135.11.157])
	by smtp.cs.uchicago.edu (Postfix) with ESMTP id E8A36A13C;
	Tue, 27 Jul 2010 19:33:36 -0500 (CDT)
Received: by dert.cs.uchicago.edu (Postfix, from userid 10442)
	id 9B48A9A16D; Tue, 27 Jul 2010 19:33:36 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <AANLkTikr5jjZJa2irLb2rNew8ngJcv3rhcFV+pNRpRrw@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152022>

Greg Brockman wrote:

> Hmm, ok.  So if I'm not mistaken, the only outstanding issue is
> whether to provide a way to globally disable git-shell-commands.  Do
> you have a particular threat model in mind?

No, it was only a vague thing.  I do not even use git-shell
myself, so it was a vague worry for a scenario I am not even
involved in.  So if you have thought it over and decided it is
not an issue, that is good enough for me.

What would be most comforting is an explanation like this:

 "Uses not using this feature will not be impacted by patch 1,
  since all it adds is:
  
   - some memory allocation
   - a call to split_cmdline, which I have audited and
     seems to be safe
   - an execv that does not permit . or / characters and so
     can only run commands from the directory the user is
     in (which would be safe because..."

Actually if I understand correctly I am not comforted at all,
because a former user at a multi-user installation that only has
git-shell access now can suddenly run arbitrary commands from
the home directory once git is upgraded.

Jonathan
