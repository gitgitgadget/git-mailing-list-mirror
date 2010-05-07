From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 0/3] Per-repository end-of-line normalization
Date: Fri, 07 May 2010 12:06:28 -0700
Message-ID: <7vzl0bfs5n.fsf@alter.siamese.dyndns.org>
References: <x2s40aa078e1005061340vaf404ab3g30b2b98ca408205@mail.gmail.com>
 <cover.1273183206.git.eyvind.bernhardsen@gmail.com>
 <7v4oijhdsi.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1005071007320.901@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	git@vger.kernel.org, hasan.aljudy@gmail.com,
	kusmabite@googlemail.com, prohaska@zib.de
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri May 07 21:07:11 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAStC-0004cL-CL
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 21:07:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757962Ab0EGTGr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 May 2010 15:06:47 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37660 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757799Ab0EGTGo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 May 2010 15:06:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 20C88B1BCA;
	Fri,  7 May 2010 15:06:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NmTn+LqkQzGFVYTe8M7QfHf7fwU=; b=RFiyyP
	1ZOzPqLGfIy7FaDX4rvDm9jKUzhEfN9pRmKgEeaSmaYUM+71eF0QBAcUlP1g4fnM
	tDudyFyhLvm0KarABuNKN2N+NAlXSO81R9jSp1r17M84UNWyZ30sSlvxodukf2Lv
	QnYexdewTbi14HcXbA3twxXh1DP/Hbz0VIBbo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gMJBerFjtc4j1Mwq1qNuJn5x66KxfoxT
	PTWnnUWCXVAjjJav6t+ci6mty8TR+gL6jQlmX/J6NUrunMDNlHEDozDkiF8RuSxE
	MyEkRyHlTAvKXuJiGhtBuGzKy+uvPRLTqWWcXzifP68Ov0HKZ57dqqkb1ngs3RpG
	W0N1fFMPdNM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AB1AAB1BC2;
	Fri,  7 May 2010 15:06:36 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A7BA4B1BB1; Fri,  7 May
 2010 15:06:29 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.00.1005071007320.901@i5.linux-foundation.org>
 (Linus Torvalds's message of "Fri\, 7 May 2010 10\:10\:09 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A8C02FF8-5A0B-11DF-B261-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146555>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Fri, 7 May 2010, Junio C Hamano wrote:
>
>> Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com> writes:
>> 
>> > - An attribute called "auto-eol" is set in the repository to turn on
>> >   normalization of line endings.  Since attributes are content, the
>> >   setting is copied when the repository is cloned and can be changed in
>> >   an existing repository (with a few caveats).  Setting this attribute
>> >   is equivalent to setting "core.autocrlf" to "input" or "true".
>> 
>> In what way is this attribute different from existing "crlf" attribute?
>
> The existing crlf attribute is a no-op _unless_ core.autocrlf is set, 
> isn't it?
>
> The whole point of Eyvind's series is to be able to set crlf attributes 
> without having to set the config option - because he wants to make sure 
> that a new clone always gets the proper crlf handling without users 
> having to do anything extra.
>
> And I do have to say that it makes sense.
>
> I also do think that maybe we could just change the existing crlf 
> attribute to work even without 'core.autocrlf'. 

Yes, that is exactly what I was alluding to.
