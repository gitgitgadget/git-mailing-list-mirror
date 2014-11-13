From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Let deny.currentBranch=updateInstead ignore submodules
Date: Thu, 13 Nov 2014 13:06:50 -0800
Message-ID: <xmqqzjbuzu6t.fsf@gitster.dls.corp.google.com>
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
	<xmqq4mu2285w.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 13 22:06:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xp1bV-00089O-JR
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 22:06:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934011AbaKMVGx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2014 16:06:53 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54218 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933636AbaKMVGw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2014 16:06:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7FA8A1D3EE;
	Thu, 13 Nov 2014 16:06:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=H1a6Pel8MKFx9XnbpYXgQ9SygmQ=; b=A+UKZP
	SQk7rQ0X9STXkmGC1hE1PZATB8cDexFkXdQbf+IgJZAZbFTFBRfD4LIC5U8RZq5X
	9qYCZ3/1afY1ZasjMfzWQCuqosZDO3gtz14ETmFxRMP2d+ZMURIDptTVUhIvmRUz
	EhvPL/x8TCGBMK/T/O1wC7FfXVYUjaDrYnfYA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Wmtkuu40kUKyzvyEHLaBSx+aWYp8Oeas
	87PqVQhnD3n/28popUipQA20dev/JB7OAYnbJGZyqvkgbaJhuHmfNaW6teBZP6eB
	Q4OpdIMAQasTBBXOmvtjMYechz7/sr1Ff8G/h4YXaTLF4VDxvHtZJTm76kIhVsXJ
	zEr40Dm9tX8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 751431D3ED;
	Thu, 13 Nov 2014 16:06:51 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EEC271D3EA;
	Thu, 13 Nov 2014 16:06:50 -0500 (EST)
In-Reply-To: <xmqq4mu2285w.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 13 Nov 2014 11:48:59 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FCD35286-6B78-11E4-A5FD-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Thanks for an explanation why the updateInstead mode must require a
> pristine working tree (and the index).  I *now* agree why such a
> mode would be useful, *after* reading it.  I did not understand why
> *after* reading only the patch, the documentation updates and the
> log message.
>
> That tells us something, doesn't it? ;-)

Just to be less cryptic, I meant that the documentation since v2 is
probably insufficient.

> I agree that a new value "mergeInstead" or something should be
> invented when/if different workflows want a looser semantics.
> People would rely not only on "being able to push when clean" but
> also on "being safely prevented from pushing when not" (and that is
> where my earlier comment to test both sides comes from).  Loosening
> the check to an existing "updateInstead" would break users who have
> been using updateInstead.

And thinking about the names again, I have a feeling that
updateInstead and mergeInstead are both probably misnomer.  The
"make sure there is no modification and then do an equivalent of
reset --hard there" option makes sense only in push-to-deploy
scenario (perhaps "resetInstead"?)  Compared to that, "do an
equivalent of checkout as long as it can be done without involving
real merges" sounds more deserving the "updateInstead" name.

But I am not very good at names (and I suspect you feel you yourself
aren't, either), so perhaps somebody listening from the sideline can
chime in.
