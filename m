From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: do a partial rebuild if rev_map is out-of-date
Date: Wed, 17 Sep 2008 23:38:04 -0700
Message-ID: <20080918063754.GA13328@untitled>
References: <20080917031304.GA2505@riemann.deskinm.fdns.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Deskin Miller <deskinm@umich.edu>
X-From: git-owner@vger.kernel.org Thu Sep 18 08:49:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgDK5-0002hn-Hf
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 08:49:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752710AbYIRGr5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 02:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752673AbYIRGr5
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 02:47:57 -0400
Received: from user-118bg0q.cable.mindspring.com ([66.133.192.26]:58479 "EHLO
	untitled" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751809AbYIRGr5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 02:47:57 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by untitled (Postfix) with ESMTP id E4C9E33466A;
	Thu, 18 Sep 2008 06:38:05 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080917031304.GA2505@riemann.deskinm.fdns.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96169>

Deskin Miller <deskinm@umich.edu> wrote:
> This commit will have git-svn do a partial rebuild of the rev_map to
> match the true state of the branch, if it ever is used to fetch again.
> 
> This will only work for projects not using either noMetadata or
> useSvmProps configuration options; if you are using these options,
> git-svn will fall back to the previous behaviour.
> 
> Signed-off-by: Deskin Miller <deskinm@umich.edu>
> ---

Hi Deskin,

This seems to break the following test case for me:

*** t9107-git-svn-migrate.sh ***
*   ok 1: setup old-looking metadata
*   ok 2: git-svn-HEAD is a real HEAD
*   ok 3: initialize old-style (v0) git svn layout
*   ok 4: initialize a multi-repository repo
*   ok 5: multi-fetch works on partial urls + paths
*   ok 6: migrate --minimize on old inited layout
* FAIL 7: .rev_db auto-converted to .rev_map.UUID

I haven't had time to diagnose it.  Also, can you add a test that
demonstrates this functionality (and ensures things keeps working when
future work is done on git-svn?)

Thanks.

-- 
Eric Wong
