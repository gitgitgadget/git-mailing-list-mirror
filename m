From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add post-merge hook.
Date: Tue, 04 Sep 2007 13:03:20 -0700
Message-ID: <7vodgimc53.fsf@gitster.siamese.dyndns.org>
References: <11885136172952-git-send-email-jjengla@sandia.gov>
	<7v7inc7hao.fsf@gitster.siamese.dyndns.org>
	<1188923110.6192.15.camel@beauty>
	<7vmyw2ny05.fsf@gitster.siamese.dyndns.org>
	<1188934573.6192.35.camel@beauty>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Josh England" <jjengla@sandia.gov>
X-From: git-owner@vger.kernel.org Tue Sep 04 22:03:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISecf-0005Ny-Ji
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 22:03:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753385AbXIDUD2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 16:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753391AbXIDUD1
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 16:03:27 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:46919 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753384AbXIDUD1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 16:03:27 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 9AAF112C262;
	Tue,  4 Sep 2007 16:03:44 -0400 (EDT)
In-Reply-To: <1188934573.6192.35.camel@beauty> (Josh England's message of
	"Tue, 04 Sep 2007 13:36:13 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57638>

"Josh England" <jjengla@sandia.gov> writes:

> On Tue, 2007-09-04 at 10:25 -0700, Junio C Hamano wrote:
>> "Josh England" <jjengla@sandia.gov> writes:
>> 
>> >> Two questions.
>> >> 
>> >>  * Do you want to run the post-merge hook even for a squash
>> >>    merge?
>> >
>> > Yes.  I'd like to run it at any time that the working tree might be
>> > updated.
>> 
>> If that is the case, perhaps your hook may want to get a
>> parameter to tell it what kind of "git-merge" invocation it was?
>> Squash merge does not even advance the HEAD and is of a very
>> different nature from a normal merge.
>
> OK.  Should it just pass in a flag (squash or normal), or are there
> other merge types it should need to know about.

I suspect you have thought abuot the issues involved longer than
I have ;-), so you should take whatever I say with grain of
salt, but I think you would also want to know fast-forwards and
up-to-dates if the hook wants to be generic, not "for Josh's
workflow only".
