From: David Kastrup <dak@gnu.org>
Subject: Re: Output from "git blame A..B -- path" for the bottom commit is misleading
Date: Fri, 09 May 2014 21:59:22 +0200
Message-ID: <87lhuayb8l.fsf@fencepost.gnu.org>
References: <xmqq8uqc2dt5.fsf@gitster.dls.corp.google.com>
	<20140508212647.GA6992@sigill.intra.peff.net>
	<874n10ot2m.fsf@fencepost.gnu.org>
	<20140509001145.GA8734@sigill.intra.peff.net>
	<87zjiro856.fsf@fencepost.gnu.org>
	<20140509152935.GD18197@sigill.intra.peff.net>
	<xmqqy4yazwss.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 10 15:24:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wj7GR-0007JV-Bi
	for gcvg-git-2@plane.gmane.org; Sat, 10 May 2014 15:24:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753874AbaEJNYX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2014 09:24:23 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:36275 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752845AbaEJNYW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 May 2014 09:24:22 -0400
Received: from localhost ([127.0.0.1]:35306 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1Wj7GG-0003cR-Tu; Sat, 10 May 2014 09:24:21 -0400
Received: by lola (Postfix, from userid 1000)
	id 651AAE07CB; Fri,  9 May 2014 21:59:22 +0200 (CEST)
In-Reply-To: <xmqqy4yazwss.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 09 May 2014 10:28:19 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248656>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> On Fri, May 09, 2014 at 07:04:05AM +0200, David Kastrup wrote:
>>
>>> Arguably if the user explicitly limited the range, he knows what he's
>>> looking at. Admittedly, I don't know offhand which options _will_
>>> produce boundary commit indications: there may be some without explicit
>>> range limitation, and we might also be talking about limiting through
>>> shallow repos (git blame on a shallow repo is probably a bad idea in the
>>> first place, but anyway).
>>
>> Yes, I was thinking mostly of "X..Y" types of ranges, which are probably
>> the most common. I hadn't considered shallow repositories, and you can
>> also hit the root commit as a boundary if you do not specify --root.
>>
>> I guess the question still in my mind is: what use does the identity of
>> the boundary commit have? That is, whether you know ahead of time where
>> the boundary is or not, is there ever a case where knowing its author
>> and/or commit sha1 is a useful piece of information, as opposed to
>> knowing that we hit a boundary at all?
>>
>> I could not think of one, but I may simply lack imagination.
>
> Well, the original message was triggered by the same "I could not
> think of one" from me ;-).

If it's the root commit, omitting all info may surprisingly make "who
should I yell at" hard.  I also am not sure about the implications in
connection with --reverse.

In connection with explicit -b however, I think it is nonsensical to
blank out only the commit id.

-- 
David Kastrup
