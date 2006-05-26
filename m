From: Christopher Faylor <me@cgf.cx>
Subject: Re: file name case-sensitivity issues
Date: Thu, 25 May 2006 23:59:25 -0400
Message-ID: <20060526035925.GA17618@trixie.casa.cgf.cx>
References: <20060523210615.GB5869@steel.home> <7v7j4c4af3.fsf@assigned-by-dhcp.cox.net> <20060525154735.GA6119@steel.home> <7vac96ufxv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri May 26 05:59:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjTU1-00050S-Ae
	for gcvg-git@gmane.org; Fri, 26 May 2006 05:59:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030214AbWEZD70 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 May 2006 23:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030288AbWEZD70
	(ORCPT <rfc822;git-outgoing>); Thu, 25 May 2006 23:59:26 -0400
Received: from pool-71-248-179-19.bstnma.fios.verizon.net ([71.248.179.19]:8905
	"EHLO cgf.cx") by vger.kernel.org with ESMTP id S1030214AbWEZD7Z
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 May 2006 23:59:25 -0400
Received: by cgf.cx (Postfix, from userid 201)
	id 5700013C01F; Thu, 25 May 2006 23:59:25 -0400 (EDT)
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vac96ufxv.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20791>

On Thu, May 25, 2006 at 11:17:48AM -0700, Junio C Hamano wrote:
>I have git installed on a Cygwin on NTFS at work...

Maybe this has been mentioned already but I wanted to point out that
Cygwin's mount has a "managed" option: "mount -o managed c:/foo /foo"
which causes cygwin to encode "problem" characters into the filename.

This means that there is a possibility that you'll run into the Windows
260 character max filename limit sooner so many people don't like to use
this option.  However, since only uppercase characters and characters
like ">", ":", etc.  are encoded, in practice you wouldn't see path
length problems *from this* very often.  There is, of course, some
processing overhead involved in this, too, so using managed mode
will slow things down slightly.

We've been contemplating using Unicode functions in cygwin for a while
since those allow much longer path lengths but this is a massive change
and would potentially cause problems on Windows 9x.  There has also been
some discussion of using native NT calls which, I believe, allow case
preservation like linux.  However, those have a similar set of problems.

FYI,
cgf
