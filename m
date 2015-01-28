From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] test-lib.sh: Dynamic test for the prerequisite SANITY
Date: Wed, 28 Jan 2015 12:38:52 -0800
Message-ID: <xmqq7fw6hc83.fsf@gitster.dls.corp.google.com>
References: <54C7B115.7020405@web.de>
	<xmqqh9vbkgrg.fsf@gitster.dls.corp.google.com>
	<54C89DC8.1050805@web.de>
	<CAPc5daVAGOnu3pe_r=GuDXp1kNkJgbCqP-qD38kXmdEJa3ZSFQ@mail.gmail.com>
	<54C9362E.2000705@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Jan 28 21:40:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGZPZ-0003nd-Pa
	for gcvg-git-2@plane.gmane.org; Wed, 28 Jan 2015 21:40:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759477AbbA1UkX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Jan 2015 15:40:23 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61539 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1761198AbbA1Uiy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Jan 2015 15:38:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4E0D433D01;
	Wed, 28 Jan 2015 15:38:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=FBKWBEK9+34G
	RzlGrYC/VpDit/4=; b=EKtFmujeeJXLD6bfY02vAz3xMCi7ETb4iHtKS7iPPNTi
	e0zKY0O8ttUA3m/8GWeEY/yCdYxtewCAdCDtecLsAxNUQwJVA+ptoL2RUShuNuMW
	N8CN+n+BOJ6uTr5DjQ0E8g1Z1J8o/nj8jElU0NlOz3LnIq2OTCeIu2dBLTYD+8I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=AvRvD7
	8blGsa4X07Kr7wYptOrQWQcZQtK01+rgsG6EjPz6WvWgQE0Os38IrJo8YyuwptQ2
	NMbEXIIljK/7dC2cpQahdkpmXYqeFLW5eN1RahAP/Y/dqAoutJXhX/3wQKEmpZbO
	m36a+uZBJF2lcL3Gv7IKdAj43vJoee9hfuiJA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4421F33D00;
	Wed, 28 Jan 2015 15:38:54 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A232633CFD;
	Wed, 28 Jan 2015 15:38:53 -0500 (EST)
In-Reply-To: <54C9362E.2000705@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Wed, 28 Jan 2015 20:19:10 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AC75EFF6-A72D-11E4-8409-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263114>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

>> OK, but MacOS X does not have SANITY problem; "is the / writable?" t=
est
>> was misdetecting and declaring a system with SANITY does not have on=
e.
>>
>> Perhaps roll Cygwin and Mingw into a single Windows category? I dunn=
o.
> The whole discussion actually started with Mac OS X,
> and the conclusion was that Mac OS X should have SANITY set, but hadn=
't,
> because  / is writable (if you install from scratch):

Exactly. =20

On MacOSX running as non-root-but-can-write-to-slash-user, we should
say SANITY is satisfied, but "is the / writable?" check was
misdetecting and declaring the system does not have SANITY.

So we are in agreement, no?
