From: David Kastrup <dak@gnu.org>
Subject: Re: People unaware of the importance of "git gc"?
Date: Wed, 05 Sep 2007 11:13:31 +0200
Message-ID: <86abs1cw5g.fsf@lola.quinscape.zz>
References: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org> <20070905074206.GA31750@artemis.corp> <46DE6DBC.30704@midwinter.com> <86ps0xcwxo.fsf@lola.quinscape.zz> <46DE71BC.5040008@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 05 11:13:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISqxM-0002y8-CI
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 11:13:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755393AbXIEJNq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 05:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754909AbXIEJNq
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 05:13:46 -0400
Received: from main.gmane.org ([80.91.229.2]:40607 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754796AbXIEJNq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 05:13:46 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1ISqx9-0003Az-Ci
	for git@vger.kernel.org; Wed, 05 Sep 2007 11:13:39 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 05 Sep 2007 11:13:39 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 05 Sep 2007 11:13:39 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:efc1lH4c2OnYqsJSad6o0b7yors=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57698>

Steven Grimm <koreth@midwinter.com> writes:

> David Kastrup wrote:
>> You'll potentially get accumulating unfinished files from
>> aborted/killed repack processes.
>
> Which can get cleaned up when the next repack starts. This is no
> different from unfinished files accumulating from aborted/killed
> manual repacks.
>
>> If communication fails, you'll get a
>> new repack session for every command you start.
>
> Git handles this already:
>
> $ git-gc
> fatal: unable to create '.git/packed-refs.lock': File exists
> error: failed to run pack-refs
>
> Presumably in that case you would simply not fire up a new repack.
>
>>   If a repository is used by multiple people...
>>   
>
> Then the first one will kick off the repack, and subsequent ones won't.

And the first one might get habitually killed by the user unwittingly
having started it (because he really only logs in for shorter amounts
of times than needed for git-gc to finish), wasting disk space and
time all the while.

-- 
David Kastrup
