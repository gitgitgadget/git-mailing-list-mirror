From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] Teach git to change to a given directory using -C option
Date: Thu, 19 Sep 2013 10:13:51 -0700
Message-ID: <xmqqob7ou434.fsf@gitster.dls.corp.google.com>
References: <20130919131854.GA19790@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Nazri Ramliy <ayiehere@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 19 19:14:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMhnj-0003YA-Ly
	for gcvg-git-2@plane.gmane.org; Thu, 19 Sep 2013 19:14:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752136Ab3ISRNz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Sep 2013 13:13:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52128 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752103Ab3ISRNz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Sep 2013 13:13:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D61A420C0;
	Thu, 19 Sep 2013 17:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6qYSIhjOwlXdeeX4F3cCUscRaZk=; b=D6XwzK
	+ghSwotM8GeWEk0ml9GhqQpUZXrCy2Li8AdGYZva4ss2zwL/YQQuwqpylHkgBK59
	vhNex4fSSGbUsclmYq00SaxHQkBicnlM3jzPtAlHt9tnUpHYHg/tNrsjfZySrF1o
	FyhXnAetgeTvKeCpZov9aoIj1ThB98joMU1ms=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WQ39CAd4slDawzqf0xzW2GEkPnCVlNf8
	8T1hj0j/7jWz5Q8LGTAHmNz10WYsAm7XbuvLplXDu8UxQP8H1nRgK2pEPhCInpxI
	PdC9Wx7CX7soUlULw5hjkchWmWB8TXa5VxJJqhYGU+dzN5sepnKVM/013tEjSZRx
	FDHQuy4zH/k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6342D420BF;
	Thu, 19 Sep 2013 17:13:54 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B2A43420BB;
	Thu, 19 Sep 2013 17:13:52 +0000 (UTC)
In-Reply-To: <20130919131854.GA19790@gmail.com> (Nazri Ramliy's message of
	"Thu, 19 Sep 2013 21:18:54 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DBA47D94-214E-11E3-A875-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235020>

Nazri Ramliy <ayiehere@gmail.com> writes:

> Now I'm noticing that you've already made the above fixes in next ;)

Yes.  I said I'd locally tweak and queue, didn't I?

>>> +test_expect_success '"git -C <path>" runs git from the directory <path>' '
>>> +     test_create_repo dir1 &&
>>> +     echo 1 >dir1/a.txt &&
>>> +     (cd dir1 && git add a.txt && git commit -m "initial in dir1") &&
>>
>> Curious why this does not use -C here.
>
> It didn't use -C there because it's in the "prepare the expected test
> output" stage and we want that to succeed, whether -C works or not - we
> haven't reached the part where we are actually testing the -C option,

Good thinking.

Will queue as an incremental update on top of what is already in 'next'.

Thanks.
