From: "Yann Dirson" <ydirson@linagora.com>
Subject: [BUG] git-svn: HEAD pointing to a tag after cloning
Date: Mon, 11 May 2009 13:08:38 +0200 (CEST)
Message-ID: <37678.10.0.0.1.1242040118.squirrel@intranet.linagora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 11 13:08:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3TN9-0007jF-Lq
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 13:08:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752746AbZEKLIb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2009 07:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752461AbZEKLIb
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 07:08:31 -0400
Received: from alderaan.linagora.com ([84.14.148.74]:55799 "EHLO
	alderaan.linagora.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751142AbZEKLIa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2009 07:08:30 -0400
Received: from 10.0.0.2 (unknown [10.75.192.3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alderaan.linagora.com (Postfix) with ESMTPSA id C7ECD429F00
	for <git@vger.kernel.org>; Mon, 11 May 2009 13:08:29 +0200 (CEST)
Received: from 10.0.0.1 (proxying for 194.206.158.221)
        (SquirrelMail authenticated user ydirson)
        by intranet.linagora.com with HTTP;
        Mon, 11 May 2009 13:08:38 +0200 (CEST)
User-Agent: SquirrelMail/1.4.11
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118791>

The following happens with git 1.6.3.  For some reason git-svn sets HEAD
to the wrong branch.  Not sure what happens here, $self->full_url seems to
be used for a wrong purpose somewhere in the code.


(you can see a commit on the "tag" branch, which got committed at the
wrong place because the user did not notice that HEAD was not pointing to
the correct branch)

$ git svn clone --stdlayout svn://xxxx/at-remote test
[....]
Successfully followed parent
r3287 = 08b210cf2e97caeb6d431a4a0bc594702aa9c6d2 (tags/luciole-2.0.4)
Found possible branch point: svn://xxxx/at-remote/trunk =>
svn://xxxx/at-remote/tags/luciole-2.0.5, 3352
Found branch parent: (tags/luciole-2.0.5)
ddff7cedbd1d66c836153606db1f80ad3ce6b00d
Following parent with do_switch
Successfully followed parent
r3367 = 35b21f3f8e206c391f09a788ba9cb6b35f21752d (tags/luciole-2.0.5)
        M       at-remote
r3652 = faeb3bab02016b23a7fb7256bbabea305f599022 (tags/luciole-2.0.5)
Checked out HEAD:
  svn://xxxx/at-remote/tags/luciole-2.0.5 r3652
$
