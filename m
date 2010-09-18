From: Marcus Comstedt <marcus@mc.pp.se>
Subject: [PATCH v3 0/4] fix normalization of foreign idents
Date: Sat, 18 Sep 2010 16:30:51 +0200
Message-ID: <cover.1284820251.git.marcus@mc.pp.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 18 16:47:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Owyhi-0008C7-GS
	for gcvg-git-2@lo.gmane.org; Sat, 18 Sep 2010 16:47:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755458Ab0IROra (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Sep 2010 10:47:30 -0400
Received: from ua-85-227-1-6.cust.bredbandsbolaget.se ([85.227.1.6]:51061 "EHLO
	bahamut.mc.pp.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755290Ab0IROr2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Sep 2010 10:47:28 -0400
Received: from chiyo.mc.pp.se (chiyo [192.168.42.32])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by bahamut.mc.pp.se (Postfix) with ESMTPS id 2C87CF8C3;
	Sat, 18 Sep 2010 16:37:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mc.pp.se; s=hedgehog;
	t=1284820668; bh=47Z3GPTIweq9/1FHecEvfGfGjXRmJ+Ov2dV0nIYLlP4=;
	h=Message-Id:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:To:Cc; b=KJfA2J8jrs+7eA0dqJiV6JzNYfLLCt8
	KjNY221Gh8oGBD/IHPhx1hio06rDd33iE+/e4Th+8G9nTNdItrPGjjbskuR3kKQp+ir
	ajh+x2Zv8a1x9WTWVDPxWgB+btLoWyj8jaXCZscfE1gHNh5vL7xg4SfCvbVxRg7ppTN
	nbGL5s=
Received: from marcus by chiyo.mc.pp.se with local (Exim 4.71)
	(envelope-from <c2829398f87f35f24522a780fa82b1250a15b7c8@chiyo>)
	id 1OwyXy-0002N9-PH; Sat, 18 Sep 2010 16:37:46 +0200
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156455>

New in this reroll:

  * Added documentation of foreign idents

  * Raised the level of abstraction for the arguments to
    convert_to_git which control the conversion process (both
    old and new), as suggested by Junio

Marcus Comstedt (4):
  convert: generalize checksafe parameter
  convert: fix normalization of foreign idents
  t0021: test checkout and commit of foreign idents
  Documentation: document foreign idents

 Documentation/gitattributes.txt |    7 +++++
 builtin/apply.c                 |    2 +-
 builtin/blame.c                 |    2 +-
 cache.h                         |   13 ++++++++-
 combine-diff.c                  |    2 +-
 convert.c                       |   26 +++++++++++++----
 diff.c                          |    2 +-
 sha1_file.c                     |    3 +-
 t/t0021-conversion.sh           |   58 +++++++++++++++++++++++++++++++++++++++
 9 files changed, 103 insertions(+), 12 deletions(-)

-- 
1.7.2
