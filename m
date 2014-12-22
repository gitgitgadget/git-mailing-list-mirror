From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 0/2] Let `git remote add` play nicer with
 url.<url>.insteadOf
Date: Mon, 22 Dec 2014 18:06:46 +0100 (CET)
Message-ID: <cover.1419267895.git.johannes.schindelin@gmx.de>
References: <20141216021900.50095.24877@random.io>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: anapsix@random.io, git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Dec 22 18:07:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y36Rm-0003l0-KJ
	for gcvg-git-2@plane.gmane.org; Mon, 22 Dec 2014 18:07:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755449AbaLVRGz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2014 12:06:55 -0500
Received: from mout.gmx.net ([212.227.15.18]:58625 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755149AbaLVRGy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2014 12:06:54 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx002) with ESMTPSA (Nemesis) id 0MLfH9-1Y3vO93pLv-000x3I;
 Mon, 22 Dec 2014 18:06:46 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <20141216021900.50095.24877@random.io>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:vTdr/P0TORUKZfwfxABwR3jCzmv37D+2fHiVvPonZqvAy0vZpKJ
 66fg3M1UtIeVvs+kSdL7HSt/FezaeJZ5HmKHvgWOuykd/mj3Pjbac3XepWYLpU2Vpb9AV8n
 +MjCEA2BDoHxly30ggJm1sd0lbXxdcv+S8UIQGnKYL4++LXlvIvjY1Vsn6n1J9O1fpLxB//
 mj9BPTrtWbpk2SW2utU2w==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261651>

Anastas Dancha reported that it is not possible to add a remote when
there is already a url.<url>.insteadOf = <nick> setting in
$HOME/.gitconfig.

While it makes sense to prevent surprises when a user adds a remote and
it fetches from somewhere completely different, it makes less sense to
prevent adding a remote when it is actually the same that was specified
in the config.

Therefore we add just another check that let's `git remote add` continue
when the "existing" remote's URL is identical to the specified one.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>


Johannes Schindelin (2):
  git remote add: allow re-adding remotes with the same URL
  Add a regression test for 'git remote add <existing> <same-url>'

 builtin/remote.c  | 3 ++-
 t/t5505-remote.sh | 5 +++++
 2 files changed, 7 insertions(+), 1 deletion(-)

-- 
2.0.0.rc3.9669.g840d1f9
