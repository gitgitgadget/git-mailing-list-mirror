From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix memory corruption when .gitignore does not end by \n
Date: Wed, 20 Jan 2010 11:51:50 -0800
Message-ID: <7v3a20367d.fsf@alter.siamese.dyndns.org>
References: <fcaeb9bf1001200458v436a8adeq5cfc6753900e6c0c@mail.gmail.com>
 <1263996556-9712-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jonathan del Strother <maillist@steelskies.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 20 20:52:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXgb6-0005RT-Dk
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 20:52:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754168Ab0ATTwH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Jan 2010 14:52:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754156Ab0ATTwG
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 14:52:06 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50526 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753237Ab0ATTwB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jan 2010 14:52:01 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1FCB592236;
	Wed, 20 Jan 2010 14:52:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=eu3dasdFMQwP
	v9OeoKqbUHkJlRw=; b=Go9gzIzejJadkBjU0RRZ+9ndUu8PFFjASY/rxyUGxRWq
	trgvLqbG6gzM5XW2r/6ztyxWRmayvRFrg+rPorvW2aoWYwm/hQ1OYtG3K7CmO0eh
	+4I0wsGnye/doGPNlPezPPx32R6GVSyUPcAoEAyjs/bpqdoAUo5cefhLpum4E6A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=PhXkNr
	pzZ4+g5e5oMdcyeF9YxBsbJ3/M4prvWOsl1ijRfjg+/n1FlULx+30huMAJtTcryA
	zL21f6GLM6fOKFz2HXwEKwSRF2XwSuUjEv9vDG6yGf0Gkd50e2wcqdTc6U23DCDg
	xJOO9lMav7Q9jNRkyDQ4fz8xcMeH02B5jGnik=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D075F9222D;
	Wed, 20 Jan 2010 14:51:56 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0001392228; Wed, 20 Jan
 2010 14:51:51 -0500 (EST)
In-Reply-To: <1263996556-9712-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuIFRow6FpIE5n4buNYw==?= Duy"'s message of "Wed\, 20 Jan
 2010 21\:09\:16 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 43E2D1CE-05FD-11DF-99F7-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137565>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

>  This patch causes a crash for me. Not sure if it does for anybody el=
se.

I am puzzled.  What do you mean by this?  If this patch makes the code
crash, then it is not a fix.  Is this meant as "Jonathan, can you try t=
his
patch and tell me what happens, so that I can diagnose the issue better=
?"
patch?

Is it better/safer to revert the entire nd/sparse topic from the master=
 in
the meantime before we know what is going on?
