From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Move test-* to t/helper/ subdirectory
Date: Tue, 26 Apr 2016 15:07:49 -0700
Message-ID: <xmqqwpnkc9ca.fsf@gitster.mtv.corp.google.com>
References: <1460553762-12419-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 00:08:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avB9D-0002p6-29
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 00:07:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752233AbcDZWHy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Apr 2016 18:07:54 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60485 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751998AbcDZWHx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2016 18:07:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EA7D41642F;
	Tue, 26 Apr 2016 18:07:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=iqIYuVWgRQqH
	qGbYmrGe51si9Cw=; b=RcLSp4mYOZLDZT5cKP3RND7z2wmce387py/Yub6idUIB
	HC6znBwY8snTZuHOVCTHnSVn5UuivVnh9EZ4MP5NM+GSILzbB4T1QqDacF983qN+
	9RGIzksoi9bMEZqYskMGr03Pdhjl0jB+KXLUbSe2WhHjBMGdaTlLY5cLVPH0VSg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=PBrX5D
	Uv8/aY0V7+tcDh36Dm4BAeNZfom4yiKrrUGa5WfwH4ldtI/IqcZhSkTTt0yf1bMC
	FlM/vrTacgVC/+LPFzyeZC/FIJI9Jc8KxGGhcbRipbnqwRgxX3wGwJmQDeUE63Uc
	z6L0tQSbmu+4x1BLYQ1dPsYCbINdPOPuCWbDA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E2C9E16429;
	Tue, 26 Apr 2016 18:07:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 50DF516427;
	Tue, 26 Apr 2016 18:07:51 -0400 (EDT)
In-Reply-To: <1460553762-12419-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 13
 Apr 2016 20:22:42 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5180EB8A-0BFB-11E6-BC75-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292688>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> This keeps top dir a bit less crowded. And because these programs are
> for testing purposes, it makes sense that they stay somewhere in t/
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  This patch will break any patches that add new test programs.
>  Luckily, none in 'next' or 'pu' does that. I know lmdb backend adds
>  test-lmdb-backend, so a manual move and some .gitignore fixup is
>  required there.

Can you (or somebody else) double check that the resulting Makefile
gets the build dependencies and exec path right?

I am seeing occasional failure from t0040 when checking out between
master and pu, and between the branches test-parse-options do change
behaviour which explains the breakage.
