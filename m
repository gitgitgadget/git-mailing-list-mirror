From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git: submodule honor -c credential.* from command line
Date: Wed, 24 Feb 2016 16:43:43 -0800
Message-ID: <xmqqfuwhr54w.fsf@gitster.mtv.corp.google.com>
References: <1456344559-2822-1-git-send-email-jacob.e.keller@intel.com>
	<CAGZ79kbSd4TRdgdcj2NUrc+pL7ATrGQNcfTYd57TuJtyZ5QBwg@mail.gmail.com>
	<xmqq1t81smu6.fsf@gitster.mtv.corp.google.com>
	<CA+P7+xrJkOaqfOBOK7oh1w97dEJytyPN5UbH6ctK+saGUSkZiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Mark Strapetz <marc.strapetz@syntevo.com>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 01:43:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYk2A-0001gh-9u
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 01:43:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758501AbcBYAns (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 19:43:48 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54799 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753293AbcBYAnq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 19:43:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9209548BC0;
	Wed, 24 Feb 2016 19:43:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+1h82HwyW9UzuBpbmOkZqElASY4=; b=IxytbZ
	J1EEtZ2q31oMgDnsO+qVObHc1frOedtT04I7k3eFNQ4Pg6eqigiNbYQ7EVs3RzGC
	GXIz1kRmRS9NJ0khZ97izoXpCnNLrRQt2xgnuGpU6oe/6SmoYoaD/9xnOlK59XIX
	EyvIH+p1mwyOwWklfEA31bio7HyJuwoou3Tyo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vpFzIAyDRmtP81s8D0+C6fMI/hOoNzCV
	7NFNdiFUG48IuvBjCxkKjCHN/rpjxGn2M56IluvlVjefiUoCMWD9L4A8IQ9sOcGC
	ogJtpop0m9zc2aI3HJFrfh3U6g8BokYuY+AwyxPGxwWOi+bsDujsNdzkIgRuVURf
	ERCkhjxwhCA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8899F48BBF;
	Wed, 24 Feb 2016 19:43:45 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id F40BE48BBE;
	Wed, 24 Feb 2016 19:43:44 -0500 (EST)
In-Reply-To: <CA+P7+xrJkOaqfOBOK7oh1w97dEJytyPN5UbH6ctK+saGUSkZiw@mail.gmail.com>
	(Jacob Keller's message of "Wed, 24 Feb 2016 15:51:01 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D3224856-DB58-11E5-BCFB-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287295>

Jacob Keller <jacob.keller@gmail.com> writes:

>>>> Add a git submodule--helper function which can be used to sanitize the
>>>> GIT_CONFIG_PARAMETERS value to only allow certain settings. For now,
>>>> restrict this to only credential.* settings.
>>>
>>> I guess for now that subset is fine and will be expanded over time?
>>
>> I think it is more like "we pass only what is known to be necessary
>> and safe, and right now, credential.* are the only such variables."
>>
>> As the system evolves more, theoretically we might find more, but
>> let's not phrase it as if expanding is a good thing and a longer
>> term goal.
>>
>
> I can reword the commit message to that effect.

I think what you wrote was perfectly fine.
