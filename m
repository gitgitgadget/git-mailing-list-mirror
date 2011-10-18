From: Jeff Sipek <jeffpc@josefsipek.net>
Subject: Re: [GUILT] handle branches with slashes in guilt-graph
Date: Tue, 18 Oct 2011 09:30:38 -0400
Message-ID: <20111018133038.GA16088@josefsipek.net>
References: <4E9D57BB.2030707@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, ceder@lysator.liu.se
To: Per Cederqvist <cederp@opera.com>
X-From: git-owner@vger.kernel.org Tue Oct 18 15:30:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RG9kj-0006eC-BO
	for gcvg-git-2@lo.gmane.org; Tue, 18 Oct 2011 15:30:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755326Ab1JRNak (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Oct 2011 09:30:40 -0400
Received: from josefsipek.net ([64.9.206.49]:53652 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755229Ab1JRNaj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2011 09:30:39 -0400
Received: by josefsipek.net (Postfix, from userid 1000)
	id C66E358534; Tue, 18 Oct 2011 09:30:38 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <4E9D57BB.2030707@opera.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183881>

On Tue, Oct 18, 2011 at 12:40:59PM +0200, Per Cederqvist wrote:
> Avoid sed errors when the branch name contains a slash.

Makes sense.  I'll test it and add it to my patch queue.

Thanks,

Jeff.

> Signed-off-by: Per Cederqvist <cederp@opera.com>
> 
> --- /usr/bin/guilt-graph~	2011-01-25 20:15:50.000000000 +0100
> +++ /usr/bin/guilt-graph	2011-10-18 12:30:31.000000000 +0200
> @@ -37,9 +37,10 @@ disp "digraph G {"
> 
>  current="$top"
> 
> +safebranch=`echo "$branch"|sed 's%/%\\\\/%g'`
>  while [ "$current" != "$base" ]; do
>  	pname=`git show-ref | sed -n -e "
> -/^$current refs\/patches\/$branch/ {
> +/^$current refs\/patches\/$safebranch/ {
>  	s,^$current refs/patches/$branch/,,
>  	p
>  	q

-- 
Once you have their hardware. Never give it back.
(The First Rule of Hardware Acquisition)
