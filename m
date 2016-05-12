From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: clarify signature verification v2
Date: Thu, 12 May 2016 09:38:59 -0700
Message-ID: <xmqq4ma3grj0.fsf@gitster.mtv.corp.google.com>
References: <20160512065022.GA32387@hashbang.sh>
	<CAFZEwPOJg=njvhtK7ZQf_-3DUVjMpFBEV_0m1NHAE1UL7eM5ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Fox in the shell <KellerFuchs@hashbang.sh>,
	Git List <git@vger.kernel.org>,
	"Michael J. Gruber" <git@drmicha.warpmail.net>,
	"Brian M. Carlson" <sandals@crustytoothpaste.ath.cx>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 12 18:39:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0tdm-0000eo-QA
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 18:39:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752667AbcELQjG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 12:39:06 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54481 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752361AbcELQjE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 12:39:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BD2291A818;
	Thu, 12 May 2016 12:39:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=svsl1d6MS8J22OLClAO2pE9hruA=; b=O0GGqj
	oBhn3xG6RMZHOWVl9lU3IIkp1oFxqHc9K7Ukf0c5Q4GW8dgbGIYV0KZAeg9vL6rw
	YO+UQ6VekxPSCiXFJUXLgBiw4zV39Q+Xq52insXkpxtEXh2qWeXtM0OOdAs6JQmP
	96dreH/fVqTZFlDHsYQRdE5jd0ENYt3vuRCe0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=J5o6ZLm4FYBhir7b8hg2Li5LU4AgbW9i
	wTdnqo+XhOptqfD7atiINhKKhJ7/yA2d6ipsf7Hfw58W/i7TfHHW12G+/4xdUFmU
	8/cYfXGv18AlUF6FLzyE8yiSAKrQZ7+LFveEErF1dFpxCbRRV6EImwSoslhm52WB
	5tyhXz09dDg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B29C71A817;
	Thu, 12 May 2016 12:39:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2A7541A816;
	Thu, 12 May 2016 12:39:02 -0400 (EDT)
In-Reply-To: <CAFZEwPOJg=njvhtK7ZQf_-3DUVjMpFBEV_0m1NHAE1UL7eM5ng@mail.gmail.com>
	(Pranit Bauva's message of "Thu, 12 May 2016 13:34:36 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 089E5328-1860-11E6-8597-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294418>

Pranit Bauva <pranit.bauva@gmail.com> writes:

> Seems like Junio was waiting for someone to point this out[2].

Thanks. I think you covered most of them correctly; I only have one
thing to add.

>  * Comments are put after ---. So your paragraph
>       "Clarify which commits need to be signed.
>
>         Uniformise the vocabulary used wrt. key/signature validity with OpenPGP
>          - a signature is valid if made by a key with a valid uid;
>          - in the default trust-model, a uid is valid if signed by a
> trusted key;
>          - a key is trusted if the (local) user set a trust level for it.
>
>            Thanks to Junio C Hamano <gitster@pobox.com> for reviewing
>            the first attempt at this patch."
>
>     is actually treated as a comment.

This is half-true, I think. The message you are responding to had
only two dashes, not three.

The usual way to do what the original wanted to do is like this:

	... e-mail headers like From:, Subject:, ...

	Hi,

        Here is a second attempt.

        -- >8 --
        Subject: Documentation: clarify --verify signature

	Clarify that only the signature of the commit at the tip of
	the branch being merged is checked.  Also align the
	vocabulary to describe key & signature validity with those
	used by OpenPGP, namely:

         - a signature is valid if ...
         ...
         - a key is trusted if ...

	Signed-off-by: A U Thor <au@thor.xz>
        ---
         Documentation/merge-options.txt | ... diffstat comes here
        
Notice the "-- >8 --" (cut here) line.  "am" will notice it, discard
what it has read so far and restart from there.
