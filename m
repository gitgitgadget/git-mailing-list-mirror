From: "Yann Dirson" <ydirson@linagora.com>
Subject: [BUG] "git-mergetool -t emerge" does not fully die on Ctrl-C
Date: Tue, 12 May 2009 11:38:04 +0200 (CEST)
Message-ID: <49338.10.0.0.1.1242121084.squirrel@intranet.linagora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 12 11:38:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3oR9-0003fH-82
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 11:38:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753677AbZELJh7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 05:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753363AbZELJh7
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 05:37:59 -0400
Received: from alderaan.linagora.com ([84.14.148.74]:52994 "EHLO
	alderaan.linagora.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752917AbZELJh6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 05:37:58 -0400
Received: from 10.0.0.2 (unknown [10.75.192.3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alderaan.linagora.com (Postfix) with ESMTPSA id EF27A429F01
	for <git@vger.kernel.org>; Tue, 12 May 2009 11:37:57 +0200 (CEST)
Received: from 10.0.0.1 (proxying for 194.206.158.221)
        (SquirrelMail authenticated user ydirson)
        by intranet.linagora.com with HTTP;
        Tue, 12 May 2009 11:38:04 +0200 (CEST)
User-Agent: SquirrelMail/1.4.11
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118886>

While playing with the various tools supported by mergetool, I noticed
that, while with most tools you can just use Ctrl-C and git-mergetool as
well as the external tool get killed, the behaviour with emerge looks
buggy: whereas the toplevel "git" process gets killed, the children
git-mergetool as well as emacs are not impacted, and the merge continues
in the background.
