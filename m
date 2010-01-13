From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: remote to push to local branch: hung up unexpectedly
Date: Wed, 13 Jan 2010 15:08:43 +0200
Message-ID: <20100113130843.GA13545@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 13 14:11:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NV30s-0003qM-07
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 14:11:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753215Ab0AMNLk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 08:11:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752794Ab0AMNLk
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 08:11:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:18335 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751351Ab0AMNLj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 08:11:39 -0500
Received: from int-mx08.intmail.prod.int.phx2.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.21])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o0DDBdcp013478
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <git@vger.kernel.org>; Wed, 13 Jan 2010 08:11:39 -0500
Received: from redhat.com (vpn1-7-187.ams2.redhat.com [10.36.7.187])
	by int-mx08.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with SMTP id o0DDBbKk006816
	for <git@vger.kernel.org>; Wed, 13 Jan 2010 08:11:38 -0500
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.21
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136815>

I have this in .config:

[remote "anthony"]
        url = .
        push = +refs/heads/pci:refs/heads/for_anthony

The point is to save state when it's stable and safe for outside use.

I hoped to make this shortcut for:
git push  . +refs/heads/pci:refs/heads/for_anthony

But this does:

Total 0 (delta 0), reused 0 (delta 0)
To .
 * [new branch]      pci -> for_anthony
fatal: The remote end hung up unexpectedly

So the command works but seems to give an error at the end.
Same effect with url = file://.
with url = /scm/qemu   (this is repo path)
and with url = file:///scm/qemu

reproduced with 1.6.6.144 and with 1.6.2.5

-- 
MST
