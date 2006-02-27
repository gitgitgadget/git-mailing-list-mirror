From: Mark Wooding <mdw@distorted.org.uk>
Subject: [PATCH 0/2] combine-diff consistency fixes
Date: Mon, 27 Feb 2006 12:48:15 +0000
Message-ID: <20060227124815.25144.83101.stgit@metalzone.distorted.org.uk>
X-From: git-owner@vger.kernel.org Mon Feb 27 13:53:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDhsE-00076V-12
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 13:53:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbWB0Mwt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Feb 2006 07:52:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751091AbWB0Mwt
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 07:52:49 -0500
Received: from excessus.demon.co.uk ([83.105.60.35]:13144 "HELO
	metalzone.distorted.org.uk") by vger.kernel.org with SMTP
	id S1751088AbWB0Mwt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2006 07:52:49 -0500
Received: (qmail 25561 invoked from network); 27 Feb 2006 12:52:48 -0000
Received: from localhost (HELO metalzone.distorted.org.uk) (?MLp2VfHGUm43KkB1dkVDJkoxTjK92+16?@127.0.0.1)
  by localhost with SMTP; 27 Feb 2006 12:52:48 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16840>

The output of git diff-tree --cc on a merge is not consistent with its
output for a normal commit.  In particular:

  * the index lines on a combined diff are abbreviated even if
    --full-index is given, and

  * the headers on a combined diff are not null terminated, even if -z
    is given.

For example, run

  git-diff-tree --cc -z --full-index f0b0af1b04f558b684cae2a3b805ca4bab84d45f

-- [mdw]
