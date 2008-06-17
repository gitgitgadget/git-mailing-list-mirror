From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] test-lib.sh: add --long-tests option
Date: Tue, 17 Jun 2008 00:15:52 -0700
Message-ID: <7vprqg7crb.fsf@gitster.siamese.dyndns.org>
References: <1213666142-24680-1-git-send-email-LeWiemann@gmail.com>
 <7vy7547egk.fsf@gitster.siamese.dyndns.org> <48576345.7000809@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 17 09:17:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8VRA-0003MZ-Jx
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 09:17:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752486AbYFQHQJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 03:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752088AbYFQHQJ
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 03:16:09 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62574 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751798AbYFQHQI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 03:16:08 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2D84723571;
	Tue, 17 Jun 2008 03:16:07 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id BE5C523570; Tue, 17 Jun 2008 03:15:59 -0400 (EDT)
In-Reply-To: <48576345.7000809@gmail.com> (Lea Wiemann's message of "Tue, 17
 Jun 2008 09:09:57 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 40F96788-3C3D-11DD-A6A6-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85271>

Lea Wiemann <lewiemann@gmail.com> writes:

> Junio C Hamano wrote:
>> I am guessing that the reason why you do not unset GIT_TEST_LONG upfront
>> in the script is because the user can do:
>>
>>         $ GIT_TEST_LONG=t; export GIT_TEST_LONG
>>         $ ./t9999-this-test.sh
>>         $ ./t9999-that-test.sh
>>
>> or even:
>>
>> 	$ GIT_TEST_LONG=t make test
>
> Yes, that's the idea.
>
>> If that is the case, however, I wonder if this --long-tests option is even
>> necessary.
>
> It's very convenient for development, where you go back and forth
> between "./t9503-gitweb-Mechanize.sh -v -l" and
> "./t9503-gitweb-Mechanize.sh -v".  All it takes is to add or remove
> the "-l" at each invocation.  So I think the switch is actually quite
> useful.

Heh, one-shot export "GIT_TEST_LONG_t ./t9999-this-test.sh" would equally
be swift, but Ok.
