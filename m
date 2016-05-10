From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/2] travis-ci: build documentation
Date: Tue, 10 May 2016 10:12:00 -0700
Message-ID: <xmqqpostrg67.fsf@gitster.mtv.corp.google.com>
References: <E4A56B4E-6F2E-44E3-870B-D1D3A71B2869@gmail.com>
	<1462351116-19308-1-git-send-email-larsxschneider@gmail.com>
	<1462351116-19308-3-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, peff@peff.net, Matthieu.Moy@grenoble-inp.fr,
	sbeller@google.com
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Tue May 10 19:12:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0BCd-00070z-So
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 19:12:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbcEJRMH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 13:12:07 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64619 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750978AbcEJRMF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 13:12:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A88BC19AD4;
	Tue, 10 May 2016 13:12:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=l5Fc/FLlzTl8GFCgFhRVzo7Y7Lw=; b=W7Wq9m
	/GLfMOj8MXvD3ghvzfONpPpW+O3n/sUAfl1SJD8Jklrrvyv93Aw55mO3I+5+//en
	TbZAVybUhBgnF43RHER1Y8In0uM2sMHiT13BmDsyjoyRkRa36C/EUt24fQ0QcWnr
	0UjtkDubcOglonx0T3zzPQya/WN/T5U4Y2pb8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Qs8/ME9+Sis1jV8KZpJi3IUgOIGLeuW3
	PAfpeYdw5H5fvQQ0RYCVHmWykDfb6z8Q74x1ecnnOHwpwA7Gnf8y3Zxq1taShy1v
	cLfBYl2vyCEH/wZtFcRLrKkvAvkNirV4Y+0pzE2cG8Ah4Xft4yxS/EL/44e6aORT
	6J7uGRaOSbU=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9EF7719AD3;
	Tue, 10 May 2016 13:12:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0CEB119ACF;
	Tue, 10 May 2016 13:12:02 -0400 (EDT)
In-Reply-To: <1462351116-19308-3-git-send-email-larsxschneider@gmail.com>
	(larsxschneider@gmail.com's message of "Wed, 4 May 2016 10:38:36
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 507CEDA6-16D2-11E6-8F71-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294155>

larsxschneider@gmail.com writes:

> From: Lars Schneider <larsxschneider@gmail.com>
>
> Build documentation as separate Travis CI job to check for
> documentation errors.
>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>  .travis.yml              | 15 +++++++++++++++
>  ci/test-documentation.sh | 14 ++++++++++++++
>  2 files changed, 29 insertions(+)
>  create mode 100755 ci/test-documentation.sh
>
> diff --git a/.travis.yml b/.travis.yml
> index 78e433b..55299bd 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -32,6 +32,21 @@ env:
>      # t9816 occasionally fails with "TAP out of sequence errors" on Travis CI OS X
>      - GIT_SKIP_TESTS="t9810 t9816"

Completely offtopic, but this looks like this is made to apply to
all archs, not limited to OSX?  It of course would be ideal to see
why they fail only on OSX and fix them, but shouldn't the blacklist
at least limited to the platform with the problem?
