From: Daniel Shahaf <danielsh@apache.org>
Subject: Re: [PATCH 2/2] git-svn: allow git-svn fetching to work using serf
Date: Sun, 7 Jul 2013 16:39:57 +0300
Message-ID: <20130707133957.GA3648@lp-shahaf.local>
References: <ABDE5FFA-C19F-44BF-A360-3FD5D74F2B28@gmail.com> <20130707002430.GE30132@google.com> <8CACBE8F-8672-43AB-882E-4ADA05B4D822@gmail.com> <20130707022332.GD4193@google.com> <3871C226-16AE-4E25-8AD3-007EDAB0E25F@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	David Rothenberger <daveroth@acm.org>,
	Petr Baudis <pasky@ucw.cz>, Eric Wong <normalperson@yhbt.net>
To: Kyle McKay <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 07 15:46:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvpCG-0004x1-Et
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 15:40:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751821Ab3GGNkI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 09:40:08 -0400
Received: from hermes.apache.org ([140.211.11.3]:26094 "HELO mail.apache.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751759Ab3GGNkH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 09:40:07 -0400
Received: (qmail 84065 invoked by uid 99); 7 Jul 2013 13:40:05 -0000
Received: from minotaur.apache.org (HELO minotaur.apache.org) (140.211.11.9)
    by apache.org (qpsmtpd/0.29) with ESMTP; Sun, 07 Jul 2013 13:40:05 +0000
Received: from localhost (HELO lp-shahaf.local) (127.0.0.1)
  (smtp-auth username danielsh, mechanism plain)
  by minotaur.apache.org (qpsmtpd/0.29) with ESMTP; Sun, 07 Jul 2013 13:40:04 +0000
Content-Disposition: inline
In-Reply-To: <3871C226-16AE-4E25-8AD3-007EDAB0E25F@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229776>

Kyle McKay wrote on Sat, Jul 06, 2013 at 19:46:40 -0700:
> On Jul 6, 2013, at 19:23, Jonathan Nieder wrote:
>> Kyle McKay wrote:
>>
>>> Unless bulk updates are disabled when using the serf access method
>>> (the only one available with svn 1.8) for https?: urls,
>>> apply_textdelta does indeed get called multiple times in a row
>>> without an intervening temp_release.
>>
>> You mean "Unless bulk updates are enabled" and "without an intervening
>> close_file", right?
>
> The problem seems to be skelta mode although it may just be the fact  
> that ra_serf has multiple connections outstanding and since ra_neon only 
> ever has one it can't happen over ra_neon.
>
> If the server disables bulk updates (SVNAllowBulkUpdates Off) all  
> clients are forced to use skelta mode, even ra_neon clients.

As Brane and I have pointed out, git-svn can instruct libsvn_* to use
bulk updates regardless of the server version, by setting
SVN_CONFIG_OPTION_HTTP_BULK_UPDATES (new in 1.8).

If you have questions about that, though, please address them to
users@subversion.apache.org (the proper list for API usage questions),
not to me personally.

Cheers,

Daniel
