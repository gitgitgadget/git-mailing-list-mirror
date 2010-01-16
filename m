From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Add push --set-upstream
Date: Fri, 15 Jan 2010 17:10:19 -0800
Message-ID: <7vhbqmn9c4.fsf@alter.siamese.dyndns.org>
References: <1263595630-18962-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <7vzl4frl7i.fsf@alter.siamese.dyndns.org>
 <7vfx66sz5p.fsf@alter.siamese.dyndns.org>
 <20100116090321.6117@nanako3.lavabit.com>
 <7vk4virjzh.fsf@alter.siamese.dyndns.org>
 <be6fef0d1001151653o7ba2cf7et8875eaf4333fc15a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 16 02:10:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVxBX-0001ML-2o
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 02:10:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932391Ab0APBKe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Jan 2010 20:10:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932380Ab0APBKe
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 20:10:34 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39060 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932328Ab0APBKd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Jan 2010 20:10:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AD1CF91313;
	Fri, 15 Jan 2010 20:10:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=VTs+TwHTsTuK
	99FJpQBWMXtHbuU=; b=bIEsLAR3Bk2I0v9PWzZ6V98yF7auwNafNvLxvdlCufXo
	44JYTaCdhE/0N35XlXQVa3+CxgLQWFgsXnMGPOaUNs0IMCoNouxsKuCYgdRuB+qt
	wXNOk39EcqZyw+9a/OZKTGj6ZHTiyuEm43E5UQ68q+BqT1erGER2DtYc5aURj48=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Iak58+
	IEwPfO9teBFvu6cGGMr9kjrqzS9NE6ZXQueulK9J9QrcKhoEdUX9u011HR8nsNDP
	+Ov7Ksa2hg+KmyRsbOykl951+rn5SWfmZKRVdDslRGup7jCtm8aPdiStzVZ1fuMd
	7KVsKc/V+Jgxc5sk2a3uTl35qK+1tCREEG4/Y=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6AE649130D;
	Fri, 15 Jan 2010 20:10:27 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 61D2B91305; Fri, 15 Jan
 2010 20:10:21 -0500 (EST)
In-Reply-To: <be6fef0d1001151653o7ba2cf7et8875eaf4333fc15a@mail.gmail.com>
 (Tay Ray Chuan's message of "Sat\, 16 Jan 2010 08\:53\:14 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EE9DE006-023B-11DF-B4C5-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137186>

Tay Ray Chuan <rctay89@gmail.com> writes:

> Hi,
>
> On Sat, Jan 16, 2010 at 8:06 AM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> Nanako Shiraishi <nanako3@lavabit.com> writes:
>>
>>> Quoting Junio C Hamano <gitster@pobox.com>
>>>
>>>> Junio C Hamano <gitster@pobox.com> writes:
>>>>
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Ok let's do it for real.
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 git push =C2=A0 =C2=A0--track there t=
his
>>>>
>>>> Ugh; s/--track/--set-upstream/, of course.
>>>
>>> How can I use this to say I want to use 'pull --rebase'?
>>
>> I dunno; "git push --set-upstream=3Drebase", perhaps?
>
> how about --setup-merge and --setup-rebase?
>
> After all, there's already the config called branch.autosetupmerge an=
d
> branch.autosetuprebase.

Do you mean Ilari's patch already sets up branch.name.rebase for people
with branch.autosetuprebase true?

If so, it might be better to keep "--set-upstream" as is, and have a wa=
y
to countermand that "autosetuprebase" default.
