From: david@lang.hm
Subject: Re: Not going beyond symbolic links
Date: Mon, 4 Aug 2008 20:04:31 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0808042003200.29250@asgard.lang.hm>
References: <20080721002354.GK10151@machine.or.cz> <20080721002508.26773.92277.stgit@localhost> <7v8wvpm9cl.fsf@gitster.siamese.dyndns.org> <7vej5543v5.fsf_-_@gitster.siamese.dyndns.org> <alpine.LFD.1.10.0808041719380.3299@nehalem.linux-foundation.org>
 <7v8wvc2seh.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.10.0808041839130.3299@nehalem.linux-foundation.org> <7v3alk17yh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 05 05:06:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQCrz-0001Xx-II
	for gcvg-git-2@gmane.org; Tue, 05 Aug 2008 05:05:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763179AbYHEDEd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 23:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763022AbYHEDE3
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 23:04:29 -0400
Received: from mail.lang.hm ([64.81.33.126]:53041 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762975AbYHEDE0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 23:04:26 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id m7533dDw005948;
	Mon, 4 Aug 2008 20:03:39 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <7v3alk17yh.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91417>

On Mon, 4 Aug 2008, Junio C Hamano wrote:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>> ... Because this is definitely not a black-and-white "one behavior is
>> wrong and one behavior is right".
>
> I wish I could agree with you that this is a feature, but 16a4c61
> (read-tree -m -u: avoid getting confused by intermediate symlinks.,
> 2007-05-10) and 64cab59 (apply: do not get confused by symlinks in the
> middle, 2007-05-11) came from real world breakage cases and the root cause
> was that we were too lenient to allow such a "feature" that pretends the
> symlink not to be there.
>
> Right now, we are being careful only while branch switching and patch
> application, but the codepaths that add directly to the index (add and
> update-index) are not fixed (or "still has the feature").
>
> I do not see a clean way to keep such a "feature" without hurting users
> who suffered the bugs these two commits from May 2007 fixed.

config option?

I think a command line is too much work for too little value, but if the 
check could be ignored based on a config option without costing too much 
it may be reasonable.

David Lang
