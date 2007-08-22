From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] git-svn: update documentation with CAVEATS section
Date: Thu, 23 Aug 2007 00:51:47 +0200
Message-ID: <853aybkwsc.fsf@lola.goethe.zz>
References: <20070816085645.GA3159@soma>
	<7v4piri44r.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 23 00:53:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INz4O-0007yQ-Fq
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 00:53:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764765AbXHVWwW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 18:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756351AbXHVWwU
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 18:52:20 -0400
Received: from mail-in-10.arcor-online.net ([151.189.21.50]:52041 "EHLO
	mail-in-10.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1764745AbXHVWwC (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Aug 2007 18:52:02 -0400
Received: from mail-in-07-z2.arcor-online.net (mail-in-07-z2.arcor-online.net [151.189.8.19])
	by mail-in-10.arcor-online.net (Postfix) with ESMTP id 385971F5990;
	Thu, 23 Aug 2007 00:52:00 +0200 (CEST)
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net [151.189.21.47])
	by mail-in-07-z2.arcor-online.net (Postfix) with ESMTP id 26A7C2C6A03;
	Thu, 23 Aug 2007 00:52:00 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-060-116.pools.arcor-ip.net [84.61.60.116])
	by mail-in-07.arcor-online.net (Postfix) with ESMTP id AC0332C29E2;
	Thu, 23 Aug 2007 00:51:47 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 2164A1C36605; Thu, 23 Aug 2007 00:51:47 +0200 (CEST)
In-Reply-To: <7v4piri44r.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Wed\, 22 Aug 2007 15\:41\:24 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/4032/Wed Aug 22 22:15:27 2007 on mail-in-07.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56433>

Junio C Hamano <gitster@pobox.com> writes:

> Eric Wong <normalperson@yhbt.net> writes:
>
>>   I've been meaning to do this for a while, hopefully this cuts
>>   down on the redundant mailing list traffic about these subjects.
>> ...
>> +CAVEATS
>> +-------
>> +
>> +For the sake of simplicity and interoperating with a less-capable system
>> +(SVN), it is recommended that all git-svn users clone, fetch and dcommit
>> +directly from the SVN server, and avoid all git-clone/pull/merge/push
>> +operations between git repositories and branches.  The recommended
>> +method of exchanging code between git branches and users is
>> +git-format-patch and git-am, or just dcommiting to the SVN repository.
>> +
>> +Running 'git-merge' or 'git-pull' is NOT recommended on a branch you
>> +plan to dcommit from.  Subversion does not represent merges in any
>> +reasonable or useful fashion; so users using Subversion cannot see any
>> +merges you've made.
>
> Ok, my ruling before 1.5.3 is to take this patch, and encourage
> interested parties to help Eric adding reliable support for the
> feature after that, if such is possible.

Couldn't we at least get a _documentation_ of the current behavior
when actually using git for branch work?  Knowing what will fail how
and when is not as good as things just working as one would expect,
but it certainly beats obscure warnings.

For example, I consider it rather unacceptable that nowhere is
documented just _how_ git-svn chooses one Subversion branch to commit
to.

It also drastically misrepresents the consequences: the problem is
_not_ that users using Subversion cannot see merges.  That is
something that one can readily accept.  The problem is that git-svn
will dcommit to a seemingly random branch.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
