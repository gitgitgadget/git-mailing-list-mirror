From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH 0/5] fork/exec removal series
Date: Mon, 01 Oct 2007 11:49:39 +0200
Message-ID: <86odfjb1vw.fsf@lola.quinscape.zz>
References: <1191183001-5368-1-git-send-email-johannes.sixt@telecom.at>
	<Pine.LNX.4.64.0709302212160.28395@racer.site>
	<200709302334.37129.johannes.sixt@telecom.at>
	<Pine.LNX.4.64.0709302242100.28395@racer.site>
	<47009CC7.70300@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 01 11:50:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcHuc-0000dD-0W
	for gcvg-git-2@gmane.org; Mon, 01 Oct 2007 11:50:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbXJAJtz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2007 05:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751288AbXJAJty
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Oct 2007 05:49:54 -0400
Received: from main.gmane.org ([80.91.229.2]:58541 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750912AbXJAJty (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2007 05:49:54 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IcHuL-00046Q-NE
	for git@vger.kernel.org; Mon, 01 Oct 2007 09:49:45 +0000
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 01 Oct 2007 09:49:45 +0000
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 01 Oct 2007 09:49:45 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
In-Reply-To: <47009CC7.70300@viscovery.net> (Johannes Sixt's message of "Mon\, 01 Oct 2007 09\:07\:51 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.50 (gnu/linux)
Cancel-Lock: sha1:6ztPGx84bvtBKNDTHugr8c352cg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59592>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Johannes Schindelin schrieb:
>> On Sun, 30 Sep 2007, Johannes Sixt wrote:
>>> These cases I hope to be able to treat as "coroutine":
>>>
>>> - sideband demultiplexer in builtin-fetch-pack.c
>>> - internal rev-list in upload-pack
>>> - the two-way pipe handling in convert.c and builtin-upload-archive.c
>>>
>>> There are probably more in daemon.c and imap-send.c.
>>>
>>> BTW, the convert.c case (apply_filter) is most interesting for me,
>>> since I have a real-world use-case for a clean-filter.
>>
>> Calling it coroutine is interesting... But yes, I agree that these
>> three cases cannot be handled otherwise.
>
> Suggestions for a better name are appreciated!

I think coroutine is commonly used as the name for _synchronous_
context switches aka message passing.  Basically the same as
subroutine calls, except that the called subroutine has its own
dynamic context (instruction pointer, call stack, control flow) that
gets activated and suspended.

If there is parallelism implied, "thread" is the more appropriate
name.

-- 
David Kastrup
