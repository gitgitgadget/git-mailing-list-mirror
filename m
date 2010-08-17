From: Thomas Rast <trast@student.ethz.ch>
Subject: [BUG] merge into unborn branch resets index+WT even if populated
Date: Tue, 17 Aug 2010 09:45:31 +0200
Message-ID: <201008170945.31850.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 17 09:45:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlGrm-0005tN-IJ
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 09:45:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751898Ab0HQHpe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Aug 2010 03:45:34 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:55026 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751025Ab0HQHpe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 03:45:34 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Tue, 17 Aug
 2010 09:45:32 +0200
Received: from thomas.site (129.132.246.132) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.0.702.0; Tue, 17 Aug
 2010 09:45:32 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.34-12-desktop; KDE/4.4.4; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153730>

Hi,

I'm posting this on behalf of Dscho who reported it on IRC, but
apparently doesn't have the time for email.

If you run the following sequence of commands:

  git init
  echo foo > somefile
  git add somefile
  git pull elsewhere master

(where 'elsewhere' is any repo having a master branch) the "merge into
unborn branch" logic silently nukes the index AND worktree copy of
"somefile", thereby losing it.  The same works with fetch+merge, so
it's not pull's fault.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
