From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: HTTP push
Date: Sun, 6 Nov 2005 20:31:49 -0800
Message-ID: <20051107043149.GH3001@reactrix.com>
References: <Pine.LNX.4.63.0511070328230.25684@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 07 05:33:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EYygA-00071h-6t
	for gcvg-git@gmane.org; Mon, 07 Nov 2005 05:32:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932393AbVKGEcD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Nov 2005 23:32:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932405AbVKGEcD
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Nov 2005 23:32:03 -0500
Received: from 195.37.26.69.virtela.com ([69.26.37.195]:28753 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S932393AbVKGEcC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Nov 2005 23:32:02 -0500
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id jA74Vo5Q018706;
	Sun, 6 Nov 2005 20:31:50 -0800
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id jA74VnQM018704;
	Sun, 6 Nov 2005 20:31:49 -0800
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0511070328230.25684@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11252>

On Mon, Nov 07, 2005 at 03:35:33AM +0100, Johannes Schindelin wrote:

> I played a little with git-http-push. There are some strange things going 
> on: whenever I commented out the calls to curl_multi_remove_handle() and 
> curl_multi_cleanup(), all was well. Whenever I did not, there was either a 
> segfault, or an endless loop.

http-push is a bit more aggressive than http-fetch about freeing up memory,
perhaps too aggressive...  I ran into similar issues when memory was
freed more than once.

> I will run some tests on another client with valgrind (that will wait 
> until tomorrow; it's 3.30am local time, so I head to bed).

Thanks, I'll work on memory cleanup some more.

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
