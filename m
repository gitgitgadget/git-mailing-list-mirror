From: Eric Blake <ebb9@byu.net>
Subject: Re: [PATCH 01/18] rebase -i: Make the condition for an &quot;if&quot; more transparent
Date: Thu, 14 Jan 2010 15:42:22 +0000 (UTC)
Message-ID: <loom.20100114T164214-897@post.gmane.org>
References: <cover.1263447037.git.mhagger@alum.mit.edu> <aa37ee8a68d460df172b23b4999fbe4ce7d77c1e.1263447037.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 14 16:43:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVRqj-0004s0-Hz
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 16:43:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754672Ab0ANPm7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 10:42:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754501Ab0ANPm6
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 10:42:58 -0500
Received: from lo.gmane.org ([80.91.229.12]:37763 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752957Ab0ANPm5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 10:42:57 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NVRqY-0004mp-Hp
	for git@vger.kernel.org; Thu, 14 Jan 2010 16:42:54 +0100
Received: from l3-128-170-36-102.l-3com.com ([128.170.36.102])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 14 Jan 2010 16:42:54 +0100
Received: from ebb9 by l3-128-170-36-102.l-3com.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 14 Jan 2010 16:42:54 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 128.170.36.102 (Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; Trident/4.0; .NET CLR 1.1.4322; .NET CLR 2.0.50727; .NET CLR 3.0.04506.30; .NET CLR 3.0.04506.648; InfoPath.2; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729; OfficeLiveConnector.1.4; OfficeLivePatch.1.3))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137003>

Michael Haggerty <mhagger <at> alum.mit.edu> writes:

>  	current_sha1=$(git rev-parse --verify HEAD)
> -	if test "$no_ff$current_sha1" = "$parent_sha1"; then
> +	if test -z "$no_ff" -a "$current_sha1" = "$parent_sha1"

'test cond1 -a cond2' is not portable.  Use 'test cond1 && test cond2'.

-- 
Eric Blake
