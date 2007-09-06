From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: builtin commit series sent
Date: Wed, 05 Sep 2007 20:45:27 -0400
Message-ID: <1189039527.20311.24.camel@hinata.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 06 02:45:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IT5V5-0003Ar-PF
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 02:45:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932287AbXIFApf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 20:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932286AbXIFApf
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 20:45:35 -0400
Received: from mx1.redhat.com ([66.187.233.31]:46447 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932271AbXIFApe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 20:45:34 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l860jXK0010789
	for <git@vger.kernel.org>; Wed, 5 Sep 2007 20:45:33 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l860jXEr002652
	for <git@vger.kernel.org>; Wed, 5 Sep 2007 20:45:33 -0400
Received: from [192.168.1.101] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l860jXXE018472
	for <git@vger.kernel.org>; Wed, 5 Sep 2007 20:45:33 -0400
X-Mailer: Evolution 2.11.90 (2.11.90-4.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57792>

Hi,

I finally sat down and finished the last details in my git-commit.sh
port and made it pass the test suite.  The test suite is cruel, but
awesome.  There's one test that doesn't look right to me:
t1400-update-ref.sh.  The 'creating initial files' case does a git
commit --amend and apparently expect to commit the changed contents of
the file F, even though it hasn't been added to the index.  Similarly,
there's a git commit -F M just below it that does the same thing.  I'm
not sure how they pass with the shell script commit...

Also, there is some overlap in the patch set with Pierre's nice strbuf
work, but it's mostly just naming, and should be easy to work out.  I
have a couple of places where I manually add a NUL terminator, but I
like Pierres approach of always implicitly doing that.

I didn't work on this for a couple of weeks, and keeping up-to-date with
the various git-commit.sh changes that happened in the meantime
(templates, different option semantics etc) wasn't fun.  Also I don't
really have the time to maintain this out of tree, these days, so I'd
really appreciate, now that the work is finished, if we can get it in.

cheers,
Kristian
