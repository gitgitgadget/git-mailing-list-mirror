From: Sam Ravnborg <sam@ravnborg.org>
Subject: git cole give unexpected error message
Date: Tue, 13 Dec 2005 22:28:20 +0100
Message-ID: <20051213212820.GB5232@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Dec 13 22:30:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmHgy-00023F-Fg
	for gcvg-git@gmane.org; Tue, 13 Dec 2005 22:28:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030237AbVLMV2J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Dec 2005 16:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbVLMV2J
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Dec 2005 16:28:09 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:12829 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S932506AbVLMV2I
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2005 16:28:08 -0500
Received: from mars.ravnborg.org (0x50a0757d.hrnxx9.adsl-dhcp.tele.dk [80.160.117.125])
	by pfepa.post.tele.dk (Postfix) with ESMTP id 23F1847FEF9
	for <git@vger.kernel.org>; Tue, 13 Dec 2005 22:28:03 +0100 (CET)
Received: by mars.ravnborg.org (Postfix, from userid 1000)
	id 447FD6AC07C; Tue, 13 Dec 2005 22:28:20 +0100 (CET)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13590>

Encountered following minor issue today:

Executed:
sam@mars ~/work $ git clone git://git.kernel.org/pub/scm/lib/klibc/klibc.git viggo
defaulting to local storage area
fatal: unexpected EOF

The errormessage "fatal: unexpected EOF" did not immediately tell me
that the requested git repository did not exists.

But I corrected the path and tried again:
sam@mars ~/work $ git clone git://git.kernel.org/pub/scm/libs/klibc/klibc.git viggo
viggo already exists.

So one can see that git did not clean up after the faulty clone.

It would be nice if git:
1) Displayed a more meaningfull error message
2) Cleaned up so I did not have to do a manual rm -rf viggo


cogito being a nice porcelain gives the git errormessage but manage to
clean up when the clone fails.
So also cogito would benefit from a more descriptive errormessage.

	Sam
