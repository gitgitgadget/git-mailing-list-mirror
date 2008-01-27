From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Contents of file for a commit
Date: Sat, 26 Jan 2008 23:40:27 -0500
Message-ID: <20080127044027.GS24004@spearce.org>
References: <18332.1826.220373.129812@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Sun Jan 27 05:41:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIzKS-0008Ku-Kc
	for gcvg-git-2@gmane.org; Sun, 27 Jan 2008 05:41:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752897AbYA0Ekd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2008 23:40:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752849AbYA0Ekd
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jan 2008 23:40:33 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:48559 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752705AbYA0Ekc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2008 23:40:32 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JIzJv-0007Cr-Ep; Sat, 26 Jan 2008 23:40:39 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 60C8720FBAE; Sat, 26 Jan 2008 23:40:27 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <18332.1826.220373.129812@lisa.zopyra.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71803>

Bill Lear <rael@zopyra.com> wrote:
> How can I do the equivalent of 'cvs co -r <commit> -p <file>' in git?
> I want to see the entire contents of a file as it existed after a
> particular commit was introduced.

`git checkout $commit -- $path`

would get the file at that version into your working directory,
but also will update the index, thus staging the file for the
next commit.

You can also just view the file if you don't want those changes
to be made:

`git show $commit -- $path`

If you are scripting, use cat-file directly to avoid any CRLF
conversion or whatnot:

`git cat-file blob $commit:$path`

-- 
Shawn.
