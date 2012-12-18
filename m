From: Matt Kraai <kraai@ftbfs.org>
Subject: [PATCH v2 0/2] Port to QNX
Date: Tue, 18 Dec 2012 14:03:53 -0800
Message-ID: <1355868235-23173-1-git-send-email-kraai@ftbfs.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 18 23:04:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tl5Gy-0005nF-5Z
	for gcvg-git-2@plane.gmane.org; Tue, 18 Dec 2012 23:04:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755401Ab2LRWEH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2012 17:04:07 -0500
Received: from kvm.ftbfs.org ([46.22.115.26]:59270 "EHLO kvm.ftbfs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754499Ab2LRWEF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2012 17:04:05 -0500
Received: from kraai by kvm.ftbfs.org with local (Exim 4.72)
	(envelope-from <kraai@ftbfs.org>)
	id 1Tl5Gd-00062Z-Nr
	for git@vger.kernel.org; Tue, 18 Dec 2012 14:04:03 -0800
X-Mailer: git-send-email 1.7.2.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211789>

This series ports Git to QNX.  It differs from the previous version in
that:

 * it's rebased on dm/port, so it narrows the scope of the lock
   variable in builtin/fetch-pack.c instead of fetch-pack.c and uses
   HAVE_STRINGS_H; and
 * it disables use of Pthreads, since fork(2) doesn't work once
   Pthreads are used.

The first test suite failure occurs because getcwd(3) can return paths
containing symbolic links.
