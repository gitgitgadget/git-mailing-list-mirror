From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Storing additional information in commit headers
Date: Tue, 02 Aug 2011 15:53:12 +0200
Message-ID: <4E380148.7010701@alum.mit.edu>
References: <20110801182015.GA3100@fishbowl.rw.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git discussion list <git@vger.kernel.org>,
	Petr Baudis <pasky@ucw.cz>, Clemens Buchacher <drizzd@aon.at>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Tue Aug 02 15:53:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoFPS-0004Sc-QA
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 15:53:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754064Ab1HBNxX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Aug 2011 09:53:23 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:59481 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752096Ab1HBNxV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2011 09:53:21 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p72DrChW032048
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 2 Aug 2011 15:53:12 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.18) Gecko/20110617 Lightning/1.0b2 Thunderbird/3.1.11
In-Reply-To: <20110801182015.GA3100@fishbowl.rw.madduck.net>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178469>

On 08/01/2011 08:20 PM, martin f krafft wrote:
> Are there any strong reasons against my use of commit headers for
> specific, well-defined purposes in contained use-cases? E.g. are
> there tools known to only copy "known" headers, which could
> potentially break my assumptions?

Before you store important information in a git-internal data structure,
please consider:

* Some of your developers might prefer using another DVCS (e.g.,
Mercurial via hg-git) and they will not be able to see the information
at all

* Some day the main project might want to (god forbid!) switch to a
successor to git, and your extra information might be difficult to migrate.

* Somebody might want to work with your project from a tarball rather
than having to install and use git.

Therefore, I recommend a strong bias towards storing information in as
transparent, non-system-specific a way as possible.  Metadata and
scripts stored within the file tree part of the repository are typically
a lot easier to work with and more transparent than git-specific hacks.

That being said, I haven't understood your application well enough to
know whether these biases might be trumped by convenience in your
particular situation.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
