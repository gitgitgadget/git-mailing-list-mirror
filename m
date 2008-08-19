From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] test-lib.sh: work around ksh's trap shortcomings
Date: Tue, 19 Aug 2008 00:39:43 -0700
Message-ID: <7v3al1h2rk.fsf@gitster.siamese.dyndns.org>
References: <giNXZFTxzY3B65dQob7CwvwwfSKlZpw_60oz81RxU5UN3PsTT_3dMQ@cipher.nrlssc.navy.mil> <gPlIc7E6mNDrXE6mwaHXFoin7rDpLmjvuzlhJfCp-YmuyVK3pEzqNA@cipher.nrlssc.navy.mil> <7vbpzplw9o.fsf@gitster.siamese.dyndns.org> <ZqhiQsjr6llIQS0q8PP8utINgu-mnafhFeUc119IDyjsaBEePvtv9g@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Aug 19 09:40:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVLpm-0004bh-4N
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 09:40:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752630AbYHSHju (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 03:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752623AbYHSHju
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 03:39:50 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:65451 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752520AbYHSHjt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 03:39:49 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3F5BA59FF4;
	Tue, 19 Aug 2008 03:39:48 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id A788C59FF3; Tue, 19 Aug 2008 03:39:45 -0400 (EDT)
In-Reply-To: <ZqhiQsjr6llIQS0q8PP8utINgu-mnafhFeUc119IDyjsaBEePvtv9g@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Mon, 18 Aug 2008 19:06:38 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 00062368-6DC2-11DD-83C9-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92823>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> Junio C Hamano wrote:
>> Brandon Casey <casey@nrlssc.navy.mil> writes:
>> 
>>> In ksh, if trap is called within a function with 0 or EXIT as its signal,
>>> then the trap will be executed at the time the function returns. This
>>> causes a problem in the test functions since 'trap - exit' is called
>>> within the test_done function
>> 
>> Your alias test_done that calls function test_done look ugly and confusing
>> beyond words.
> ...
> I will try your suggestions.
>
> I also hope you noticed that these patches followed an FYI message
> and were not meant for direct inclusion. I hope you noticed that
> since I don't want you to waste your time. Maybe I should have
> put FYI in the [PATCH] string.

Yeah, I think I got the subtle distinction between [PATCH FYI], [PATCH]
and ones with and without sign-offs.

I've read "trap" section of 1003.1 2004 three times but I do not see the
exact definition of "EXIT" condition mentioned.  Is the behaviour to
consider "function return" the EXIT condition considered a "shortcoming"
(aka bug)?
