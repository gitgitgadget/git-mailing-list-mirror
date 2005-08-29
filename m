From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: gitweb : index.aux
Date: Mon, 29 Aug 2005 20:25:34 +0200
Message-ID: <20050829182534.GA16808@vrfy.org>
References: <20050829093500.54242.qmail@web53602.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 29 20:32:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9oKg-0005f5-C7
	for gcvg-git@gmane.org; Mon, 29 Aug 2005 20:26:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbVH2SZk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Aug 2005 14:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbVH2SZk
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Aug 2005 14:25:40 -0400
Received: from soundwarez.org ([217.160.171.123]:40856 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S1751297AbVH2SZj (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Aug 2005 14:25:39 -0400
Received: by soundwarez.org (Postfix, from userid 2702)
	id C04B456F39; Mon, 29 Aug 2005 20:25:34 +0200 (CEST)
To: Komal Shah <komal_shah802003@yahoo.com>
Content-Disposition: inline
In-Reply-To: <20050829093500.54242.qmail@web53602.mail.yahoo.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7915>

On Mon, Aug 29, 2005 at 02:35:00AM -0700, Komal Shah wrote:
> Kay,
> 
> I am able to setup gitweb tree for my linux-omap tree internally, but
> for this I am using $project_list equals to $projectroot. I want to add
> more projects, but I don't know how write/generate index.aux file?

Yeah, this works only if all the trees are in one directory. The index file
is a simple list with the pathes url encoded. (It is exported by a cron job
running on kernel.org. We need it there cause the trees are in subdirs and
the mirrored trees don't have the original ownership, that is displayed in
gitweb.)

> Me don't know much about cgi-bin/perl :(

So let's do it in perl then. :) Just encode the pathes and put them into
the file (optionaly the owner comes after a space in the same line):
  perl -e 'use CGI; print CGI::escape("/this/is/my/project") . "\n"'
  %2Fthis%2Fis%2Fmy%2Fproject

Good luck,
Kay
