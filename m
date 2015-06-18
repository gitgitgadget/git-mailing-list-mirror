From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v5 15/19] fsck: Document the new receive.fsck.<msg-id> options
Date: Thu, 18 Jun 2015 22:09:43 +0200
Organization: gmx
Message-ID: <dd5502af544216e743196a5c520df5255e4e35ba.1434657920.git.johannes.schindelin@gmx.de>
References: <cover.1422737997.git.johannes.schindelin@gmx.de>
 <cover.1434657920.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jun 18 22:10:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5g8V-00048w-Gp
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 22:10:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932550AbbFRUJ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 16:09:57 -0400
Received: from mout.gmx.net ([212.227.17.21]:59548 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756175AbbFRUJu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 16:09:50 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MOSNd-1ZAunK240L-005tFl; Thu, 18 Jun 2015 22:09:43
 +0200
In-Reply-To: <cover.1434657920.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:pnBD1uMMbab5XFRuKOCw/ejYQ8taeWlYbi3TePH1FuiHTY4rRf6
 Q640aKAMJ6xsiDgiPhC0TsACMLn4zSwO14J2cF8fWMp4WCGoOwT+28Y1vQJTQwMzSt2+40d
 RAetLNZuRvkmXcETfXeFI4GOnMv+f/4Fw3/tQJ6hwz9jWECHZQfJ/DfCqZkR8bYIdV0r5s/
 LxP9RefKVph9HNoK+TD9w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2YRqHx+F21A=:SSLnQzspQDmAcW5sLJlYIf
 rgANZlfE1qZeDKoKXUfLaEYDRYTCVW/VRUQZvUZao/WTfyd7kzpOqKI43Tn/h/a5SpqnzUbBT
 +MhHSdpFFD8r9Z7FI6t8ULAN3rX+WsMrCAEiS5AiqPjoG2znWdIQb5eFQIC2F2pBIWChItmVe
 BEJbrGK4NpxhPpZjyMXeiWUi1GGdv7xTZ1p3s+zTXVPcthDmkI2ZSWxNYyti2laQxvgTyjNVu
 r/DQIZXJTJzHGDljsdq0sPoXwadz5Aw+PxyD3L474+Q0HWlh1WDU3K6BF70Ht2mKRmtXmsq+d
 dc5mJ9BoSPVTqJ2q4Ip+twa6EncUAY8BpcOZbWJakcWWNf9w+szL5pJ+LZmnYw62AvKyDupTD
 vli6KEgYX24XRCrfLpNoL+mNyc4+icfrHKSUnPZsDpA0hzN6VMzNQQAX8IiVPaREH7MmwVSoW
 9ipe3iF1BnIqIyDhyuJ6ZOqNkT/vcwvwEaRFsDr/h3kSLbC8+ION6VcWFDqYL7vG/A5yz7hg2
 GyHOONBM+bVmuKqg5IwAz6IAmfW9S98VwtCfBRs7qptGCBh+n0HcABUNLd3hJ4Lper9hqhFF0
 CB7f6Am+yufLvKWbytvQ/RueWHHrApo9J22AMjplkDbVE5LnR0pmSX3Lelq0cEi6AucD7Z5fn
 m6OWRshwdfHlrbQZLpBmWVSYjfMBPN9kquohl3qB/dp07UV0uKscaWDQPRpjg2PEdPSw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272059>

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config.txt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 3e37b93..306ab7a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2205,6 +2205,20 @@ receive.fsckObjects::
 	Defaults to false. If not set, the value of `transfer.fsckObjects`
 	is used instead.
 
+receive.fsck.<msg-id>::
+	When `receive.fsckObjects` is set to true, errors can be switched
+	to warnings and vice versa by configuring the `receive.fsck.<msg-id>`
+	setting where the `<msg-id>` is the fsck message ID and the value
+	is one of `error`, `warn` or `ignore`. For convenience, fsck prefixes
+	the error/warning with the message ID, e.g. "missingemail: invalid
+	author/committer line - missing email" means that setting
+	`receive.fsck.missingemail = ignore` will hide that issue.
++
+This feature is intended to support working with legacy repositories
+which would not pass pushing when `receive.fsckObjects = true`, allowing
+the host to accept repositories with certain known issues but still catch
+other issues.
+
 receive.unpackLimit::
 	If the number of objects received in a push is below this
 	limit then the objects will be unpacked into loose object
-- 
2.3.1.windows.1.9.g8c01ab4
