From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Jabber, question on push,pull and --tags, and no help but jabber
Date: Mon, 06 Jun 2011 10:58:24 -0700
Message-ID: <7v1uz6alkv.fsf@alter.siamese.dyndns.org>
References: <20110606130205.GA41674@sherwood.local>
 <9215090.63086.1307370716794.JavaMail.trustmail@mail1.terreactive.ch>
 <20110606153405.GA15894@victor.terreactive.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Steffen Daode Nurpmeso <sdaoden@googlemail.com>,
	git@vger.kernel.org
To: Victor Engmark <victor.engmark@terreactive.ch>
X-From: git-owner@vger.kernel.org Mon Jun 06 19:58:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTe4Z-00007J-ST
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 19:58:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754441Ab1FFR6j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2011 13:58:39 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60235 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751607Ab1FFR6i (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2011 13:58:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8BC4B476E;
	Mon,  6 Jun 2011 14:00:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yu2V7ptkDInrIJ53ocVMklzRK6I=; b=B8fUqw
	J4GlyN99TKvRPlOnpRKKHLkUgCCFy0CEj3vb5STP+maOdvABxjvuf/KwQzyn5L+1
	F7Fx9tsXhvWsuJKe0QIJgg/jxMBzdbC5zdO7sLZHMTdUaz5x/u1k774m3ijOGUYo
	Q+iOglVsyMhC9eflIt3fUn2ZbKDXgexU3MH0g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QLmWEBoD0iaBXwRk9iDo/M2z+6EqjePh
	ydo9DEbOcFbtx9qg867eOpFVzRbgIZuSVqG4FpQJRfiVS+tA9brmlz/kGhP4fIeh
	smRXzT0nzHOcub3F00CsuJoDSznhkAi8j+/V7lZ1D9jDGX9GAEkaa5bRJf+GUm1b
	q7zG+bcOQ5w=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 45A29476C;
	Mon,  6 Jun 2011 14:00:42 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E50D9476A; Mon,  6 Jun 2011
 14:00:36 -0400 (EDT)
In-Reply-To: <20110606153405.GA15894@victor.terreactive.ch> (Victor Engmark's
 message of "Mon, 6 Jun 2011 17:34:05 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E4DF4B94-9066-11E0-B1D5-EA23C7C1A288-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175143>

Victor Engmark <victor.engmark@terreactive.ch> writes:

>> More seriously, tags are not part of the "remotes layout", so when you
>> push them and others pull them they overwrite their tags if there's a
>> name clash.
>
> That's odd - I wouldn't expect anything handled by Git to be simply
> overwritten without merging. Is there some technical reason for this, or
> is it just not implemented yet?

Branches are something you work on by looking at other people's progress,
so remote layout to copy his master branch to refs/remotes/his/master so
that you can compare it with yours with "git diff his/master master" or
merge his effort into yours with "git merge his/master" makes sense.

Tags are something that is to be _shared_ amongst people, and having v1.4.3
that is different depending on which member of the same project you ask is
a road to insanity, hence we don't do refs/remotes/his/v1.4.3 that could
be different from the project's global refs/tags/v1.4.3 to reduce the risk
of confusion.
