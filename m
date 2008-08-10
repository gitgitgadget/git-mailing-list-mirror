From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 0/2] Avoid run_command() for recursive in builtin-merge
Date: Sun, 10 Aug 2008 15:20:22 +0200
Message-ID: <cover.1218374062.git.vmiklos@frugalware.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 10 15:21:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSAr0-0007PU-9O
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 15:21:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752450AbYHJNUA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 09:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751993AbYHJNUA
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 09:20:00 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:36834 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751548AbYHJNT7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 09:19:59 -0400
Received: from vmobile.example.net (dsl5401CE89.pool.t-online.hu [84.1.206.137])
	by yugo.frugalware.org (Postfix) with ESMTP id E35AB1DDC5C
	for <git@vger.kernel.org>; Sun, 10 Aug 2008 15:19:56 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 0185E1A5FC0; Sun, 10 Aug 2008 15:20:24 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.rc0.14.g95f8.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91835>

Hi,

The idea (by Dscho) is simple: builtin-merge-recursive already has a
merge_recursive() function that is _almost_ ready to be called from
builtins without fork+exec, so make use of it.

And yes, of course this is not for 1.6.0, I just wanted to send this out
before the "suggested 'pencils down' date" of GSoC.

Miklos Vajna (2):
  merge-recursive: prepare merge_recursive() to be called from builtins
  builtin-merge: avoid run_command_v_opt() for recursive

 builtin-merge-recursive.c |   19 +++++++---
 builtin-merge.c           |   82 +++++++++++++++++++++++++++++++--------------
 2 files changed, 70 insertions(+), 31 deletions(-)
