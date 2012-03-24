From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: Not a git repository: '.'
Date: Sat, 24 Mar 2012 19:14:31 +0100
Message-ID: <4F6E0F07.6030400@kdbg.org>
References: <87r4wh6hce.fsf@smith.obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: greened@obbligato.org
X-From: git-owner@vger.kernel.org Sat Mar 24 19:15:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBVUT-0000Le-LF
	for gcvg-git-2@plane.gmane.org; Sat, 24 Mar 2012 19:15:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755733Ab2CXSOf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Mar 2012 14:14:35 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:25056 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754047Ab2CXSOf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Mar 2012 14:14:35 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 2D307130045;
	Sat, 24 Mar 2012 19:14:31 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id AE98B19F34A;
	Sat, 24 Mar 2012 19:14:31 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.27) Gecko/20120215 SUSE/3.1.19 Thunderbird/3.1.19
In-Reply-To: <87r4wh6hce.fsf@smith.obbligato.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193835>

Am 24.03.2012 18:26, schrieb greened@obbligato.org:
> I have a post-receive hook set up that does the following when something
> is pushed to a repository.
> 
> - Change directory to another non-bare repository
> - Do 'git status'
> 
> I get this error from the original git push:
> 
> remote: fatal: Not a git repository: '.'
> 
> Debug output tells me I am in the correct directory when attempting the
> status check.  This directory is a full git workarea (i.e. not a bare
> repository).
> 
> Any idea what git is complaining about?  I can log on to the server and
> do 'git status' in the target directory and everything is fine.

Most likely, GIT_DIR=. is set when the hook is entered. Does unset
GIT_DIR help?

-- Hannes
