From: David Kastrup <dak@gnu.org>
Subject: Re: New GSoC microproject ideas
Date: Wed, 12 Mar 2014 22:12:47 +0100
Message-ID: <87k3bzi0j4.fsf@fencepost.gnu.org>
References: <532049A7.6000304@alum.mit.edu>
	<xmqq1ty7me6a.fsf@gitster.dls.corp.google.com>
	<87wqfzi5wa.fsf@fencepost.gnu.org>
	<20140312192108.GA1601@sigill.intra.peff.net>
	<87siqni25m.fsf@fencepost.gnu.org>
	<20140312204453.GA9702@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	git discussion list <git@vger.kernel.org>,
	Fabian <bafain@gmail.com>,
	Quint Guvernator <quintus.public@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 12 22:12:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNqSL-0003nt-O5
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 22:12:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752973AbaCLVMt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 17:12:49 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:41367 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751440AbaCLVMs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 17:12:48 -0400
Received: from localhost ([127.0.0.1]:40406 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WNqSF-0006k0-D4; Wed, 12 Mar 2014 17:12:47 -0400
Received: by lola (Postfix, from userid 1000)
	id 1CF2BE05DC; Wed, 12 Mar 2014 22:12:47 +0100 (CET)
In-Reply-To: <20140312204453.GA9702@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 12 Mar 2014 16:44:53 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243992>

Jeff King <peff@peff.net> writes:

> On Wed, Mar 12, 2014 at 09:37:41PM +0100, David Kastrup wrote:
>
>> > Try:
>> >
>> >   zippo() {
>> >     echo $XXX
>> >   }
>> >   XXX=8 zippo
>> >   zippo
>> >
>> > XXX remains set after the first call under dash (but not bash). I
>> > believe "ash" has the same behavior.
>> 
>> Yes.  I would lean towards considering this a bug.  But I agree that it
>> does not help.
>
> Dash's behavior is POSIX (and "bash --posix" behaves the same way).
>
>   http://article.gmane.org/gmane.comp.version-control.git/137095

In that case I consider it a standard-compliant bug (namely being a
serious problem regarding the usefulness of shell functions).  Which
makes it unlikely to go away.  It makes it easier to interpret, say

zippo() {
  XXX=$XXX
}

XXX=8 zippo
echo $XXX

as shell functions presumably should be able to assign to shell
variables like built-ins do.  But that's not really much of an
advantage.

The behavior does not make sense to me also with regard to special
built-ins.  Bash does

dak@lola:/usr/local/tmp/git$ XXX=8 :
dak@lola:/usr/local/tmp/git$ echo $XXX

dak@lola:/usr/local/tmp/git$ 

And that makes sense to me.  Whatever, does not help.

-- 
David Kastrup
