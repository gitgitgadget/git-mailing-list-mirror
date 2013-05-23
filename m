From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: push not resolving commit-ish?
Date: Thu, 23 May 2013 13:53:10 +0300
Message-ID: <20130523105310.GA17361@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 23 12:52:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfT8e-0004Om-Ix
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 12:52:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758101Ab3EWKws (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 06:52:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42054 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757825Ab3EWKws (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 06:52:48 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r4NAqloi018622
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <git@vger.kernel.org>; Thu, 23 May 2013 06:52:47 -0400
Received: from redhat.com (vpn-202-161.tlv.redhat.com [10.35.202.161])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id r4NAqkOl018174
	for <git@vger.kernel.org>; Thu, 23 May 2013 06:52:46 -0400
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225235>

Looks like push can't resolve tags to commits.
Why is that?

linux$ git push -f $PWD v3.10-rc2:refs/heads/vhost-next
error: Trying to write non-commit object
a8c6d53c4d84b3a5eb182758a9cdceceba4691da to branch refs/heads/vhost-next
To /scm/linux
 ! [remote rejected] v3.10-rc2 -> vhost-next (failed to write)
error: failed to push some refs to '/scm/linux'

linux$ git log v3.10-rc2|head -5
commit c7788792a5e7b0d5d7f96d0766b4cb6112d47d75
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon May 20 14:37:38 2013 -0700

    Linux 3.10-rc2


linux$ $ git push -f $PWD
c7788792a5e7b0d5d7f96d0766b4cb6112d47d75:refs/heads/vhost-next
Everything up-to-date
