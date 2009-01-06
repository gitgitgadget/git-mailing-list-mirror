From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: Problems getting rid of large files using git-filter-branch
Date: Wed, 7 Jan 2009 00:17:26 +0100
Message-ID: <20090106231726.GB13379@cuci.nl>
References: <c09652430901061359q7a02291fk656ab23e54b19f5e@mail.gmail.com> <alpine.LFD.2.00.0901061709510.26118@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: ?yvind Harboe <oyvind.harboe@zylin.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Jan 07 00:28:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKLLM-0003NF-96
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 00:28:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753513AbZAFX0t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 18:26:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753371AbZAFX0t
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 18:26:49 -0500
Received: from aristoteles.cuci.nl ([212.125.128.18]:44980 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752015AbZAFX0s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 18:26:48 -0500
X-Greylist: delayed 560 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Jan 2009 18:26:48 EST
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 066085466; Wed,  7 Jan 2009 00:17:27 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0901061709510.26118@xanadu.home>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104738>

Nicolas Pitre wrote:
>On Tue, 6 Jan 2009, ?yvind Harboe wrote:
>OK, try this:

>	git pull file://$(pwd)/../my_repo.orig

Alternately, try:

rm -rf .git/ORIG_HEAD .git/FETCH_HEAD .git/index .git/logs .git/info/refs \
  .git/objects/pack/pack-*.keep .git/refs/original .git/refs/patches \
  .git/patches .git/gitk.cache &&
 git prune --expire now &&
 git repack -a -d --window=200 &&
 git gc

-- 
Sincerely,
           Stephen R. van den Berg.

"Very funny, Mr. Scott. Now beam down my clothes!"
