From: perryh@pluto.rain.com (Perry Hutchison)
Subject: previewing "git pull"
Date: Fri, 25 Oct 2013 20:23:10 -0700
Message-ID: <526b359e.dmR4kAHrnCsJVbAm%perryh@pluto.rain.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 26 05:25:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZuVK-0008Ps-8T
	for gcvg-git-2@plane.gmane.org; Sat, 26 Oct 2013 05:25:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754253Ab3JZDZM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Oct 2013 23:25:12 -0400
Received: from agora.rdrop.com ([199.26.172.34]:4557 "EHLO agora.rdrop.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754186Ab3JZDZL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Oct 2013 23:25:11 -0400
Received: from agora.rdrop.com (66@localhost [127.0.0.1])
	by agora.rdrop.com (8.13.1/8.12.7) with ESMTP id r9Q3P8cr035342
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Fri, 25 Oct 2013 20:25:10 -0700 (PDT)
	(envelope-from perryh@pluto.rain.com)
Received: (from uucp@localhost)
	by agora.rdrop.com (8.13.1/8.14.2/Submit) with UUCP id r9Q3P87Z035341
	for git@vger.kernel.org; Fri, 25 Oct 2013 20:25:08 -0700 (PDT)
	(envelope-from perryh@pluto.rain.com)
Received: from fbsd81 by pluto.rain.com (4.1/SMI-4.1-pluto-M2060407)
	id AA04531; Fri, 25 Oct 13 20:21:32 PDT
User-Agent: nail 11.25 7/29/05
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236732>

In git 1.7.0.4, what's the correct way to preview what a "git pull"
would do, without actually doing it?  Unlike most git subcommands,
pull seems not to understand --dry-run:

$ git pull --dry-run
sed: can't read {pathname suppressed}/.git/FETCH_HEAD: No such file or directory
You asked to pull from the remote '--dry-run', but did not specify
a branch. Because this is not the default configured remote
for your current branch, you must specify a branch on the command line.

Trying the "fetch" part of pull by itself, at least fetch doesn't
mistake --dry-run for a remote name, but it doesn't seem to
implement it either -- instead of a report of what it would do,
there's no output at all:

$ git fetch --dry-run
$

I'm guessing that I may need to actually do the fetch in order
for git to know what the remote has, but then how would I find
out exactly what merge command "pull" would have issued (so as
to try adding --dry-run to it)?
