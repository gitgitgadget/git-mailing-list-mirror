From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv6 2/4] t7512-status-help.sh: better advices for git
 status
Date: Mon, 04 Jun 2012 08:04:26 -0700
Message-ID: <7vbokzunid.fsf@alter.siamese.dyndns.org>
References: <1338477344-15940-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1338748217-16440-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1338748217-16440-2-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <7vvcj8xffp.fsf@alter.siamese.dyndns.org>
 <20120604120406.Horde.ge3VMHwdC4BPzIgWN72l8oA@webmail.minatec.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kong Lucien <Lucien.Kong@ensimag.imag.fr>, git@vger.kernel.org,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>,
	Nguyen Huynh Khoi Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Moy Matthieu <Matthieu.Moy@grenoble-inp.fr>
To: konglu@minatec.inpg.fr
X-From: git-owner@vger.kernel.org Mon Jun 04 17:04:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbYpe-0004fz-UE
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jun 2012 17:04:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755066Ab2FDPEa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jun 2012 11:04:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35437 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751225Ab2FDPE3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2012 11:04:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C41786A79;
	Mon,  4 Jun 2012 11:04:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=COJWDaE0gpGBJM3Mg6k6NKaSxMI=; b=Jj0GtQ
	wXWbNE7JMvbGqBel0ogpGmTtUE9voMDFIh+qhoYY71SgdImTzOqKKUAzAZw78Im0
	pCE0YC/Mit9mWJz8c0wd0FJytp27J8x2dLTsqAZRE6F1T1g+b4Err9DyaxQxmv+K
	VfINV6lHDIPtAn6zvbcEZdmWD4srtnPbopEv8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=j38Wz+ipLE1vUQnHQJz7Ns42tFvSsA1b
	nSgRhmod8Xot4zMsmP4XmDhhYqXj61l4ONCIbwrMKv8W9W5UW9eUO1P3DVu2bEs4
	eQmGgwrbQrA/K4mKoHcW2IIUQ3qUkNv98VSdhgQGmV4GltPJTaMB6oogYIIuNZFD
	eu54DdEjiJM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BA5E96A78;
	Mon,  4 Jun 2012 11:04:28 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 48AF96A77; Mon,  4 Jun 2012
 11:04:28 -0400 (EDT)
In-Reply-To: <20120604120406.Horde.ge3VMHwdC4BPzIgWN72l8oA@webmail.minatec.grenoble-inp.fr> (konglu@minatec.inpg.fr's message of "Mon, 04 Jun 2012 12:04:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 94B7ED60-AE56-11E1-94D7-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199141>

konglu@minatec.inpg.fr writes:

> Junio C Hamano <gitster@pobox.com>:
> ...
>> Please be consistent.  If you want _me_ to pick one, I'd say
>>
>> 	test_when_finished 'rm -fr git' &&
>>         git init git &&
>>         (
>>         	cd git &&
>>                 ... do everything in git subdirectory ...
>> 	)
>>
>> would be my choice.
>
> Btw, should each test be independant with the others?

It would be ideal if you can make them independent with each other,
so that after one fails, later ones do not have to.

> Wouldn't it be better if we remove the "git init git" part?

If you do not need to keep your tests from using the test repository
in $TRASH_DIRECTORY (e.g. "t/trash directory.t7512-status-help"),
you do not have to create a new one with "git init".
