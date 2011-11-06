From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add abbreviated commit hash to rebase conflict message
Date: Sat, 05 Nov 2011 21:14:23 -0700
Message-ID: <7vy5vt7uqo.fsf@alter.siamese.dyndns.org>
References: <1320501759-27236-1-git-send-email-srabbelier@gmail.com>
 <7v39e2852t.fsf@alter.siamese.dyndns.org>
 <CAGdFq_hw1630ELQP3+AEaCmUTEjYq7K1j8ZB-n0_rb1VN=wQgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Jonas =?utf-8?Q?Flod=C3=A9n?= <jonas@floden.nu>,
	Eric Herman <eric@freesa.org>, Fernando Vezzosi <fv@repnz.net>,
	Git List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 06 05:14:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMu86-0001hG-HV
	for gcvg-git-2@lo.gmane.org; Sun, 06 Nov 2011 05:14:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750875Ab1KFEO1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Nov 2011 00:14:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53951 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750725Ab1KFEO0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Nov 2011 00:14:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 86EAD5871;
	Sun,  6 Nov 2011 00:14:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1JPqFJg2/Ct6PtBkBQdfq7yICWI=; b=fbmCrM
	YYxsv3qSVRlF91S3bX8xdWDWzra3o97LNtZ/Riu5gHqujNLtyWwpII0vDLSoLwXD
	HtbwrZZaIbWuIPrbJ6CpcImI6zD/FX87Yx6+R2IYqsKF0gfzks6u4SJ+2rV1Nkdo
	rD8VM/4CEkI1TcfXbKA5pd9auBMvBcNrEq/+s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=w+lCyiIWVI0lAdTmmAbWy0UoshmRbDjL
	+Wa56FETB2EtdrkcbAAoY/UdW2lyNmlPNMRsp7Rjn0VTzIivA9o5+A3mDl+nb+CV
	CBkwXoePL6vhYmMujDpNGfHD63kN/8kr1IZZ2Q/LO7Wdlkhnxs2Pr/pbGS44dZeG
	NF7RDoq4tns=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7D8EE5870;
	Sun,  6 Nov 2011 00:14:25 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 08B5B586C; Sun,  6 Nov 2011
 00:14:24 -0400 (EDT)
In-Reply-To: <CAGdFq_hw1630ELQP3+AEaCmUTEjYq7K1j8ZB-n0_rb1VN=wQgA@mail.gmail.com> (Sverre
 Rabbelier's message of "Sun, 6 Nov 2011 01:37:49 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CFCB5204-082D-11E1-9A6F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184897>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> We had a little Git hackathon in Amsterdam today,...

Ah, that was the context I was missing.

>> What happens when threeway is not enabled, and especially when "git am" is
>> used for applying patches, not within rebase?
>
> The same thing that already happens. I'm not sure what it is, but
> whatever title/number is shown, the matching hash is now shown as
> well. This patch does not change that behavior.

I am puzzled, but that cannot be true. The existing message uses $msgnum
and $FIRSTLINE but does not use $commit because it does not necessarily
exist.

What a value would the variable contain when I am applying your original
patch message using "git am -s" (or "git am -s3")?
