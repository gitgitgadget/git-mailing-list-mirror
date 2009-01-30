From: Yuval Kogman <nothingmuch@woobling.org>
Subject: [PATCH] Add --ff-only flag to git-merge (take 2)
Date: Fri, 30 Jan 2009 06:32:44 +0200
Message-ID: <1233289965-19538-1-git-send-email-nothingmuch@woobling.org>
References: <7vbptpeoge.fsf@gitster.siamese.dyndns.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 30 05:34:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSl5N-0002mp-Jh
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 05:34:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753490AbZA3Ecy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 23:32:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751489AbZA3Ecx
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 23:32:53 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:55475 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751344AbZA3Ecw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 23:32:52 -0500
Received: by fxm13 with SMTP id 13so88966fxm.13
        for <git@vger.kernel.org>; Thu, 29 Jan 2009 20:32:49 -0800 (PST)
Received: by 10.103.172.9 with SMTP id z9mr405237muo.39.1233289969041;
        Thu, 29 Jan 2009 20:32:49 -0800 (PST)
Received: from syeeda.local (bzq-84-109-225-67.red.bezeqint.net [84.109.225.67])
        by mx.google.com with ESMTPS id y6sm791107mug.2.2009.01.29.20.32.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 29 Jan 2009 20:32:48 -0800 (PST)
Received: by syeeda.local (Postfix, from userid 501)
	id 054C13150949; Fri, 30 Jan 2009 06:32:45 +0200 (IST)
X-Mailer: git-send-email 1.6.1
In-Reply-To: <7vbptpeoge.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107767>

Hi,

This attempt fixes the various issues raised, except for the case of octopus
ending in 1 or more fast forwards. I'm not sure what the best way to fix this
is. I see three obvious options, none of which seem optimal:

	1. git-merge-octopus will take a --ff-only flag as well, adding a branch for that

	2. ff-only could be a merge strategy, and octopus is forbidden in
	   --ff-only, while this new strategy will behave just like octopus when
	   the merge can be fast forward only.

	3. the logic from git-merge-octopus could be duplicated into builtin-merge,
	   to handle only the fast forward case.

Please advise.

Regards,
Yuval
