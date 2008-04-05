From: Gerrit Pape <pape@smarden.org>
Subject: Re: [PATCH (BUGFIX)] gitweb: Fix "Use of uninitialized value"
	error in 'history' view
Date: Sat, 5 Apr 2008 16:43:03 +0000
Message-ID: <20080405164303.30566.qmail@47fa24fd520dbf.315fe32.mid.smarden.org>
References: <200804041623.44595.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 05 18:43:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JiBUD-0000HV-FH
	for gcvg-git-2@gmane.org; Sat, 05 Apr 2008 18:43:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752407AbYDEQmm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Apr 2008 12:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752444AbYDEQmm
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Apr 2008 12:42:42 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:47702 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752394AbYDEQml (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Apr 2008 12:42:41 -0400
Received: (qmail 30567 invoked by uid 1000); 5 Apr 2008 16:43:03 -0000
Content-Disposition: inline
In-Reply-To: <200804041623.44595.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78852>

On Fri, Apr 04, 2008 at 03:23:42PM +0100, Jakub Narebski wrote:
> When asked for history of a file with no $hash ('h') parameter set,
> and which file is not present in current branch ("HEAD" or given by
> $hash_hase ('hb') parameter), but is present deeper in the full
> history of a branch, gitweb would spew multiple of "Use of
> uninitialized value" warnings, and some links would be missing.
> This commit fixes this bug.
> 
> This bug occurs in the rare cases when "git log -- <path>" is empty
> and "git log --full-history -- <path>" is not.  Gitweb tried to get
> file type (it means if it is 'tree' or 'blob' or even 'commit', as
> 'history' view is for single path which can be any of given types)
> from the commit we start searching from, and not among found commits.

Do you know whether this fixes http://bugs.debian.org/469083 too?  I
took a short look back then to fix it, but didn't manage it in a
reasonable amount of time.

Thanks, Gerrit.
