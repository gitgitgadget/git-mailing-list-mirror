From: David Kastrup <dak@gnu.org>
Subject: Re: [ANNOUNCE] GIT 1.5.3
Date: Mon, 03 Sep 2007 15:17:29 +0200
Message-ID: <86wsv7hora.fsf@lola.quinscape.zz>
References: <7vodglr32i.fsf@gitster.siamese.dyndns.org>
	<46DA5F33.2020005@zytor.com> <85odgltrtj.fsf@lola.goethe.zz>
	<46DA88EF.7080103@zytor.com>
	<20070902133803.1b46f599.seanlkml@sympatico.ca>
	<7v4picpvgq.fsf@gitster.siamese.dyndns.org> <46DBF0BB.3070605@op5.se>
	<868x7nj482.fsf@lola.quinscape.zz> <46DC05F8.7000709@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 03 15:17:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISBoT-0005nE-9E
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 15:17:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752669AbXICNRw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Sep 2007 09:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752596AbXICNRv
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 09:17:51 -0400
Received: from main.gmane.org ([80.91.229.2]:42406 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752462AbXICNRv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2007 09:17:51 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1ISBoD-0001Lq-1A
	for git@vger.kernel.org; Mon, 03 Sep 2007 15:17:41 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 03 Sep 2007 15:17:41 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 03 Sep 2007 15:17:41 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:jkRwB0/wiAPS7aBUuCRS+yc32rM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57483>

Andreas Ericsson <ae@op5.se> writes:

> David Kastrup wrote:
>> Andreas Ericsson <ae@op5.se> writes:
>>
>>> Junio C Hamano wrote:
>>>> Assuming that we do not give the old git-p4import script
>>>> packaged in "git-p4 package", would the following patch be all
>>>> that is needed, or do we need other things in the spec file?
>>>>
>>>> -- snipsnap clipcrap --
>>>> +Obsoletes:	git-p4
>>> That depends. If packages outside of git requires the git-p4 package
>>> to function then this will not suffice and a line saying
>>>
>>> 	Provides: git-p4
>>>
>>> would have to be added instead.
>>
>> Not instead, but in addition IIRC (it obsoletes the package and
>> provides the feature).  But that would be nonsensical if the outside
>> package indeed requires git-p4 and we don't have it in our current
>> RPM: the purpose of dependencies is to not have things break silently,
>> and lying about what we provide would be wrong.
>
> No, it really is instead. A package obsoleting one of the features
> it provides itself would be insane.

Not according to my understanding: "Obsoletes:" concerns _packages_,
while "Provides:" concerns features.  So it is perfectly feasible to
obsolete a previously separate package and provide its functionality.

And indeed, our "emacs-auctex" package _both_ obsoletes _and_ provides
"auctex".  And it is not like we did not learn this the hard way...

-- 
David Kastrup
