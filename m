From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 16/19] mingw: mark t9100's test cases with appropriate prereqs
Date: Tue, 26 Jan 2016 13:50:14 -0800
Message-ID: <xmqqoac8au3t.fsf@gitster.mtv.corp.google.com>
References: <cover.1453650173.git.johannes.schindelin@gmx.de>
	<cover.1453818789.git.johannes.schindelin@gmx.de>
	<49a0657c42cba813c4cf0c17169b28031c6d4312.1453818790.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 26 22:50:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOBVH-0002j4-Bb
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 22:50:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751524AbcAZVuU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2016 16:50:20 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58200 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751341AbcAZVuT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2016 16:50:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3D2C63F38A;
	Tue, 26 Jan 2016 16:50:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FDunkfmWRjrAwqfNFB53hz+m/6I=; b=RcFbtq
	MpbcAt+7+O/g+HqCJ2fxmlcnUXlOGXWXgaklNkz8UTWJkXmlT0gJzIW1s/mQnXkl
	q8jiHKlKMMoxl7tN1qk/8NeP+T+ipfZvIibRwpO9CIqQ28Hn+PHyWearfJjWPHEi
	1luULrv0ege3/yGBkXj3Li7/nGhHXfn28Pr3c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GNVZAk6W+tJSislfN58Q4dSxf+8Bleen
	HK8mE6TKOEmGNMCWq0LQEHFk+C8tocoxuWfwbEdFOy3A/uXZolXTM4cVhKmFJP27
	5iCCZ9Pq8QTC3UQ3AcN8eaK/mxxzttGWIs52/EBDXuuYEhqEug/6gyj6qrMUtuNO
	z78WZS2SVyc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 353DC3F389;
	Tue, 26 Jan 2016 16:50:16 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 86D8E3F388;
	Tue, 26 Jan 2016 16:50:15 -0500 (EST)
In-Reply-To: <49a0657c42cba813c4cf0c17169b28031c6d4312.1453818790.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Tue, 26 Jan 2016 15:35:30 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C89E4AB8-C476-11E5-846D-80A36AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284859>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> @@ -181,7 +180,8 @@ test_expect_success "$name" '
>  name="commit with UTF-8 message: locale: $GIT_SVN_LC_ALL"
>  LC_ALL="$GIT_SVN_LC_ALL"
>  export LC_ALL
> -test_expect_success UTF8 "$name" "
> +# This test relies on the previous test, hence requires POSIXPERM,SYMLINKS
> +test_expect_success UTF8,POSIXPERM,SYMLINKS "$name" "
>  	echo '# hello' >> exec-2.sh &&
>  	git update-index exec-2.sh &&
>  	git commit -m '???????' &&

Hmph.  "Content-Type: text/plain; charset=X-UNKNOWN" in the header
gives a hint to me, too.

I'll try to wiggle them in (19/19 has the same X-UNKNOWN), so no
need to re-send to fix only this.

Thanks.
