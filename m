From: perryh@pluto.rain.com
Subject: How do I specify a revision for "git blame" by date?
Date: Thu, 14 Jun 2012 08:26:21 -0700
Message-ID: <4fda029d.g99uVull9jgguc/Y%perryh@pluto.rain.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 14 11:02:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sf5x9-0006Md-M5
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jun 2012 11:02:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755349Ab2FNJCw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jun 2012 05:02:52 -0400
Received: from agora.rdrop.com ([199.26.172.34]:3075 "EHLO agora.rdrop.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751582Ab2FNJCv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2012 05:02:51 -0400
X-Greylist: delayed 1877 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Jun 2012 05:02:51 EDT
Received: from agora.rdrop.com (66@localhost [127.0.0.1])
	by agora.rdrop.com (8.13.1/8.12.7) with ESMTP id q5E8VYaG073924
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Thu, 14 Jun 2012 01:31:34 -0700 (PDT)
	(envelope-from perryh@pluto.rain.com)
Received: (from uucp@localhost)
	by agora.rdrop.com (8.13.1/8.14.2/Submit) with UUCP id q5E8VYml073923
	for git@vger.kernel.org; Thu, 14 Jun 2012 01:31:34 -0700 (PDT)
	(envelope-from perryh@pluto.rain.com)
Received: from fbsd81 ([192.168.200.81]) by pluto.rain.com (4.1/SMI-4.1-pluto-M2060407)
	id AA02671; Thu, 14 Jun 12 01:27:40 PDT
User-Agent: nail 11.25 7/29/05
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199985>

How do I get "git blame" to operate "as of" a particular date in
the past, without having to manually look up the corresponding
SHA1 using "git rev-list"?  For example, I can get a report as of
2011-12-29 by doing something like:

  $ git rev-list --all --date-order --format="%h %ai" .
  ...
  7c69106 2012-01-03 ...
  b4227af 2011-12-27 ...
  ...

  $ git blame <file> b4227af

but I want to have git look up the last revision prior to the given
date, by doing something like

  $ git blame <file> @{2011-12-29}

This does not work as written:  it ignores the date parameter with
a warning:

  warning: Log for '' only goes back to Thu, 10 May 2012 08:14:16 -0700.

If I use HEAD@ instead of just @ I get the same message with 'HEAD'
in place of '', and everything else I've tried gives a "fatal: bad
revision" message.

Clearly, as shown by git rev-list, the log for the _repository_
goes back farther than May 10, so this is a problem of finding the
correct syntax rather than of wanting to do something "impossible".
What do I need to put in front of the @ to cause the entire log to
be examined?
