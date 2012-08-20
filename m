From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Aug 2012, #06; Sun, 19)
Date: Mon, 20 Aug 2012 09:35:06 -0700
Message-ID: <7v8vd9ldxh.fsf@alter.siamese.dyndns.org>
References: <7v393im4jy.fsf@alter.siamese.dyndns.org>
 <CABPQNSZ+JskSvEUFbxy78eqB5cg1npq7n_thaVhhoXxd-DK+MQ@mail.gmail.com>
 <7vobm5lejl.fsf@alter.siamese.dyndns.org>
 <CABPQNSZpS6YX-WSp7nYnav+Szk0V-N9nx-F+RXtZLw7s6KMBQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>,
	Pete Wyckoff <pw@padd.com>, Luke Diamand <luke@diamand.org>,
	Stefan Zager <szager@google.com>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Mon Aug 20 18:35:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3Uwh-0006ki-BX
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 18:35:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754325Ab2HTQfN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 12:35:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62360 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753613Ab2HTQfK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 12:35:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 23B1677B7;
	Mon, 20 Aug 2012 12:35:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jWHfO47x5ooXQrSeSxOqmZYQpXg=; b=ONeSgG
	p20t2LgkCNxOOrxyQ0+626HhGBSmcr4npBsvgIFAWExdrNOX6FMBdnr9v860Rkul
	eYm6i1bznoEatJ7eDRViv7hKXZNL1bLrp8iA2LCusdu38CM/3EtVIzXw5hd+T/fW
	jO4LwMdFDpI9EaAz/TPQz6KM0fu/bNXjykRvg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DQ+kkQ3EXHXrWajbDYcqmkDU/018J4f/
	3a+0q7swjaJIiBDdBTHE7toJYXDMGr83HdMzZfN682uHvzcZ+17bsegagwrA3DqP
	K5z5jbn/QTtOaQ61MXT3v2NPlDzH8YarVh4nOjAWXUwe60dte9BLvN62e3s7aohc
	jTCvqqmgeSw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 06B2077B0;
	Mon, 20 Aug 2012 12:35:10 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5900677AD; Mon, 20 Aug 2012
 12:35:08 -0400 (EDT)
In-Reply-To: <CABPQNSZpS6YX-WSp7nYnav+Szk0V-N9nx-F+RXtZLw7s6KMBQg@mail.gmail.com> (Erik
 Faye-Lund's message of "Mon, 20 Aug 2012 18:23:45 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 010EC66C-EAE5-11E1-BC93-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203853>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> On Mon, Aug 20, 2012 at 6:21 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Erik Faye-Lund <kusmabite@gmail.com> writes:
>>
>>> On Mon, Aug 20, 2012 at 9:00 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>>> * ef/win32-cred-helper (2012-08-16) 1 commit
>>>>  - contrib: add win32 credential-helper
>>>>
>>>> Credential helper for Win32 (is this GUI???).
>>>
>>> No, and credential helpers shouldn't be either.
>>
>> Hrm, doesn't it even do "the application wants to access your
>> keychain.  Allow it [Y/N]?" kind of thing?
>>
>
> No. On Windows, you can freely access the keychain as long as a user
> is logged in and the machine is not locked.

OK, so is this a good description to go in the merge commit when it
goes to 'master'?

    * ef/win32-cred-helper (2012-08-16) 1 commit
     - contrib: add win32 credential-helper

     Credential helper for Win32, to allow access to the keychain of
     logged-in user.
