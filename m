From: Greg Brockman <gdb@MIT.EDU>
Subject: [PATCH/RFC 0/4] Providing mechanism to list available repositories
Date: Tue, 13 Jul 2010 23:01:11 -0400
Message-ID: <1279076475-27730-1-git-send-email-gdb@mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 14 05:06:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYsIo-0001Nr-NK
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 05:06:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754110Ab0GNDGZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jul 2010 23:06:25 -0400
Received: from DMZ-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.35]:54855 "EHLO
	dmz-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751137Ab0GNDGZ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Jul 2010 23:06:25 -0400
X-Greylist: delayed 300 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Jul 2010 23:06:24 EDT
X-AuditID: 12074423-b7be0ae000000a83-b9-4c3d2883103b
Received: from mailhub-auth-3.mit.edu (MAILHUB-AUTH-3.MIT.EDU [18.9.21.43])
	by dmz-mailsec-scanner-6.mit.edu (Symantec Brightmail Gateway) with SMTP id 2A.67.02691.3882D3C4; Tue, 13 Jul 2010 23:01:23 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-3.mit.edu (8.13.8/8.9.2) with ESMTP id o6E31NK8030221;
	Tue, 13 Jul 2010 23:01:23 -0400
Received: from localhost (EASTCAMPUS-NINE-NINETY-FOUR.MIT.EDU [18.238.6.227])
	(authenticated bits=0)
        (User authenticated as gdb@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o6E31MDN005061;
	Tue, 13 Jul 2010 23:01:23 -0400 (EDT)
X-Mailer: git-send-email 1.7.0.4
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150958>

I'm working on a project that has separate Git repositories for
different components.  Repositories are cloneable via
  git clone git@xvm.mit.edu:path/to/repo.git,
where the 'git' user's shell is git-shell.

We have been seeking a simple and maintainable way for users to
discover the set of available repositories.  E.g. posting the list on
our website would add extra steps for users to find and retrieve the
list as well as require extra effort from our end.  Since we already give
users ssh access to git@xvm.mit.edu, we would like to multiplex the
functionality to allow discovery of available repositories.

Our solution is to expose a 'list' command to the end user, invocable
as
  ssh git@xvm.mit.edu list,
which displays the available repositories.

We find this mechanism useful in that it requires no extra
infrastructure on either our end or the user's end.  Our
implementation is extensible, allowing the system administrator to
place arbitrary commands in ~/git-shell-commands (if the directory is
omitted, no extra functionality is exposed), and also supports an
interactive mode.

What do people think of this approach?  I'd love to get this
functionality merged in some form.

Thank you!

Greg Brockman
