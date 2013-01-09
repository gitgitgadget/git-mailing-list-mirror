From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Enabling scissors by default?
Date: Wed, 09 Jan 2013 09:40:26 -0800
Message-ID: <7vk3rm6yr9.fsf@alter.siamese.dyndns.org>
References: <50EC92C6.7090509@ubuntu.com>
 <7vvcb7b8lc.fsf@alter.siamese.dyndns.org> <50ECAAE2.2020507@ubuntu.com>
 <7vr4lvb63a.fsf@alter.siamese.dyndns.org>
 <20130109171011.GB5332@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Phillip Susi <psusi@ubuntu.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 09 18:40:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tszdz-00056R-D2
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 18:40:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758044Ab3AIRkb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 12:40:31 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52160 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758026Ab3AIRkb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2013 12:40:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 54450A66C;
	Wed,  9 Jan 2013 12:40:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ny9PyQ/XX04g8aL8jBkKO7TePUE=; b=aiVqlg
	y9skNC+6EXXyO4ZwOZzpI7DJVPr9qk5yTNq7ttLfl0QSzKiNLMUEgAkLyIBc+tEK
	G/WovT+q6NjRfSI9L9loGujTQhbxW9Je1P/UsdVVZl6klFArAiTHXaTeoHKtpi+J
	f329c8FiJ+4lrvLcLmVs+Rcaf80gT8KXOTM7c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DC9hxRgTa/oIgBlZsvH9ZvI99kimrYJy
	3FL5lpKRSlZFoLlS8WeeN0dRtOflaGevbANNCzTRUPMpCae4uf61xCzVrp3OZNso
	+oLiMszwxIiKkBteiEUGcJevabZ3l65byqDxmx5RK0DchysmQ7tE7xooscL+RxeP
	umVq5+IrttQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 484DEA66B;
	Wed,  9 Jan 2013 12:40:28 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A00A2A666; Wed,  9 Jan 2013
 12:40:27 -0500 (EST)
In-Reply-To: <20130109171011.GB5332@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 9 Jan 2013 12:10:11 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A7C7A6B4-5A83-11E2-828E-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213072>

Jeff King <peff@peff.net> writes:

> On Tue, Jan 08, 2013 at 03:36:09PM -0800, Junio C Hamano wrote:
>
>> You could introduce a new configuration variable "am.scissors" and
>> personally turn it on, though.  Setting that variable *does* count
>> as the user explicitly asking for it.
>
> I think we have mailinfo.scissors already.

Oh, spoiler.  I was hoping that I could entice new people into doing
a little digging on their own X-<.


>> > I often see patches being tweaked in response to feedback and
>> > resubmitted, usually with a description of what has changed since the
>> > previous version.  Such descriptions don't need to be in the change
>> > log when it is finally applied and seem a perfect use of scissors.
>> 
>> Putting such small logs under "---" line is the accepted practice.
>
> Maybe it is just me, but I find the scissors form more readable, because
> the "cover letter" material often serves to introduce and give context
> to the patch (e.g., "Thanks for your feedback. I've tried to do X, and
> it came out well. Here's the patch." serves as an introduction, and
> logically comes before the commit message itself).
>
> That does not say anything one way or another about how dangerous or not
> it might be to enable scissors by default. Just my two cents that I like
> the scissors style for patches that come as part of a discussion (and I
> prefer the "---" style when making comments on the contents of a patch;
> i.e., when the comments make more sense to be read after reading the
> commit message to understand what the patch does).

Yes, scissors have their uses, namely when presenting a patch in a
discussion context.  Otherwise we wouldn't have introduced it in the
first place.

But the "desription of what has changed since the previous version"
use case I was responding to is where the space below "---" is meant
to be used from very early days of Git (the convention established
on the kernel list).
