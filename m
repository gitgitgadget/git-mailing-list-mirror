From: "Yann Dirson" <y.dirson@e-sidor.com>
Subject: [msysgit? bug] crlf double-conversion on win32
Date: Tue, 13 Oct 2009 22:49:25 +0200
Message-ID: <38cfaa83fdf80dec3a3d81ed3e0de0e2.squirrel@intranet.linagora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 13 22:59:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxoS5-0006dS-1h
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 22:58:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934336AbZJMU4F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2009 16:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934324AbZJMU4F
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 16:56:05 -0400
Received: from alderaan.linagora.com ([84.14.148.74]:34592 "EHLO
	alderaan.linagora.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934183AbZJMU4E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 16:56:04 -0400
X-Greylist: delayed 382 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Oct 2009 16:56:04 EDT
Received: from 10.0.0.2 (unknown [10.75.192.3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alderaan.linagora.com (Postfix) with ESMTPSA id 20103429ECA
	for <git@vger.kernel.org>; Tue, 13 Oct 2009 22:49:00 +0200 (CEST)
Received: from 10.0.0.1 (proxying for 194.206.158.221)
        (SquirrelMail authenticated user ydirson)
        by intranet.linagora.com with HTTP;
        Tue, 13 Oct 2009 22:49:25 +0200
User-Agent: SquirrelMail/1.4.18
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130211>

With a msysgit 1.6.4 package, I got stuck after someone copied a CRLF file
to a Linux box and committed it.

In that situation, the win32 client in autocrlf mode keeps telling that
the files are locally modified, even after eg "git reset --hard".  Without
touching the crlf setting (which I believe should not ever be necessary),
this can be corrected by committing the faulty files after dos2unix'ing
them, and using "git fetch && git reset --hard origin/master" ("git pull
--rebase" refuses to do the job since it believes there are local
changes).
