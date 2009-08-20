From: Seba Illingworth <seba.illingworth@gmail.com>
Subject: Re: difftool, open all diff files immediately, not in serial
Date: Thu, 20 Aug 2009 01:39:23 +0000 (UTC)
Message-ID: <loom.20090820T033212-722@post.gmane.org>
References: <loom.20090804T204107-117@post.gmane.org> <200908042347.48705.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 20 03:40:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdwdX-0001II-5D
	for gcvg-git-2@lo.gmane.org; Thu, 20 Aug 2009 03:40:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753910AbZHTBju (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 21:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753905AbZHTBjt
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 21:39:49 -0400
Received: from lo.gmane.org ([80.91.229.12]:53939 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752497AbZHTBjt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 21:39:49 -0400
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1Mdwd1-0001Af-8y
	for git@vger.kernel.org; Thu, 20 Aug 2009 03:39:48 +0200
Received: from 125-239-38-1.jetstream.xtra.co.nz ([125.239.38.1])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 20 Aug 2009 03:39:47 +0200
Received: from seba.illingworth by 125-239-38-1.jetstream.xtra.co.nz with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 20 Aug 2009 03:39:47 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 125.239.38.1 (Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US) AppleWebKit/530.5 (KHTML, like Gecko) Chrome/2.0.172.39 Safari/530.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126602>

Thomas Rast <trast <at> student.ethz.ch> writes:
> I posted the script below on IRC the other week[1] in reply to someone
> looking for a way to do this for 'meld'.  I'm not sure this is the
> *fastest* way to do this, but I'm at least trying to take a few
> shortcuts...

I've come up with a simple script that diffs the files in a background task:

  for name in $(git diff --name-only $1); do git difftool $1 $name & done

Then aliased the script for usage:

  git diffall [--staged]

Being a bash newbie, I'd appreciate any feedback on what seems to be 
a simple solution...??
