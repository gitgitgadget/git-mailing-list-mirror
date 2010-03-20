From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: [PATCH 0/2] Template cleanups
Date: Sat, 20 Mar 2010 10:48:07 -0400
Message-ID: <1269096489-12750-1-git-send-email-bwalton@artsci.utoronto.ca>
Cc: Ben Walton <bwalton@artsci.utoronto.ca>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 20 15:48:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NszyV-0001K1-Gk
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 15:48:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752934Ab0CTOsV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Mar 2010 10:48:21 -0400
Received: from www.cquest.utoronto.ca ([192.82.128.5]:53014 "EHLO
	www.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752770Ab0CTOsU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 10:48:20 -0400
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:42661 ident=93)
	by www.cquest.utoronto.ca with esmtp (Exim 4.43)
	id 1NszyN-0002wq-BV; Sat, 20 Mar 2010 10:48:19 -0400
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1NszyN-0003KA-8p; Sat, 20 Mar 2010 10:48:19 -0400
X-Mailer: git-send-email 1.7.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142711>

Hi All,

I noticed that the template sample hooks were a) using shell
conventions that may not work under /bin/sh on all platforms and b)
using the old git-foo calling conventions in some, but not all, cases.
The following two patches rectify this.

The build system will now substitute SHELL_PATH and PERL_PATH into
files under templates/ so that the templates use the same tools as the
rest of git.

Ben Walton (2):
  Make templates honour SHELL_PATH and PERL_PATH
  Modernize git calling conventions in hook templates

 Makefile                                   |    2 +-
 templates/Makefile                         |   17 +++++++++++++++--
 templates/hooks--commit-msg.sample         |    2 +-
 templates/hooks--post-update.sample        |    2 +-
 templates/hooks--pre-commit.sample         |    4 ++--
 templates/hooks--pre-rebase.sample         |   20 ++++++++++----------
 templates/hooks--prepare-commit-msg.sample |    6 +++---
 templates/hooks--update.sample             |    4 ++--
 templates/info--exclude                    |    2 +-
 9 files changed, 36 insertions(+), 23 deletions(-)
