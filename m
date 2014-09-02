From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/2] Push the NATIVE_CRLF Makefile variable to C and added a test for native.
Date: Tue, 02 Sep 2014 12:03:05 -0700
Message-ID: <xmqq61h526c6.fsf@gitster.dls.corp.google.com>
References: <54024473.4040709@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Sep 02 21:03:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XOtMK-0003Mb-LC
	for gcvg-git-2@plane.gmane.org; Tue, 02 Sep 2014 21:03:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754982AbaIBTDK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Sep 2014 15:03:10 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62951 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754972AbaIBTDJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Sep 2014 15:03:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4D13637533;
	Tue,  2 Sep 2014 15:03:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=zhkcDsPAKAq3
	fnu6WuuMl7YdiX0=; b=arlccFyBdvteKkeL8ZoP3xyuq4CWTAT4Pl2c+fSULYZn
	/LeHBMasUHGvWZnCBM6wZ0/onWf2n5VCN+n39zB5uMuCB/fVeNsprE+3N+1xz6aC
	zgs8OSeTlflEe6mKzJBRi+yb/8SYD2xSLLYcyp6EcT5uKL6GoPjYUmYnbEcBjVY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Hdp4hE
	lviqaVEZgbZbOfkpnP6/FMJk6mPSTq5mcebXYz7w1HeC4NEIlZqdqQl0d7Xwpx2B
	hAGTjvCDbimgZYJaudp8wAmXDpuq7lmQd9Qb6aw9g1xsLHieVuGZDGVpAz3Vk4yy
	pJQqCGt0QSar1rK9XbkwIxAvqZudneye4PUiY=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 43E3437532;
	Tue,  2 Sep 2014 15:03:08 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 984AE37531;
	Tue,  2 Sep 2014 15:03:07 -0400 (EDT)
In-Reply-To: <54024473.4040709@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Sat, 30 Aug 2014 23:38:59 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C66AB65E-32D3-11E4-ADDF-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256337>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> From: Pat Thoyts <patthoyts@users.sourceforge.net>
>
> Commit 95f31e9a correctly points out that the NATIVE_CRLF setting is
> incorrectly set on Mingw git. However, the Makefile variable is not
> propagated to the C preprocessor and results in no change. This patch
> pushes the definition to the C code and adds a test to validate that
> when core.eol as native is crlf, we actually normalize text files to =
this
> line ending convention when core.autocrlf is false.
>
> Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
> Signed-off-by: Stepan Kasal <kasal@ucw.cz>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
> This mini series mainly updates git.git with patches from msysgit:
> Patch 1 is taken "as is",
> Patch 2 is taken from msysgit "nearly as is": the broken && chain
> had been fixed.

Shouldn't Patch 1 also be made "nearly as is" to fix the same?
