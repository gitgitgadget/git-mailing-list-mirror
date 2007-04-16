From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [PATCH] Add -q option to "git rm" to suppress output when there
 aren't errors.
Date: Sun, 15 Apr 2007 17:17:48 -0700
Message-ID: <4622C0AC.8090904@midwinter.com>
References: <20070416000408.GA19107@midwinter.com> <7v4pnh18hr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 16 02:17:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdEul-0001iz-1i
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 02:17:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754167AbXDPARs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Apr 2007 20:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754168AbXDPARs
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 20:17:48 -0400
Received: from tater.midwinter.com ([216.32.86.90]:50757 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754167AbXDPARr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2007 20:17:47 -0400
Received: (qmail 20128 invoked from network); 16 Apr 2007 00:17:47 -0000
Received: from c-76-21-17-123.hsd1.ca.comcast.net (HELO ?192.168.0.133?) (koreth@76.21.17.123)
  by tater.midwinter.com with SMTP; 16 Apr 2007 00:17:47 -0000
User-Agent: Thunderbird 1.5.0.10 (Macintosh/20070221)
In-Reply-To: <7v4pnh18hr.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44558>

Junio C Hamano wrote:
> Suppressing output is understandable and probably is a useful
> thing to do, but I do not see a justification to tie that
> quietness to making the status unuable...
>   

The status is unusable as is, actually, for the particular use case of 
cg-admin-rewritehist. If you try to use git-rm as an index filter, 
cg-admin-rewritehist will stop running as soon as you hit a revision 
that doesn't contain the file you're looking to filter out. (If the file 
doesn't exist in the first revision in your repo, that means it will do 
no work at all.)

My justification was that the "-f" option to the normal UNIX "rm" 
command does the same thing: it suppresses output and causes the command 
to exit with a zero status code even if no files match. But "git rm -f" 
was already taken.

If you like I'll be happy to split it into two separate options.

-Steve
