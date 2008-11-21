From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 0/4] builtin-clone: use strbuf
Date: Fri, 21 Nov 2008 01:44:57 +0100
Message-ID: <cover.1227227976.git.vmiklos@frugalware.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 21 01:45:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3K8x-0007H5-5v
	for gcvg-git-2@gmane.org; Fri, 21 Nov 2008 01:45:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755341AbYKUAnw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 19:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755337AbYKUAnv
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 19:43:51 -0500
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:47486 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755271AbYKUAnv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 19:43:51 -0500
Received: from vmobile.example.net (catv-80-98-230-81.catv.broadband.hu [80.98.230.81])
	by yugo.frugalware.org (Postfix) with ESMTPA id BFED7446CCF;
	Fri, 21 Nov 2008 01:43:48 +0100 (CET)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 8FCFD148F2; Fri, 21 Nov 2008 01:45:01 +0100 (CET)
X-Mailer: git-send-email 1.6.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101486>

Hi,

These patches replace hand-rolled sprintf/strcpy usage and such with
using the strbuf API.

The first patch is unrelated, I just noticed that minor issue during
creating the other patches.

Miklos Vajna (4):
  builtin-clone: fix a memory leak in cmd_clone()
  builtin-clone: use strbuf in guess_dir_name()
  builtin-clone: use strbuf in clone_local() and
    copy_or_link_directory()
  builtin_clone: use strbuf in cmd_clone()

 builtin-clone.c |  110 ++++++++++++++++++++++++++++++-------------------------
 1 files changed, 60 insertions(+), 50 deletions(-)
