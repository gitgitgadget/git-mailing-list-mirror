From: David Kastrup <dak@gnu.org>
Subject: Re: New GSoC microproject ideas
Date: Wed, 12 Mar 2014 21:37:41 +0100
Message-ID: <87siqni25m.fsf@fencepost.gnu.org>
References: <532049A7.6000304@alum.mit.edu>
	<xmqq1ty7me6a.fsf@gitster.dls.corp.google.com>
	<87wqfzi5wa.fsf@fencepost.gnu.org>
	<20140312192108.GA1601@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	git discussion list <git@vger.kernel.org>,
	Fabian <bafain@gmail.com>,
	Quint Guvernator <quintus.public@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 12 21:37:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNpuO-0004gX-PZ
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 21:37:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbaCLUho (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 16:37:44 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:40727 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751039AbaCLUhn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 16:37:43 -0400
Received: from localhost ([127.0.0.1]:39765 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WNpuI-00088d-CY; Wed, 12 Mar 2014 16:37:42 -0400
Received: by lola (Postfix, from userid 1000)
	id E4705E05D9; Wed, 12 Mar 2014 21:37:41 +0100 (CET)
In-Reply-To: <20140312192108.GA1601@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 12 Mar 2014 15:21:08 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243987>

Jeff King <peff@peff.net> writes:

> On Wed, Mar 12, 2014 at 08:16:53PM +0100, David Kastrup wrote:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>> 
>> > Here is another, as I seem to have managed to kill another one ;-)
>> >
>> > -- >8 --
>> >
>> > "VAR=VAL command" is sufficient to run 'command' with environment
>> > variable VAR set to value VAL without affecting the environment of
>> > the shell itself, but we cannot do the same with a shell function
>> > (most notably, "test_must_fail");
>> 
>> No? bash:
>> 
>> dak@lola:/usr/local/tmp/lilypond$ zippo()
>> > {
>> > echo $XXX
>> > echo $XXX
>> > }
>> dak@lola:/usr/local/tmp/lilypond$ XXX=8 zippo
>> 8
>> 8
>
> Try:
>
>   zippo() {
>     echo $XXX
>   }
>   XXX=8 zippo
>   zippo
>
> XXX remains set after the first call under dash (but not bash). I
> believe "ash" has the same behavior.

Yes.  I would lean towards considering this a bug.  But I agree that it
does not help.

-- 
David Kastrup
