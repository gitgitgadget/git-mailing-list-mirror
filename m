From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Subject: Use "git pull --ff-only" by default?
Date: Fri, 21 May 2010 14:59:07 +0200
Message-ID: <A612847CFE53224C91B23E3A5B48BAC74483234E90@xmail3.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 21 14:59:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFRoq-0000ot-QN
	for gcvg-git-2@lo.gmane.org; Fri, 21 May 2010 14:59:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754002Ab0EUM7L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 May 2010 08:59:11 -0400
Received: from krynn.se.axis.com ([193.13.178.10]:48823 "EHLO
	krynn.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753310Ab0EUM7K convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 May 2010 08:59:10 -0400
Received: from xmail3.se.axis.com (xmail3.se.axis.com [10.0.5.75])
	by krynn.se.axis.com (8.14.3/8.14.3/Debian-5) with ESMTP id o4LCx8Kj008312
	for <git@vger.kernel.org>; Fri, 21 May 2010 14:59:08 +0200
Received: from xmail3.se.axis.com ([10.0.5.75]) by xmail3.se.axis.com
 ([10.0.5.75]) with mapi; Fri, 21 May 2010 14:59:08 +0200
Thread-Topic: Use "git pull --ff-only" by default?
Thread-Index: Acr45WWwGfXWPIJRTtyw4SR5+1WVVw==
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US, sv-SE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147452>

Is there some way to make "git pull --ff-only" be the default?
I could not find anything about this in "git config --help" and
also the lack of a --no-ff-only option for git pull (it exists 
for git merge) indicates that there is no such support.

I did considered the branch.<name>.mergeoptions configuration
option, but it does not seem appropriate as it only applies to
a specific branch, whereas I want it to apply to all branches
by default.

Yes, I know I could do "git config alias.pl 'pull --ff-only'",
but since my intensions are for this to be the default for all
developers in our organization (most of whom have no git knowledge
at all yet) to avoid unnecessary branches caused by the developers 
hacking directly on master rather than a topic branch, I would 
very much prefer a configuration option rather than an alias (as 
I am unlikely to get the developers to remember to do "git pl" 
instead of "git pull").

My idea was to add something like merge.options and pull.options
as configuration options (I want to be able to specify the options
separately for pull and merge). However, I wanted throw this out
here first before starting to hack away at the code, in case I
missed something obvious, or if others find this to be an
incredibly stupid idea...

//Peter
