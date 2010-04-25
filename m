From: =?UTF-8?q?Henrik=20Grubbstr=C3=B6m=20=28Grubba=29?= 
	<grubba@grubba.org>
Subject: [PATCH RFC v2 0/4] Patches to avoid reporting conversion changes.
Date: Sun, 25 Apr 2010 18:29:04 +0200
Message-ID: <cover.1272210580.git.grubba@grubba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Henrik=20Grubbstr=C3=B6m=20 (Grubba) ?= 
	<grubba@grubba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 25 18:29:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O64hv-0005fj-Jc
	for gcvg-git-2@lo.gmane.org; Sun, 25 Apr 2010 18:29:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753075Ab0DYQ3S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Apr 2010 12:29:18 -0400
Received: from mail.roxen.com ([212.247.29.220]:58567 "EHLO mail.roxen.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752258Ab0DYQ3S (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Apr 2010 12:29:18 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.roxen.com (Postfix) with ESMTP id D53BC628335
	for <git@vger.kernel.org>; Sun, 25 Apr 2010 18:29:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at roxen.com
Received: from mail.roxen.com ([212.247.29.220])
	by localhost (marge.roxen.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Uv+phaN46xfD for <git@vger.kernel.org>;
	Sun, 25 Apr 2010 18:29:14 +0200 (CEST)
Received: from shipon.roxen.com (shipon.roxen.com [212.247.28.156])
	by mail.roxen.com (Postfix) with ESMTP id C1F596282D8
	for <git@vger.kernel.org>; Sun, 25 Apr 2010 18:29:14 +0200 (CEST)
Received: from shipon.roxen.com (localhost [127.0.0.1])
	by shipon.roxen.com (8.13.8+Sun/8.13.8) with ESMTP id o3PGTCH6012711;
	Sun, 25 Apr 2010 18:29:12 +0200 (CEST)
Received: (from grubba@localhost)
	by shipon.roxen.com (8.13.8+Sun/8.13.8/Submit) id o3PGTAjI012710;
	Sun, 25 Apr 2010 18:29:10 +0200 (CEST)
X-Mailer: git-send-email 1.7.0.4.369.g81e89
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145748>

This is the second go at having the git index keep track of the
conversion mode and corresponding normalized blob sha1 for files.

Since last time the diff behaviour patch has been removed, and
with it the need for storing of the normalized blob and thus
the gc patch. Some basic test cases have been added.

Thanks to Junio C Hamano for the suggestion and some of the tests.

Henrik Grubbstr=C3=B6m (Grubba) (4):
  sha1_file: Added index_blob().
  cache: Added ce_norm_sha1() and related cache_entry fields.
  cache: Added index extension "NORM".
  t/t0021: Test that conversion changes are detected.

 cache.h               |   22 ++++++++++++++++
 convert.c             |   31 +++++++++++++++++++++++
 read-cache.c          |   66 +++++++++++++++++++++++++++++++++++++++++=
++------
 sha1_file.c           |   19 ++++++++++++++
 t/t0021-conversion.sh |   50 +++++++++++++++++++++++++++++++++++++
 5 files changed, 180 insertions(+), 8 deletions(-)
