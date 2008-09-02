From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] Makefile: add merge_recursive.h to LIB_H
Date: Wed,  3 Sep 2008 00:13:59 +0200
Message-ID: <1220393639-20433-1-git-send-email-vmiklos@frugalware.org>
References: <b96b1e10babd379daea483e72d99d8e520e34506.1220392547.git.vmiklos@frugalware.org>
Cc: git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 03 00:15:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kae9Y-00050j-Ti
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 00:15:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753388AbYIBWOF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 18:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753251AbYIBWOE
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 18:14:04 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:48786 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753224AbYIBWOC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 18:14:02 -0400
Received: from vmobile.example.net (dsl5401C449.pool.t-online.hu [84.1.196.73])
	by yugo.frugalware.org (Postfix) with ESMTP id 8367F1DDC5B;
	Wed,  3 Sep 2008 00:14:00 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 26F9C84CA; Wed,  3 Sep 2008 00:13:59 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.1
In-Reply-To: <b96b1e10babd379daea483e72d99d8e520e34506.1220392547.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94729>

When modifying merge-recursive.h, for example builtin-merge-recursive.c
have to be recompiled which was not true till now, causing various
runtime errors using an incremental build.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Wed, Sep 03, 2008 at 12:05:32AM +0200, Miklos Vajna <vmiklos@frugalware.org> wrote:
> Subject: Re: [PATCH 1/2] merge-recursive: move call_depth to struct
>       merge_options

While testing this one, I got some weird errors, finally they gone after
a 'touch builtin-merge-recursive.c', I guess this is the right fix.

 Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index f697618..bec6a84 100644
--- a/Makefile
+++ b/Makefile
@@ -362,6 +362,7 @@ LIB_H += list-objects.h
 LIB_H += ll-merge.h
 LIB_H += log-tree.h
 LIB_H += mailmap.h
+LIB_H += merge_recursive.h
 LIB_H += object.h
 LIB_H += pack.h
 LIB_H += pack-refs.h
-- 
1.6.0.1
