From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 07/10] builtin/replace: teach listing using short, medium or full formats
Date: Thu, 26 Dec 2013 11:10:38 -0800
Message-ID: <xmqqppojctsh.fsf@gitster.dls.corp.google.com>
References: <20131211074147.11117.1155.chriscool@tuxfamily.org>
	<20131211074614.11117.96106.chriscool@tuxfamily.org>
	<52B196F1.3060003@gmail.com>
	<CAP8UFD3UsdcDg2D2nysMZgGAxLebYm-qQX3LZfqdwF9gNbyxgA@mail.gmail.com>
	<xmqqioumjc1n.fsf@gitster.dls.corp.google.com>
	<CAP8UFD1+kydjrjhTxKDSMmOa+KiOYgMGK5gyxCe-LPih02=VYQ@mail.gmail.com>
	<xmqqbo0cfz1x.fsf@gitster.dls.corp.google.com>
	<CAP8UFD1hdNE__+bVtKegChBT4u3Rx7NEzBYYkdEmUwfFLLpkzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Karsten Blees <karsten.blees@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Joey Hess <joey@kitenet.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 26 20:11:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VwGKk-0006jh-F5
	for gcvg-git-2@plane.gmane.org; Thu, 26 Dec 2013 20:11:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753639Ab3LZTKn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Dec 2013 14:10:43 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58186 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753572Ab3LZTKl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Dec 2013 14:10:41 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7E4365A72C;
	Thu, 26 Dec 2013 14:10:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7vfJEceJVEu8SLFYxjwQKfa0Vtc=; b=BXlV//
	I1y+inTvfxwAyNn1920Ls5KjzEQCskG/3N9vtnsVaej6Vktp9JMt+NZI3ZWYMW2K
	ZzBPHJMLx11z7b05K1DXa2ULTUtpZtue2EhrrXRUzNhMRPOAomrn0ZUByJSTum29
	ZB5wia7mpdZ9RFXmoPNj3GlaotZRbKJjF9lDE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YN+RHoWSI8uru/qM0eKSDv2LBBvwJY2M
	5mOSfoim5RCWndGwltDVN9uv7Pwu+KD1wd5nA9+JCYPLxpDM7EyIVPQwopjm39zS
	FWreprf1Nl7OY7rGgBxvGbe7M1j8QeyqSARuAABD65BKf6cJHjM9dc72yPSE8miF
	9McTMsbfgkU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 70FEF5A72B;
	Thu, 26 Dec 2013 14:10:41 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BCE7B5A728;
	Thu, 26 Dec 2013 14:10:40 -0500 (EST)
In-Reply-To: <CAP8UFD1hdNE__+bVtKegChBT4u3Rx7NEzBYYkdEmUwfFLLpkzg@mail.gmail.com>
	(Christian Couder's message of "Sat, 21 Dec 2013 10:34:06 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6949CDF2-6E61-11E3-BD53-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239706>

Christian Couder <christian.couder@gmail.com> writes:

> On Thu, Dec 19, 2013 at 7:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Christian Couder <christian.couder@gmail.com> writes:
>>
>>> I think this last one might be useful for people replacing objects
>>> with objects that have another type.
>>
>> ... which IIUC is strongly discouraged---didn't you have to tighten
>> it recently?
>>
>> And that makes it "useful primarily for debugging" unusual
>> situations.
>
> Ok, so would you prefer the following:
>
> - NAME_ONLY_REPLACE_FMT and "--format=name_only" instead of
> SHORT_REPLACE_FMT and "--format=short"
>
> - NAME_AND_VALUE_REPLACE_FMT and "--format=name_and_value" instead of
> MEDIUM_REPLACE_FMT and "--format=medium"
>
> - DEBUG_REPLACE_FMT and "--format=debug" instead of FULL _REPLACE_FMT
> and "--format=full"

The end-user facing names are probably fine with short, medium,
full, as long as what they show are clearly explained in the
end-user documentation (patch 10/10 covers this).

I have a hunch that we may later regret "full" when somebody wants
to add even fuller information, though. It might be better spelled
"long" instead;

I'd rather see REPLACE_FMT_ as a prefix, not suffix.  Do we use
common suffix for enum values elsewhere?
