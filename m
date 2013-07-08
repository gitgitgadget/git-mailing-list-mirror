From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 0/3] merge -Xindex-only
Date: Mon, 08 Jul 2013 17:21:22 +0200
Message-ID: <51DAD8F2.5070008@alum.mit.edu>
References: <cover.1373219466.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git discussion list <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jul 08 17:21:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwDGB-0005Sb-D7
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 17:21:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752609Ab3GHPV1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jul 2013 11:21:27 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:50153 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752541Ab3GHPVZ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Jul 2013 11:21:25 -0400
X-AuditID: 12074411-b7f296d000001209-30-51dad8f4fd65
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 1E.4B.04617.4F8DAD15; Mon,  8 Jul 2013 11:21:24 -0400 (EDT)
Received: from [192.168.101.152] (mx.berlin.jpk.com [212.222.128.135] (may be forged))
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r68FLMoa022918
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 8 Jul 2013 11:21:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <cover.1373219466.git.trast@inf.ethz.ch>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsUixO6iqPvlxq1Ag51rNC26rnQzWdy9vIrd
	gcnj9uv5zB6fN8kFMEVx2yQllpQFZ6bn6dslcGecn3OYreAIX8WCVxdYGxjPcncxcnJICJhI
	9M9Zxg5hi0lcuLeerYuRi0NI4DKjxNNDK1ghnKtMEpNXX2YEqeIV0Ja4/XwiE4jNIqAqseRn
	KyuIzSagK7GopxkozsEhKhAmceW3KkS5oMTJmU9YQMIiAsoS2xbWgJjMQNUP3ySCmMJAA690
	W4IUCwFdM2vKXDYQm1PAVOL7kz9glzEL6Ei863vADGHLS2x/O4d5AqPALCTzZyEpm4WkbAEj
	8ypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXVO93MwSvdSU0k2MkBAV3ME446TcIUYBDkYlHt6Z
	F28FCrEmlhVX5h5ilORgUhLlFbwGFOJLyk+pzEgszogvKs1JLT7EKMHBrCTCu+kYUI43JbGy
	KrUoHyYlzcGiJM7Lt0TdT0ggPbEkNTs1tSC1CCYrw8GhJMH77zpQo2BRanpqRVpmTglCmomD
	E2Q4l5RIcWpeSmpRYmlJRjwoRuOLgVEKkuIB2st5A2RvcUFiLlAUovUUoy7HgR9b3jMKseTl
	56VKifN+B9khAFKUUZoHtwKWkF4xigN9LMz7GaSKB5jM4Ca9AlrCBLSkIQ1sSUkiQkqqgTFM
	58yVfR7CjcW2p65V757Odz1dgvdiofiETV5zdZYVzfpZMf/1nOSwC+ZpmVePfEtguT9N6d+p
	OxEP7wpezZWyXvO04L/l25fPVu9XL0xf0vv3x9k/qwPf6AvkpjFF++/fZ3iDL/Nc 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229867>

[Resend because of address confusion in replied-to email.]

On 07/07/2013 08:00 PM, Thomas Rast wrote:
> I recently looked into making merge-recursive more useful as a modular
> piece in various tasks, e.g. Michael's git-imerge and the experiments
> I made in showing evil merges.
> 
> This miniseries is the extremely low-hanging fruit.  If it makes a
> good first step for git-imerge, perhaps it can go in like this.  It's
> not a big speedup (about 2.2s vs 2.4s in a sample conflicting merge in
> git.git), but it does feel much cleaner to avoid touching the worktree
> unless actually necessary.
> 
> Otherwise it's probably not worth it just yet; for what I want to do
> with it, we need some more reshuffling of things.

Interesting.

For git-imerge, it would be nice to speed up merges by skipping the
working tree updates.  10% might not be so noticeable, but every little
bit helps :-)

But the killer benefit would be if git-imerge could do some of its
automatic merge-testing and autofilling in the background while the user
is resolving conflicts in the main index and working tree.

Is it possible to use this option with an alternate index file (e.g.,
via the GIT_INDEX_FILE environment variable)?  Can it be made to leave
other shared state (e.g., MERGE_HEAD) alone?  If so, maybe it's already
there.

For this feature to be useful for test merges, it would be enough to
just get a retcode saying whether a given merge would succeed or conflict.

For it to be used for autofilling, it would also be necessary to be able
to create a commit from the merge result in the alternate index (this
would only be done when there are no conflicts).  I assume this part can
be done in the usual way using "git commit-tree".

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
