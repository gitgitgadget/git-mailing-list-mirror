From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git v2.8.0-rc0
Date: Sat, 27 Feb 2016 09:46:42 -0800
Message-ID: <xmqqtwkugi65.fsf@gitster.mtv.corp.google.com>
References: <xmqqmvqnhwf4.fsf@gitster.mtv.corp.google.com>
	<CAP8UFD0XF=tx0RAu+uH20UpGm45HPrcxSBJZEGKc4xiOro1jvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 27 18:46:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZix7-0007dM-J7
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 18:46:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422923AbcB0Rqq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Feb 2016 12:46:46 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54949 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756553AbcB0Rqp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2016 12:46:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5B84345BF0;
	Sat, 27 Feb 2016 12:46:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wz/fB0tKbdLXkMdh76YUUi2KtI4=; b=wEw8RM
	J+pHw/F7q0sPr8Kj6VNFb4kedEcWx7gQ0kWzzaC7hgFFsmYIlyxZYHc1TBsj4/QB
	dsgmrG7W/2WZ81zaJgUSnaSlrK98iMgUujODDMQ8zdi+5SXInTMRvS5bFwKA+j7o
	okUHHKLQ48axrvVAvry/c4HPd+FF7yza5b1h8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bOlcbJHEczMur/zrgsF49ULAr6Bv6GBX
	R3a32bdUO/jSy8hddCUFc34DVI2uLtUS+4tmKY/xgQ1CbxNzvBkzVI4nSKvmuEnH
	z68tRkIh/S35VcwKjO1QyZJBH/9aJW9mJR/MmJ20652i3/+M9VY5dgXcZMnYGznI
	N2GTkYYMWJg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 51B6E45BEF;
	Sat, 27 Feb 2016 12:46:44 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id BF21145BEE;
	Sat, 27 Feb 2016 12:46:43 -0500 (EST)
In-Reply-To: <CAP8UFD0XF=tx0RAu+uH20UpGm45HPrcxSBJZEGKc4xiOro1jvA@mail.gmail.com>
	(Christian Couder's message of "Sat, 27 Feb 2016 12:10:08 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 108AF79C-DD7A-11E5-9A8E-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287712>

Christian Couder <christian.couder@gmail.com> writes:

> On Sat, Feb 27, 2016 at 12:41 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Git 2.8 Release Notes (draft)
>> =============================
>>
>> Backward compatibility note
>> ---------------------------
>>
>> The rsync:// transport has been removed.
>
> We may want to add something about untracked cache changes here, maybe
> something like:
>
>     The untracked cache subsystem has been updated and its primary UI
> has been changed
>     from "git update-index" to "git config" with some small backward
> incompatibilities.

I seriously hope we do not have to do that, and you do too.

The section is about "We deliberately did something that breaks your
expectation", "You may have been assuming that X would be a good way
to achieve Y, but X no longer will serve that purpose".  The latter
can be optionally followed by "To do Y, you now can do W instead",
but it still is breaking the established way of using Git.

I did not think your untracked update was done in such a way to
"break" existing uses (if it is not the case and breaks existing
uses, it needs to be fixed, but I think we made sure it will keep
working the same way for those who do not explicitly set
configuration to adopt the new behaviour).
