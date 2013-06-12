From: Junio C Hamano <gitster@pobox.com>
Subject: Re: New feature discussion: git rebase --status
Date: Wed, 12 Jun 2013 15:19:39 -0700
Message-ID: <7vzjuvynt0.fsf@alter.siamese.dyndns.org>
References: <fb379a75c6c1af6dcff2e65bef1f1836@ensibm.imag.fr>
	<20130611125521.GL22905@serenity.lan> <vpqbo7c4wen.fsf@anie.imag.fr>
	<CAE1pOi0azF1pFqhU1Dq3qeXXF+n9xBcAnHOHapTDjbNXop0d2g@mail.gmail.com>
	<CA+55aFwtBm2RPwgXNa48zQM7ONCgzOEN2XdA_MeHsGu4=BDq5w@mail.gmail.com>
	<fa9c12a81ef2e92ba75dd1271d9e0b2d@ensibm.imag.fr>
	<51B857B0.5030603@ensimag.fr>
	<3cafe99fe3b868e6fc025110d324b9c8@ensibm.imag.fr>
	<CALWbr2xhhUNTo54u7K5iFr+wSMSiX6JrgTX=QJsDQ6E30uwDzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mathieu =?utf-8?Q?Li=C3=A9nard--Mayor?= 
	<mathieu.lienard--mayor@ensimag.fr>,
	=?utf-8?Q?C=C3=A9lestin?= Matte <celestin.matte@ensimag.fr>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Users <git@vger.kernel.org>,
	Jorge-Juan.Garcia-Garcia@ensimag.imag.fr,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 13 00:19:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmtON-0006qY-Qe
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 00:19:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756840Ab3FLWTn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Jun 2013 18:19:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55518 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755220Ab3FLWTm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jun 2013 18:19:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F720271FD;
	Wed, 12 Jun 2013 22:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nfSuTgb6XWUpFX8mcaFMgo49DC0=; b=LMLcbo
	mB00+gsWMWmWFu3LYCkRw9CGGTV54WINJeBUFjUTTsJvNWJ2UAIqIOX2zUBgWeVG
	/z8MPU57NQrWuFuCydASIRvmlz0LXIIaBWe7xc0Q6LUVRp+XJtttzVPxo4A+ziRA
	QkJHgcHumENL3immrwmZkuOyjDqcmXDFuZtc8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NduUkWMDsdEaQuggqMUG2sQHgihg1q/2
	6qybNHYvF0FG72PHPgrQj6Ekaw2Z3SGcFhZN6hT7Zu84shz7w/iM13hbyleVQtJm
	d3movHpZJujPMtS13pxztv88MApCYEnjI4b1UmX/KgoSvl/yYnduskaCpZ6+BYhF
	Pm4NScKevfs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 01B6A271FC;
	Wed, 12 Jun 2013 22:19:42 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5622F271F9;
	Wed, 12 Jun 2013 22:19:41 +0000 (UTC)
In-Reply-To: <CALWbr2xhhUNTo54u7K5iFr+wSMSiX6JrgTX=QJsDQ6E30uwDzQ@mail.gmail.com>
	(Antoine Pelisse's message of "Wed, 12 Jun 2013 14:28:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2D6E04A4-D3AE-11E2-9EF6-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227687>

Antoine Pelisse <apelisse@gmail.com> writes:

> Maybe we can display previous and next commits to provide some
> context. Like we do for diff.
> For example:
>
> $ git status
> # HEAD detached from ecb9f3e
> # Already applied 330 patches (displaying next 3):
> #     b170635... my_commit_message
> #     b170635... my_commit_message
> #     b170635... my_commit_message
> # Already applied 119 (displaying last 3)
> #     b170635... my_commit_message
> #     b170635... my_commit_message
> #     b170635... my_commit_message

I think you meant one of them to be

    # Still to be applied 119 (showing the first 3)

instead.  I am not sure if it is worth 8 lines, especially given
that "git log --oneline -$n" would give you "Already applied" part
that is beyond what will be shown in this message easily if you
wanted to.  So it might be enough to show "The one that has last
been replayed" (aka "HEAD") and "The one you are in the middle of
replaying".
