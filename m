From: Junio C Hamano <gitster@pobox.com>
Subject: Re: weird diff output?
Date: Tue, 29 Mar 2016 17:04:54 -0700
Message-ID: <xmqqbn5wvnix.fsf@gitster.mtv.corp.google.com>
References: <CA+P7+xoiFUiBwDU2Wo9nVukchBvJSknON2XN572b6rSHnOSWaQ@mail.gmail.com>
	<CAGZ79ka4ad5dQMWANJUDx-0+kV3qR=HttOJni2XfhFzjMKfcPw@mail.gmail.com>
	<xmqqzithxj8l.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZiiOgxh6vMDnaJ_b+VVGrFBfGzZukTN6OEBxUV9-2vQw@mail.gmail.com>
	<CA+P7+xoLZhKzHf6khQfT_pZ2=CQAp8Nmhc9B8+10+9=YYUZH3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Git mailing list <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 02:05:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al3d8-0008Rz-As
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 02:05:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757847AbcC3AE6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 20:04:58 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:57697 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752438AbcC3AE5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 20:04:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7F78651948;
	Tue, 29 Mar 2016 20:04:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8uAuRlUwpfYJm1hsL/MyJrbg4r8=; b=WgGCIB
	PNweT3F5qtqRFB3ZVX3lNd6fYEZu4nQdm1kDvnYB8HmdnRd9JaSlYBNSiv3lU2xO
	rfpz/qIHNz+aV/4GQKOljgViqLoefMgONSLpSGjAK/jetWHDKeW5mzsxfw7sB2zi
	AC8hJVrL7Kg/bVDfTyXHyb/XV3IMHIF9AspSY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GeelpsWYj/OTQmAz0Uwg65dAv3BXAHku
	EyGpu2GBovzj2mFTB8TW05zivzBlRsSXLOAnug85sezZYEw735Kg2XRFxmZNNKXs
	PoFjoD9q+EJSREg0Jk/ac0qkDLZQpDiG8ZycKn6rV4CR1j4jajs4Djbxc2RF0M97
	IucNQZ9w2Bw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 76F5351947;
	Tue, 29 Mar 2016 20:04:56 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id EE8CB51945;
	Tue, 29 Mar 2016 20:04:55 -0400 (EDT)
In-Reply-To: <CA+P7+xoLZhKzHf6khQfT_pZ2=CQAp8Nmhc9B8+10+9=YYUZH3w@mail.gmail.com>
	(Jacob Keller's message of "Tue, 29 Mar 2016 16:05:57 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 08F3B506-F60B-11E5-BB49-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290230>

Jacob Keller <jacob.keller@gmail.com> writes:

> On Tue, Mar 29, 2016 at 11:16 AM, Stefan Beller <sbeller@google.com> wrote:
>> ...
>> To find a heuristic, which appeals both the C code
>> and the shell code, we could take the empty line
>> as a strong hint for the divider:
>
> This seems like a good heuristic. Can we think of any examples where
> it would produce wildly confusing diffs? I don't think it necessarily
> needs to be default but just a possible option when formatting diffs,
> much like we already have today.

I earlier said "50% of the time it is correct, you just do not
remember", but such an option with configuration variable would let
somebody interested set it permanently for his daily use of Git, and
it would help him to find out (1) if he sees a "Huh?" division less
(or more) often than he used to, and (2) if it gives a better
division for the same change to view the diff with the plain-vanilla
heuristic.
