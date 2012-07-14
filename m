From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Support of '^' as alias for 'HEAD^'
Date: Sat, 14 Jul 2012 13:34:19 -0700
Message-ID: <7vr4se5bg4.fsf@alter.siamese.dyndns.org>
References: <CAAa3hFMgy66W0dVEGv164Zowfa6Q-5DqgkkLz_1paymU_1SHUw@mail.gmail.com>
 <loom.20120714T114718-783@post.gmane.org>
 <7vzk725c86.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	"Zeeshan Ali \(Khattak\)" <zeeshanak@gnome.org>
To: Stefan =?utf-8?Q?N=C3=A4we?= <stefan.naewe@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 14 22:34:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sq93H-0004sd-6v
	for gcvg-git-2@plane.gmane.org; Sat, 14 Jul 2012 22:34:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752906Ab2GNUeb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Jul 2012 16:34:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63278 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752821Ab2GNUeW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Jul 2012 16:34:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F363C70D1;
	Sat, 14 Jul 2012 16:34:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=L4cHclfStKOe
	E8s+uhRdbgrhNqE=; b=EZ0DxNAvZx4FbDY4cYZPE0Vb+gbW+Xn6o9YsZPTyhDS+
	B19DUPOzHXU6mbkoIZfKHFvZcmz1WcWHJjOd5G101O8j+ILjk98mAE8fxWIuVhaQ
	0ZviemCg6u4Er1HDKpGGt3sTzME4AEN8PCGZGLr42Cn1UcABPhl7zEhyara3IsQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=I+gJ/y
	tl8zyA0KUCjI36Q454z7dmd6lIEpaLb0gUqpAb/oKFGGeGIcfycrj5p9YKti7XUV
	SEH/Z3Uf1MTLu9o71eC1IeYqIY1VR9KFkBVC2VmHBMyWgjwehdbVh0qLpTQ9JZX+
	T1XPBgCd3Zc7+f7vm2QnIsdRnJO7XAnAPMEbI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DF4F770D0;
	Sat, 14 Jul 2012 16:34:21 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4A08770CF; Sat, 14 Jul 2012
 16:34:21 -0400 (EDT)
In-Reply-To: <7vzk725c86.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat, 14 Jul 2012 13:17:29 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4AC6AF18-CDF3-11E1-944F-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201454>

Junio C Hamano <gitster@pobox.com> writes:

> Stefan N=C3=A4we <stefan.naewe@gmail.com> writes:
>
>> Zeeshan Ali (Khattak <zeeshanak <at> gnome.org> writes:
>>>=20
>>> Many times I want to refer to 'HEAD^', 'HEAD^^' and sometimes even
>>> further up the tree. It would be really nice if I didn't have to ty=
pe
>>> 'HEAD^' but could only type '^'. Bash completion make things easier
>>> but it automatically inserts a space immediately after HEAD so you
>>> have to hit backspace. I think this change would be good in general
>>> anyway.
>>
>> Or even '~1', '~3'.
>
> "^" has a problem when used with other things (does "log ^^2
> origin" mean "log HEAD^2..origin"?  Or "log HEAD^^2 origin"), so I
> do not think it would never fly as an abbreviated syntax.
>
> While I see your "~<N>" much distasteful compared to "^", you still

s/dist/less dist/; sorry ;-)

> need to be a bit more careful when analysing the benefit of such an
> abbreviation.  To shells used by many people, these mean tilde
> expansion ~<N> to refer to elements on the dirstack and you need to
> quote, perhaps like \~3.
