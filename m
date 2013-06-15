From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/6] status: do not depend on flaky reflog messages
Date: Sat, 15 Jun 2013 02:51:00 -0700
Message-ID: <7vsj0jln23.fsf@alter.siamese.dyndns.org>
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
X-From: git-owner@vger.kernel.org Sat Jun 15 11:51:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Unn8n-0007nY-DY
	for gcvg-git-2@plane.gmane.org; Sat, 15 Jun 2013 11:51:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753547Ab3FOJvF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Jun 2013 05:51:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53784 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752942Ab3FOJvE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Jun 2013 05:51:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E73E2324F;
	Sat, 15 Jun 2013 09:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/YlWUena8dp7CPuSqQwqrzr7KLs=; b=PNoe7U
	5uj2h+nnkP36cVfdD7V+3sJEgAZku8qm7opFMYLqHudaYuNK70ck5t7JFC41CJod
	AqjZj2wq2dg6GFUazdzRaLojkgadObVSE3ZDRVFoUgWOJtmGdfsTrQqD7NS9E/HB
	ImkRVH/yC4EplJJlJuyOW2XPIg1kLgGXX4XBI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IEaxv7ePI2hnwZHTEI4xtnqERs7dLT6l
	xJsBILm6l8GBj6rqDBzT2ijyN9kDxd2Snt6JhsSki2Zgddema3D1yvEjzjTGW7s0
	ysQkc3eAoTn543KwoE9/MZUBjhDbwRILeMtJkxTYDvXw4KnJhPYDOCnHQ03qIIfy
	5DxiAptVkok=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 834AD2324D;
	Sat, 15 Jun 2013 09:51:02 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E4D722324B;
	Sat, 15 Jun 2013 09:51:01 +0000 (UTC)
In-Reply-To: <CALkWK0nDwqqiAq044wwj__1XzAuFDBUG59_0zHRMNzQ6ARsiww@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Sat, 15 Jun 2013 14:14:56 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 168EE722-D5A1-11E2-A5C4-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227937>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> I am only saying that the last test the commit adds must be kept
>> unbroken.  I am also saying that, even though that commit did not
>> add a test for "detached from" case, we should add something like
>> the attached to protect the behaviour.  These two are sacred.
>>
>> What happens to be shown during a stopped "git rebase" is not.
> ...
> The question is: what do _you_ want now?

It should be fairly clear what _I_ want now.  Re-read the first four
lines you quoted above.

> Read the various "HEAD detached from/to" messages in the rebase tests
> in t/status-help and tell me that they make some sense.

Again, re-read the part you did _not_ quote before those four lines.
I do not think all of them make lot of sense; some of them may.

Unless you are also tackling the topic of the other thread:

  http://thread.gmane.org/gmane.comp.version-control.git/227432/focus=227469

(which I would not suggest to do in this topic), what these lines
say during "rebase" does not really matter, as far as your topic is
concerned.

Two possibilities:

 (1) Assume that the other thread will produce a more reasonable
     semantics when finished; perhaps the first line will go away
     entirely, or maybe it would say something like "# Rebasing;
     head at $commit".

     Your topic does not _care_ what it would say, so you tweak the
     "status" test that is done during "rebase" so that they
     ignore the first lines; or

 (2) Starting from the same assumption as above, but try to minimize
     the semantics change to user-visible behaviour this series
     makes.

     That means that even though the _primary_ thing you want to do
     is to tweak "rebase" and its internal use of "checkout" in such
     a way that reflog will not record the implementation-detail
     checkout (because that will affect the next "checkout -"), make
     sure that "status" while doing "rebase" reports where the
     internal "checkout" of $ONTO detached HEAD from/at.

The "something along this line" patch was an illustration of how
the beginning of the effort for (2) would look like.

As I already said, I could see us going either way.  If we can do
(2), that may be better, but at end it would not matter that much as
long as we will be doing the other topic, too.
