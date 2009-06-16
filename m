From: Allan Wind <allan_wind@lifeintegrity.com>
Subject: Re: Using git for code deployment on webservers?
Date: Tue, 16 Jun 2009 03:13:28 -0400
Message-ID: <20090616071328.GB6615@lifeintegrity.com>
References: <200906160111.47325.ioe-git@rameria.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: ioe-git@rameria.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 16 09:23:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGT14-0002nc-RK
	for gcvg-git-2@gmane.org; Tue, 16 Jun 2009 09:23:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751528AbZFPHXZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2009 03:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751513AbZFPHXY
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jun 2009 03:23:24 -0400
Received: from static-173-48-39-13.bstnma.fios.verizon.net ([173.48.39.13]:53549
	"EHLO lifeintegrity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750902AbZFPHXX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2009 03:23:23 -0400
X-Greylist: delayed 597 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Jun 2009 03:23:23 EDT
Received: from vent.lifeintegrity.com (Wireless_Broadband_Router [173.48.39.13])
	by submission.lifeintegrity.com (Postfix) with ESMTPS id 679B33001F;
	Tue, 16 Jun 2009 03:13:29 -0400 (EDT)
Received: by vent.lifeintegrity.com (Postfix, from userid 1000)
	id 0837F304B04; Tue, 16 Jun 2009 03:13:28 -0400 (EDT)
Mail-Followup-To: git@vger.kernel.org, ioe-git@rameria.de
Content-Disposition: inline
In-Reply-To: <200906160111.47325.ioe-git@rameria.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121660>

On 2009-06-16T01:11:47, Ingo Oeser wrote:
> - Transfer as little as possible data.
>   Cancel out addition and deletion on the fly.

I use `git diff` with the post-receive hook to distribute changes 
to my web server.  diff carries the previous content when you 
delete a file, and in my case this was large mpeg files defeating 
the purpose somewhat.

If you do not mind having a full repository on the web servers, 
then pushing changes might work better.  This appears to be what 
you are doing now though.

If I had to scale this I would probably build a master image 
(either locally or remotely) and use rsync to distribute the 
content instead of git.

> - Nearly atomic update of file tree (easy to implement outside git)

stow can be handy for this.


/Allan
-- 
Allan Wind
Life Integrity, LLC
http://lifeintegrity.com
