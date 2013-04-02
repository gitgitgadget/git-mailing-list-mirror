From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Composing git repositories
Date: Tue, 02 Apr 2013 11:03:54 -0700
Message-ID: <7v7gkkern9.fsf@alter.siamese.dyndns.org>
References: <CALkWK0=CsuAWQwk5Guf0pbC4_ZEoZiwQpamcRvBGz5LJ0QGKHg@mail.gmail.com>
 <7vmwtqt8rs.fsf@alter.siamese.dyndns.org>
 <CALkWK0kNH2A4eLML22RTofarR3MB++OECiNXMi-bWLLMWK1GAg@mail.gmail.com>
 <7vvc8comj5.fsf@alter.siamese.dyndns.org>
 <CALkWK0nARWAtC-D3UiNLccuaSwjR6meJb+Cu590N=8Ti8O7OMg@mail.gmail.com>
 <51537A7B.7050206@web.de>
 <CALkWK0nfNCu775MBB-Y28=V93RkV24kbTLTDKWO2dZ-0yxX=Sw@mail.gmail.com>
 <5154AACC.7050006@web.de>
 <CALkWK0k=g3iFjmpUQA1VkuH2kZsVX1_Hpo=LZ7CuotwHz_1++g@mail.gmail.com>
 <20130331225747.GB11704@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 02 20:04:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN5ZK-0006lB-Nz
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 20:04:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759934Ab3DBSD6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 14:03:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65103 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758787Ab3DBSD5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 14:03:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9FDA711829;
	Tue,  2 Apr 2013 18:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NF20ucxWwyfAuyx4CLlucnztExs=; b=wdupgJ
	IvtkCKl/3ic2T8AQAg6cGK6oU4Bob7swzDmGa8OZI2VQpybnY76PosPooox/Qfbc
	n0jAHyArz0EbDwfzOvQ40rSSi1+5vl8bQFLs/pEDvMTcA5AC/iBg/dw5VuquTv+P
	2IyrRUfjsHFDn6jSbh8in3irIO7I2XLhXXkkQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UfVK/XBB4lVybcWYcnMseOISM511OMmB
	4YpmHveLrXY/VxBmT5mEdBUHiFdbCaG1MPL5YJ7LkjvuRJx4SIkQjRJHpHSAMKXz
	cu94u0wnCyxdTfnGQu4Adv/6FC169RqwWcpWaF24NBqre8BXkIEi/mk6AsZug7wL
	Gr3eO5SBp1g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 97D8C11828;
	Tue,  2 Apr 2013 18:03:56 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 21A4811827; Tue,  2 Apr
 2013 18:03:56 +0000 (UTC)
In-Reply-To: <20130331225747.GB11704@elie.Belkin> (Jonathan Nieder's message
 of "Sun, 31 Mar 2013 15:57:48 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AF969972-9BBF-11E2-9F28-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219823>

Jonathan Nieder <jrnieder@gmail.com> writes:

> If you are curious, at a quieter time it might be useful to ask for
> pointers to the discussions that led to the current design, and folks
> on the list might be glad to help.

Not on the current design but the discussion before that round that
influenced the outcome greatly was this:

  http://thread.gmane.org/gmane.comp.version-control.git/14486/focus=14492

where we discussed a separate "gitlink" type of object.

And obviously this discussion is also a must read:

  http://thread.gmane.org/gmane.comp.version-control.git/44106

I vaguely recall asking (or seeing somebody ask) why Linus ended up
with using "commit in index" without introducing a separate gitlink
type, but I didn't find it.  IIRC, the answer was "it turned out
that we didn't need it" or something like that, which I tend to
agree.
