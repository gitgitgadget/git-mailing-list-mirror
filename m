From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Show modified files in git-ls-files
Date: Fri, 02 Sep 2005 02:28:54 -0700
Message-ID: <7v3bonkecp.fsf@assigned-by-dhcp.cox.net>
References: <43179E59.80106@didntduck.org> <tnxzmqvalie.fsf@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gerst <bgerst@didntduck.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 02 11:29:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EB7r1-00050p-TM
	for gcvg-git@gmane.org; Fri, 02 Sep 2005 11:29:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbVIBJ25 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Sep 2005 05:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750856AbVIBJ25
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Sep 2005 05:28:57 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:41658 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1750757AbVIBJ24 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Sep 2005 05:28:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050902092855.FXYJ6784.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 2 Sep 2005 05:28:55 -0400
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <tnxzmqvalie.fsf@arm.com> (Catalin Marinas's message of "Fri, 02
	Sep 2005 10:04:25 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8013>

Catalin Marinas <catalin.marinas@gmail.com> writes:

> Brian Gerst <bgerst@didntduck.org> wrote:
>> Add -m/--modified to show files that have been modified wrt. the index.
>>
>> M was already taken so the tag for modifified files is C (changed).
>
> I think git-ls-files should be consistent with git-diff-cache where M
> means modified and U unmerged (but for the former, M is unmerged).
>
> StGIT currently uses C to report a merge conflict but I will probably
> change this since it means copied in git-diff-cache.

I think that is an excellent suggestion.  It looks to me that
the tag feature in ls-files needs serious renaming.

 * an option is called --deleted and the variable to control the
   output is show_deleted; the tag variable and string is
   removed and "R".  Probably the tag should be renamed to "D".

 * before "modified", tag_cached was OK, but probably "known to
   git" would have been a better name.  I'd vote for just a
   single space " " as the tag letter; if we want to use printing
   character, then a single dot ".".  Most of the things are
   "known to git" anyway so these are visually less
   distracting.

 * unmerged should be "U" as you say.
