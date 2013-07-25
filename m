From: =?utf-8?B?T25kxZllaiBCw61sa2E=?= <neleai@seznam.cz>
Subject: [RFC] Faster git grep.
Date: Thu, 25 Jul 2013 20:29:05 +0200
Message-ID: <20130725182905.GA7664@domone.kolej.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 25 20:29:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2QHr-00061x-KU
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jul 2013 20:29:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756875Ab3GYS3M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jul 2013 14:29:12 -0400
Received: from popelka.ms.mff.cuni.cz ([195.113.20.131]:33027 "EHLO
	popelka.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756851Ab3GYS3K (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jul 2013 14:29:10 -0400
Received: from domone.kolej.mff.cuni.cz (popelka.ms.mff.cuni.cz [195.113.20.131])
	by popelka.ms.mff.cuni.cz (Postfix) with ESMTPS id 033CD682B3
	for <git@vger.kernel.org>; Thu, 25 Jul 2013 20:29:06 +0200 (CEST)
Received: by domone.kolej.mff.cuni.cz (Postfix, from userid 1000)
	id C83B25FB95; Thu, 25 Jul 2013 20:29:05 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.97.6 at popelka.ms.mff.cuni.cz
X-Virus-Status: Clean
X-Spam-Status: No, score=-1.8 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	UNPARSEABLE_RELAY autolearn=ham version=3.3.1
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	popelka.ms.mff.cuni.cz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231143>

Hi, 

When I do git grep then with big codebase (gcc) it executes slowly.
I am thinking to add option to speed up search time.

One solution would be to use same trick as was done in google code. 
Build and keep database of trigraphs and which files contain how many of
them. When querry is made then check
only these files that have appropriate combination of trigraphs.

Updating database would be relatively inexpensive compared to disk
access we need to do anyway.

A space usage might be problem so which is why I decided go option
route.

Comments, pointers?

Ondra
