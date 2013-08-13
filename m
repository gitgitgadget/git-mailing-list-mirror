From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Fwd: ephemeral-branches instead of detached-head?
Date: Tue, 13 Aug 2013 10:13:01 -0700
Message-ID: <7v38qdy0o2.fsf@alter.siamese.dyndns.org>
References: <CA+CP9O6on2NXo6o4_0NoULnT8sgUD3pvvkFZvCTM5xKb38qOeA@mail.gmail.com>
	<7veh9z1gym.fsf@alter.siamese.dyndns.org>
	<CA+CP9O5fhyQrn3SboafocWJjaAywJHC0T-bw+AXk_8RX53hJ6Q@mail.gmail.com>
	<CACsJy8Dke6Pezqsdcjzejc_cWCgOGTGs8LifjM2h2TQJy7N4HA@mail.gmail.com>
	<CA+CP9O5Ak3YD60--Mj+eLv3qzbZuuwTN-AxY3xb=SciKD=uZoQ@mail.gmail.com>
	<CA+CP9O5cK_zuRRj6uBdW_H7XO-w=B=vcjQsT1iF70Ce-jc02Ow@mail.gmail.com>
	<7vbo51y1bi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>
To: David Jeske <davidj@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 13 19:13:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9I9g-00057x-9N
	for gcvg-git-2@plane.gmane.org; Tue, 13 Aug 2013 19:13:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757405Ab3HMRNJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Aug 2013 13:13:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63343 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756163Ab3HMRNH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Aug 2013 13:13:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BB6AF38CE9;
	Tue, 13 Aug 2013 17:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=i/wJG//aOdTwh+kYmxZGw+Ki7lM=; b=P8F7eb
	8D0qoiDlK5p8RSm1TY/vug1MjDaWhfThI+ahPCNfyAyEfqxQ1Oib4dc+KJm6ZssV
	VgvwVYFSefMrpjy2DX5YY5ZMkRqrxGzBjRjOeIanVudDAB0YVGo8Y2mOaO+NCUat
	kCblBT6e0jDUP6M5o3xTc/HDWyJ+Hbl8WyeBo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FeNIbkrX9DdF9S9/IrbvMy7xi5t67Kw4
	8swD0Z+NOiDnhwKJlmLlP4c38Oi43DaZDfAKQIL5jqPFKYzMt2rCG2WqVe/DAeDY
	qPrthK1k8wH0UMFaPDGeki0DFB3A+RN56cO6Q7/SDZ/V8xKsisIEUzSCUSXhnERw
	JbsUHMazCNk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 85CA538CE8;
	Tue, 13 Aug 2013 17:13:06 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3639438CDB;
	Tue, 13 Aug 2013 17:13:04 +0000 (UTC)
In-Reply-To: <7vbo51y1bi.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 13 Aug 2013 09:58:57 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9D76DF60-043B-11E3-B519-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232237>

Junio C Hamano <gitster@pobox.com> writes:

> David Jeske <davidj@gmail.com> writes:
>
>>> When you do "git commit --amend",
>>> the current commit will become dangling (in the sense that it's not
>>> referred by any ref, but the commit exists) and those are just noise
>>> in my opinion.
>>
>> This is *exactly* my point.
>>
>> There is no way to distinguish a commit which was accidentally and
>> implicitly dangled due to checkout or submodule update on a detached
>> head, from all those other intentionally dangling refs which were
>> explicitly handled with merge, rebase, amend.
>
> I do not follow.  Just like "commit --amend", checking out another
> branch to leave a detached HEAD _is_ an explicit way to discard what
> you started experimenting behind, declaring it useless.  Otherwise
> you would have saved it to some named branch.
>
> This of course assumes that, as you said in one of your earlier
> messages, the user knows what he is doing, though.

By the way, by the above I do not mean "checking out a named branch
should not be protected".  I am saying "treating commits lost by
running 'commit --amend' differently does not make sense to me".
