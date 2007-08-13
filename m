From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGIT PATCH 0/4] Optimizations for the DAG appliedness stuff
Date: Mon, 13 Aug 2007 23:01:18 +0200
Message-ID: <20070813205801.25929.34925.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 13 23:02:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKh39-000626-MJ
	for gcvg-git@gmane.org; Mon, 13 Aug 2007 23:02:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S969869AbXHMVBd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 13 Aug 2007 17:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968543AbXHMVBa
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Aug 2007 17:01:30 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3330 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967290AbXHMVBZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2007 17:01:25 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IKh2O-0008PD-00; Mon, 13 Aug 2007 22:01:20 +0100
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55784>

The DAG appliedness series incurred a serious slowdown when it had to
recompute the set of uninteresting commits from scratch. (This is the
set of commits that are parents of patch commits, but not ancestors of
any patch commit. They are used to make DAG appliedness operations
fast.)

The patches in this series fall into two categories:

  * Making the recomputation-from-scratch (slightly) faster.

  * Reducing the number of situations where the
    recomputation-from-scratch has to be done.

--=20
Karl Hasselstr=C3=B6m, kha@treskal.com
      www.treskal.com/kalle
