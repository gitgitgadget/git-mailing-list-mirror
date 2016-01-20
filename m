From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/7] diff: add --rename-file
Date: Wed, 20 Jan 2016 14:47:05 -0800
Message-ID: <xmqqzivz3m3a.fsf@gitster.mtv.corp.google.com>
References: <1453287968-26000-1-git-send-email-pclouds@gmail.com>
	<1453287968-26000-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 20 23:47:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aM1Wz-00075X-2K
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 23:47:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754032AbcATWrJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Jan 2016 17:47:09 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60311 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753233AbcATWrI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jan 2016 17:47:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 835EE3E255;
	Wed, 20 Jan 2016 17:47:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=bkXg/q5wpf2d
	kwZwxUkXIIdDPts=; b=sYZDqBJdAXsmNw5pQLcmetMXxg0T3cOyA8YA7sYZ0VCE
	JeQmD6rJfYVBdDGDxV6abq1gEvjJlanuQyewenZp2S0C6X1Wh+lPrGax1Rh08qM1
	P8huFnG6Co+Ozwvm6NWq14i/PIg3lI3YZ7rXX549cLX4vR5IhdL51pHtN4cTojA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=olNnBE
	zNeJTPIhYB6aiRG9WqghPCY9fiiA5gHzq+5BZl72WABqXUgPWjrlG6WWzteVv0pR
	24VnviGWX5c1B7hjL67Z8sL0dMkmc0qGjOcNa0WaVtVX3+Lto5m+oc79fLr/FcLv
	GtYp2X/IfDJaVid8aRerzzd2MOHdi/HJPkSMM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7BD063E254;
	Wed, 20 Jan 2016 17:47:07 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id EC0643E253;
	Wed, 20 Jan 2016 17:47:06 -0500 (EST)
In-Reply-To: <1453287968-26000-4-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 20
 Jan 2016 18:06:04 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BB802D46-BFC7-11E5-BCAB-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284480>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Git's heuristics to detect renames or copies works most of the time.
> This option can be used to correct the result when it goes wrong.
> Matching pairs get max rename score and override even exact rename
> detection.
>
> Note that --rename-file does not try to break existing diff pairs. So
> if you have "abc =3D> def" in your file, but they are already paired =
up
> (e.g. "abc =3D> abc" and "def =3D> def") and not broken down by -B, t=
hen
> nothing happens.

By the way, how would this interact with "diff -R"?

Do you need to spell --rename-file in reverse before you can run the
diff in reverse?
