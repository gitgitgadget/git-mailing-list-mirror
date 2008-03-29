From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Truncating and cleaning a imported git repositary to make it
 more	usable
Date: Sat, 29 Mar 2008 18:51:56 +0100
Message-ID: <47EE81BC.4020700@alum.mit.edu>
References: <1206707716.9819.15.camel@malory>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Alex Bennee <kernel-hacker@bennee.com>
X-From: git-owner@vger.kernel.org Sat Mar 29 18:53:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JffFV-0001CF-6O
	for gcvg-git-2@gmane.org; Sat, 29 Mar 2008 18:53:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753257AbYC2Rwp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Mar 2008 13:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755438AbYC2Rwp
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Mar 2008 13:52:45 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:50602 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755351AbYC2Rwj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Mar 2008 13:52:39 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.135] (kaiserty.in-dsl.de [217.197.85.174])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id m2THqZb1030567
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 29 Mar 2008 18:52:36 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.12) Gecko/20080227 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
In-Reply-To: <1206707716.9819.15.camel@malory>
X-Enigmail-Version: 0.95.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78475>

Alex Bennee wrote:
> I've succeeded in porting our whole CVS repository into git (with plenty
> of swap, cvsps is very memory hungry). [...]

It sounds like you are doing a one-time conversion.  If so, please
consider using cvs2svn [1], which can also convert to git [2].
cvsps-based tools are known to have problems with most nontrivial CVS
repositories (the contents of the output repository simply don't agree
with those of the CVS original).  IMO, the only reason to use a
cvsps-based tool is if you really need incremental conversions *and* are
willing to live with data loss.

Before you trust your new repository, please make some checks.  As a
minimum, make sure that the contents of each tag and branch tip revision
is the same as the contents that you get if you check out of CVS.  (I
bet they don't!)

Michael

[1] http://cvs2svn.tigris.org
[2] http://cvs2svn.tigris.org/cvs2git.html
