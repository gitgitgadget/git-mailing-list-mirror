From: Junio C Hamano <gitster@pobox.com>
Subject: Re: BUG: git pull --rebase on detatched head prints a lot of usage
 warnings
Date: Fri, 03 Dec 2010 13:06:01 -0800
Message-ID: <7vbp52o9c6.fsf@alter.siamese.dyndns.org>
References: <AANLkTimyCG6zVhc4znWPWwipd0bn-YT2FrOT=T0AgHNW@mail.gmail.com>
 <20101203190050.GB14049@burratino>
 <AANLkTin-9pb7cxsAvDqWj3So47_zq5co9TZRWux9ezxz@mail.gmail.com>
 <AANLkTikwdqQpmyxZu-kp7UHjYnKuVxs8urxM=9c=66H0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Santi =?utf-8?Q?B=C3=A9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Fri Dec 03 22:06:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POcpg-0004qn-P0
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 22:06:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753384Ab0LCVGQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Dec 2010 16:06:16 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61481 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752582Ab0LCVGP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Dec 2010 16:06:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C85E435A4;
	Fri,  3 Dec 2010 16:06:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=zFvRxE4RsmMw
	ZtY7ao7tP2ivyGo=; b=cHjcgjuteZhlKyvjMhW//aNwPaSlh1YEq8g0bQU93g4T
	y7Bbwbicu8+QKGNPwXJsT9Yg7VNmaw4kEBEfYSWxe4bTH1VM6d3FnXSh4eqZlDx/
	nP4fh4U4biyRlnN0Nv4owCGmf8E5/q7BSpPJB8pSCwBVXs1l2xoW2slCLX72jVw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=KuiBSj
	tuJCn0k5F4N50FR05DaL+UUdDq83V2+a6a4ARSCMcxwVdiID5xJWi2cE9KcVZJl4
	1MfdIoxuKEKSPCp2SYi3xHJL7cmdLmlwA4xkgv/TOax5sFQ7Zta8Dr509t5nI6ud
	6IH6kmKkVGjdFWKsyUQIW9Ff/zv5YQvFeEQ28=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 768A935A3;
	Fri,  3 Dec 2010 16:06:29 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D7A0A35A2; Fri,  3 Dec 2010
 16:06:22 -0500 (EST)
In-Reply-To: <AANLkTikwdqQpmyxZu-kp7UHjYnKuVxs8urxM=9c=66H0@mail.gmail.com>
 ("Santi =?utf-8?Q?B=C3=A9jar=22's?= message of "Fri\, 3 Dec 2010 21\:23\:54
 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 32BA0A7A-FF21-11DF-AFAD-CDEAE6EC64FC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162855>

Santi B=C3=A9jar <santi@agolina.net> writes:

> I also think it fixes, but I wonder if it's the best fix. One thing i=
s
> that show-branch is an ancillary command, and not a plumbing command
> (but there is already a call to show-branch, but it should probably b=
e
> change to merge-base now that it handles three commit as arguments).

Are you sure "show-branch --merge-base A B C" and "merge-base A B C" ar=
e
meant to compute the same thing?

I do not think ancillary necessarily means Porcelain, but that is a
separate issue.
