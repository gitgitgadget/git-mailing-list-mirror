From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Wed, 27 Apr 2011 11:28:48 -0700
Message-ID: <7vpqo77dlr.fsf@alter.siamese.dyndns.org>
References: <BANLkTinh3v1o7t4HRwzZtFW--zu-j4U3kw@mail.gmail.com>
 <4DB80747.8080401@op5.se>
 <BANLkTimUHrHqS-Ssj+mK=0T8QHKg34pkaw@mail.gmail.com>
 <4DB82D90.6060200@op5.se> <7vbozr8uo8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Seymour <jon.seymour@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed Apr 27 20:29:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QF9U3-0004dY-Ua
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 20:29:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755920Ab1D0S3B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 14:29:01 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54779 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753535Ab1D0S3A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 14:29:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CF320440A;
	Wed, 27 Apr 2011 14:31:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WFp6ql52w42eYBcGFlbFxl33E5Q=; b=Etgu6w
	t7zG5bvsy+iE7EYYIYM68F6M7f9ypYfilPRulysgHiu64SODLysMyY6HrrY681Kb
	m56g8LxeRDZYyIPI9qKtdImW/p6H7MJ1qKioyoGCiCDUClhU/kJpSYgqCPyWk8Y4
	scTALdH2FZdfRNYlhDaTnHEJ57eyqy7F+33/0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vm4jsH+ESvdwALx3Qqul98K17ckYJhBa
	I9DjHgbDttPo+SogXq+6BUxsSU3dwKEqv0LE9pULmsZV/ZOaA86syq4bo8V/O0lz
	6x0TbZYQ3QFFV596B5iy1A8scO40lAXiZb/T5zjAQG0XKEtojesuZsjbhe4uSBkh
	56IrHaYLiIo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 972FE4409;
	Wed, 27 Apr 2011 14:30:58 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 852EC4407; Wed, 27 Apr 2011
 14:30:53 -0400 (EDT)
In-Reply-To: <7vbozr8uo8.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 27 Apr 2011 10:34:47 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7EF7A2EC-70FC-11E0-BF2A-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172257>

Junio C Hamano <gitster@pobox.com> writes:

> Andreas Ericsson <ae@op5.se> writes:
>
>> You're utterly horribly wrong. ...
>> ...
>> So the complete description would be
>>
>>   git clone git://somerepo/gitworks
>>   cd gitworks
>>   make install
>>
>> and the rest is in developer hands.
>
> Yeah, I like this as the conclusion of this thread ;-).

Having said that, to make this work well not just for the command but for
documentation and help, there needs a way for the build procedure of such
user-script project to query the manpage and the documentation paths, just
like we let them query the executable path via "git --exec-path".
