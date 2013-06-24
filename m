From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 3/4] git-mw: Adding git-mw.perl script
Date: Mon, 24 Jun 2013 10:23:48 -0700
Message-ID: <7vsj07a0d7.fsf@alter.siamese.dyndns.org>
References: <1371118039-18925-1-git-send-email-benoit.person@ensimag.fr>
	<1371118039-18925-4-git-send-email-benoit.person@ensimag.fr>
	<vpqsj07vb3m.fsf@anie.imag.fr>
	<7vfvw7bh0u.fsf@alter.siamese.dyndns.org>
	<vpqy59zsb0u.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: benoit.person@ensimag.fr, git@vger.kernel.org,
	Celestin Matte <celestin.matte@ensimag.fr>,
	Jeff King <peff@peff.net>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 24 19:23:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrAUe-0001Uz-7a
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 19:23:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253Ab3FXRXw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 13:23:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43077 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750900Ab3FXRXv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 13:23:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 415F22B82F;
	Mon, 24 Jun 2013 17:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VvP2cHOnlVFLc49B5lP86Emwvnc=; b=mKmC/A
	+aKBp5NF5mMUOqu/R1FdMV4tHa8ORtT7zOZSlcHEC31HXvq4j+JgOMgu11Az1rmF
	EKVrTiPU1YP9PLjxxRSfBedi8ukJcrxft1xKY4zsM6yJ5zKJyFjOHmEzsHs3Ay64
	VISamwMHgd/dx0hlzfUH35HdlP2hy2BHbD3r8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JgYcGxYAcdaUUsvuM+dEMQlxvlIapyM9
	mll8fulTeZ9do39UX4kXP9HcWUcOjeWhlE1MAR1PFFCUdpDhY1GSYmWfHqtdcSj5
	VooQ+2PX1y+W60a91Q9x/OUWdEMR9mdGxA884wxYKvYlV7wziMg78/cVidJ+h/Ro
	Eg391YFvzFo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 295C42B82E;
	Mon, 24 Jun 2013 17:23:51 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 81CE82B82C;
	Mon, 24 Jun 2013 17:23:50 +0000 (UTC)
In-Reply-To: <vpqy59zsb0u.fsf@anie.imag.fr> (Matthieu Moy's message of "Mon,
	24 Jun 2013 18:56:17 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D6058108-DCF2-11E2-9EE5-9B86C9BC06FA-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228881>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>>
>>> benoit.person@ensimag.fr writes:
>>>
>>>> diff --git a/contrib/mw-to-git/git-mw.perl b/contrib/mw-to-git/git-mw.perl
>>>> new file mode 100644
>>>> index 0000000..a2f0aa1
>>>> --- /dev/null
>>>> +++ b/contrib/mw-to-git/git-mw.perl
>>>
>>> *.perl scripts are usually executable in Git's tree (although it's
>>> usually better to run the non-*.perl version).
>>
>> Good eyes.  But if we encourage people to run non-*.perl version,
>> perhaps we should drop the executable bit from the source, no?
>
> But by default, I'd say consistency is most important so if other *.perl
> are executable, we should do the same.

Ah, I should have been more clear.  I meant "perhaps we should drop
executable bits from existing *.perl source files."

> But it may make sense to change the convention, i.e. run a "chmod -x
> *.perl" in Git's tree (in any case, people can still run "perl
> foo.perl").

Yes, that is exactly what I meant.
