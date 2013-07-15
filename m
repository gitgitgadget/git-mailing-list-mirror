From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] send-email: squelch warning from Net::SMTP::SSL
Date: Sun, 14 Jul 2013 21:15:26 -0700
Message-ID: <7vvc4ce9wh.fsf@alter.siamese.dyndns.org>
References: <1373025947-26495-1-git-send-email-artagnon@gmail.com>
	<1373025947-26495-2-git-send-email-artagnon@gmail.com>
	<51D82970.5070108@web.de>
	<20130706143256.GX862789@vauxhall.crustytoothpaste.net>
	<51D83C7E.8000902@web.de>
	<CALkWK0kAfZLqyCO+e+0PH0-MmjMYX1nJmit5Qb5L3Qf6nyhC9Q@mail.gmail.com>
	<20130714170316.GE11097@vauxhall.crustytoothpaste.net>
	<51E3677D.6040903@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Jul 15 06:15:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyaCD-0003VR-Ru
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 06:15:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172Ab3GOEPa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Jul 2013 00:15:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58632 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750806Ab3GOEP3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Jul 2013 00:15:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ECC6F2A77B;
	Mon, 15 Jul 2013 04:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=oXv4TfBqkS51
	RwBI/TVF+xwDkhA=; b=mip7V5TT6QsJcv16DVh82O62wYx8hA+oGP2X1h9q56WM
	8ucTnQ8o9+/L4i1W+7h4aacWaz/ENOJRTCZntAXJ5AiMewdBo4RIGjDbYiUdvOBc
	mO+Kc/17kY5PZO4SX8vUFdKHNXLSNUg7GJiOGqHE7r+g7FP3xO2Mb8dp+gfNz1I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=kZSYBz
	9szag/FA2UvmDplCJaNs/KbIew/ZmVQU/QzW6+UmCsg8iAbpAiTmc3oNbIjQte96
	kIzKVJZmU3pOucorLaWvhVKW9NyQb5jptpsLpQJytMdi8FMFCVeAMWvHOuRhHiYe
	lxdKwB/BPrvXJxJVNBYAsbjgh83iQ5/NXLZjQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E10C82A778;
	Mon, 15 Jul 2013 04:15:28 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 469A12A773;
	Mon, 15 Jul 2013 04:15:28 +0000 (UTC)
In-Reply-To: <51E3677D.6040903@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Mon, 15 Jul 2013 05:07:41 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2E5D393C-ED05-11E2-BCF0-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230412>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

>> I didn't stick the require in the eval because git-send-email will f=
ail
>> in this case anyway if you don't have it, since Net::SMTP::SSL requi=
res
>> it.  Let me know if you want a patch for this on top of the existing=
 two
>> in this series and I'll provide one.
>>=20
> Please send a patch if possible.
> I can volonteer to test it here, but it can take a couple of days to =
respond.

Thanks all.
