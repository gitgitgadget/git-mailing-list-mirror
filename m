From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix t7004 which fails with retarded sed
Date: Fri, 16 Nov 2007 11:36:42 -0800
Message-ID: <7vlk8yx9rp.fsf@gitster.siamese.dyndns.org>
References: <20071116165944.GB29272@glandium.org>
	<1195233971-12288-1-git-send-email-mh@glandium.org>
	<7vpryaxczx.fsf@gitster.siamese.dyndns.org>
	<20071116191715.GB7624@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Fri Nov 16 20:37:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1It6zy-0008JE-6Z
	for gcvg-git-2@gmane.org; Fri, 16 Nov 2007 20:37:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754590AbXKPTgt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2007 14:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754408AbXKPTgt
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Nov 2007 14:36:49 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:42746 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754247AbXKPTgs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2007 14:36:48 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id E0C1F2FA;
	Fri, 16 Nov 2007 14:37:08 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 6B1ED9670D;
	Fri, 16 Nov 2007 14:37:06 -0500 (EST)
In-Reply-To: <20071116191715.GB7624@glandium.org> (Mike Hommey's message of
	"Fri, 16 Nov 2007 20:17:15 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65244>

Mike Hommey <mh@glandium.org> writes:

>> So the earlier part of the test
>> 
>> 	GIT_EDITOR=cat git tag -a initial-comment > actual || true &&
>> 
>> is already bogus with respect to the latter point.  It will
>> happily continue if "git tag" erroneously returns success, and
>> the above does not catch it.
>> 
>> 	if GIT_EDITOR=cat git tag -a initial-comment >actual
>>         then
>>         	echo >&2 oops we should have errored out
>>                 false
>> 	else
>>         	: happy -- anything else we want to check?
>> 	fi
>
> This should probably be tested in another test block.

Fair enough; please make it so.

> Which is roughly what my patch does, except it doesn't check for
> ordering.

... which I think is more important part.  If the blank like
were at the end, that would be irritating for the user, wouldn't
it?
