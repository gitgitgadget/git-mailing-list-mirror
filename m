From: Pavel Roskin <proski@gnu.org>
Subject: What's wrong with cogito repository today?
Date: Tue, 20 Sep 2005 12:27:13 -0400
Message-ID: <1127233633.8374.26.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Sep 20 18:29:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHkxs-0003DW-Ap
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 18:27:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964784AbVITQ1R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Sep 2005 12:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964782AbVITQ1R
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Sep 2005 12:27:17 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:15574 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S964784AbVITQ1Q
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Sep 2005 12:27:16 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1EHkxe-0000gC-VM
	for git@vger.kernel.org; Tue, 20 Sep 2005 12:27:15 -0400
Received: from proski by dv.roinet.com with local (Exim 4.52)
	id 1EHkxd-0004UH-P0
	for git@vger.kernel.org; Tue, 20 Sep 2005 12:27:13 -0400
To: git <git@vger.kernel.org>
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9005>

Hello!

cogito repository is broken today:

$ git-fetch
Fetching refs/heads/master from http://www.kernel.org/pub/scm/cogito/cogito.git/ using http
Getting pack list
Getting alternates list
error: Unable to find 69ba00668be16e44cae699098694286f703ec61d under http://www.kernel.org/pub/scm/cogito/cogito.git//

Cannot obtain needed object 69ba00668be16e44cae699098694286f703ec61d
while processing commit 0000000000000000000000000000000000000000.

[proski@dv cogito]$ curl http://www.kernel.org/pub/scm/cogito/cogito.git/refs/heads/master
69ba00668be16e44cae699098694286f703ec61d

[proski@dv cogito]$ wget http://www.kernel.org/pub/scm/cogito/cogito.git/objects/69/ba00668be16e44cae699098694286f703ec61d
--12:19:49--  http://www.kernel.org/pub/scm/cogito/cogito.git/objects/69/ba00668be16e44cae699098694286f703ec61d
           => `ba00668be16e44cae699098694286f703ec61d'
Resolving www.kernel.org... 204.152.191.5
Connecting to www.kernel.org[204.152.191.5]:80... connected.
HTTP request sent, awaiting response... 404 Not Found
12:19:49 ERROR 404: Not Found.


I don't know how the commits are pushed to kernel.org, but maybe it's
possible to prevent such breakage by ensuring that the head is only
updated if the objects have been uploaded?

-- 
Regards,
Pavel Roskin
