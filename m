From: Pierre Habouzit <madcoder@debian.org>
Subject: strbuf new API, take 2 for inclusion
Date: Thu,  6 Sep 2007 13:20:04 +0200
Message-ID: <11890776114037-git-send-email-madcoder@debian.org>
References: <20070902224213.GB431@artemis.corp>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 06 13:20:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITFPI-0008IQ-SM
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 13:20:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752775AbXIFLUQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 07:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752350AbXIFLUP
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 07:20:15 -0400
Received: from pan.madism.org ([88.191.52.104]:52603 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751263AbXIFLUN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 07:20:13 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id D0B651E402
	for <git@vger.kernel.org>; Thu,  6 Sep 2007 13:20:12 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id C3CDB1A3BC; Thu,  6 Sep 2007 13:20:11 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.1
In-Reply-To: <20070902224213.GB431@artemis.corp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57862>

  Here is a new patchset (with no wrong patchs and numbering this time)
with Junio's remarks integrated (the va_copy stuff, better documentation
and patch comments and so on).

  strbuf_read remains a "I can read all the content of the file or the
caller is supposed to die()" operation for now, as it's how it's used
right now, this can be changed easily in the future if needs for it
exists.

  I've also stripped as many STRBUF_INIT uses as possible, some people
didn't liked it. I've kept its use for "static" strbufs where it's way
more convenient that a function call.
