From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] git checkout --nodwim
Date: Sun, 18 Oct 2009 12:53:51 -0700
Message-ID: <7v7huspjg0.fsf@alter.siamese.dyndns.org>
References: <1254775583-49452-1-git-send-email-jaysoffian@gmail.com>
 <alpine.DEB.1.00.0910052314580.4985@pacific.mpi-cbg.de>
 <7vzl7pyvzl.fsf@alter.siamese.dyndns.org>
 <7v63adxh9a.fsf_-_@alter.siamese.dyndns.org>
 <81b0412b0910180540u7030c22br7efcaf7f51df771d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jay Soffian <jaysoffian@gmail.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 18 21:55:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzbqX-0006B1-Cw
	for gcvg-git-2@lo.gmane.org; Sun, 18 Oct 2009 21:55:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755172AbZJRTyC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Oct 2009 15:54:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755153AbZJRTyC
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Oct 2009 15:54:02 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44832 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754683AbZJRTyA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Oct 2009 15:54:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8F6EC7CEBC;
	Sun, 18 Oct 2009 15:54:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=2vI4/y8I0KGD
	P6lk3aTW5IXx4yI=; b=SFUk6L4PehfO9q8lad59VoPmrMijdOPU0Zjlb9p/H0Sw
	QkwLSU5sChW7QE2oykzGyoDP9mtmGFuK0/c2AbITsjD83VVDlbLTfCD0fgObdHrn
	QGN4mmmgKhgdbWUGjZGjdMLUi3j6WJqBMmwVyMo/KgGc1QGXOhI5TMkSQqqzxA0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Nqq9AK
	pOAd5yih1+gHtYIS6XpKkBFXrndU0NxzuvTXszQ0l4KA7noaFc7YHT7LLfSG5V1i
	XcpiMQ60zxENcJc5KdV8grJk//UIr6j0UtXx3PvSpWHrKUke/31i8+2uGlR+OPgL
	dBKERjZEE4Rxu2/XsA+wWrUHT0UmUVyBkpTyA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5A6F97CEBB;
	Sun, 18 Oct 2009 15:54:00 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 99CFE7CEB1; Sun, 18 Oct 2009
 15:53:53 -0400 (EDT)
In-Reply-To: <81b0412b0910180540u7030c22br7efcaf7f51df771d@mail.gmail.com>
 (Alex Riesen's message of "Sun\, 18 Oct 2009 14\:40\:21 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FAA91E2C-BC1F-11DE-B2AF-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130608>

Alex Riesen <raa.lkml@gmail.com> writes:

> On Sun, Oct 18, 2009 at 10:01, Junio C Hamano <gitster@pobox.com> wro=
te:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OPT_SET_INT(0, "n=
odwim", &dwim_new_local_branch,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 "do not dwim local branch creation", 0),
>
> Isn't there a special negation support for --no-something in parse-op=
tions?

There probably is, but this is a whetherbaloon patch without documentat=
ion
and pretty much Porcelain only, so I took the lazy route.

Helping hands in polishing it up is very welcome.
