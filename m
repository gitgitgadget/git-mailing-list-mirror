From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [PATCH] Ignore end-of-line style when computing similarity score for 
 rename detection
Date: Thu, 28 Jun 2007 09:22:02 +0200
Organization: eudaptics software gmbh
Message-ID: <4683619A.F753C97E@eudaptics.com>
References: <46831F70.2060403@midwinter.com> <20070628024603.GA1534@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 28 10:13:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3p7n-0004Oe-OW
	for gcvg-git@gmane.org; Thu, 28 Jun 2007 10:13:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760791AbXF1INJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jun 2007 04:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759676AbXF1INJ
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jun 2007 04:13:09 -0400
Received: from main.gmane.org ([80.91.229.2]:33717 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761138AbXF1INH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jun 2007 04:13:07 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1I3oZm-0000o1-7D
	for git@vger.kernel.org; Thu, 28 Jun 2007 09:38:02 +0200
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 28 Jun 2007 09:38:02 +0200
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 28 Jun 2007 09:38:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51087>

Steven Grimm wrote:
> 
> Signed-off-by: Steven Grimm <koreth@midwinter.com>
> ---
> Okay, let's try this again with an MUA that won't change my tabs to
> spaces -- sorry about that.
> 
> A couple of source files got checked into my code base with DOS-style
> end-of-line characters. I converted them to UNIX-style (the convention
> for this project) in my branch. Then later, I renamed a couple of them.
> 
> Meanwhile, back in the original branch, someone else fixed a bug in one
> of the files and checked it in, still with DOS-style line endings.
> 
> When I merged that change into my branch, git didn't detect the rename
> because the fact that every line has a change (the end-of-line
> character) dropped the similarity score way too low.
> 
> This patch teaches git to ignore end-of-line style when looking for
> potential rename candidates. A separate question, which I expect may be
> more controversial, is what to do with conflict markers; with this
> patch, the entire file is still marked as in conflict if the end-of-line
> style changes (but it's still an improvement in that we at least detect
> the rename now.)

I think that nobody would object to have a use-case description like
this in the commit message...

-- Hannes
