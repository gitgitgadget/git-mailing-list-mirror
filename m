From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Idea for git-fast-import
Date: Sun, 22 Jul 2007 20:35:57 +0200
Message-ID: <46A3A38D.5020601@alum.mit.edu>
References: <46A05D4B.1050208@alum.mit.edu> <20070720072824.GP32566@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Jul 22 20:36:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICgHq-0001cW-Ux
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 20:36:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759351AbXGVSgH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 14:36:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759246AbXGVSgG
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 14:36:06 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:36352 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759064AbXGVSgF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 14:36:05 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.135] (kaiserty.in-dsl.de [217.197.85.174])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id l6MIZvLf022879
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 22 Jul 2007 20:35:58 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.12) Gecko/20070604 Thunderbird/1.5.0.12 Mnenhy/0.7.5.666
In-Reply-To: <20070720072824.GP32566@spearce.org>
X-Enigmail-Version: 0.94.0.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53287>

Shawn O. Pearce wrote:
> Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> Also, is there a big cost to using "not-quite-consecutive" integers as
>> marks?  cvs2svn's CVSRevision IDs are intermingled with IDs for
>> CVSBranches and CVSTags, so the CVSRevisions alone probably only pack
>> the ID space 5%-50% full.
> 
>> In fact, if there is a big cost to "not-quite-consecutive" integers,
>> then I withdraw my request for separate mark namespaces, since I would
>> have to reallocate mark numbers anyway :-)
> 
> See above.  5% full is really bad, because you are probably going to
> allocate nearly every block in the directory, and only fill each leaf
> block at 5% full.  50% full is actually reasonable, as it means marks
> are only costing you about 2 pointers on average (8 or 16 bytes).

OK, then, never mind.  As I mentioned, it is not a big deal to have
cvs2svn generate a separate integer series for marks.  If comments are
implemented, then the debugging disadvantage is also quite minor.

>> Another thing that might help with debugging would be a "comment"
>> command, which git-fast-import should ignore.  One could put text about
>> the source of a chunk of git-fast-import stream to relate it back to the
>> front-end concepts when debugging the stream contents by hand.
> 
> This is an awesome idea, especially when combined with having a
> buffer of the last few commands that fast-import saw right before
> it crashed.  I'll see what I can do.

Thanks!

Michael
