From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Let deny.currentBranch=updateInstead ignore submodules
Date: Thu, 13 Nov 2014 11:48:59 -0800
Message-ID: <xmqq4mu2285w.fsf@gitster.dls.corp.google.com>
References: <cover.1415368490.git.johannes.schindelin@gmx.de>
	<84dba8872922da96e99953eea0ccff5f5af9dd4a.1415368490.git.johannes.schindelin@gmx.de>
	<xmqqh9yag6mt.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1411101400050.13845@s15462909.onlinehome-server.info>
	<xmqq1tpbawqe.fsf@gitster.dls.corp.google.com>
	<xmqq389qam25.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1411121208250.13845@s15462909.onlinehome-server.info>
	<xmqqzjbw47vr.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1411131123330.13845@s15462909.onlinehome-server.info>
	<alpine.DEB.1.00.1411131136200.13845@s15462909.onlinehome-server.info>
	<xmqqh9y32e36.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1411131850510.13845@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 13 20:49:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xp0OE-00026e-ES
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 20:49:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933626AbaKMTtF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Nov 2014 14:49:05 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56267 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933146AbaKMTtD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Nov 2014 14:49:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4DBF71DCC7;
	Thu, 13 Nov 2014 14:49:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=NYCDowQr2XqK
	Q26XyewjkoRwXbg=; b=okxSIfFx6/dMKrpUevJxO2SJR58eBYgH8jGJD48k+sti
	AeQPaGsRX8vI3275cLtbKra1w03VH8Ye1gG7ZOLbLg2eYDTTRAa7e1e4WbYpKSvq
	CZcY0HmG1i9S1eFBDllNc96/jFAlzTC79QPahVuoHV/PSuwTrNP5i10QsoEMg5o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=gyNwjW
	lA090repoJwI9X3OnxZRynkk0+4Yu+YsF638B3Uv9Ug0XJiPH1Uu7GYEmfZ59WVv
	9voiuX7YoPImb0A92jWxo9A0rGkqKvbu6bY6nnxniuqZA1Bm2RAoX/5WsY51ciOn
	75mEhdHjmFXBH5MBDGguGy2x0avYemSEaow8Q=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 45CBB1DCC6;
	Thu, 13 Nov 2014 14:49:01 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6EDF71DCC2;
	Thu, 13 Nov 2014 14:49:00 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.1411131850510.13845@s15462909.onlinehome-server.info>
	(Johannes Schindelin's message of "Thu, 13 Nov 2014 19:55:49 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1CFA0538-6B6E-11E4-AD4C-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Thanks for mentioning this. I would like to ask not to loosen this la=
ter.
> Let me try to explain in more detail than before why I think it would=
 make
> *my* life hard if it ever were loosened.
> ...
> And now when I try to push, Git complains that the working directory =
is
> not clean, which is *just* fine by me, because after further inspecti=
on it
> turns out that the uncommitted changes =E2=80=93 which are in a diffe=
rent file
> than the changes introducing my new feature =E2=80=93 would have bork=
ed the
> production system rather thoroughly.
> ...
> In my mind, when (and if!) a less strict version is desired, it shoul=
d be
> added as another denyCurrentBranch value and 'updateInstead' should b=
e
> unaffected, otherwise, speaking for me personally, all my work in thi=
s
> patch series would be for naught.

Thanks for an explanation why the updateInstead mode must require a
pristine working tree (and the index).  I *now* agree why such a
mode would be useful, *after* reading it.  I did not understand why
*after* reading only the patch, the documentation updates and the
log message.

That tells us something, doesn't it? ;-)

Also the failure case test must protect us from making a change you
fear in the future.  The interdiff you sent in a separate message
was to smudge path2 that is modified in the 'fourth' commit, which
should fail with either your "OK only if really clean" requirement
or the other "OK as long as it does not interfere with the switch"
criterion.  Checking that is a good step, but you would want to have
a separate "Smudge a path that is unchanged with the switch and see
the push updateInstead fail" to protect the current semantics.

I agree that a new value "mergeInstead" or something should be
invented when/if different workflows want a looser semantics.
People would rely not only on "being able to push when clean" but
also on "being safely prevented from pushing when not" (and that is
where my earlier comment to test both sides comes from).  Loosening
the check to an existing "updateInstead" would break users who have
been using updateInstead.

Also I suspect that people would want to send a patch to add "-q" to
your "update-index --refresh" invocation, at which time you would
need to add a call to "diff-files" to check that the working tree
and the index match.  You may want to add that "diff-files" now, or
at least have a test that is designed to break when "-q" is added to
"update-index --refresh" without adding the necessary "diff-files".

Thanks.
