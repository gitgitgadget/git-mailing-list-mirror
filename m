From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 0/7] i18n: mark missing C messages
Date: Tue, 12 Apr 2011 00:27:44 -0700
Message-ID: <7vei58q68f.fsf@alter.siamese.dyndns.org>
References: <1302464048-21806-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 12 09:27:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9Y11-000694-5F
	for gcvg-git-2@lo.gmane.org; Tue, 12 Apr 2011 09:27:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756762Ab1DLH1y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Apr 2011 03:27:54 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44553 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756732Ab1DLH1x convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Apr 2011 03:27:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A1FF427DE;
	Tue, 12 Apr 2011 03:29:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=F47fWcdAI9ud
	MesWSG+4pmDRZu4=; b=GiOcpOKe/QeVBUpk1xMPqx6bZt+WJ1VrY72WQdqZZwZu
	/ColC//PGmm0hFe087O1hb3m7xQeak5yf83dvDtsDdF80kjnttU9veHCDXT8/7Oy
	ajUvOyy+736D9Eu0RTEUiN44RsDOeMjWmLZh7pIf/BMWD9fAzdYoUr1KmrML/6c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=vdv4Wf
	DegMK4uGeYtpMcGKS3rm4knOHX8io2JuJBbtGtcFmRZzL1KEMoAnBwVUU2KSRBKK
	qOILbJOi2OT/DoWN4gCtzbiIYpF4Lt50f7+mQ8KiiU1liPTWEpOUAsQwmJBbPK1U
	0XbHFwJc8Ku9cM2DEATNtiBlQBFeMmPniC6Kw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 80C4727DD;
	Tue, 12 Apr 2011 03:29:46 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7519627DC; Tue, 12 Apr 2011
 03:29:43 -0400 (EDT)
In-Reply-To: <1302464048-21806-1-git-send-email-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sun, 10 Apr
 2011 19:34:01 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A45375E8-64D6-11E0-9BDF-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171379>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> This is an RFC because the first patch still leaves one remaining
> gitdir test failing under GETTEXT_POISON, and I won't be able to find
> out why tonight. Help welcome with figuring out why (in which case
> this should all be OK), you just need too build with
> GETTEXT_POISON=3DYesPlease and run t/t0001-init.sh.

I didn't even compile test this one, but I highly suspect that all the
failures you saw come from the fact that .git file your patch produces
with gettext poisoning (or any l10n) would be malformed and cannot be
parsed by read_gitfile_gently() anymore.

I took a look at the remainder of the series, and except for the "do no=
t
call what you know is a singleton 'them'" grammo, everything looked fin=
e
to me.

I am tempted to merge them to 'master' before rc2; the alternative is t=
o
queue it on ab/i18n-fixup and keep it in 'next' until the 1.7.5 final, =
and
have other people build on top of ab/i18n-fixup topic.
