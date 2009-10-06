From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] Add the --submodule-summary option to the diff option
 family
Date: Tue, 06 Oct 2009 12:58:49 +0200
Message-ID: <4ACB22E9.3010001@web.de>
References: <cover.1254668669u.git.johannes.schindelin@gmx.de> <67a884457aeaead275612be10902a80726b2a7db.1254668669u.git.johannes.schindelin@gmx.de> <7vbpkmn6oi.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0910051027010.4985@pacific.mpi-cbg.de> <7vr5thacb4.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0910052251190.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 06 13:01:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mv7nO-0007Wg-2n
	for gcvg-git-2@lo.gmane.org; Tue, 06 Oct 2009 13:01:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbZJFK71 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Oct 2009 06:59:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932099AbZJFK71
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Oct 2009 06:59:27 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:41910 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932098AbZJFK71 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Oct 2009 06:59:27 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate01.web.de (Postfix) with ESMTP id C5D54125822A4;
	Tue,  6 Oct 2009 12:58:49 +0200 (CEST)
Received: from [80.128.52.8] (helo=[192.168.178.26])
	by smtp07.web.de with asmtp (WEB.DE 4.110 #314)
	id 1Mv7kn-0007Wq-00; Tue, 06 Oct 2009 12:58:49 +0200
User-Agent: Thunderbird 2.0.0.23 (X11/20090812)
In-Reply-To: <alpine.DEB.1.00.0910052251190.4985@pacific.mpi-cbg.de>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+R5E4uWill/dGDHzGBh7oQcSsgLv/3KVH55mtD
	fJKXQzshkQ6X0TLZEWL+ptip7m/9MRLPQBH+pkGw/dBYOyYZpu
	aRm9WTiz87A9AkDHGOAw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129621>

Johannes Schindelin schrieb:
>>> I have no idea why "submodule --summary" uses --first-parent, but 
>>> personally, I would _hate_ it not to see the merged commits in the 
>>> diff.
>>>
>>> For a summary, you might get away with seeing
>>>
>>> 	> Merge bla
>>> 	> Merge blub
>>> 	> Merge this
>>> 	> Merge that
>>>
>>> but in a diff that does not cut it at all.
>> As long as bla/blub/this/that are descriptive enough, I do not see at all
>> why you think "summary" is Ok and "diff" is not.  If your response were
>> "it is just a matter of taste; to some people (or project) --first-parent
>> is useful and for others it is not", I would understand it, and it would
>> make sense to use (or not use) --first-parent consistently between this
>> codepath and "submodule --summary", though.
> 
> You may be used to git.git's quality of naming the branches you merge.
> 
> Sadly, this is not the common case.

IMHO both arguments are valid, using --first-parent really is a matter of
taste *and* it is dependent on the quality of branch naming whether it is
useful or not.

But when both commands shall produce the same output, i think we have to
use --first-parent as default, no? And maybe we could add another option
to diff which can change that behaviour according to users taste?


> But I really, really, really want to avoid a fork() in the common case.  I 
> do have some users on Windows, and I do have a few submodules in that 
> project.  Having too many fork() calls there would just give Git a bad 
> reputation.  And it has enough of that, it does not need more.

Me too thinks performance matters here. We do have a repo at my dayjob
with more than a handful of submodules and its main target platform is
windows ... so having that perform nicely is a win for us.


Jens
