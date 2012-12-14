From: Matt Kraai <kraai@ftbfs.org>
Subject: [PATCH 0/2] Port to QNX
Date: Fri, 14 Dec 2012 10:38:18 -0800
Message-ID: <1355510300-31541-1-git-send-email-kraai@ftbfs.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 14 19:39:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tja9x-0007Wd-QW
	for gcvg-git-2@plane.gmane.org; Fri, 14 Dec 2012 19:38:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756851Ab2LNSil (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2012 13:38:41 -0500
Received: from kvm.ftbfs.org ([46.22.115.26]:57372 "EHLO kvm.ftbfs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756657Ab2LNSij (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2012 13:38:39 -0500
Received: from kraai by kvm.ftbfs.org with local (Exim 4.72)
	(envelope-from <kraai@ftbfs.org>)
	id 1Tja9d-0008Dd-JZ
	for git@vger.kernel.org; Fri, 14 Dec 2012 10:38:37 -0800
X-Mailer: git-send-email 1.7.2.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211497>

This series ports Git to QNX.  It builds on both QNX 6.3.2 and QNX
6.5.0.  The test suite does not pass.  Unless the corresponding
software is installed, the following arguments must be passed to Make:

 NO_CURL=1 NO_GETTEXT=1 NO_OPENSSL=1 NO_PERL=1 NO_PYTHON=1 NO_TCLTK=1

  [1/2]: Make lock local to fetch_pack

QNX 6.3.2's unistd.h declares a function named lock, which causes
fetch-pack.c to fail to compile if lock has file-scope.  Since it's
only used in a single function, move it therein.

  [2/2]: Port to QNX
