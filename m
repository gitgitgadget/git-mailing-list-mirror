From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] safe_create_leading_directories(): on Windows, \ can separate path components
Date: Tue, 21 Jan 2014 11:35:27 -0800
Message-ID: <xmqqmwipuo00.fsf@gitster.dls.corp.google.com>
References: <1390088444-11439-1-git-send-email-mhagger@alum.mit.edu>
	<CAHGBnuMmutYqwZNw+VoZi=R_LaS_fowZrqaU2+JMYN53q6XQ2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 21 20:35:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5h6p-0002dO-E0
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jan 2014 20:35:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752031AbaAUTff (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jan 2014 14:35:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57422 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751408AbaAUTfe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jan 2014 14:35:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD59864AA8;
	Tue, 21 Jan 2014 14:35:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=R49hxekIk4ZVQNTYhycFPqmOrD0=; b=ib2eK3
	msAAym4Ek3iEdpX+1/7Bqzto5TMfetK0p3V7k7crx5Xs7/kEiLPrmr6dDZsRQGcF
	vhPVsMCXrXkR6oJZnPG1OZPZC02DSfTY6kmmULsyzJBaeD5G2EkO8I8ExelUWfLe
	nRIxlower39QU4ea8jxbrj/6QboTMKZUsvoNw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HEo6lzccoxabByg/IyfilkpAr/Pm2WUF
	STQrMe+bLtbsdpF7ggrDlxvhf8AQ7gQGjJCyauZfu/rIB/OAtWaPBFtBJKKnD5lM
	WuPZE7pJ8YNKORjm/XGpcqoketF7RWdwDe12H98EGzpoxaOgdudynWUY3JWSMOYb
	iWenoCNekC0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 61D8C64AA7;
	Tue, 21 Jan 2014 14:35:33 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A22DD64AA6;
	Tue, 21 Jan 2014 14:35:31 -0500 (EST)
In-Reply-To: <CAHGBnuMmutYqwZNw+VoZi=R_LaS_fowZrqaU2+JMYN53q6XQ2Q@mail.gmail.com>
	(Sebastian Schuberth's message of "Sun, 19 Jan 2014 21:26:38 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 30A0CBAA-82D3-11E3-91D0-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240766>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> On Sun, Jan 19, 2014 at 12:40 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>
>> This patch applies on top of v3 of mh/safe-create-leading-directories.
>>
>> The only logical change from Sebastian's patch is that this version
>> restores the original slash character rather than always restoring it
>> to '/' (as suggested by Junio).
>
> Thanks Michael. This is very similar to Junio's current merge conflict
> resultion in pu between your original series and my patch (c2fec83). I
> like this patch of yours slightly better, however, as it uses a
> "while" instead of a "for" loop and the more conclusive
> "slash_character" than the "was_slash" variable name.

Yeah, I agree this patch that uses more descriptive names is a much
more desirable end-result than the tentative merge in 'pu'.
