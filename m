From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Apr 2014, #09; Tue, 29)
Date: Wed, 07 May 2014 11:56:18 -0700
Message-ID: <xmqqvbtha04t.fsf@gitster.dls.corp.google.com>
References: <xmqq7g67iwxc.fsf@gitster.dls.corp.google.com>
	<20140505184546.GB23935@serenity.lan>
	<xmqqd2fqcv7s.fsf@gitster.dls.corp.google.com>
	<20140507080558.GH23935@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed May 07 20:56:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi718-0000y2-KG
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 20:56:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbaEGS4Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 14:56:24 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55124 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751115AbaEGS4X (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 14:56:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 192FA16C06;
	Wed,  7 May 2014 14:56:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jwS0X+hp7LpsblSDH3atpBSN5uY=; b=uJt/c7
	7Zzk67kTPMfma2z8g9Fx417Z6aEDRLWfL7dtaq9dHl3BWuNyRNfFTxRWECTQxzWM
	PN/6zOH8YemBcKM1ahJSz8b6S+aTydMlVUin1jbBmL1sM2sgGPbMq1Dx6uC9CBSl
	EEORZ5XLeo3PwRygWDnHyUpFSetU1y7Jx+hQY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wwXn4uz9fBxK8iqmXz+KIJ/vlXCqY/cJ
	dg4pLRmYp4iASiV6IW36OUvU+e0y5ImcdornRxemnqCBaXUCX8F2QcKxx2Ukq95u
	62nchOdoMzXg6ILYyp41M45xb2c8hk99eVvqD6QP6rsQlZ+GiCLuBkVc4sPILAys
	2PulFSDp4P8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0F55816C05;
	Wed,  7 May 2014 14:56:23 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 090BF16C01;
	Wed,  7 May 2014 14:56:19 -0400 (EDT)
In-Reply-To: <20140507080558.GH23935@serenity.lan> (John Keeping's message of
	"Wed, 7 May 2014 09:05:58 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 46BC2652-D619-11E3-A98F-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248346>

John Keeping <john@keeping.me.uk> writes:

> On Tue, May 06, 2014 at 05:01:59PM -0700, Junio C Hamano wrote:
> ...
>> Another thing to keep in mind is that we need to ensure that we give
>> a good way for these third-party tools to integrate well with the
>> core Git tools to form a single toolchest for the users.  I would
>> love to be able to do
>> 
>>     $ (cd git.git && make install)
>>     $ (cd git-imerge.git && make install)
>> 
>> and then say "git imerge", "git --help imerge", etc.  The same for
>> the remote helpers that we may be splitting out of my tree into
>> their own stand-alone projects.
>
> This can already work given suitable installation.  With
> git-integration[1] I can type `git help integration` and it shows me the
> man page in the same way that `git help commit` does.  When I manually
> linked the HTML file to the right place `git help -w integration` worked
> as well.

That "when I manually" part is what I meant by "we give a good way
for these third-party tools" above, and "make it really easy to
install these third-party tools" in the remaining part of the
message you are responding to.

> I think this is enough...

Thanks.

The reason why I CC'ed Michael was primarily because I thought you
were not one of those third-party tools maintainers (and secondarily
I am a fairly big fan of imerge), but it is good to hear your
opinion as another third-party provider.  Your git-integrate might
turn into something I could augment my workflow with with some
additions.  What is missing (I only read the full manual page at
http://johnkeeping.github.io/git-integration/git-integration.html)
to support my workflow seems to be:

 - specifying a merge strategy per branch being merged;
 - support evil merges or picking a fix-up commit;
 - leaving an empty commit only to leave comment in the history.

and until that happens, I'll keep using the Reintegrate script found
in my 'todo' branch.
