From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: git-cvsimport bug with dates
Date: Sat, 17 Nov 2007 11:12:22 +0100
Message-ID: <200711171112.23150.robin.rosenberg.lists@dewire.com>
References: <51419b2c0711152059q55ced86gd224310c8c4a1851@mail.gmail.com> <7vr6iq207f.fsf@gitster.siamese.dyndns.org> <51419b2c0711160612r1a80bd5o686040f945e8d9c3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Elijah Newren" <newren@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 17 11:10:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItKdI-0004Gt-Kw
	for gcvg-git-2@gmane.org; Sat, 17 Nov 2007 11:10:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752340AbXKQKKQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2007 05:10:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752309AbXKQKKP
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Nov 2007 05:10:15 -0500
Received: from [83.140.172.130] ([83.140.172.130]:9930 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1750835AbXKQKKN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2007 05:10:13 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id CE7438030C5;
	Sat, 17 Nov 2007 11:01:03 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 22868-08; Sat, 17 Nov 2007 11:01:03 +0100 (CET)
Received: from [10.9.0.5] (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id 7C24B802670;
	Sat, 17 Nov 2007 11:01:03 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <51419b2c0711160612r1a80bd5o686040f945e8d9c3@mail.gmail.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65266>

fredag 16 november 2007 skrev Elijah Newren:
> On Nov 15, 2007 11:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > When you use "branch@{date}" notation, you are not asking a
> > question on the project history, but a question on the local
> > view from _your_ repository on that project.
> 
> Interesting; that makes sense from a merge or pull viewpoint, but
> wouldn't it make more sense to have cvsimport ensure the commits are
> treated as though they actually existed in master as of the date
> specified in CVS?

Reflog do not work that way. They don't say when a commit entered a repo,
only when a ref changed. For a CVS import things could work as you suggest
but I think the confusion among newcomers would be massive if people start
using reflogs  'as if' it said anyting about when a commit entered. It can be used
as a hint.

Reflogs get pruned by git-gc and are not cloned (cannot be since they store
local-only information.

Use the --since and --until switches instead.

-- robin
