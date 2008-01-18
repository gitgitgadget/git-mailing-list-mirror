From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] http-push: fix double free()
Date: Fri, 18 Jan 2008 15:34:17 +0900
Organization: glandium.org
Message-ID: <20080118063417.GB22089@glandium.org>
References: <alpine.LSU.1.00.0801171943360.5731@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, nigel.magnay@gmail.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 18 13:39:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFqVW-0007SR-HO
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 13:39:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757492AbYARMi5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 07:38:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760944AbYARMi4
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 07:38:56 -0500
Received: from vuizook.err.no ([85.19.215.103]:42754 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760930AbYARMiz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 07:38:55 -0500
Received: from aputeaux-153-1-59-190.w82-124.abo.wanadoo.fr ([82.124.13.190] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JFqUu-0005or-M2
	for git@vger.kernel.org; Fri, 18 Jan 2008 13:39:06 +0100
Received: from mh by jigen with local (Exim 4.68)
	(envelope-from <mh@jigen>)
	id 1JFknx-0008A3-Qi; Fri, 18 Jan 2008 15:34:17 +0900
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0801171943360.5731@racer.site>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Spam-Status: (score 7.1): Yes, score=7.1 required=5.0 tests=DATE_IN_PAST_06_12,RCVD_IN_DSBL,RCVD_IN_PBL,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71010>

On Thu, Jan 17, 2008 at 07:45:11PM +0000, Johannes Schindelin wrote:
> 
> There was an extra free(url) in remote_exists() (both if clauses before 
> that contain a free(url) already), which resulted in a crash on Windows.

Mmmmmm the free(url) you remove has been added in 3a462bc9 and the
free(url) in the if clauses before have been removed in the same commit.
I fail to see how that could lead to a double free().

Actually, I do see how, because git show 64be904 displays an obviously
wrong remote_exists. OTOH, neither next, master nor pu have such code...

Mike
