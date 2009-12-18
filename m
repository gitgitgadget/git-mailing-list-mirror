From: David Antliff <david.antliff@gmail.com>
Subject: Re: core.autocrlf & Cygwin - files incorrectly flagged as modified
Date: Fri, 18 Dec 2009 02:43:05 +0000 (UTC)
Message-ID: <loom.20091218T033941-445@post.gmane.org>
References: <loom.20091215T225528-115@post.gmane.org> <200912170800.35752.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 18 03:43:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLSod-0003Gi-Eu
	for gcvg-git-2@lo.gmane.org; Fri, 18 Dec 2009 03:43:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752589AbZLRCnb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2009 21:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752499AbZLRCnb
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Dec 2009 21:43:31 -0500
Received: from lo.gmane.org ([80.91.229.12]:48829 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752080AbZLRCna (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2009 21:43:30 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NLSoR-0003Ev-Ty
	for git@vger.kernel.org; Fri, 18 Dec 2009 03:43:28 +0100
Received: from 202-27-34-1.dia.global-gateway.net.nz ([202-27-34-1.dia.global-gateway.net.nz])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 Dec 2009 03:43:27 +0100
Received: from david.antliff by 202-27-34-1.dia.global-gateway.net.nz with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 Dec 2009 03:43:27 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 202.27.34.1 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1.6) Gecko/20091201 Firefox/3.5.6 (.NET CLR 3.5.30729))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135395>

Robin Rosenberg writes:
> tisdag 15 december 2009 23:24:15 skrev  David Antliff:
> > The problem is that sometimes, after a git-clone, the output of git-status
> >  and git-diff shows entire files as being different. However these files
> >  have not been modified by the user - only git has had a chance to change
> >  them (due to autocrlf=true). But surely if git has converted the file
> >  automatically, it should know that it has to compensate for this when
> >  comparing with the local repository?
> 
> AFAIK, this happens if you have CRLF line endings in the blobs in the repo.

Oh? That could very well be true - how would such line endings get into a blob?
I'm pretty sure everyone is using autocrlf=true which should convert all line
endings to LF on commit, but perhaps there's another way to get CRLF line
endings into a blob?

If autocrlf=false, files are committed as-is (I believe), so this would be one
way to end up committing such files. But as far as I know, nobody has turned
that option off in our group.
