From: Eli Barzilay <eli@barzilay.org>
Subject: gitweb.perl suggestion
Date: Wed, 7 Jul 2010 22:38:06 -0400
Message-ID: <19509.14862.368282.470934@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 08 04:38:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWh0G-00024L-2S
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 04:38:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752621Ab0GHCiJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jul 2010 22:38:09 -0400
Received: from winooski.ccs.neu.edu ([129.10.115.117]:42958 "EHLO barzilay.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751377Ab0GHCiI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jul 2010 22:38:08 -0400
Received: from eli by barzilay.org with local (Exim 4.66)
	(envelope-from <eli@barzilay.org>)
	id 1OWh02-0006qr-CG
	for git@vger.kernel.org; Wed, 07 Jul 2010 22:38:06 -0400
X-Mailer: VM 8.0.12 under 23.1.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150527>

Currently, if I go to

  http://server/gitweb/project/<commit-sha1>

I get to the shortlog page, which is not as useful as the commit
page.  But changing this to have a default `commit' action isn't right
either since the shortlog is more appropriate with

  http://server/gitweb/project/<commit-sha1>..<other-commit-sha1>

So how about changing this:

  $input_params{'action'} ||= "shortlog";

to this:

  $input_params{'action'} ||= ((defined $parentrefname) ? "shortlog" : "commit");

which will make the first case show the commit, and the second show
the shortlog?

-- 
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay:
                    http://barzilay.org/                   Maze is Life!
