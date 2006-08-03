From: Blu Corater <blu@daga.cl>
Subject: Re: gitweb testing with non-apache web server
Date: Thu, 3 Aug 2006 11:56:03 -0400
Message-ID: <20060803155603.GS7533@daga.cl>
References: <20060803075403.GA5238@buici.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Aug 03 17:56:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8fYQ-00035Y-LL
	for gcvg-git@gmane.org; Thu, 03 Aug 2006 17:56:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964816AbWHCP4G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Aug 2006 11:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964820AbWHCP4G
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Aug 2006 11:56:06 -0400
Received: from [201.215.212.46] ([201.215.212.46]:17642 "EHLO daga.cl")
	by vger.kernel.org with ESMTP id S964816AbWHCP4F (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Aug 2006 11:56:05 -0400
Received: from blu by daga.cl with local (Exim 4.62)
	(envelope-from <blu@daga.cl>)
	id 1G8fYJ-0002pB-Aj
	for git@vger.kernel.org; Thu, 03 Aug 2006 11:56:03 -0400
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060803075403.GA5238@buici.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24736>

On Thu, Aug 03, 2006 at 12:54:03AM -0700, Marc Singer wrote:
> I would like to use gitweb with the Cherokee web server because the
> host that I have on hand has very limited RAM, 32MiB.  Neither the
> version of gitweb available on Debian (v264) nor the latest in the git
> repo works.
> 
> I did some debugging on the latest repo version.  The lines
> 
>   our $project = ($cgi->param('p') || $ENV{'PATH_INFO'});
>   if (defined $project) {
>      ...
> 
> are being executed even though the url is
> 
>   http://server/git
> 
> I think that the problem is that Cherokee translates the request URL
> into
> 
>   http://server/git/
> 
> which means that the $ENV{'PATH_INFO'} is the string "/" insted of
> being undefined.
> 
> The error I'm seeing is that the request path is forbidden, but I
> suspect that this is some sort of misunderstanding between the web
> server and the script.

I am using Cherokee+GitWeb and the behaviour observed is that
http://server/git will return the default Cherokee index page, but
http://server/git/, with a slash at the end, works. 

-- 
Blu.
