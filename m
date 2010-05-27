From: Jonathan Callen <abcd@gentoo.org>
Subject: [PATCH 0/3] Interix support
Date: Thu, 27 May 2010 04:19:41 -0400
Message-ID: <1274948384-167-1-git-send-email-abcd@gentoo.org>
Cc: mduft@gentoo.org, jrnieder@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 27 10:20:02 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHYJu-00045o-Bd
	for gcvg-git-2@lo.gmane.org; Thu, 27 May 2010 10:20:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755321Ab0E0IT4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 May 2010 04:19:56 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:45280 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751777Ab0E0ITy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 May 2010 04:19:54 -0400
Received: from localhost.localdomain (pool-72-86-43-250.clppva.fios.verizon.net [72.86.43.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTP id D623A1B4011;
	Thu, 27 May 2010 08:19:50 +0000 (UTC)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147833>

This series of patches adds support for building git on Interix.

Interix is an interesting system, as it lacks some functions that are
normally present on POSIX systems, such as poll().  As I did not have
time to implement poll() on top of select(), these patches simply
disable the three commands that require poll() to be present:
git-daemon, git-upload-archive, and git-upload-pack.

Jonathan Callen (3):
      Support building on systems without poll(2)
      Support building without inttypes.h
      Add Interix support

 Makefile          |   40 +++++++++++++++++++++++++++++++++++-----
 builtin.h         |    2 ++
 git-compat-util.h |    6 ++++++
 git.c             |    2 ++
 4 files changed, 45 insertions(+), 5 deletions(-)
