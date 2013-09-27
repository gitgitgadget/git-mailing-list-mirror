From: Morten Stenshorne <mstensho@opera.com>
Subject: Bug: [hostname:port]:repo.git notation no longer works (for ssh)
Date: Fri, 27 Sep 2013 10:07:26 +0200
Message-ID: <87vc1mg01t.fsf@aeneas.oslo.osa>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 27 10:19:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPTHE-0003vO-RI
	for gcvg-git-2@plane.gmane.org; Fri, 27 Sep 2013 10:19:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752655Ab3I0ITs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Sep 2013 04:19:48 -0400
Received: from smtp.opera.com ([213.236.208.81]:35164 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751953Ab3I0ITr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Sep 2013 04:19:47 -0400
X-Greylist: delayed 763 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Sep 2013 04:19:46 EDT
Received: from aeneas.oslo.osa (gw-idc-bgp-c.opera.com [213.236.208.19])
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id r8R871K7012124
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 27 Sep 2013 08:07:01 GMT
Received: from aeneas.oslo.osa (localhost [127.0.0.1])
	by aeneas.oslo.osa (8.14.4/8.14.4/Debian-4) with ESMTP id r8R87QlY030015
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Sep 2013 10:07:26 +0200
Received: (from mstensho@localhost)
	by aeneas.oslo.osa (8.14.4/8.14.4/Submit) id r8R87Qas030014;
	Fri, 27 Sep 2013 10:07:26 +0200
X-Authentication-Warning: aeneas.oslo.osa: mstensho set sender to mstensho@opera.com using -f
X-mstensho: sent-copy
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235444>

I've just upgraded to Debian testing (jessie), and with that I got a
brand new (for me) git version:

    $ git --version
    git version 1.8.4.rc3

Some of my repos I use an ssh tunnel to reach, so when I want to reach a
repo forwarded to local port 2223, using the ssh protocol, the following
used to work (.git/config) in older git versions:

    [remote "exp"]
            url = [localhost:2223]:blink.git
            fetch = +refs/heads/*:refs/remotes/exp/*

However, now I get this message:

    $ git fetch exp
    fatal: ':blink.git' does not appear to be a git repository
    fatal: Could not read from remote repository.

    Please make sure you have the correct access rights
    and the repository exists.

If I don't go via the ssh tunnel (I finally have some VPN stuff these
days, so I don't really need the tunnel thing anymore, but that's going
to be a lot of remotes to update, so I'd prefer it just worked like it
used to):

-            url = [localhost:2223]:blink.git
+            url = git:blink.git

... it works fine.

-- 
---- Morten Stenshorne, developer, Opera Software ASA ----
------------------ http://www.opera.com/ -----------------
