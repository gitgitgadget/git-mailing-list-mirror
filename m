From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Subject: Re: [PATCH 1/5] Introduces for_each_revision() helper
Date: Thu, 26 Apr 2007 18:12:14 -0300
Organization: Mandriva
Message-ID: <20070426181214.36049e32@localhost>
References: <11776168001253-git-send-email-lcapitulino@mandriva.com.br>
	<11776168001048-git-send-email-lcapitulino@mandriva.com.br>
	<46310485.8070605@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: junkio@cox.net, git@vger.kernel.org
To: Andy Whitcroft <apw@shadowen.org>
X-From: git-owner@vger.kernel.org Thu Apr 26 23:12:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhBGS-0001hc-3Q
	for gcvg-git@gmane.org; Thu, 26 Apr 2007 23:12:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755101AbXDZVM2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Apr 2007 17:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755109AbXDZVM2
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Apr 2007 17:12:28 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:41670 "EHLO
	perninha.conectiva.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755101AbXDZVM1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2007 17:12:27 -0400
Received: from localhost (localhost [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 4F6C417DA4;
	Thu, 26 Apr 2007 18:12:25 -0300 (BRT)
X-Virus-Scanned: amavisd-new at conectiva.com.br
Received: from perninha.conectiva.com.br ([127.0.0.1])
	by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id 4TEnPnlWt-no; Thu, 26 Apr 2007 18:12:18 -0300 (BRT)
Received: from localhost (doriath.conectiva [10.0.2.48])
	by perninha.conectiva.com.br (Postfix) with ESMTP id B777317DA7;
	Thu, 26 Apr 2007 18:12:17 -0300 (BRT)
In-Reply-To: <46310485.8070605@shadowen.org>
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.3; i586-mandriva-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45657>

Em Thu, 26 Apr 2007 20:59:01 +0100
Andy Whitcroft <apw@shadowen.org> escreveu:

| If this is constructed like that then I would expect the code below to
| be miss-compiled:
| 
| 	if (condition)
| 		for_each_revision(commit, rev) {
| 		}
| 
| As it would be effectivly be:
| 
| 	if (condition)
| 		prepare_revision_walk(rev);
| 	while ((commit = get_revision(rev)) != NULL) {
| 	}
| 
| I think you'd want this to be something more like:
| 
| #define for_each_revision(commit, rev) \
| 	for (prepare_revision_walk(rev); \
| 		(commit = get_revision(rev))) != NULL); ) {

 I'm *so* clueless that this mistake does not surprise me.

 Will fix, thanks for the review Andy.

-- 
Luiz Fernando N. Capitulino
