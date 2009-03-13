From: Kristian Amlie <kristian.amlie@nokia.com>
Subject: Re: Honoring a checked out gitattributes file
Date: Fri, 13 Mar 2009 14:24:14 +0100
Message-ID: <1236950656-1967-1-git-send-email-kristian.amlie@nokia.com>
References: <49B8DD1D.3060908@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 13 14:26:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Li7Ok-0001ew-8q
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 14:26:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754471AbZCMNY0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2009 09:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753904AbZCMNYZ
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 09:24:25 -0400
Received: from hoat.troll.no ([62.70.27.150]:59317 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753568AbZCMNYY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Mar 2009 09:24:24 -0400
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 8BFF22131A
	for <git@vger.kernel.org>; Fri, 13 Mar 2009 14:24:17 +0100 (CET)
Received: from sx01.troll.no (sx01.troll.no [62.70.27.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id 76F54212F7
	for <git@vger.kernel.org>; Fri, 13 Mar 2009 14:24:17 +0100 (CET)
Received: from sx01.troll.no (localhost.localdomain [127.0.0.1])
	by sx01.troll.no (8.13.8/8.13.8) with ESMTP id n2DDOHu0007225
	for <git@vger.kernel.org>; Fri, 13 Mar 2009 14:24:17 +0100
Received: from axis.localdomain ( [172.24.90.99])
    by sx01.troll.no (Scalix SMTP Relay 11.4.1.11929)
    via ESMTP; Fri, 13 Mar 2009 14:24:17 +0100 (CET)
Received: by axis.localdomain (Postfix, from userid 1000)
	id CF03136182DE; Fri, 13 Mar 2009 14:24:16 +0100 (CET)
In-Reply-To: <49B8DD1D.3060908@viscovery.net>
x-scalix-Hops: 1
X-Mailer: git-send-email 1.6.1.1
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113181>


Ok, here's another round. I fixed the test case to expect failure, as
pointed out by Matthieu, and I also added code to make sure that
.gitattributes gets checked out first.

I also added a test case and some code to support the case where
.gitattributes is removed in a commit, but this doesn't work properly
yet (see commit message). I'm not sure how to solve this without
resolving to ugly hacks like passing the new index_state* all the way
down to where git_checkattr gets called. If anybody has any
suggestions, do share.

The main usecase where .gitattributes is modified, is anyway covered
by this patch.

--
Kristian
