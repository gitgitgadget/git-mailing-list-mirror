From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/6] status: do not depend on flaky reflog messages
Date: Sat, 15 Jun 2013 03:26:03 -0700
Message-ID: <7vfvwjllfo.fsf@alter.siamese.dyndns.org>
References: <1371130349-30651-1-git-send-email-artagnon@gmail.com>
	<1371130349-30651-6-git-send-email-artagnon@gmail.com>
	<7vvc5hubox.fsf@alter.siamese.dyndns.org>
	<CALkWK0kjxKFkrLArL1mLZYCMN1=sgnDSa3vaoJm6eSUp2E4Pyw@mail.gmail.com>
	<7vd2rpu3kf.fsf@alter.siamese.dyndns.org>
	<CALkWK0=NAiGDVWbwHXMmEffPF9wKXd23BdwOntfdvNCpVe8fiA@mail.gmail.com>
	<7vppvosstl.fsf@alter.siamese.dyndns.org>
	<CALkWK0k28u583Jci+Dvad1pbu7_dJdnmz1WBkP790a_t2QdPTg@mail.gmail.com>
	<7v38sksq14.fsf@alter.siamese.dyndns.org>
	<CALkWK0n_Jsb46qPojbGL3S+mPunNQWUOmypQOvdaBjcT5wgJBg@mail.gmail.com>
	<7vsj0kpsb0.fsf@alter.siamese.dyndns.org>
	<CALkWK0==Phbe-9QaOa3jkYMEvxb6F3kypRkk9RbzrLco-HkHKw@mail.gmail.com>
	<7v7ghwmi9x.fsf@alter.siamese.dyndns.org>
	<CALkWK0nDwqqiAq044wwj__1XzAuFDBUG59_0zHRMNzQ6ARsiww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 15 12:26:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnngV-0004TD-KZ
	for gcvg-git-2@plane.gmane.org; Sat, 15 Jun 2013 12:26:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753991Ab3FOK0L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Jun 2013 06:26:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60304 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753702Ab3FOK0J (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Jun 2013 06:26:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 21ED423A46;
	Sat, 15 Jun 2013 10:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=no//e3sz+vA7Ad/i4nLWxpqhCsA=; b=q3F9Le
	jnlPkpFBVR7+Sm+39V+w2RWfepq+rhIVVybCLA4VsVobEeFOGKvzzSu2td81AJnL
	hqukitfTFLBM6rMyR/1Es5rdBl159sX3+V23xbNQf2CSUzlIg0DuwEmBl5KTZ8a/
	Se5vCwlQkbM1MctSivfc51ShkDAZ3wheDoA08=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LQd6yeakju4Kizek7ph6NWPdoFMlPzaM
	Nf2a46iH7ozeYNQ3Au58+VbKnAeLtVp0LkO4+l2vIGBMPd3ESFAs1OyofCaj8Zdg
	w5F5k9qpaPiCFwMVz+cwKg3VgfMt9gkTJCCddk7LriBzbZ6KMSWtLwA+a6/zU258
	fvK1KBYgSK4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 14D9623A45;
	Sat, 15 Jun 2013 10:26:09 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8BDC823A40;
	Sat, 15 Jun 2013 10:26:07 +0000 (UTC)
In-Reply-To: <CALkWK0nDwqqiAq044wwj__1XzAuFDBUG59_0zHRMNzQ6ARsiww@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Sat, 15 Jun 2013 14:14:56 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FD9D406A-D5A5-11E2-B6F6-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227941>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

>> I have been assuming the "main" thing Duy wanted to do was the last
>> test (and the one below), but was this meant as an improvement for
>> "git status" output during that state?
>
> On what basis are you making that assumption? 

List archive helps.

http://thread.gmane.org/gmane.comp.version-control.git/217342/focus=217444

Not just that single message, but a few messages in the discussion
that led to the design shows that we wanted both "at" and "from" to
mean something sensible, when a "checkout" initiated by the end-user
detached HEAD and we are not on any branch, even after making
commits or doing resets.
