From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add abbreviated commit hash to rebase conflict message
Date: Wed, 09 Nov 2011 10:25:21 -0800
Message-ID: <7vmxc5tapa.fsf@alter.siamese.dyndns.org>
References: <1320501759-27236-1-git-send-email-srabbelier@gmail.com>
 <7v39e2852t.fsf@alter.siamese.dyndns.org>
 <CAGdFq_hw1630ELQP3+AEaCmUTEjYq7K1j8ZB-n0_rb1VN=wQgA@mail.gmail.com>
 <7vy5vt7uqo.fsf@alter.siamese.dyndns.org>
 <CAGdFq_j7NxojZ+82s0GJ8ZF0oyd5sH8t0kcMOTQGtKbASXqYTA@mail.gmail.com>
 <7vaa89573r.fsf@alter.siamese.dyndns.org>
 <CAGdFq_gS2fV5B26ZBOLs=5L_rnaeORmKW49OxwbP-+vx+ZN8cQ@mail.gmail.com>
 <7v4nyg6b9s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Jonas =?utf-8?Q?Flod=C3=A9n?= <jonas@floden.nu>,
	Eric Herman <eric@freesa.org>, Fernando Vezzosi <fv@repnz.net>,
	Git List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 09 19:25:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROCq1-0008Go-CW
	for gcvg-git-2@lo.gmane.org; Wed, 09 Nov 2011 19:25:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751596Ab1KISZY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Nov 2011 13:25:24 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39111 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751364Ab1KISZY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Nov 2011 13:25:24 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 63ADB51D3;
	Wed,  9 Nov 2011 13:25:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yIY+RUNDHVdtAVUaMzc9UwKD50o=; b=NDG/XI
	33GX4zSEoAM8PUelsuDugxGsS46+kSZjefPgykKmEEZYdfGINlW7/uMAbckx1UgJ
	I/oWVnS+1UU0HcHHWzeC+WBVc7amIBLUwfp4F07TGqkmkbYBTsJYr2um1+nbSvuT
	713Zz3a+Zyz+oJpO7IpuMAoWw/GbBC+ix43gM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FUh4atrZgG6Z59Sa9abpaE+uYEWnkVy/
	3YiUxVqgC93yLH0ypmxymKxzdkZtOH0N3fImCaKLC6SQCE+/7hERqbZfiLkXVfHN
	l77x/eMyzoDwcPMfDgPDVhL9Jx/pz+oAv2Rwyy9WUQEkP7rDTraE/CSiR/brVKuc
	HFsNs85fh3g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A59551D2;
	Wed,  9 Nov 2011 13:25:23 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AD1AE51D1; Wed,  9 Nov 2011
 13:25:22 -0500 (EST)
In-Reply-To: <7v4nyg6b9s.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 06 Nov 2011 16:12:31 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2FC5DF6A-0B00-11E1-9CB5-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185166>

Junio C Hamano <gitster@pobox.com> writes:

> Sverre Rabbelier <srabbelier@gmail.com> writes:
>
>> On Sun, Nov 6, 2011 at 21:27, Junio C Hamano <gitster@pobox.com> wrote:
>>> In what situation does it make sense to say "It came from _this_ commit"?
>>>
>>> I think there is a separate variable that allows any part of the script if
>>> we are being run as a backend of rebase or not, and that is the condition
>>> you are looking for.
>>
>> The closest I could find is:
>>
>>                 if test -f "$dotest/rebasing"
>>
>> Which is exactly the case when commit is set. Do you prefer the "-f
>> $dotest/rebasing" test or the "-n $commit" one?
>
> Given the variable scoping rules of vanilla shell script, relying on the
> variable $commit is a very bad idea to begin with.  I think the variable
> also is used to hold the final commit object name produced by patch
> application elsewhere in the script in the same loop, and I do not think
> existing code clears it before each iteration, as each part of the exiting
> code uses the variable only immediately after that part assigns to the
> variable for its own purpose, and they all know that nobody uses the
> variable as a way for long haul communication media between different
> parts of the script.  Unless your patch updated that aspect of the
> lifetime rule for the variable, which I doubt you did, using $commit would
> introduce yet another bug without solving anything, I would think.

I was looking at git-am today for a separate topic. Doesn't it appear to
you that $dotest/original-commit is what serves your purpose the best?

The file is removed before starting to process a new input (i.e. message
in the mbox), created only after we read the from line and determine it is
really the commit we are rebasing, and is left intact until we decide the
patch was applied correctly and write the result out as a tree.

It might be a clean-up to get rid of $dotest/original-commit file, rename
the variable to $original_commit and initialize it to an empty string
where we currently have 'rm -f "$dotest/original-commit"' (and replace the
check 'test -f "$dotest/original-commit"' later in the script with a check
'test -n "$original_commit"'), though.
