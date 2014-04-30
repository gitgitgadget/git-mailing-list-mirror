From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Pull is Evil
Date: Wed, 30 Apr 2014 13:01:49 -0700
Message-ID: <xmqqa9b2egcy.fsf@gitster.dls.corp.google.com>
References: <4ay6w9i74cygt6ii1b0db7wg.1398433713382@email.android.com>
	<xmqqoazlqot4.fsf@gitster.dls.corp.google.com>
	<536106EA.5090204@xiplink.com>
	<xmqqppjyhnom.fsf@gitster.dls.corp.google.com>
	<536152D3.5050107@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 22:02:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wfaha-0004Ke-Mp
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 22:01:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946020AbaD3UBy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 16:01:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51443 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752776AbaD3UBy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 16:01:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A1ABD7FF6D;
	Wed, 30 Apr 2014 16:01:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=05ERaNj2RGwXEpLi3oBg2DtBuos=; b=ZE/bDW
	X6tO5qUiFghmS/KKm6ZTCTJgirzf255t6mj7/uHX7xGV9UTRyd7ovecGixrhvq1U
	86zjaFpZtBWFbvdIb4dNV7g0atu1LcrrxLd+YckRXHnHV84lMagKQTZ931yJqZzW
	Y5g34g0spiNdg2Z/k+PF+KQyXS204PXwBKfAE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=q93K+17FF2KZa6XK0iHRtyZ3krv8bhGC
	lVk7XSvSwbDZxOdhYeFnKcy3KgCCz5Jvs6d6SXPwRU8nVa1X+RlGzxMiQ9ZcZlfF
	stXHjjHzBxUStFqUBTuKEts56YRWMVPC2UwInJ7epWn68zbipr60UfO7uqtAyKbW
	mEDGj2UlTlU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8AD177FF6C;
	Wed, 30 Apr 2014 16:01:53 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A1D5D7FF69;
	Wed, 30 Apr 2014 16:01:50 -0400 (EDT)
In-Reply-To: <536152D3.5050107@xiplink.com> (Marc Branchaud's message of "Wed,
	30 Apr 2014 15:45:23 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 44B091EE-D0A2-11E3-B698-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247770>

Marc Branchaud <marcnarc@xiplink.com> writes:

> On 14-04-30 10:55 AM, Junio C Hamano wrote:
>> Marc Branchaud <marcnarc@xiplink.com> writes:
> ...
>>> Anyway, rather than ranting on I'll just suggest that there's not enough
>>> commonality between the ways people use git to make it worthwhile trying to
>>> teach pull how to deal with a significant number of them.  I think the pull
>>> command should be deprecated and quietly retired as a failed experiment.
>> 
>> I almost agree with the first sentence in the last paragraph, and
>> your bulletted list above supports it.
>> 
>> I am not sure how the second sentence can follow as its consequence.
>> 
>> If the conclusion were "maybe adding a 'git update' to match the
>> expectation of those who build on top of the work of others (aka
>> CVS/SVN style) more  closely and teaching new users to use that
>> instead of 'git pull' may be a good way forward", I can sort of
>> understand (if I may not be able to immediately agree with, until I
>> can regurgitate the ramifications of such a change) it.
>
> I think we would run into much the same problem with "git update" as we do
> with "git pull"....

Maybe I was unclear.

I didn't mean "replace 'pull' with 'update' everywhere".  I meant
"Introduce 'update' that lets integrate your history into that from
the remote, which is to integrate in a direction opposite from how
'pull' does".  

Then the downstream people (i.e. by definition, most of us) would
use "git update" while integrators would use "git pull".  There is
no workflow assumption if we do so.

> I don't think we'll ever be able to create a One "Git Pull" To Rule Them All.

Yes, that is exactly why I mentioned "git update".

Another way not to make any workflow assumption is to ask the user
to tell us.
