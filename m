From: "Guido Ostkamp" <git@ostkamp.fastmail.fm>
Subject: [BUG] git remote add failure
Date: Thu, 18 Oct 2007 10:55:19 +0200
Message-ID: <1192697719.31199.1216526739@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 18 10:55:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiRAF-000525-83
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 10:55:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756806AbXJRIzY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 04:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757496AbXJRIzY
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 04:55:24 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:38365 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755661AbXJRIzX (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Oct 2007 04:55:23 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 1330C32DA2
	for <git@vger.kernel.org>; Thu, 18 Oct 2007 04:55:21 -0400 (EDT)
Received: from web6.messagingengine.com ([10.202.2.215])
  by compute1.internal (MEProxy); Thu, 18 Oct 2007 04:55:22 -0400
Received: by web6.messagingengine.com (Postfix, from userid 99)
	id D0834D10E; Thu, 18 Oct 2007 04:55:19 -0400 (EDT)
X-Sasl-Enc: 2J6BTvSDuEiJcsrO4MOJJ3p9acvaOn4v4TbPxDKhAEX7 1192697719
Content-Disposition: inline
X-Mailer: MessagingEngine.com Webmail Interface
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61508>

Hello,

I think I've found a bug in "git remote add". I tried the following:

$ git remote add -f spearce2 http://repo.or.cz/git/spearce.git
Cannot get the repository state from http://repo.or.cz/git/spearce.git
fetch spearce2: command returned error: 1

Obviously I used the wrong URI. Then I tried again:

$ git remote add -f spearce2 http://repo.or.cz/r/git/spearce.git
remote spearce2 already exists.

I think Git should not store the bad info and block the name when the
first call wasn't successfull.

Regards

Guido
