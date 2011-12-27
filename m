From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gc --auto: warn garbage collection happens soon
Date: Tue, 27 Dec 2011 13:52:35 -0800
Message-ID: <7vpqf94r8c.fsf@alter.siamese.dyndns.org>
References: <1324993534-16307-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 27 22:52:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rfews-0001Me-Mo
	for gcvg-git-2@lo.gmane.org; Tue, 27 Dec 2011 22:52:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751707Ab1L0Vwj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Dec 2011 16:52:39 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53063 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751577Ab1L0Vwh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Dec 2011 16:52:37 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0961E63DD;
	Tue, 27 Dec 2011 16:52:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=dM1r08sfiUFc
	g1sPat6doLgHLwg=; b=HGwMcbNrlabEkKg2rV57mGOTth+uuiKBEMvrxzdPE3oy
	IfjVEqer7rPb2LOTBNHQyMmNhC00EzZc+1p9l6KOwc3LRnu5p+SYdh4zbesvlbkl
	FGXUAswlxp3xc+h5JeZRopKiodlD1xmo/LuXgS3/nF7vpJtbYRa3IOZrzHr2HZ4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=RnljyT
	YqI6C3WDcIaJo2HqbEO5A6YM/4u530H/QUkQcYqRTWKGD1zBdUTB7JKcf2zs19pV
	aWh/ekmaDpJeZc18KNTiMNrOzWWpfMxuA+QuMCz2NkNxWnPiUKM44lAIW8HZh12w
	l2MgXGbW3j6pegnxLdVNx5GTa4lIjEIU9EfIw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 00C4663DC;
	Tue, 27 Dec 2011 16:52:37 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8505063DB; Tue, 27 Dec 2011
 16:52:36 -0500 (EST)
In-Reply-To: <1324993534-16307-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 27 Dec
 2011 20:45:34 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 16BE1F00-30D5-11E1-A87E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187733>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> This gives users a chance to run gc explicitly elsewhere if they do n=
ot
> want gc to run suddenly in current terminal.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>

As I am still in a cheerly holiday mood, let's be a bit philosophical,
step back a bit and think.

After this patch gets applied, will the users start feeling bothered by
repeated "you will soon see auto-gc" messages and will want "you will s=
oon
start seeing the you will soon see auto-gc messages" warnings?

And if the answer to that tongue-in-cheek question is no, what is the
reason why the users will not find the messages disturbing, while loath=
ing
the auto-gc?

I suspect that is because auto-gc takes long time, making the user wait=
,
compared to the new message that may be noisy but quick.  Perhaps the r=
eal
cure for the disease is not to add the message but to make an auto-gc l=
ess
painful, no?

What are the things we could do to make auto-gc less painful?

Are we doing something that is not necessary in auto-gc that takes time
but that we can live without doing?

It may be a better cure for the disease to force a full gc after
operations that we know the users already know to take long time (e.g. =
a
clone, a large fetch), so that the next auto-gc do not have to do much
work.
