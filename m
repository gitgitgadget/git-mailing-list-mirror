From: Eric Raible <raible@nextest.com>
Subject: Should 'git status' understand a .git containing "gitdir: dir"?
Date: Thu, 30 Jun 2011 02:04:29 -0700
Message-ID: <4E0C3C1D.1050406@nextest.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 30 11:04:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QcDAs-0000JR-7p
	for gcvg-git-2@lo.gmane.org; Thu, 30 Jun 2011 11:04:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756432Ab1F3JEc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jun 2011 05:04:32 -0400
Received: from pops.nextest.com ([12.96.234.114]:58406 "EHLO
	exchange.DOMAIN1.nextest.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754648Ab1F3JEb (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Jun 2011 05:04:31 -0400
Received: from [131.101.151.1] (131.101.151.1) by Exchange.DOMAIN1.nextest.com
 (131.101.21.39) with Microsoft SMTP Server (TLS) id 8.2.176.0; Thu, 30 Jun
 2011 02:07:55 -0700
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.18) Gecko/20110616 Lightning/1.0b2 Thunderbird/3.1.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176480>

The following sequence sets up a trivial repo that uses "gitdir:":

$ git init gitdir-test
$ cd gitdir-test
$ mv .git real-git-dir
$ echo "gitdir: real-git-dir" > .git
$ git status

Fine so far.  But git-status shows that "real-git-dir" is untracked:

$ git status -sb
## Initial commit on master
?? real-git-dir/

Which strikes one as a bit inconsistent (since other pars of git-status
knows to look in real-git-dir to find the index).

Sorry - no time to investigate.
