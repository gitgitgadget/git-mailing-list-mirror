From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH try 2] t1301-shared-repo.sh: don't let a default ACL 
 interfere with the test
Date: Wed, 15 Oct 2008 22:23:20 -0700
Message-ID: <7vzll5jepj.fsf@gitster.siamese.dyndns.org>
References: <1224022020.2699.4.camel@mattlaptop2.local>
 <1224022216.2699.5.camel@mattlaptop2.local>
 <7vzll66c5u.fsf@gitster.siamese.dyndns.org> <48F589EC.6050307@viscovery.net>
 <7vmyh64bgy.fsf@gitster.siamese.dyndns.org> <48F59928.5040502@viscovery.net>
 <7v7i8a47f6.fsf@gitster.siamese.dyndns.org> <48F5A590.3050905@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matt McCutchen <matt@mattmccutchen.net>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Oct 16 07:24:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqLLq-0003Xi-UL
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 07:24:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754396AbYJPFXc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 01:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754340AbYJPFXc
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 01:23:32 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34210 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754157AbYJPFXa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 01:23:30 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id DD1BF8BBB4;
	Thu, 16 Oct 2008 01:23:27 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 106698BBAE; Thu, 16 Oct 2008 01:23:22 -0400 (EDT)
In-Reply-To: <48F5A590.3050905@viscovery.net> (Johannes Sixt's message of
 "Wed, 15 Oct 2008 10:10:56 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 901ADF72-9B42-11DD-9EBC-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98344>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Junio C Hamano schrieb:
>
>> If that is the case what difference does your suggestion of not putting it
>> in test-lib.sh make?  We discourage users from playing ACL games, and we
>> protect ourselves from such by making sure the trash directory used for
>> running tests are not contaminated with ACL.  Wouldn't it make more sense
>> to do so for all the tests, so that future test writers do not have to
>> worry about it?
>
> We have to decide case by case. In the case of shared directories it makes
> sense to suggest "do not play ACL games". In other cases, however, this
> suggestion could not work out that well, and a workaround in the code is
> the better solutions. But we do not know what those other cases are, and
> the test suite may be a tool to uncover them.

Although I am not particularly interested in hypothetical case that does
not have concrete examples, I do not care deeply enough either.  So let's
take this patch (with updated/corrected log message) that minimally covers
the parts that can be broken by ACL games.
