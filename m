From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 0/2] RUNTIME_PREFIX enhancements
Date: Thu, 19 Feb 2009 20:10:44 +0100 (CET)
Message-ID: <cover.1235070304u.git.johannes.schindelin@gmx.de>
References: <499C63E7.5040306@kdbg.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j6t@kdbg.org>, Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Feb 19 20:11:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaEIl-0000pR-Ar
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 20:11:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751927AbZBSTJp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 14:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751875AbZBSTJp
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 14:09:45 -0500
Received: from mail.gmx.net ([213.165.64.20]:60800 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751754AbZBSTJo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 14:09:44 -0500
Received: (qmail invoked by alias); 19 Feb 2009 19:09:42 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp008) with SMTP; 19 Feb 2009 20:09:42 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX189n/wITSk9r2c9uubbpQ19+unByAbcqwYYG7o4Cg
	rKtPdJLzRS4Y5g
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <499C63E7.5040306@kdbg.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110732>

The idea is to simplify the RUNTIME_PREFIX code, and to make Git handle 
the case where the binary was found in $ROOT/git/, too.

Changes since v1:

- changed the signature of strip_path_suffix() as suggested by Hannes:

	char *strip_path_suffix(const char *path, const char *suffix)

- added a test to test-path-utils

Johannes Schindelin (2):
  Introduce the function strip_path_suffix()
  system_path(): simplify using strip_path_suffix(), and add suffix
    "git"

 cache.h               |    1 +
 exec_cmd.c            |   33 ++++-----------------------------
 path.c                |   32 ++++++++++++++++++++++++++++++++
 t/t0060-path-utils.sh |    4 ++++
 test-path-utils.c     |    6 ++++++
 5 files changed, 47 insertions(+), 29 deletions(-)
