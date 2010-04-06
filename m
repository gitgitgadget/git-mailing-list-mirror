From: =?UTF-8?q?Henrik=20Grubbstr=C3=B6m=20=28Grubba=29?= 
	<grubba@grubba.org>
Subject: [PATCH v4 0/8] Attribute and conversion patches
Date: Tue,  6 Apr 2010 14:46:36 +0200
Message-ID: <cover.1270554878.git.grubba@grubba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Henrik=20Grubbstr=C3=B6m=20 (Grubba) ?= 
	<grubba@grubba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 06 14:47:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nz8Bj-0004uy-2f
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 14:47:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755476Ab0DFMq4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Apr 2010 08:46:56 -0400
Received: from mail.roxen.com ([212.247.29.220]:39923 "EHLO mail.roxen.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753516Ab0DFMqw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Apr 2010 08:46:52 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.roxen.com (Postfix) with ESMTP id 079BD628180
	for <git@vger.kernel.org>; Tue,  6 Apr 2010 14:46:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at roxen.com
Received: from mail.roxen.com ([212.247.29.220])
	by localhost (marge.roxen.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id auOIn70CHVsW; Tue,  6 Apr 2010 14:46:46 +0200 (CEST)
Received: from shipon.roxen.com (shipon.roxen.com [212.247.28.156])
	by mail.roxen.com (Postfix) with ESMTP id DBE5B628173;
	Tue,  6 Apr 2010 14:46:46 +0200 (CEST)
Received: from shipon.roxen.com (localhost [127.0.0.1])
	by shipon.roxen.com (8.13.8+Sun/8.13.8) with ESMTP id o36CkktE028638;
	Tue, 6 Apr 2010 14:46:46 +0200 (CEST)
Received: (from grubba@localhost)
	by shipon.roxen.com (8.13.8+Sun/8.13.8/Submit) id o36CkkoT028637;
	Tue, 6 Apr 2010 14:46:46 +0200 (CEST)
X-Mailer: git-send-email 1.7.0.3.316.g33b5e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144138>

These are some patches that are needed to get the support for
attributes and especially the 'ident' attribute to a useable
state.

Since last time the 'ident'-specific patch "Inhibit contraction of
foreign $Id$ during stats." is gone, and replaced with the generic
"Filter files that have changed only due to conversion changes.".

Henrik Grubbstr=C3=B6m (Grubba) (8):
  convert: Safer handling of $Id$ contraction.
  convert: Keep foreign $Id$ on checkout.
  status: Added missing calls to diff_unmodified_pair() in
    format_callbacks.
  diff: Filter files that have changed only due to conversion changes.
  convert: Added core.refilteronadd feature.
  attr: Fixed debug output for macro expansion.
  attr: Allow multiple changes to an attribute on the same line.
  attr: Expand macros immediately when encountered.

 Documentation/config.txt |   12 +++++++
 attr.c                   |   38 ++++++++++++++--------
 cache.h                  |    2 +
 config.c                 |   10 ++++++
 convert.c                |   28 ++++++++++++++++-
 diff.c                   |   42 +++++++++++++++++++++++++
 environment.c            |    2 +
 sha1_file.c              |   57 ++++++++++++++++++++++++++++++++++
 t/t0003-attributes.sh    |   15 +++++++++
 t/t0021-conversion.sh    |   76 ++++++++++++++++++++++++++++++++++++++=
++++----
 wt-status.c              |    4 ++
 11 files changed, 264 insertions(+), 22 deletions(-)
