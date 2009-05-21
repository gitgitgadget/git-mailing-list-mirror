From: Tony Finch <dot@dotat.at>
Subject: Re: git doesn't append ".git" to url WAS [PATCH 0/3] http*: refactor
  fetching code (v2)
Date: Thu, 21 May 2009 15:29:48 +0100
Message-ID: <alpine.LSU.2.00.0905211518430.23333@hermes-2.csi.cam.ac.uk>
References: <be6fef0d0905210717j174499f5k4740dc2f821bec62@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 21 16:29:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M79HS-0007Kq-0N
	for gcvg-git-2@gmane.org; Thu, 21 May 2009 16:29:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753705AbZEUO3t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2009 10:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752989AbZEUO3s
	(ORCPT <rfc822;git-outgoing>); Thu, 21 May 2009 10:29:48 -0400
Received: from ppsw-5.csi.cam.ac.uk ([131.111.8.135]:39291 "EHLO
	ppsw-5.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753352AbZEUO3r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2009 10:29:47 -0400
X-Cam-AntiVirus: no malware found
X-Cam-SpamDetails: not scanned
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-2.csi.cam.ac.uk ([131.111.8.54]:41879)
	by ppsw-5.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.155]:25)
	with esmtpa (EXTERNAL:fanf2) id 1M79HI-0004DZ-Gv (Exim 4.70)
	(return-path <fanf2@hermes.cam.ac.uk>); Thu, 21 May 2009 15:29:48 +0100
Received: from fanf2 (helo=localhost) by hermes-2.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local-esmtp id 1M79HI-00005f-7T (Exim 4.67)
	(return-path <fanf2@hermes.cam.ac.uk>); Thu, 21 May 2009 15:29:48 +0100
X-X-Sender: fanf2@hermes-2.csi.cam.ac.uk
In-Reply-To: <be6fef0d0905210717j174499f5k4740dc2f821bec62@mail.gmail.com>
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119685>

On Thu, 21 May 2009, Tay Ray Chuan wrote:
>
> are your friends hosting non-bare repositories directly (with
> checked-out copies)? In the first place, this isn't a good idea;

Yes, and yes we all know that this is discouraged.

There are two bugs. Git's error message is misleading: the problem is
nothing to do with running git update-server-info (see below). Its
behaviour is inconsistent: git retries after appending .git if you are
fetching from a local repository or ssh:// or git:// URLs but not for
http:// URLs.

$ git clone http://www.greenend.org.uk/rjk/
Initialized empty Git repository in /tmp/rjk/.git/
fatal: http://www.greenend.org.uk/rjk//info/refs not found: did you run git update-server-info on the server?

Actually maybe there's a third bug: it says it has initialized
a repository but it removes it again if the clone fails.

Tony.
-- 
f.anthony.n.finch  <dot@dotat.at>  http://dotat.at/
GERMAN BIGHT HUMBER: SOUTHWEST 5 TO 7. MODERATE OR ROUGH. SQUALLY SHOWERS.
MODERATE OR GOOD.
