From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Dec 2012, #03; Wed, 12)
Date: Thu, 13 Dec 2012 15:42:19 -0800
Message-ID: <7vsj79wmck.fsf@alter.siamese.dyndns.org>
References: <7vhanq257s.fsf@alter.siamese.dyndns.org>
 <CAMP44s2DAuhk5FkDm0-cYsikY0o6vuZ4FyAnXhbtsgqKQF1dpg@mail.gmail.com>
 <7vvcc6z801.fsf@alter.siamese.dyndns.org>
 <CAMP44s3uyC0V6ycTv78mG36_i7ugMLwwNk2cqNZatEJuL7Ee1w@mail.gmail.com>
 <7vmwxhycii.fsf@alter.siamese.dyndns.org>
 <CAMP44s0qK6yNiPe0ERDJWK-wfm3DdXZYwRzisoCPJ7PjsdkObQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 14 00:42:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjIQL-0007xa-Hw
	for gcvg-git-2@plane.gmane.org; Fri, 14 Dec 2012 00:42:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753674Ab2LMXmX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2012 18:42:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50770 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753028Ab2LMXmW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2012 18:42:22 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EE1A4AFFF;
	Thu, 13 Dec 2012 18:42:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QZVZVe21WrN6tHDQOzNgHYIU3yA=; b=Dio4Bx
	8iwMM5D6PU5CaCl2wdM2uujUBmKVeI+iP8wImiKsAN+fq9ae2Sh4HsiDRrACS83O
	qxi5eZZF9c1y5FU8DcCuBJWnmPUxIRHqn2wtRJBw/pdVWKfOQ1ghI6hfAdDAHzBQ
	/RNV6BtVYRd1mfg64GkESgKiViSbobtlf30Ec=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uj/4ZPgN8wgmjfQaaAg/0wYMw0RBJkQU
	q6H7Qs5mQdZb3hQOOH6aqN1I7dMg6UO+A2y7tVqJ1rFeI9Kt71jfDQwlJNHZb5jc
	8xIq3Rey2MIbGavDwly3d3vUvgrkNihg70W343Fv0X0i8bCmiCrJ1OJNg+GZAFhM
	wSIDvo+xljQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DB287AFFE;
	Thu, 13 Dec 2012 18:42:21 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 34CF4AFFD; Thu, 13 Dec 2012
 18:42:21 -0500 (EST)
In-Reply-To: <CAMP44s0qK6yNiPe0ERDJWK-wfm3DdXZYwRzisoCPJ7PjsdkObQ@mail.gmail.com> (Felipe
 Contreras's message of "Thu, 13 Dec 2012 16:05:08 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BCEAD5EE-457E-11E2-AF9E-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211477>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Thu, Dec 13, 2012 at 1:31 PM, Junio C Hamano <gitster@pobox.com> wrote:
> ...
>> One of the review points were about this piece in the test:
>>
>>     > +cmd=<<EOF
>>     > +import bzrlib
>>     > +bzrlib.initialize()
>>     > +import bzrlib.plugin
>>     > +bzrlib.plugin.load_plugins()
>>     > +import bzrlib.plugins.fastimport
>>     > +EOF
>>     > +if ! "$PYTHON_PATH" -c "$cmd"; then
>>
>>     I cannot see how this could have ever worked.
>>
>> And I still don't see how your "would work just fine" can be true.
>
> As I have explained, all this code is the equivalent of python -c '',
> or rather, it's a no-op. It works in the sense that it doesn't break
> anything.

Aren't you ashamed of yourself after having said this?

> The purpose of the code is to check for the fastimport plug-in, but
> that plug-in is not used any more, it's vestigial code, it doesn't
> matter if the check works or not, as long as it doesn't fail.

If so, the final version that is suitable for merging would have
that unused code stripped away, no?

>> But it is totally a different matter to merge a crap with known
>> breakage that is one easy fix away from the get-go.  Allowing that
>> means that all the times we spend on reviewing patches here go
>> wasted, discouraging reviewers.
>
> There is no breakage.

Unused code that burdens others to read through to make sure nothing
is broken is already broken from maintenance point of view.

Why are you wasting my time and everybody's bandwidth on this, when
you are very well capable of rerolling the series with removal and
style fixes in far shorter time?
