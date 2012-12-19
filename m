From: wking@tremily.us
Subject: [PATCH v8 0/3] submodule update: add --remote for submodule's upstream
 changes
Date: Wed, 19 Dec 2012 11:03:30 -0500
Message-ID: <cover.1355932282.git.wking@tremily.us>
References: <20121212230217.GB7729@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 19 17:04:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlM7x-0003Qa-Pe
	for gcvg-git-2@plane.gmane.org; Wed, 19 Dec 2012 17:04:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755608Ab2LSQDz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2012 11:03:55 -0500
Received: from vms173019pub.verizon.net ([206.46.173.19]:50261 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755579Ab2LSQDy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2012 11:03:54 -0500
Received: from odin.tremily.us ([unknown] [72.68.92.119])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MFA00JEYCLQ8A90@vms173019.mailsrvcs.net> for
 git@vger.kernel.org; Wed, 19 Dec 2012 10:03:28 -0600 (CST)
Received: from mjolnir (mjolnir.tremily.us [192.168.0.6])
	by odin.tremily.us (Postfix) with SMTP id 81B9B737703; Wed,
 19 Dec 2012 11:03:25 -0500 (EST)
Received: by mjolnir (sSMTP sendmail emulation); Wed, 19 Dec 2012 11:03:38 -0500
X-Mailer: git-send-email 1.8.0
In-reply-to: <20121212230217.GB7729@odin.tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211830>

From: "W. Trevor King" <wking@tremily.us>

Comments on v7 seem to have petered out, so here's v8.  Changes since
v7:

* Series based on gitster/master instead of v1.8.0.
* In Documentation/config.txt, restored trailing line of
  submodule.<name>.update documentation, which I had accidentally
  removed in v7.
* In Documentation/git-submodule.txt, make --no-fetch example in the
  --remote description more general, following Phil's suggestion.
* In git-submodule.sh:
  * Remove accidental "ges" line.
  * Use the submodule's default remote to determine which tracking
    branch to fetch.  In v7 I'd been using the superproject's default
    remote.
  * In cmd_add(), use sm_name instead of sm_path to store the --branch
    option (catching up with 73b0898).

W. Trevor King (3):
  submodule: add get_submodule_config helper funtion
  submodule update: add --remote for submodule's upstream changes
  submodule add: If --branch is given, record it in .gitmodules

 Documentation/config.txt        |  6 +++++
 Documentation/git-submodule.txt | 25 +++++++++++++++++++-
 Documentation/gitmodules.txt    |  5 ++++
 git-submodule.sh                | 51 ++++++++++++++++++++++++++++++++++++++++-
 t/t7400-submodule-basic.sh      |  1 +
 t/t7406-submodule-update.sh     | 31 +++++++++++++++++++++++++
 6 files changed, 117 insertions(+), 2 deletions(-)

-- 
1.8.0
