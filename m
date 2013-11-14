From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [ANNOUNCE] Git v1.8.5-rc2
Date: Thu, 14 Nov 2013 11:47:04 -0500
Message-ID: <5284FE88.8040208@xiplink.com>
References: <xmqqsiuzdhov.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Kyle J. McKay" <mackyle@gmail.com>,
	Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 14 17:46:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vh047-0001Rf-HC
	for gcvg-git-2@plane.gmane.org; Thu, 14 Nov 2013 17:46:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755093Ab3KNQqn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Nov 2013 11:46:43 -0500
Received: from smtp138.ord.emailsrvr.com ([173.203.6.138]:41366 "EHLO
	smtp138.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755700Ab3KNQq3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Nov 2013 11:46:29 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp18.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id DEA6A305C4;
	Thu, 14 Nov 2013 11:46:28 -0500 (EST)
X-Virus-Scanned: OK
Received: by smtp18.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 7F4AE30532;
	Thu, 14 Nov 2013 11:46:28 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <xmqqsiuzdhov.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237857>

On 13-11-13 06:07 PM, Junio C Hamano wrote:
> A release candidate Git v1.8.5-rc2 is now available for testing
> at the usual places.

 [ snip ]

> Updates since v1.8.4
> --------------------
> 
> Foreign interfaces, subsystems and ports.
> 
>  * "git-svn" used with SVN 1.8.0 when talking over https:// connection
>    dumped core due to a bug in the serf library that SVN uses.  Work
>    it around on our side, even though the SVN side is being fixed.
> 
>  * On MacOS X, we detected if the filesystem needs the "pre-composed
>    unicode strings" workaround, but did not automatically enable it.
>    Now we do.
> 
>  * remote-hg remote helper misbehaved when interacting with a local Hg
>    repository relative to the home directory, e.g. "clone hg::~/there".
> 
>  * imap-send ported to OS X uses Apple's security framework instead of
>    OpenSSL one.
> 
>  * Subversion 1.8.0 that was recently released breaks older subversion
>    clients coming over http/https in various ways.

Isn't this the same as the serf fixes ([1],[2])?  If not, what git change is
it referring to?

BTW,

$ git log --no-merges --oneline v1.8.4..v1.8.5-rc2 -- git-svn.perl perl/Git/SVN/

shows:

f849bb6 git-svn: Warn about changing default for --prefix in Git v2.0
60786bd git-svn: fix signed commit parsing
73ffac3 git-svn: fix termination issues for remote svn connections
8ac251b git-svn: allow git-svn fetching to work using serf

The release notes don't seem to mention 60786bd.

		M.

[1] http://thread.gmane.org/gmane.comp.version-control.git/229720
[2] http://thread.gmane.org/gmane.comp.version-control.git/233701
