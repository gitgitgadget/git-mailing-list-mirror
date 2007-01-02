From: Juergen Ruehle <j.ruehle@bmiag.de>
Subject: [PATCH/RFC] Assorted small changes to runstatus
Date: Tue,  2 Jan 2007 20:26:19 +0100
Message-ID: <1167765983316-git-send-email-j.ruehle@bmiag.de>
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Jan 02 20:26:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1pHa-0007wE-Tg
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 20:26:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964915AbXABT0n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Jan 2007 14:26:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964919AbXABT0n
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jan 2007 14:26:43 -0500
Received: from meriadoc.bmiag.de ([62.154.210.133]:37833 "EHLO
	meriadoc.bmiag.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964915AbXABT0l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jan 2007 14:26:41 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by meriadoc.bmiag.de (Postfix) with ESMTP id 0225C3AED2;
	Tue,  2 Jan 2007 20:26:37 +0100 (CET)
Received: from meriadoc.bmiag.de ([127.0.0.1])
	by localhost (meriadoc [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 14487-06; Tue, 2 Jan 2007 20:26:36 +0100 (CET)
Received: from eorl.intranet.kiel.bmiag.de (eorl.intranet.kiel.bmiag.de [10.131.2.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by meriadoc.bmiag.de (Postfix) with ESMTP id A36793AED1;
	Tue,  2 Jan 2007 20:26:33 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by eorl.intranet.kiel.bmiag.de (Postfix) with ESMTP id 288A53ADCA;
	Tue,  2 Jan 2007 20:26:32 +0100 (CET)
Received: from eorl.intranet.kiel.bmiag.de ([127.0.0.1])
	by localhost (eorl [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 20762-02; Tue, 2 Jan 2007 20:26:26 +0100 (CET)
Received: from localhost.localdomain (dialin5.galadriel.bmiag.de [192.168.251.5])
	by eorl.intranet.kiel.bmiag.de (Postfix) with ESMTP id 31B253ADC6;
	Tue,  2 Jan 2007 20:26:24 +0100 (CET)
To: git@vger.kernel.org
X-Mailer: git-send-email 1.5.0.rc0.g31e2
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at eorl.intranet.kiel.bmiag.de
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at meriadoc.bmiag.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35801>

As a regular user of git-status I'd like to propose some small changes and a
fix:

 - wording changes to the section headers

 - more context awareness in the nothing-to-commit line

 - fix runstatus breakage when amending a root commit

Additional Notes:

 - if git-reset <commit> <path> provided the ability to remove path from the
   index (if not present in commit) runstatus could advertise reset as the
   universal unstaging tool (in the non-initial-commit case)

   (this is similar to the recent request on the list to allow
    git-commit -o <path> to commit removal of path)

 - IMO git-rm without -f should not remove anything if HEAD doesn't exist
   (i.e. from the initial commit); this might be a bug
