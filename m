From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/21] "struct pathspec" conversion
Date: Sun, 06 Jan 2013 13:45:06 -0800
Message-ID: <7vpq1im1el.fsf@alter.siamese.dyndns.org>
References: <1357453268-12543-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 06 22:45:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Try2B-00017T-3X
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 22:45:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753138Ab3AFVpK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Jan 2013 16:45:10 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38423 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753018Ab3AFVpJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Jan 2013 16:45:09 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A518DA5F9;
	Sun,  6 Jan 2013 16:45:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=VN2j0pu58n/Q
	Vf9XSVWZdSzkg/Y=; b=SpA3i4wnJ1ACpe/lio+QOsHVzd1kRpDWhoUU+J5lpWkL
	Gut/R7Xpgw6fspR7TEEpXsYidN4Ztq4eSzh9h/i5Mi35ZjzOTH8Di24fmRtlFywv
	RK+ScoMM42YBXnKggq2+/SB8ZOkNVYqSa3OBIGrHyD8DJkk7dQ4s+BQPcLMpBfI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=eU7Svp
	NR7eZ6E0xKVvTyRn5eVO/fVIk3wKNzaHDjB673ptKvWV2+AuGWFv/ENXhvEvmMWY
	vgV+IYxZDwTJamohFtmaz734f+M425Rf0QuCbAexcsQoHTEW6vTH7T2k1Lz5B6/u
	4HpZFf91jHqiiMcIdBnP4E88jAPfMnATtAx4Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 96CFFA5F8;
	Sun,  6 Jan 2013 16:45:08 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F28A9A5F6; Sun,  6 Jan 2013
 16:45:07 -0500 (EST)
In-Reply-To: <1357453268-12543-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sun, 6 Jan
 2013 13:20:47 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 56B431BA-584A-11E2-9FFD-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212846>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> This is another step towards the pathspec unification. This series
> introduces a get_pathspec() alternative: parse_pathspec(). The new
> function intializes struct pathspec directly. Many builtin commands
> (except mv) are converted to use this function. As a result, struct
> pathspec is used from the start for many commands.
>
> The next step would be dealing with pathspec manipulation code blocks
> that use "raw" field, init_pathspec or get_pathspec(). add.c, dir.c,
> rm.c and mv.c are hot places. And perhaps move pathspec code from
> dir.c and setup.c to pathspec.c after as/check-ignore enters "master"=
=2E
>
> This series shares a patch (the first one) with nd/pathspec-wildcard.=
 I
> put the patch in the series to avoid dependency.
>
> This series also disables wildcards in the prefix part, but it's only
> effective in combination with nd/pathspec-wildcard. And of course it'=
s
> not fully effective until all "raw" use is eliminated.

Yay!

Thanks, looking forward to reading it through.
