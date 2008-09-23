From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: rebasing merges
Date: Tue, 23 Sep 2008 08:09:23 +0200
Message-ID: <48D88813.9060400@viscovery.net>
References: <20080922155749.c8070681.stephen@exigencecorp.com> <20080922231927.ef18f420.stephen@exigencecorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Stephen Haberman <stephen@exigencecorp.com>
X-From: git-owner@vger.kernel.org Tue Sep 23 08:10:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ki16Z-0006T2-Ne
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 08:10:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752070AbYIWGJ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 02:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752000AbYIWGJ1
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 02:09:27 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:37108 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751934AbYIWGJ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 02:09:26 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Ki15Q-000852-0K; Tue, 23 Sep 2008 08:09:24 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 8C285AFCC; Tue, 23 Sep 2008 08:09:23 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20080922231927.ef18f420.stephen@exigencecorp.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96524>

Stephen Haberman schrieb:
> I noticed the t3400.sh test explicitly tests for the flattening
> behavior, but I can't tell if that is because it's testing for
> explicitly desired behavior or if the "linear-izing" is something
> that is up for debate (or a command line/config option).

This is the expected behavior and not up for debate.

Consider this use-case, for example: You keep a private patch or two on
top of upstream, and you also regularly pull from upstream. You get this
history:

  ---o--o--o--o--o--o    <-- origin
      \     \        \
       A--B--M--------N  <-- master

A and B are the private patches. From time to time you want to update them
if they get out of date, which is indicated by merge conflicts in the
merges M and N. Then you want this result:

  ---o--o--o--o--o--o         <-- origin
                     \
                      A'--B'  <-- master

i.e. linearized history without merges.

-- Hannes
