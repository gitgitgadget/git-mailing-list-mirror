From: "Yann Dirson" <ydirson@linagora.com>
Subject: [msysgit? bug] CRLF in info/grafts causes parse error
Date: Wed, 14 Oct 2009 16:07:49 +0200
Message-ID: <ecf590a0d9e21f480529f64e465825c5.squirrel@intranet.linagora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 14 16:22:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1My4jp-0007YY-4Z
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 16:22:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933399AbZJNOQJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 10:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933325AbZJNOQJ
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 10:16:09 -0400
Received: from alderaan.linagora.com ([84.14.148.74]:46045 "EHLO
	alderaan.linagora.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933203AbZJNOQI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 10:16:08 -0400
X-Greylist: delayed 478 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Oct 2009 10:16:08 EDT
Received: from 10.0.0.2 (unknown [10.75.192.3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alderaan.linagora.com (Postfix) with ESMTPSA id 3A69F429EE9
	for <git@vger.kernel.org>; Wed, 14 Oct 2009 16:07:32 +0200 (CEST)
Received: from 10.0.0.1 (proxying for 194.206.158.221)
        (SquirrelMail authenticated user ydirson)
        by intranet.linagora.com with HTTP;
        Wed, 14 Oct 2009 16:07:49 +0200
User-Agent: SquirrelMail/1.4.18
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130290>

When creating an info/grafts under windows, one typically gets a CRLF file.
Then:

* gitk loudly complains about "bad graft data"
* "git log > /dev/null" does not report any problem
* "git log > foo" does report the problem on sdterr, but exit code is still 0

Recreating the graft as a LF file (eg with "echo" or "printf") causes the
graft to be properly interpreted.
