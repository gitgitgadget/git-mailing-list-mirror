From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] clone: forbid --bare --separate-git-dir <dir>
Date: Sun, 06 Jan 2013 18:04:28 -0800
Message-ID: <7vpq1hlpeb.fsf@alter.siamese.dyndns.org>
References: <20130106091642.GA10956@elie.Belkin>
 <1357465670-32766-1-git-send-email-pclouds@gmail.com>
 <20130106101948.GD10956@elie.Belkin>
 <7v6239nbw0.fsf@alter.siamese.dyndns.org>
 <CACsJy8A6soMEJ3FXY8MyeERAGN483M2UjqRS4muzzD6uj1QWow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Manlio Perillo <manlio.perillo@gmail.com>,
	"W. Trevor King" <wking@drexel.edu>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 07 03:04:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ts256-0007GB-3Z
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jan 2013 03:04:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753391Ab3AGCEd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 21:04:33 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53588 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753269Ab3AGCEc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 21:04:32 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2BC87A53E;
	Sun,  6 Jan 2013 21:04:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+4yYis7/EZ2R+ZqQ27GJmNpeOjw=; b=jC+fGh
	eT4aQVsO5UkzkwmScPuzYzKjTmIwfX4LjP5DW1dGjQgnIym9w2N1rjg1/QCvQuoG
	0uUhoXMPnATKW0b8lDyeXAdPnFvtdkqhb65kHMuEQv9PzdP9aFqbAIymGzUmku1h
	TkW4ly4QnigtUQd6wVzfKpuMZD1QOx+kgL3tk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Li0WkNIWCXlgOx+fOfEQC8qiW4MRQb8c
	fKrEY9ohzw0EljwhoYEkyyQurWiIPgcy+TiiQpzGSFP64k3N2paznTBluBLK+tZi
	l74DqjFKuLh0YMAz4TqnZ6JzTaOSK2KHp4LUC9HF+d3XO+JS54mO6rH9Px+7LyK3
	OiPqZNYwBUc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D20BA53D;
	Sun,  6 Jan 2013 21:04:31 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 68050A53C; Sun,  6 Jan 2013
 21:04:30 -0500 (EST)
In-Reply-To: <CACsJy8A6soMEJ3FXY8MyeERAGN483M2UjqRS4muzzD6uj1QWow@mail.gmail.com> (Duy
 Nguyen's message of "Mon, 7 Jan 2013 08:18:43 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 92AEBCF2-586E-11E2-949F-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212867>

Duy Nguyen <pclouds@gmail.com> writes:

> On Mon, Jan 7, 2013 at 6:13 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> I don't know what would go in the <explanation here> blank above,
>>> though.  Is it possible that some people are relying on this option
>>> combination?
>>
>> I do not necessarily think we must say "it happens not to work
>> already for such and such reasons, lucky us!", but it is indeed a
>> good idea to think things through, justifying why this cannot be a
>> regression, and record the fact that we did that thinking, in the
>> log message.
>>
>> Thanks.
>
> I wanted to give a day or two or think about the <explanation here>.
> Does "Thanks." mean you have picked up the patch and adjusted the
> commit message appropriately, or should I go with my original plan and
> resend it later with "explanantion there"?

The latter, "Thanks for a review".  I may have picked it up in 'pu',
but that merely means, as usual, that I wanted to add a reminder in
What's cooking to expect a reroll, and nothing more.

Thanks.
