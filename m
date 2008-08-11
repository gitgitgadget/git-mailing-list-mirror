From: sergio <sergio.callegari@gmail.com>
Subject: Re: git gc does not discard objects found in alternate unless =?utf-8?b?dGhlCWFsdGVybmF0ZQ==?= storage is packed
Date: Mon, 11 Aug 2008 10:16:28 +0000 (UTC)
Message-ID: <loom.20080811T101110-879@post.gmane.org>
References: <loom.20080810T210546-549@post.gmane.org> <20080811025438.GB27195@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 11 12:17:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSUTD-0005iE-CQ
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 12:17:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbYHKKQp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 06:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbYHKKQp
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 06:16:45 -0400
Received: from main.gmane.org ([80.91.229.2]:35192 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751184AbYHKKQp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 06:16:45 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KSUS5-0001un-Vb
	for git@vger.kernel.org; Mon, 11 Aug 2008 10:16:38 +0000
Received: from host224-59-dynamic.10-87-r.retail.telecomitalia.it ([87.10.59.224])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 11 Aug 2008 10:16:37 +0000
Received: from sergio.callegari by host224-59-dynamic.10-87-r.retail.telecomitalia.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 11 Aug 2008 10:16:37 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 87.10.59.224 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.0.1) Gecko/2008072820 Firefox/3.0.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91927>

Shawn O. Pearce <spearce <at> spearce.org> writes:

> 
> Sergio <sergio.callegari <at> gmail.com> wrote:
> > Version 1.5.6.5
> > 
> > Looks weird
> > Is it the intended behaviour?
> 
> This is the current (intended) behavior.  We have never pruned an
> object from a repository unless the object is packed in the shared
> alternate repository.  See git-prune-packed's man page.  The prune
> logic for loose objects only deletes objects which are in packs,
> and it doesn't care where that pack came from.
> 

Many thanks for the explanation.
Two more questions:
1) Is there a way to prune objects that are anyway available at the alternate
without touching the alternate (to repack it)?
2) Would there be any contraindication in doing so? (namely, is the current
behaviour of git gc a mere consequence of the prune-packed logic or a behaviour
purposely introduced for safety?)


Sergio
