From: marcnarc@xiplink.com
Subject: [PATCHv4 0/3] fetch: Only call a new ref a "branch" if it's under refs/heads/.
Date: Mon, 16 Apr 2012 18:08:47 -0400
Message-ID: <1334614130-31826-1-git-send-email-marcnarc@xiplink.com>
References: <1334591542-25136-1-git-send-email-marcnarc@xiplink.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 17 00:08:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJu67-0006Ks-9q
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 00:08:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755431Ab2DPWIb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 18:08:31 -0400
Received: from 208-85-112-101.zerofail.com ([208.85.112.101]:2185 "EHLO
	farnsworth.xiplink.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754791Ab2DPWI3 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Apr 2012 18:08:29 -0400
Received: from xiplink.com (rincewind.xiplink.com [192.168.1.166])
	by farnsworth.xiplink.com (8.14.3/8.14.3/Debian-9.1ubuntu1) with ESMTP id q3GM8QLO000947;
	Mon, 16 Apr 2012 18:08:27 -0400
X-Mailer: git-send-email 1.7.10.2.ge89da.dirty
In-Reply-To: <1334591542-25136-1-git-send-email-marcnarc@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195707>


It turns out that ref->peer_ref is always NULL in update_local_ref().  So I
made its caller pass in the full remote ref as a new parameter.  I also added
a unit test.

This series is a complete resend of all the patches discussed in these
threads, including Jens's submodule recursion fix.

 builtin/fetch.c  |   39 +++++++++++++++++++++++++--------------
 t/t5510-fetch.sh |   28 ++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 14 deletions(-)

Jens Lehmann (1):
      submodules: recursive fetch also checks new tags for submodule commits

Marc Branchaud (2):
      fetch: Pass both the full remote ref and its short name to update_local_ref().
      fetch: Use the remote's ref name to decide how to describe new refs.

		M.
