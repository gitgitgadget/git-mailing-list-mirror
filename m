From: Andrew Myrick <amyrick@apple.com>
Subject: git-svn: handling merge-base failures
Date: Wed, 23 Dec 2009 11:54:29 -0800
Message-ID: <931B0483-7628-488E-BB9F-C40346353149@apple.com>
Mime-Version: 1.0 (Apple Message framework v1130)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Eric Wong <normalperson@yhbt.net>, Sam Vilain <sam@vilain.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 23 20:55:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NNXIa-0001J2-SL
	for gcvg-git-2@lo.gmane.org; Wed, 23 Dec 2009 20:55:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757005AbZLWTyf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Dec 2009 14:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756995AbZLWTyd
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Dec 2009 14:54:33 -0500
Received: from mail-out4.apple.com ([17.254.13.23]:59833 "EHLO
	mail-out4.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756988AbZLWTyb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Dec 2009 14:54:31 -0500
Received: from relay13.apple.com (relay13.apple.com [17.128.113.29])
	by mail-out4.apple.com (Postfix) with ESMTP id 27BFF838CC89;
	Wed, 23 Dec 2009 11:54:30 -0800 (PST)
X-AuditID: 1180711d-b7b18ae000001001-88-4b32757587b6
Received: from agility.apple.com (agility.apple.com [17.201.24.116])
	(using TLS with cipher AES128-SHA (AES128-SHA/128 bits))
	(Client did not present a certificate)
	by relay13.apple.com (Apple SCV relay) with SMTP id EF.74.04097.675723B4; Wed, 23 Dec 2009 11:54:30 -0800 (PST)
X-Mailer: Apple Mail (2.1130)
X-Brightmail-Tracker: AAAAAQAAAZE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135631>

One of my projects is failing to clone because merge-base is failing on one of the revisions; the branch is a partial branch, so merge-base can't find a common ancestor with trunk.  I'd like to catch the exception that command_oneline should throw when merge-base fails, but my perl is very rusty and I'm struggling to get git-svn.perl to grok the Git::Error::Command class.  What is the appropriate way to import that class?  Or more generally, is there a better solution to handling this error case?

-Andrew