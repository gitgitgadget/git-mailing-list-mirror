From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Merging using only fast-forward
Date: Wed, 16 Jan 2008 14:49:52 -0800
Message-ID: <7v3asxo06n.fsf@gitster.siamese.dyndns.org>
References: <loom.20080116T151930-575@post.gmane.org>
	<863asxivlj.fsf@blue.stonehenge.com>
	<7vwsq9o6ls.fsf@gitster.siamese.dyndns.org>
	<402c10cd0801161438u7443ebf2xdf1d6f3040ceb1a9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Sverre Hvammen Johansen" <hvammen@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 23:50:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFH5Z-000362-DH
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 23:50:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752541AbYAPWuA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 17:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752521AbYAPWuA
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 17:50:00 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40330 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752182AbYAPWt7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 17:49:59 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D8C624817;
	Wed, 16 Jan 2008 17:49:56 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 638224815;
	Wed, 16 Jan 2008 17:49:54 -0500 (EST)
In-Reply-To: <402c10cd0801161438u7443ebf2xdf1d6f3040ceb1a9@mail.gmail.com>
	(Sverre Hvammen Johansen's message of "Wed, 16 Jan 2008 14:38:20
	-0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70759>

"Sverre Hvammen Johansen" <hvammen@gmail.com> writes:

> On Jan 16, 2008 12:31 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> A sane integration is a different story.
>>
>> We have --ff and --no-ff options to merge.  How should this new
>> option --ff-only mesh with them?  Perhaps we would want to have
>> an option --ff that takes three values?
>>
>>         --ff=never
>>         --ff=normal
>>         --ff=only
>>
>> and have the first one be synonym for existing --no-ff, the second
>> one to be a synonym for not giving anything (or giving --ff
>> explicitly), and the third one to be this new mode of operation?
>
> Thanks for the patch.  I can probably look into it tonight and do the
> suggested integration and test it out, I keep you posted.

Well, no, I did not _suggest_ that particular integration.  I do
not even know what the right answer is to these questions.  The
UI that pastebin patch implements, which uses totally separate
flags, may turn out to be the right approach.  If you want to
carry the torch forward on this topic, that's great.  It is very
much appreciated.  But one of the things included in that work
includes thinking and deciding which UI is better between the
patch in the pastebin and the one that tries to introduce a
unified --ff=<value> option.  I simply do not know the answer,
and prefer not having to think about it during a pre-release
feature freeze.

Coming up with a 7-liner quick-and-dirty solution is one thing.
It was easy (although I haven't tested it, so it may not work at
all!).  But if we want to mainline it, we need to think
carefully how the new feature integrates well with what we
already have.  That's all I wanted to say.
