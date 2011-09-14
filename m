From: Sam Vilain <sam@vilain.net>
Subject: Re: Fwd: [Survey] Signed push
Date: Wed, 14 Sep 2011 13:52:48 -0700
Message-ID: <4E711420.9080409@vilain.net>
References: <7vaaa8xufi.fsf@alter.siamese.dyndns.org> <CA+55aFxAQTR3sT7gekAD4qih8J+z-qwri7ZmNCPUd811xgci6w@mail.gmail.com> <CA+55aFy0b+eozmzbKD4RXcJ7e3WCpf7BV1n1qXHOeEwSHZKOXw@mail.gmail.com> <7vobynui8a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 14 22:52:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3wS1-0004S3-B2
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 22:52:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933304Ab1INUww (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Sep 2011 16:52:52 -0400
Received: from uk.vilain.net ([92.48.122.123]:38499 "EHLO uk.vilain.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933235Ab1INUww (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2011 16:52:52 -0400
Received: by uk.vilain.net (Postfix, from userid 1001)
	id 723A5824D; Wed, 14 Sep 2011 21:52:51 +0100 (BST)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on uk.vilain.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
	WEIRD_PORT autolearn=unavailable version=3.3.1
Received: from [192.168.112.205] (unknown [64.125.143.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by uk.vilain.net (Postfix) with ESMTPSA id D25F38176;
	Wed, 14 Sep 2011 21:52:49 +0100 (BST)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:6.0.2) Gecko/20110902 Thunderbird/6.0.2
In-Reply-To: <7vobynui8a.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181399>

[re-send as text-only.  sorry, new system]

On 9/14/11 10:49 AM, Junio C Hamano wrote:
>> The extra line in the pull request is cheap - it's not like we need to
>> >  ration them. The above format, in contrast, requires that the person
>> >  doing the*pull*  have a recent enough git client, otherwise the merge
>> >  commit message will be just horrible.
> In a re-roll patch I've added ";# branch-name" at the end of that line for
> people with older git, but existing git wouldn't allow you to fetch anything
> but refs so you won't risk getting "just horrible" merge message;-)
>

If the system is watertight enough, then you could have verified pushes 
ONLY under some new refspace, like:

refs/forks/forkid/branch

"forkid" is set up when you choose to "follow" someone's pushes.  ie, 
you say something like:

git fork follow linustorvalds@osdl.org 
<http://pgp.mit.edu:11371/pks/lookup?op=vindex&search=0x17762C4676E21CBB>

"torvalds@osdl.org" here representing a PGP key ID search string.  It 
could be instead, "0x17762c4676e21cbb"

And then the "refs/forks/linus/xxx" space gets populated as signed 
pushes are seen on the network (perhaps when fetching from a pull 
request, or perhaps via a service).  A configuration option can be set 
to warn if you are not merging a signed branch.  If the new "pull 
request/push" object is a distinct object type or tag object, then it 
could be the destination of the 'refs/forks/...' ref, and the branch 
desription and hence the default merge message be retrieved from that.

Sam
