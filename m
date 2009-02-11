From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git push failure in the case of SSH to localhost
Date: Wed, 11 Feb 2009 12:23:12 -0800
Message-ID: <7vvdrgd8pb.fsf@gitster.siamese.dyndns.org>
References: <8e04b5820902110824u1ab99cc1r4df6349b20d62f84@mail.gmail.com>
 <20090211180559.GC19749@coredump.intra.peff.net>
 <8e04b5820902111042q138a2e79vc97c533007482e5c@mail.gmail.com>
 <20090211184429.GA27896@coredump.intra.peff.net>
 <8e04b5820902111103n69cde3e1le5781fb1818b622c@mail.gmail.com>
 <20090211191445.GU30949@spearce.org>
 <8e04b5820902111120w4cb87b41sfca647a838bab43c@mail.gmail.com>
 <20090211192245.GA28832@coredump.intra.peff.net>
 <8e04b5820902111132v5b7c8e14s15c6fad13b5b76a9@mail.gmail.com>
 <20090211194218.GA28927@coredump.intra.peff.net>
 <8e04b5820902111203t344881f6g31f25cfbff5fd822@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, "Shawn O. Pearce" <spearce@spearce.org>,
	git@vger.kernel.org
To: "Ciprian Dorin, Craciun" <ciprian.craciun@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 21:25:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXLdi-0004PR-TK
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 21:24:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756106AbZBKUXb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 15:23:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755509AbZBKUXb
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 15:23:31 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63447 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752831AbZBKUXa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 15:23:30 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 068A298BC4;
	Wed, 11 Feb 2009 15:23:29 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 73B2D98BC3; Wed,
 11 Feb 2009 15:23:22 -0500 (EST)
In-Reply-To: <8e04b5820902111203t344881f6g31f25cfbff5fd822@mail.gmail.com>
 (Ciprian Dorin's message of "Wed, 11 Feb 2009 22:03:13 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D80658EA-F879-11DD-BF94-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109522>

"Ciprian Dorin, Craciun" <ciprian.craciun@gmail.com> writes:

>     I'll merge both Junio's and Jeff's emails into one... My answers bellow.
>
> On Wed, Feb 11, 2009 at 9:40 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> "Ciprian Dorin, Craciun" <ciprian.craciun@gmail.com> writes:
>>
>>> On Wed, Feb 11, 2009 at 9:27 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>
>>>> And why isn't it in $HOME/bin/?
>>>
>>>     No, it is inside .git/bin folder.
>>
>> You are not answering my question.
>>
>> I questioned the sanity of putting the scripts in .git/bin/ per
>> repository.  Why shouldn't a useful script like your "branch-import"
>> available to _all_ your repositories, possibly taking customization per
>> repository from repository's .git/config file, so that it does what is
>> appropriate in each repository?
> ...
>     Both these solutions work fine, except one concern: when moving
> the repository I would also want to move my scripts,...

Define "moving the repository".  More often than not, people move their
repositories with "git clone" than "tar cf - | tar xf -".

No matter how you are moving it to a new location, you would want to have
a working set of "regular environment" you normally work in.  Why aren't
you moving/copying your $HOME/bin at the same time to get a more familiar
and useful environment?  Viewed under this light, I think your "I move my
repository to a new machine" is a made up example that is not interesting
at all, if you ask me.

There are additional security implications.  You can invite a victim to
run "git diff" in your repository which runs your .git/bin/git-diff, for
example.
