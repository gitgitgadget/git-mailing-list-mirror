From: Kevin Bracey <kevin@bracey.fi>
Subject: [PATCH 0/2] Make --ancestry-path A...B work
Date: Mon, 13 May 2013 18:00:45 +0300
Message-ID: <1368457247-19822-1-git-send-email-kevin@bracey.fi>
References: <5190F806.6040207@bracey.fi>
Cc: Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Kevin Bracey <kevin@bracey.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 13 17:01:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbuFV-00059M-Lb
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 17:01:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754271Ab3EMPBH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 11:01:07 -0400
Received: from 8.mo5.mail-out.ovh.net ([178.32.116.78]:42240 "EHLO
	mo5.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753803Ab3EMPBG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 11:01:06 -0400
Received: from mail624.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with SMTP id AAF49FFA933
	for <git@vger.kernel.org>; Mon, 13 May 2013 17:01:03 +0200 (CEST)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 13 May 2013 17:01:21 +0200
Received: from 85-23-153-122.bb.dnainternet.fi (HELO asus-i7-debian.bracey.fi) (kevin@bracey.fi@85.23.153.122)
  by ns0.ovh.net with SMTP; 13 May 2013 17:01:19 +0200
X-Ovh-Mailout: 178.32.228.5 (mo5.mail-out.ovh.net)
X-Mailer: git-send-email 1.8.3.rc0.28.g4b02ef5
In-Reply-To: <5190F806.6040207@bracey.fi>
X-Ovh-Tracer-Id: 17732924802568414
X-Ovh-Remote: 85.23.153.122 (85-23-153-122.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: -58
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrjeehucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenudcurhgrnhguohhmuchsthhrihhnghdlshdmucdlgedvmd
X-Spam-Check: DONE|U 0.500006/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -58
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrjeehucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenudcurhgrnhguohhmuchsthhrihhnghdlshdmucdlgedvmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224165>

This patch is a revised form of the one in my "history traversal refinements"
series. Pulled out to allow it to proceed faster, given that John Keeping has
found a use for the command.

I suggest this is placed onto pu ahead of the existing series, dropping the
equivalent final commit there. And then hopefully this can proceed to next
faster.

(Dropping that commit will drop the only --ancestry-path A...B test in t6111,
meaning no immediate dependencies. But the next version of that series will be
sent with t6111 testing and expecting a pass due to this fix being in.)

Kevin Bracey (2):
  t6019: demonstrate --ancestry-path A...B breakage
  revision.c: treat A...B merge bases as if manually specified

 revision.c                        | 17 +++++++++++++++++
 revision.h                        |  1 +
 t/t6019-rev-list-ancestry-path.sh | 21 ++++++++++++++++++++-
 3 files changed, 38 insertions(+), 1 deletion(-)

-- 
1.8.3.rc0.28.g4b02ef5
