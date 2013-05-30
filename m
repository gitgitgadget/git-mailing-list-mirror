From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: promote wildmatch to be the default fnmatch implementation
Date: Wed, 29 May 2013 19:25:39 -0700
Message-ID: <7vvc61p5jw.fsf@alter.siamese.dyndns.org>
References: <1369877684-5050-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 30 04:25:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhsYk-0004HE-Mu
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 04:25:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967306Ab3E3CZn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 May 2013 22:25:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60803 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967287Ab3E3CZm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 May 2013 22:25:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6FF831A216;
	Thu, 30 May 2013 02:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=de89PrFlwkqr
	/sYInH1H12Yu+pw=; b=iWekMLuOjyI2qeFmYgN/hpTEEp0ZnO+XPcDxjUcIEdFQ
	WCSTTZmqet9n7IrqtTvuH+sWoIB/6BuGehhRdlGMrikUTDkk/hsou+S36e5W7vpz
	YLSZUV9BXeHUh2GITOZ3tFaEnUXk1LpRxgpbctZIDzgXZdvt1v4t6GubZhKF38s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=WJ8v0r
	3pyeaFuFc/0/p+2TZ0OlScZ1DrZllQXLeAnov5JEkSgEpYh3kt5w3YmuOdhqbWJV
	HAzlmPHJpPMynFYAXSdjGiiD1R7TqkPM6zWQH6xBtvGigOEbfi6BHnR1sm69Q3lB
	0QnrQkd9hL2cR2CJIP2M6l2HVmd3+ydb7bLt4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 62E491A214;
	Thu, 30 May 2013 02:25:41 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C909A1A213;
	Thu, 30 May 2013 02:25:40 +0000 (UTC)
In-Reply-To: <1369877684-5050-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 30
 May 2013 08:34:44 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 38ECB71E-C8D0-11E2-AEA7-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225909>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> This makes git use wildmatch by default for all fnmatch() calls. User=
s
> who want to use system fnmatch (or compat fnmatch) need to set
> NO_WILDMATCH flag.
>
> wildmatch is a drop-in fnmatch replacement with more features. Using
> wildmatch gives us a consistent behavior across platforms.

Hmph, could you (no need to hurry, though) check the previous
discussion and point at what we decided if we did reach any
conclusion to refresh our collective memory?

While I agree this is a good move in the longer term in that we get
the often-asked-for "foo/**/*.c" match and also we have one less
platform differences to worry about, I somehow have a recollection
that we discussed that there are incompatibilities in dark corners
we would want to warn users about and lay a transition plan across
some major version bump.

Thanks.
