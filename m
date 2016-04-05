From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 4/4] pretty: test --expand-tabs
Date: Mon, 04 Apr 2016 23:25:24 -0700
Message-ID: <xmqqfuv04lnv.fsf@gitster.mtv.corp.google.com>
References: <1459293309-25195-1-git-send-email-gitster@pobox.com>
	<1459817917-32078-1-git-send-email-gitster@pobox.com>
	<1459817917-32078-5-git-send-email-gitster@pobox.com>
	<CAPig+cSTp6R0XNwNAU=QhKOTqB4=uSuPd_mnwfvy6wHs8X7FRg@mail.gmail.com>
	<20160405014703.GA29953@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 05 08:25:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anKQe-0004r6-DC
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 08:25:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754636AbcDEGZ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2016 02:25:28 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:54646 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752172AbcDEGZ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2016 02:25:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9D65B4B1F5;
	Tue,  5 Apr 2016 02:25:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MM8SAMlckpD7pArVQwz4hXYf9kg=; b=fA0ua/
	8cozB6SEZHvuZHWYVdtnc9YOFjP5Yp2W5k1bT7/T2YjKqe4aOaT3xEIl7pXoEky0
	TkvdIgvfh0NG/gPPOTngNEA2QeFWLp+LFBWQuMQeexjdvO1uU8NmKZBYyJYtekhN
	bNYHumpKSgdIfAfj9+OWPdzNXPm5LzDNoYFJc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RiFdPp3bNXLA4rmfNql0xISV5/pe2eYr
	4kRrLj/VoTam9GO3aBr2vdjX5Am9ulbo/YqNFhCU3JyEab9Y2LLgFwBbhH2b0IPo
	bNQfkfU31okq5QA7b2vciUqHmqYuR2+7lmlwL+u0VXoBgX3xjrzcWstUKdgX76XB
	2D1hO4Z2IXg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 85C754B1F4;
	Tue,  5 Apr 2016 02:25:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 00C7A4B1F3;
	Tue,  5 Apr 2016 02:25:25 -0400 (EDT)
In-Reply-To: <20160405014703.GA29953@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 4 Apr 2016 21:47:03 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2F2FBB70-FAF7-11E5-8B83-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290762>

Jeff King <peff@peff.net> writes:

> On Mon, Apr 04, 2016 at 09:10:46PM -0400, Eric Sunshine wrote:
>
>> > +       count=$1 ;# expected tabs
>> 
>> Why semicolon before the hash here and above?
>
> I am in the habit of doing this, too. I have a vague recollection of
> getting bitten by a shell that treated:
>
>   echo foo # bar
>
> or something similar as not-a-comment. But neither bash, dash, nor ksh
> seem to.

I think the reason why I started doing the same is because some
shells can be configured to lose the comment-introducer-ness of "#"
in interactive mode, and I wanted to make sure that many things I
write can be tried out by others more easily by copy-and-paste to
their interactive session.
