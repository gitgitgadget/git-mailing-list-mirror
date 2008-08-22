From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t9301-fast-export: move unset of config variable into
 its own test function
Date: Fri, 22 Aug 2008 14:11:48 -0700
Message-ID: <7vljyo92ln.fsf@gitster.siamese.dyndns.org>
References: <7vtzdhkfo2.fsf@gitster.siamese.dyndns.org>
 <ZdQ6b4vecqtrZ-7Mze6M9UBwrI9qQRUu-BoApXUv0v2zM76stzXd3w@cipher.nrlssc.navy.mil> <7vbpzlbgyl.fsf@gitster.siamese.dyndns.org> <7v7ia9bgqc.fsf@gitster.siamese.dyndns.org> <48AE8093.4070609@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Aug 22 23:13:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWdwm-0006Gl-Ng
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 23:13:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758783AbYHVVL4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 17:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758761AbYHVVL4
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 17:11:56 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33993 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758775AbYHVVLz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 17:11:55 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 5864D63D2A;
	Fri, 22 Aug 2008 17:11:54 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 3887163D26; Fri, 22 Aug 2008 17:11:49 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F24912C4-708E-11DD-A2FC-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93367>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Nice idea. Another class would be the tests that depend on that the
> filesystem supports symbolic links.
>
>> -test_expect_success 'iso-8859-1' '
>> +test_expect_success I18N 'iso-8859-1' '
>
> How do the tests look like if this token is the *last* argument?

I thought about it but rejected it because it is much easier to spot class
tokens if it comes immediately after test_expect_xyzzy.

I suspect that certain classes of tests that need to be skipped can be
autodetected inside test-lib.sh; it would be an independent topic to build
on top of this.  Your example of 64-bit may be one of them.
