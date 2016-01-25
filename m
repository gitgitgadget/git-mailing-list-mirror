From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 06/19] mingw: try to delete target directory before renaming
Date: Mon, 25 Jan 2016 10:55:41 -0800
Message-ID: <xmqq4me1h4k2.fsf@gitster.mtv.corp.google.com>
References: <cover.1453650173.git.johannes.schindelin@gmx.de>
	<d75b0dc0b76beefee9e705555ca4f2fa4f4b96ce.1453650173.git.johannes.schindelin@gmx.de>
	<4C2ED807DD184A168C87221809034B70@PhilipOakley>
	<alpine.DEB.2.20.1601250753470.2964@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Philip Oakley <philipoakley@iee.org>, git@vger.kernel.org,
	nalla <nalla@hamal.uberspace.de>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 25 19:55:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNmIn-0007Og-9H
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jan 2016 19:55:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933255AbcAYSzp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Jan 2016 13:55:45 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52332 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932905AbcAYSzo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jan 2016 13:55:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CB3CB3E778;
	Mon, 25 Jan 2016 13:55:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=8jpbpzzQnSXj
	hZwn+oCN5ruwPbY=; b=tQInJ1qFfDtRz8P0sIw3kouthX5gew0zGuVBqD8dEe7p
	O984mNLAyJaG6evFW6GelU6pe9wEELER9kJdDTTIddjEXFr1q4v1wwGtMZsFXrHJ
	j/WC4hOonH7KtrgWpNZKQ3cm+lPF0Vr633U9N5K70y5lp0//YCENzZX7OVUKiAg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=eGkjOR
	OKo6r4O3JCjDuSkWnpFan9EYgkEeoqcmScEWs1D3HCKgJjpULLAe/pYe/KKbXqDo
	GV7DxGg+XDn7Y/ujf8En0+EznMGx1UrG8rSTFahgdXCjuYHAWpY2zpOuAnSPniuL
	rWPws94jNuSTSqJCsmbJETrP55IBWUHu0Cuqg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C2F6D3E777;
	Mon, 25 Jan 2016 13:55:43 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 23A393E774;
	Mon, 25 Jan 2016 13:55:43 -0500 (EST)
In-Reply-To: <alpine.DEB.2.20.1601250753470.2964@virtualbox> (Johannes
	Schindelin's message of "Mon, 25 Jan 2016 07:59:49 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3C29A23A-C395-11E5-B475-80A36AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284746>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Philip,
>
> On Sun, 24 Jan 2016, Philip Oakley wrote:
>
>> From: "Johannes Schindelin" <johannes.schindelin@gmx.de>
>> >From: =EB=A7=88=EB=88=84=EC=97=98 <nalla@users.noreply.github.com>
>>=20
>> Is this Nalla's preferred email, or just a carry over from cautions =
of the
>> Github interface?
>
> Neither. It is from the author field as recorded in the commit that I
> merged originally: https://github.com/dscho/git/pull/8

If it is not recorded under the name/email that is preferred by the
author, as I am not pulling from you but will be applying a patch,
we can fix it to match the author's desire, if we wanted to.

Your "Neither" hints that it is the case, but it is unclear to me
what address is the desired one (I can guess hamal.uberspace might
be), so...
