From: Marc Singer <elf@buici.com>
Subject: gitweb testing with non-apache web server
Date: Thu, 3 Aug 2006 00:54:03 -0700
Message-ID: <20060803075403.GA5238@buici.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Aug 03 09:54:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8Y1x-0000x4-L3
	for gcvg-git@gmane.org; Thu, 03 Aug 2006 09:54:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932383AbWHCHyF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Aug 2006 03:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932386AbWHCHyF
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Aug 2006 03:54:05 -0400
Received: from 206-124-142-26.buici.com ([206.124.142.26]:43436 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S932383AbWHCHyE
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 3 Aug 2006 03:54:04 -0400
Received: (qmail 5896 invoked by uid 1000); 3 Aug 2006 07:54:03 -0000
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24709>

I would like to use gitweb with the Cherokee web server because the
host that I have on hand has very limited RAM, 32MiB.  Neither the
version of gitweb available on Debian (v264) nor the latest in the git
repo works.

I did some debugging on the latest repo version.  The lines

  our $project = ($cgi->param('p') || $ENV{'PATH_INFO'});
  if (defined $project) {
     ...

are being executed even though the url is

  http://server/git

I think that the problem is that Cherokee translates the request URL
into

  http://server/git/

which means that the $ENV{'PATH_INFO'} is the string "/" insted of
being undefined.

The error I'm seeing is that the request path is forbidden, but I
suspect that this is some sort of misunderstanding between the web
server and the script.

So, I wonder if someone who has a working gitweb would be willing to
test with Cherokee or some other resource conservative web server.

Cheers.
