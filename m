From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Document git rev-list --first-parent
Date: Mon, 24 Dec 2007 01:58:12 -0800
Message-ID: <7vejdcs9cb.fsf@gitster.siamese.dyndns.org>
References: <1198484450-16454-1-git-send-email-avi@qumranet.com>
	<7v3atstry4.fsf@gitster.siamese.dyndns.org>
	<476F6F95.1030506@qumranet.com>
	<7vprwwsbey.fsf@gitster.siamese.dyndns.org>
	<476F7EA4.1030001@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Avi Kivity <avi@qumranet.com>
X-From: git-owner@vger.kernel.org Mon Dec 24 10:59:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J6k5G-0006aw-9z
	for gcvg-git-2@gmane.org; Mon, 24 Dec 2007 10:58:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751863AbXLXJ6Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Dec 2007 04:58:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751848AbXLXJ6Y
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Dec 2007 04:58:24 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50792 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751759AbXLXJ6X (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Dec 2007 04:58:23 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 12B3186C6;
	Mon, 24 Dec 2007 04:58:22 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 654D986BF;
	Mon, 24 Dec 2007 04:58:19 -0500 (EST)
In-Reply-To: <476F7EA4.1030001@qumranet.com> (Avi Kivity's message of "Mon, 24
	Dec 2007 11:40:52 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69210>

Avi Kivity <avi@qumranet.com> writes:

> Junio C Hamano wrote:
>> Avi Kivity <avi@qumranet.com> writes:
>>
>>
>>> Junio C Hamano wrote:
>>>
>>>> Avi Kivity <avi@qumranet.com> writes:
>>>>
>>>>
>>>>> Document git rev-list's --first-parent option.  Documentation taken from
>>>>> git log.
>> ...
> [I assume you mean 0053e902;  I just copied the output of git log --help]

Ahh, sorry, I thought you did "log -S--first-parent".

> Well, my use case is different.  All of the development merges are
> fast-forwards (or plain patch applications); the only multiple-parent
> merges are pulls I do from the main tree in order to advance the
> baseline,...

Yeah, that is what I meant as a special case.  If you submit
patches and rebase the remainder of your changes to the updated
upstream (as x.org folks seem to do), then the --first-parent
history will not be your own development but "the global trunk
history."  If you are the top-level maintainer and your pull
sometimes ends up as a fast forward and sometimes a real merge,
you will sometimes get a full history of a topic done by
somebody else (if that person rebased on top of you) or just a
summary single merge (otherwise), and the distinction between
these two cases does not have anything to do with whose commits
they are (i.e. mine vs others) or the scope of the changes
(i.e. the trunk history vs side branch development).  It would
not be as useful as the "looking at the list of one's own
commits while summarizing out others' developments as merge
commits" world view the --first-parent would give you in your
history.
