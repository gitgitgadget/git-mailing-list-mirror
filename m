From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Composing git repositories
Date: Thu, 04 Apr 2013 21:53:07 -0700
Message-ID: <7vwqshefyk.fsf@alter.siamese.dyndns.org>
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
 <7v7gkkern9.fsf@alter.siamese.dyndns.org>
 <7v7gkilry2.fsf@alter.siamese.dyndns.org>
 <CACsJy8C_dRqdPvAUW19zVLrJQGqFCRu_TaPMnRbkfgq+H9V2dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Git List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 05 06:53:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNyei-0005MI-AX
	for gcvg-git-2@plane.gmane.org; Fri, 05 Apr 2013 06:53:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752828Ab3DEExL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 00:53:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60054 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751500Ab3DEExK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 00:53:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DCCFB11DBD;
	Fri,  5 Apr 2013 04:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8dQs9pMZR5bqkrNHzpQIL25f+iM=; b=UPOeh+
	XDcv0DTbB98wymXic9+3ZV1h6j5e3QGwHl0NNZ9JAIKs/pMgSrfB/xEu+55qFBuf
	Jr6lIyWq71HpUXEYhdU8mnuuefqol+kD0vu8ycWEUfAsdjOUSzT8P0tCbhG4WhOa
	jc4mA3rIGUMyxK/f0uC3/atlflwD7K1lBWWow=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jPO22I92S8QfihUlRxybVrZ15V8D2hs/
	B2g6Mud1Omqu/Qz3nlfWj7NpgluYefe5Ao7q+g8HkoLYoum+f2qcus8EfQsHonQs
	awqvyxJvzXiKjaATel/GPTko0m4B8xgtRA/3EfNH6naeaaXfat6iOcC6rJHph5Pn
	wthUwXtFJU8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CDF8911DBC;
	Fri,  5 Apr 2013 04:53:09 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5230D11DBB; Fri,  5 Apr
 2013 04:53:09 +0000 (UTC)
In-Reply-To: <CACsJy8C_dRqdPvAUW19zVLrJQGqFCRu_TaPMnRbkfgq+H9V2dw@mail.gmail.com> (Duy
 Nguyen's message of "Fri, 5 Apr 2013 13:36:06 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B654C150-9DAC-11E2-BABC-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220140>

Duy Nguyen <pclouds@gmail.com> writes:

> Should someone add these links to the source code (maybe as a comment
> in submodule.c, or above the definition of S_IFGITLINK in cache.h)?

They were given in response to a request for reading material to
learn background. Most of the straw-man outlines raised in these old
discussoin threads are very different from what we ended up doing,
and their value is mostly to learn what kind of use cases should one
consider if one were designing subproject support from scratch, what
possible approaches were considered and what were found already
lacking in them before we even had a working prototype (in other
words, to learn where one should _not_ go).

Link themselves are not very useful and definitely not appropriate
as a comment next to S_IFGITLINK, as S_IFGITLINK is not the only
thing that implements the subproject support, and not all the ideals
dreamed in these threads are realized with the implementation (yet).

> A brief summary or outcome from these links in the comment would
> be nice.

A summary of what to consider in Documentation/technical/ somewhere
may be a very welcome addition.  Thanks for volunteering ;-).
