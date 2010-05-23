From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCHv3 GSoC] git-instaweb: Configure it to work with new
	gitweb structure
Date: Sun, 23 May 2010 09:56:45 +0000
Message-ID: <20100523095645.GD3426@dcvr.yhbt.net>
References: <1274599968-3749-1-git-send-email-pavan.sss1991@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jnareb@gmail.com, chriscool@tuxfamily.org,
	pasky@ucw.cz
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 23 11:56:48 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OG7vJ-0002ZL-0B
	for gcvg-git-2@lo.gmane.org; Sun, 23 May 2010 11:56:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753870Ab0EWJ4k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 May 2010 05:56:40 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:41302 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753594Ab0EWJ4j (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 May 2010 05:56:39 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 407B31F4EF;
	Sun, 23 May 2010 09:56:39 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1274599968-3749-1-git-send-email-pavan.sss1991@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147568>

Pavan Kumar Sunkara <pavan.sss1991@gmail.com> wrote:
> While at it, change apache2 configuration to use the same access log
> and error log files as the rest of web servers supported by
> git-instaweb.

Hi Pavan, I'm late to this thread, but I'm leaning against forcing
access logs onto people.  I don't believe access logs are necessary for
instaweb.  Error logs are important for debugging breakage, yes, but
access logs aren't worth the trouble IMHO.

Also, using the same error log paths might make it confusing to people
switching between web servers.  In fact, it may be the most confusing
for those folks if they're trying different web servers and forgetting
to shut down the previous server before starting the next.  They could
end up seeing confusing log messages from the wrong server if they
look in the error log to debug the problem.

I'm not sure why Mongoose has access logs enabled by default, but I know
I conciously left it out by default for lighttpd/apache/webrick.

-- 
Eric Wong
